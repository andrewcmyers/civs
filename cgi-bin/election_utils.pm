package election_utils;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.00;
    @ISA         = qw(Exporter);
    @EXPORT      = qw($name $title $email_addr $description
                      $num_winners $addresses @addresses
                      $election_begin $election_end $public
                      $publicize $writeins $allow_voting
                      $voting_enabled $proportional
                      $use_combined_ratings $external_ballots
                      $choices @choices $num_choices $num_auth
                      $num_votes $recorded_voters $ballot_reporting
                      $reveal_voters $authorization_key $shuffle
                      $no_opinion %voter_keys %used_voter_keys
                      $restrict_results $result_addrs
                      $hash_result_key $last_vote_time $close_time
                      $email_load @questions $num_questions
                      &GetElectionData &SelectQuestion);

   $ENV{'PATH'} = $ENV{'PATH'}.'@ADDTOPATH@';
}

use election_data qw(ReadElectionData);

our ($name, $title, $email_addr, $description, $num_winners, $addresses,
     @addresses, $election_begin, $election_end, $public, $publicize,
     $writeins, $allow_voting, $voting_enabled, $proportional,
     $use_combined_ratings, $external_ballots, $choices, @choices,
     $num_choices, $num_auth, $num_votes, $recorded_voters,
     $ballot_reporting, $reveal_voters, $authorization_key, $shuffle,
     $no_opinion, %voter_keys, %used_voter_keys, $restrict_results,
     $result_addrs, $hash_result_key, $last_vote_time, $close_time,
     $email_load);

# Every question in the poll. The scalars above describe question 0.
our (@questions, $num_questions);

# GetElectionData($eref, $vref) expects references to the election data map
# and the voting data map, set up using `tie`. The layout of those maps is
# described in election_data.pm, which the CGI scripts read polls through
# as well.
#
# The offline tools work in bytes rather than decoded characters, so the
# decoder passed below returns each stored value untouched.
sub GetElectionData {
    my ($eref, $vref) = @_;
    my $data = ReadElectionData($eref, $vref, sub { $_[0]->{$_[1]} });
    if (!defined($data)) {
        print STDERR "Cannot read election data file -- wrong BDB version?\n";
        return 0;
    }
    @questions = @{$data->{'questions'}};
    $num_questions = $data->{'num_questions'};
    my $poll = $data->{'poll'};

    $name = $poll->{'name'};
    $title = $poll->{'title'};
    $email_addr = $poll->{'email_addr'};
    $description = $poll->{'description'};
    $addresses = $poll->{'addresses'};
    @addresses = split /[\r\n]+/, $addresses;
    $election_begin = $poll->{'election_begin'};
    $election_end = $poll->{'election_end'};
    $public = $poll->{'public'};
    $publicize = $poll->{'publicize'};
    $allow_voting = $poll->{'allow_voting'};
    $voting_enabled = $poll->{'voting_enabled'};
    $num_auth = $poll->{'num_auth'};
    $no_opinion = $poll->{'no_opinion'};
    $num_votes = $poll->{'num_votes'};
    $close_time = $poll->{'close_time'};
    $recorded_voters = $poll->{'recorded_voters'};
    $ballot_reporting = $poll->{'ballot_reporting'};
    $external_ballots = $poll->{'external_ballots'};
    $reveal_voters = $poll->{'reveal_voters'};
    $restrict_results = $poll->{'restrict_results'};
    $result_addrs = $poll->{'result_addrs'};
    $hash_result_key = $poll->{'hash_result_key'};
    $last_vote_time = $poll->{'last_vote_time'};
    $email_load = $poll->{'email_load'}; # timestamp num_mails

    SelectQuestion(0);
    1
}

# Point the per-question globals at question $q. See the same routine in
# election.pm.
sub SelectQuestion {
    (my $q) = @_;
    my $question = $questions[$q];
    return unless defined($question);
    $choices = $question->{'choices'};
    @choices = @{$question->{'choice_list'}};
    $num_choices = $question->{'num_choices'};
    $num_winners = $question->{'num_winners'};
    $proportional = $question->{'proportional'};
    $use_combined_ratings = $question->{'use_combined_ratings'};
    $shuffle = $question->{'shuffle'};
    $writeins = $question->{'writeins'};
}

1
