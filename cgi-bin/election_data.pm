package election_data;

# The one place that knows how a poll is laid out in its election_data and
# vote_data databases. Both election.pm, which serves the CGI scripts, and
# election_utils.pm, which serves the offline tools, read polls through
# here, so the schema is described once rather than twice.
#
# A poll may ask more than one question. Per-question fields of question 0
# are stored under the unprefixed keys that polls have always used, and
# those of question N under keys prefixed "qN."; "num_questions" says how
# many there are, and is absent from polls written before this existed. A
# poll created by any earlier version of CIVS is therefore already a valid
# one-question poll, and needs no conversion.
#
# Nothing structured can be stored in these databases. They are tied to
# Berkeley DB, which holds byte strings: a reference assigned into one is
# silently stringified to something like "HASH(0x55d1...)" and cannot be
# read back. Every value here is a flat string, and the nested structure
# exists only in memory.

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT_OK);

    $VERSION   = 1.00;
    @ISA       = qw(Exporter);
    @EXPORT_OK = qw(&ReadElectionData &WriteQuestion &QuestionKey
                    @question_fields);
}

use strict;
use warnings;

# This module deliberately contains no @PLACEHOLDER@ settings, so that it
# reads correctly both from the installed tree and from cgi-bin, where the
# offline tools load it from.

# The per-question fields, in the order they are written.
our @question_fields = qw(question_title choices num_winners proportional
                          use_combined_ratings shuffle writeins);

# Which of those hold text needing decoding, rather than a number or an
# ASCII keyword. Note that the question's own text is stored under
# "question_title", not "title", which is the name of the whole poll.
my %is_text = (question_title => 1, choices => 1);

# The database key holding one field of question $q. Question 0 keeps the
# unprefixed name, so that polls predating multiple questions still read.
sub QuestionKey {
    my ($q, $field) = @_;
    return ($q == 0) ? $field : "q$q.$field";
}

# Store one question. Only the fields present in $fields are written, and
# the caller is responsible for having validated and encoded them.
sub WriteQuestion {
    my ($eref, $q, $fields) = @_;
    foreach my $field (@question_fields) {
        next unless exists $fields->{$field};
        $eref->{QuestionKey($q, $field)} = $fields->{$field};
    }
}

# Read question $q. $decode is called as $decode->($eref, $key).
sub ReadQuestion {
    my ($eref, $decode, $q) = @_;
    my %f;
    foreach my $field (@question_fields) {
        my $key = QuestionKey($q, $field);
        $f{$field} = $is_text{$field} ? $decode->($eref, $key) : $eref->{$key};
    }
    $f{'choices'} = '' unless defined($f{'choices'});
    $f{'proportional'} = '' unless defined($f{'proportional'});
    $f{'use_combined_ratings'} = $f{'use_combined_ratings'} || 0;
    my @choices = split /[\r\n]+/, $f{'choices'};
    $f{'choice_list'} = \@choices;
    $f{'num_choices'} = scalar @choices;
    return \%f;
}

# Read a whole poll, given references to the two tied databases. Returns
# undef if the poll data cannot be read at all.
#
# $decode is called as $decode->($eref, $key) for every field holding text.
# The CGI path passes a function that decodes UTF-8 and repairs the
# double-encoded values some old polls hold; the offline tools, which work
# in bytes, pass one that returns the stored value untouched.
sub ReadElectionData {
    my ($eref, $vref, $decode) = @_;
    return undef unless defined($eref->{'name'});

    my $num_questions = $eref->{'num_questions'} || 1;
    my @questions;
    for (my $q = 0; $q < $num_questions; $q++) {
        push @questions, ReadQuestion($eref, $decode, $q);
    }

    my %data = (
        name             => $decode->($eref, 'name'),
        title            => $decode->($eref, 'title'),
        email_addr       => $decode->($eref, 'email_addr'),
        description      => $decode->($eref, 'description'),
        election_end     => $decode->($eref, 'election_end'),
        result_addrs     => $decode->($eref, 'result_addrs'),
        addresses        => $decode->($eref, 'addresses') // '',
        election_begin   => $eref->{'election_begin'},
        public           => $eref->{'public'},
        publicize        => $eref->{'publicize'} || 'no',
        allow_voting     => $eref->{'allow_voting'} || 'no',
        no_opinion       => $eref->{'no_opinion'} || 'yes',
        num_auth         => $eref->{'num_auth'},
        ballot_reporting => $eref->{'ballot_reporting'} // '',
        external_ballots => $eref->{'external_ballots'} // 'no',
        reveal_voters    => $eref->{'reveal_voters'} // '',
        restrict_results => $eref->{'restrict_results'} // 'no',
        no_IP_check      => $eref->{'no_IP_check'} // 'no',
        email_load       => $eref->{'email_load'},   # timestamp num_mails
        num_votes        => $vref->{'num_votes'} || 0,
        close_time       => $vref->{'close_time'},
        recorded_voters  => $vref->{'recorded_voters'},
        last_vote_time   => $vref->{'last_vote_time'},

        questions        => \@questions,
        num_questions    => scalar @questions,
    );

    $data{'hash_result_key'} =
        ($data{'restrict_results'} eq 'yes') ? $eref->{'hash_result_key'} : 0;

    # Write-ins are settled one question at a time, but voting is enabled
    # for the poll as a whole, so it waits on the last question that is
    # still open to them. With a single question this is what it has
    # always been.
    my $any_writeins = 0;
    foreach my $q (@questions) {
        $any_writeins = 1
            if defined($q->{'writeins'}) && $q->{'writeins'} eq 'yes';
    }
    $data{'voting_enabled'} =
        (!$any_writeins || $data{'allow_voting'} eq 'yes');

    return \%data;
}

1;
