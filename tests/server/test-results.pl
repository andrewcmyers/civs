#!/usr/bin/perl
# Tabulating a poll that asks several questions: one report per question,
# each with its own choices, matrix, settings and cache.
use strict; use warnings;
use DB_File; use Fcntl;

my $inst = shift @ARGV or die "usage: test-results.pl <install dir> [source dir]\n";
my $root = shift @ARGV || '.';
my $cgi  = "$inst/cgi";
my $data = "$inst/data";

my ($fails, $checks) = (0, 0);
# The prototype matters: without it a failing match, which yields an empty
# list rather than a false value, would shift the arguments along and the
# $extra text would arrive as the condition -- reporting the failure as a
# pass.
sub ck($$;$) {
    my ($name, $cond, $extra) = @_;
    $checks++;
    if ($cond) { print "  ok: $name\n" }
    else { $fails++; print "FAIL: $name", (defined $extra ? "  [$extra]" : ''), "\n" }
}

sub urlencode {
    my ($s) = @_;
    $s =~ s/([^A-Za-z0-9_.~-])/sprintf("%%%02X", ord($1))/ge;
    return $s;
}

sub request {
    my ($script, $ip, $method, %params) = @_;
    my $body = join '&', map { urlencode($_) . '=' . urlencode($params{$_}) }
                         sort keys %params;
    local %ENV = (%ENV, SCRIPT_NAME => "/$script", REMOTE_ADDR => $ip,
                        HTTP_HOST => 'localhost');
    my $tmp = "/tmp/civs-res-$$";
    if ($method eq 'GET') {
        $ENV{REQUEST_METHOD} = 'GET';
        $ENV{QUERY_STRING} = $body;
        open(my $w, '>', $tmp) or die $!; close $w;
    } else {
        $ENV{REQUEST_METHOD} = 'POST';
        $ENV{CONTENT_TYPE} = 'application/x-www-form-urlencoded';
        $ENV{CONTENT_LENGTH} = length($body);
        delete $ENV{QUERY_STRING};
        open(my $w, '>', $tmp) or die $!; print $w $body; close $w;
    }
    open(my $fh, '-|') or do {
        open(STDIN, '<', $tmp) or die $!;
        exec($^X, "-I$cgi", "$cgi/$script") or die $!;
    };
    local $/; my $out = <$fh>; close $fh;
    unlink $tmp;
    return $out;
}
sub post { my ($s, $ip, %p) = @_; return request($s, $ip, 'POST', %p) }
sub get  { my ($s, $ip, %p) = @_; return request($s, $ip, 'GET', %p) }

sub make_poll {
    my (%params) = @_;
    my $out = post('create_election.pl', '10.0.0.1',
        name => 'Tester', email_addr => 'tester@example.invalid',
        title => 'Outing', description => 'Where shall we go',
        election_end => 'never', public => 'yes', no_opinion => 'yes',
        shuffle => 'no', ballot_reporting => 'yes', %params);
    my ($id)   = $out =~ m{control[^?]*\?id=(E_[0-9a-f]+)};
    my ($key)  = $out =~ m{control[^?]*\?id=E_[0-9a-f]+&key=([0-9a-f]+)};
    my ($akey) = $out =~ m{&akey=([0-9a-f]+)};
    die "could not create poll\n$out" unless $id && $key;
    my $started = post('start_election.pl', '10.0.0.1',
                       id => $id, key => $key, akey => ($akey || ''));
    die "could not start poll\n$started" unless $started =~ /has been started/;
    return ($id, $key, $akey || '');
}

# Cast one ballot, answering each question with the ranks given, or
# skipping where the ranks are undef.
sub cast {
    my ($id, $akey, $ip, @answers) = @_;
    my $receipt = '';
    for (my $q = 0; $q <= $#answers; $q++) {
        my %ranks;
        if (defined $answers[$q]) {
            my @r = @{$answers[$q]};
            for (my $i = 0; $i <= $#r; $i++) { $ranks{"C$i"} = $r[$i] }
            $ranks{'Vote'} = 'go';
        } else {
            $ranks{'Skip'} = 'skip';
        }
        my $page = post('vote.pl', $ip, id => $id, akey => $akey, q => $q,
                        ($receipt ? (receipt => $receipt) : ()), %ranks);
        if (!$receipt) { ($receipt) = $page =~ m{(E_[0-9a-f]+/[0-9a-f]+)} }
    }
    return $receipt;
}

sub caches {
    my ($id) = @_;
    opendir(my $dh, "$data/elections/$id") or die $!;
    my @f = sort grep { /^results_/ } readdir $dh;
    closedir $dh;
    return @f;
}

print "\n== a poll asking two questions ==\n";
my ($id, $key, $akey) = make_poll(
    num_questions     => 2,
    question_title    => 'Where shall we eat?', choices => "Pizza\r\nTacos",
    num_winners       => 1,
    q1_question_title => 'How shall we travel?',
    q1_choices        => "Walk\r\nBus\r\nTrain", q1_num_winners => 1,
);
# Three voters: Pizza wins question 1; Train wins question 2, but one
# voter skips it, so the two questions have different totals.
cast($id, $akey, '10.3.0.1', [1, 2], [3, 2, 1]);
cast($id, $akey, '10.3.0.2', [1, 2], [3, 2, 1]);
cast($id, $akey, '10.3.0.3', [2, 1], undef);
post('close.pl', '10.0.0.1', id => $id, key => $key, confirmation => 'close');

my $p = get('results.pl', '10.4.0.1', id => $id);
ck('the results page loads', $p =~ /Poll results/i);
ck('the poll description appears once',
   scalar(() = $p =~ /Where shall we go/g) == 1,
   scalar(() = $p =~ /Where shall we go/g));
ck('both questions are reported', $p =~ /Question 1/ && $p =~ /Question 2/);
ck('each question shows its text',
   $p =~ /Where shall we eat\?/ && $p =~ /How shall we travel\?/);
ck('each question lists its own choices',
   $p =~ /Pizza/ && $p =~ /Tacos/ && $p =~ /Walk/ && $p =~ /Train/);
ck('one settings form per question',
   scalar(() = $p =~ /class="settings"/g) == 2,
   scalar(() = $p =~ /class="settings"/g));
ck('one details section per question',
   scalar(() = $p =~ /class="details"/g) == 2);
ck('one results block per question',
   scalar(() = $p =~ /class="question_results"/g) == 2);
ck('polls are advertised once, not per question',
   scalar(() = $p =~ /class=trysomepolls/g) == 1,
   scalar(() = $p =~ /class=trysomepolls/g));

print "\n== the counts differ between the questions ==\n";
ck('three ballots for the poll', $p =~ /3/ && $p =~ /votes cast|Actual votes/i);
ck('question 1 answered three times', $p =~ /Question 1 was answered by 3 voters/);
ck('question 2 answered twice', $p =~ /Question 2 was answered by 2 voters/,
   ($p =~ /(Question 2 was answered[^<]*)/)[0]);

print "\n== each question is tabulated from its own ballots ==\n";
# Question 1: Pizza beats Tacos 2-1. Question 2: Train is ranked first by
# both voters who answered, so it must win despite question 1's ordering.
my ($q1_part, $q2_part) = split /Question 2/, $p, 2;
ck('question 1 is won by Pizza',
   $q1_part =~ m{<b>Pizza</b>}, ($q1_part =~ m{(<b>[^<]*</b>)})[0]);
ck('question 2 is won by Train',
   $q2_part =~ m{<b>Train</b>}, ($q2_part =~ m{(<b>[^<]*</b>)})[0]);
ck('question 1 matrix has 2 choices, question 2 has 3',
   scalar(() = $q1_part =~ /class="matrix"/g) == 1 &&
   scalar(() = $q2_part =~ /class="matrix"/g) == 1);
ck('the skipped ballot is absent from question 2',
   $q2_part !~ /Lost ballot/);

print "\n== a cache file per question ==\n";
my @c = caches($id);
ck('two cache files', scalar(@c) == 2, join(',', @c));
ck('question 0 has no question part in its name',
   scalar(grep { /^results_f\d+,win=/ } @c) == 1, join(',', @c));
ck('question 1 is named apart',
   scalar(grep { /^results_f\d+,q1,win=/ } @c) == 1, join(',', @c));

print "\n== settings apply to the question they came from ==\n";
$p = get('results.pl', '10.4.0.1', id => $id, q => 1, algorithm => 'beatpath');
@c = caches($id);
ck('a new cache appears for that question only',
   scalar(grep { /^results_f\d+,q1,win=1,alg=beatpath/ } @c) == 1, join(',', @c));
ck('the other question keeps its default',
   scalar(grep { /^results_f\d+,win=1,alg=minimax/ } @c) == 1, join(',', @c));
ck('the form posts which question it belongs to',
   $p =~ /name="q" value="1"/, ($p =~ /(name="q"[^>]*)/)[0]);

print "\n== a poll asking one question is unchanged ==\n";
my ($id1, $key1, $akey1) = make_poll(choices => "Red\r\nGreen", num_winners => 1);
cast($id1, $akey1, '10.5.0.1', [1, 2]);
cast($id1, $akey1, '10.5.0.2', [1, 2]);
post('close.pl', '10.0.0.1', id => $id1, key => $key1, confirmation => 'close');
$p = get('results.pl', '10.5.0.9', id => $id1);
ck('no question heading', $p !~ /<h2>Question 1<\/h2>/);
ck('no per-question count', $p !~ /was answered by/);
ck('one settings form', scalar(() = $p =~ /class="settings"/g) == 1);
ck('the winner is reported', $p =~ m{<b>Red</b>}, ($p =~ m{(<b>[^<]*</b>)})[0]);
my @c1 = caches($id1);
ck('one cache file, named as before',
   scalar(@c1) == 1 && $c1[0] =~ /^results_f\d+,win=1,alg=minimax,lang=/, join(',', @c1));
ck('the supervisor is still shown', $p =~ /tester\@example\.invalid/);
ck('the description is still shown', $p =~ /Where shall we go/);

print "\n== results cached by an earlier version are not served ==\n";
# What is cached is markup the page's stylesheet and script must agree
# with, so a cache written before that markup changed has to be ignored
# rather than reused. Such a file is named without the format marker.
open(my $stale, '>', "$data/elections/$id1/results_win=1,alg=minimax,lang=en-US")
    or die $!;
print $stale '<p>CACHED BY AN OLDER VERSION</p>';
close $stale;
$p = get('results.pl', '10.5.0.9', id => $id1);
ck('the stale cache is not served', $p !~ /CACHED BY AN OLDER VERSION/);
ck('the results are still shown', $p =~ m{<b>Red</b>});

print "\n", ($fails ? "$fails FAILED\n" : "all $checks checks passed\n");
exit($fails ? 1 : 0);
