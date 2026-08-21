#!/usr/bin/perl
#
# Create a public poll for the benchmark to vote in, and start it.
#
#   make-poll.pl <install dir> [num choices] [num questions]
#
# Prints "<poll id> <authorization key>". The poll is made the way a
# supervisor would make one, by running the installed CGI scripts, so that
# what the benchmark votes in is a poll of the shape the code expects
# rather than a set of database records assembled here.
use strict;
use warnings;

my $inst = shift @ARGV or die "usage: make-poll.pl <install dir> [choices] [questions]\n";
my $num_choices = shift(@ARGV) || 5;
my $num_questions = shift(@ARGV) || 1;
my $cgi = "$inst/cgi";

sub urlencode {
    my ($s) = @_;
    $s =~ s/([^A-Za-z0-9_.~-])/sprintf("%%%02X", ord($1))/ge;
    return $s;
}

sub post {
    my ($script, %params) = @_;
    my $body = join '&', map { urlencode($_) . '=' . urlencode($params{$_}) }
                         sort keys %params;
    local %ENV = (%ENV,
        REQUEST_METHOD => 'POST',
        CONTENT_TYPE   => 'application/x-www-form-urlencoded',
        CONTENT_LENGTH => length($body),
        SCRIPT_NAME    => "/$script",
        REMOTE_ADDR    => '127.0.0.1',
        HTTP_HOST      => 'localhost',
    );
    my $tmp = "$inst/../make-poll-$$";
    open(my $w, '>', $tmp) or die $!;
    print $w $body;
    close $w;
    open(my $fh, '-|') or do {
        open(STDIN, '<', $tmp) or die $!;
        exec($^X, "-I$cgi", "$cgi/$script") or die $!;
    };
    local $/;
    my $out = <$fh>;
    close $fh;
    unlink $tmp;
    return $out;
}

my @choices = map { "Choice $_" } (1 .. $num_choices);
my %params = (
    name          => 'Benchmark',
    email_addr    => 'bench@example.invalid',
    title         => 'Benchmark poll',
    description   => 'A poll cast in by the CIVS benchmark.',
    election_end  => 'never',
    public        => 'yes',
    no_opinion    => 'yes',
    # Ballots are posted straight to the script, so the order the choices
    # would have been shown in never comes into it. Shuffling anyway would
    # only add a cost to the page that the numbers could not account for.
    shuffle       => 'no',
    num_questions => $num_questions,
    choices       => join("\r\n", @choices),
    num_winners   => 1,
);
for my $q (1 .. $num_questions - 1) {
    $params{"q${q}_question_title"} = "Question " . ($q + 1);
    $params{"q${q}_choices"}        = join("\r\n", @choices);
    $params{"q${q}_num_winners"}    = 1;
}
$params{question_title} = 'Question 1' if $num_questions > 1;

my $out = post('create_election.pl', %params);
my ($id)   = $out =~ m{control[^?]*\?id=(E_[0-9a-f]+)};
my ($key)  = $out =~ m{control[^?]*\?id=E_[0-9a-f]+&key=([0-9a-f]+)};
my ($akey) = $out =~ m{&akey=([0-9a-f]+)};
die "make-poll.pl: could not create a poll\n$out" unless $id && $key;

my $started = post('start_election.pl', id => $id, key => $key, akey => ($akey || ''));
die "make-poll.pl: could not start the poll\n$started" unless $started =~ /has been started/;

print "$id ", ($akey || ''), "\n";
