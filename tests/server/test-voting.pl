#!/usr/bin/perl
# Voting on a poll that asks several questions: one question at a time,
# each recorded as it is answered, navigable with the receipt.
use strict; use warnings;
use DB_File; use Fcntl;

my $inst = shift @ARGV or die "usage: test-voting.pl <install dir> [source dir]\n";
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

# POST to a CGI script as though from $ip, and return the page.
sub post {
    my ($script, $ip, %params) = @_;
    my $body = join '&', map { urlencode($_) . '=' . urlencode($params{$_}) }
                         sort keys %params;
    local %ENV = (%ENV,
        REQUEST_METHOD => 'POST',
        CONTENT_TYPE   => 'application/x-www-form-urlencoded',
        CONTENT_LENGTH => length($body),
        SCRIPT_NAME    => "/$script",
        REMOTE_ADDR    => $ip,
        HTTP_HOST      => 'localhost',
    );
    my $tmp = "/tmp/civs-vote-$$";
    open(my $w, '>', $tmp) or die $!; print $w $body; close $w;
    open(my $fh, '-|') or do {
        open(STDIN, '<', $tmp) or die $!;
        exec($^X, "-I$cgi", "$cgi/$script") or die $!;
    };
    local $/; my $out = <$fh>; close $fh;
    unlink $tmp;
    return $out;
}

sub raw {
    my ($id) = @_;
    my (%e, %v, %copy);
    tie %e, 'DB_File', "$data/elections/$id/election_data", O_RDONLY, 0666, $DB_HASH or die $!;
    tie %v, 'DB_File', "$data/elections/$id/vote_data", O_RDONLY, 0666, $DB_HASH or die $!;
    %copy = (%e, map { ("v:$_" => $v{$_}) } keys %v);
    untie %e; untie %v;
    return \%copy;
}

# Create a public poll and start it. Returns its id and authorization key.
sub make_poll {
    my (%params) = @_;
    my $out = post('create_election.pl', '10.0.0.1',
        name => 'Tester', email_addr => 'tester@example.invalid',
        title => 'Outing', description => 'd', election_end => 'never',
        public => 'yes', no_opinion => 'yes', shuffle => 'no', %params);
    my ($id)   = $out =~ m{control[^?]*\?id=(E_[0-9a-f]+)};
    my ($key)  = $out =~ m{control[^?]*\?id=E_[0-9a-f]+&key=([0-9a-f]+)};
    my ($akey) = $out =~ m{&akey=([0-9a-f]+)};
    die "could not create poll\n$out" unless $id && $key;
    my $started = post('start_election.pl', '10.0.0.1',
                       id => $id, key => $key, akey => ($akey || ''));
    die "could not start poll\n$started" unless $started =~ /has been started/;
    return ($id, $akey || '');
}

sub receipt_of {
    my ($page) = @_;
    my ($r) = $page =~ m{(E_[0-9a-f]+/[0-9a-f]+)};
    return $r;
}

print "\n== a poll asking three questions ==\n";
my ($id, $akey) = make_poll(
    num_questions     => 3,
    question_title    => 'Where?',      choices => "Pizza\r\nTacos",     num_winners => 1,
    q1_question_title => 'How?',     q1_choices => "Walk\r\nBus\r\nTrain", q1_num_winners => 1,
    q2_question_title => 'When?',    q2_choices => "Noon\r\nOne",          q2_num_winners => 1,
);
ck('poll created and started', defined($id));

print "\n== the first voter answers every question ==\n";
my $ip = '10.1.0.1';
my $p = post('vote.pl', $ip, id => $id, akey => $akey, q => 0);
ck('opens on question 1 of 3', $p =~ /Question 1 of 3/, ($p =~ /Question \d of \d/)[0]);
ck('shows the question text', $p =~ /Where\?/);
# When the poll ends and who runs it belong to the poll, so they are said
# once, above the questions; how many choices win belongs to the question.
ck('the supervisor is named above the question',
   index($p, 'poll supervisor is') < index($p, 'Question 1 of 3')
   && index($p, 'poll supervisor is') > 0);
ck('and said only once', scalar(() = $p =~ /poll supervisor is/g) == 1,
   scalar(() = $p =~ /poll supervisor is/g));
ck('the winner count sits with the question',
   index($p, 'will win.') > index($p, 'Question 1 of 3'));
ck('and no longer claims to win the poll', $p !~ /will win the poll/);
# The description is of the whole poll, so it belongs above the question
# rather than below it.
ck('the poll description comes before the question',
   index($p, 'class="description"') < index($p, 'Question 1 of 3')
   && index($p, 'class="description"') > 0,
   index($p, 'class="description"') . ' vs ' . index($p, 'Question 1 of 3'));
ck('and the description appears once', scalar(() = $p =~ /class="description"/g) == 1,
   scalar(() = $p =~ /class="description"/g));
ck('offers to skip', $p =~ /value="Skip this question" name="Skip"/,
   ($p =~ /(value="[^"]*" name="Skip")/)[0]);
ck('does not offer to go back from the first', $p !~ /name="Previous"/);
# Skipping records no ballot, so it must not run the checks made of one:
# the warning that a ballot would have no effect, and the demand for an
# identifier.
ck('skipping turns off the ballot checks',
   $p =~ /name="Skip" onclick="window\.skip_ballot_checks = true"/,
   ($p =~ /(name="Skip"[^>]*)/)[0]);

# Rank Pizza first, Tacos second.
$p = post('vote.pl', $ip, id => $id, akey => $akey, q => 0,
          C0 => 1, C1 => 2, Vote => 'go');
my $receipt = receipt_of($p);
ck('moves on to question 2', $p =~ /Question 2 of 3/, ($p =~ /Question \d of \d/)[0]);
ck('hands over a receipt straight away', defined($receipt), $receipt);
# The receipt is worth keeping, so it comes with the same copy-to-clipboard
# control the control page offers for a poll's link.
ck('with an icon that copies it',
   $p =~ /copy_element\('midvote_receipt_text', 'midvote_receipt_popup'/,
   ($p =~ /(copy_element\([^)]*\))/)[0]);
ck('the receipt is in the element that icon reads',
   $p =~ /id="midvote_receipt_text">\Q$receipt\E</, $receipt);
ck('offers to go back', $p =~ /name="Previous"/);
ck('going back turns off the ballot checks too',
   $p =~ /name="Previous" onclick="window\.skip_ballot_checks = true"/,
   ($p =~ /(name="Previous"[^>]*)/)[0]);

my $d = raw($id);
ck('question 1 was recorded at once', defined($d->{'v:recorded_voters'}));
my $bkey = $d->{'v:recorded_voters'};
ck('under the unprefixed ballot key', ($d->{"v:$bkey"} // '') eq '1,2', $d->{"v:$bkey"});
ck('its matrix counts Pizza over Tacos', ($d->{'v:0.1'} // 0) == 1 && ($d->{'v:1.0'} // 0) == 0);
ck('one answer counted for question 1', ($d->{'v:answered'} // 0) == 1);
ck('nothing recorded for question 2 yet', !defined($d->{"v:q1.$bkey"}));
ck('one ballot in the poll', ($d->{'v:num_votes'} // 0) == 1);

$p = post('vote.pl', $ip, id => $id, akey => $akey, q => 1, receipt => $receipt,
          C0 => 2, C1 => 1, C2 => 3, Vote => 'go');
ck('moves on to question 3', $p =~ /Question 3 of 3/);
ck('the last question offers to finish', $p =~ /name="Vote"/ && $p =~ /finish/i);

$p = post('vote.pl', $ip, id => $id, akey => $akey, q => 2, receipt => $receipt,
          C0 => 1, C1 => 2, Vote => 'go');
ck('finishing thanks the voter', $p =~ /[Tt]hank/, ($p =~ /<h1>(.*?)</)[0]);
ck('the final receipt is copyable too',
   $p =~ /id="final_receipt_text">\Q$receipt\E</ &&
   $p =~ /copy_element\('final_receipt_text', 'final_receipt_popup'/,
   ($p =~ /(final_receipt[^>]*>)/)[0]);
$d = raw($id);
ck('all three answers stored', defined($d->{"v:$bkey"}) &&
   defined($d->{"v:q1.$bkey"}) && defined($d->{"v:q2.$bkey"}));
ck('question 2 stored under its prefix', ($d->{"v:q1.$bkey"} // '') eq '2,1,3');
ck('question 2 matrix is its own', ($d->{'v:q1.1.0'} // 0) == 1 && ($d->{'v:q1.0.1'} // 0) == 0);
ck('still just one ballot', ($d->{'v:num_votes'} // 0) == 1);
ck('one recorded voter', scalar(split /\n/, $d->{'v:recorded_voters'}) == 1);

print "\n== going back and changing an answer ==\n";
$p = post('vote.pl', $ip, id => $id, akey => $akey, q => 0, receipt => $receipt);
ck('the receipt gets back in', $p =~ /Question 1 of 3/, ($p =~ /Question \d of \d/)[0]);
ck('the earlier answer is shown selected', $p =~ /name="C0".*?selected/s);
# Moving past an answered question throws the answer away, so the button
# says so rather than offering to "skip".
ck('the skip button now offers to discard',
   $p =~ /value="Discard this answer" name="Skip"/,
   ($p =~ /(value="[^"]*" name="Skip")/)[0]);
$p = post('vote.pl', $ip, id => $id, akey => $akey, q => 0, receipt => $receipt,
          C0 => 2, C1 => 1, Vote => 'go');
$d = raw($id);
ck('the answer was replaced', ($d->{"v:$bkey"} // '') eq '2,1', $d->{"v:$bkey"});
ck('the matrix followed it', ($d->{'v:0.1'} // 0) == 0 && ($d->{'v:1.0'} // 0) == 1);
ck('it was not counted twice', ($d->{'v:answered'} // 0) == 1);
ck('no second ballot appeared', ($d->{'v:num_votes'} // 0) == 1);

print "\n== a second voter skips a question ==\n";
my $ip2 = '10.1.0.2';
$p = post('vote.pl', $ip2, id => $id, akey => $akey, q => 0, C0 => 1, C1 => 2, Vote => 'go');
my $receipt2 = receipt_of($p);
ck('a separate ballot', defined($receipt2) && $receipt2 ne $receipt);
$p = post('vote.pl', $ip2, id => $id, akey => $akey, q => 1, receipt => $receipt2, Skip => 'skip');
ck('skipping moves on', $p =~ /Question 3 of 3/);
$p = post('vote.pl', $ip2, id => $id, akey => $akey, q => 2, receipt => $receipt2,
          C0 => 1, C1 => 2, Vote => 'go');
$d = raw($id);
my @voters = split /\n/, $d->{'v:recorded_voters'};
my ($bkey2) = grep { $_ ne $bkey } @voters;
ck('two ballots now', scalar(@voters) == 2 && ($d->{'v:num_votes'} // 0) == 2);
ck('the skipped question holds nothing for them', !defined($d->{"v:q1.$bkey2"}));
ck('the others do', defined($d->{"v:$bkey2"}) && defined($d->{"v:q2.$bkey2"}));
ck('question 1 counts two answers', ($d->{'v:answered'} // 0) == 2);
ck('question 2 still counts one', ($d->{'v:q1.answered'} // 0) == 1, $d->{'v:q1.answered'});
ck('question 3 counts two', ($d->{'v:q2.answered'} // 0) == 2);

print "\n== skipping withdraws an answer already given ==\n";
$p = post('vote.pl', $ip2, id => $id, akey => $akey, q => 2, receipt => $receipt2, Skip => 'skip');
$d = raw($id);
ck('the answer is gone', !defined($d->{"v:q2.$bkey2"}));
ck('the count went down', ($d->{'v:q2.answered'} // 0) == 1);
ck('the matrix went down too', ($d->{'v:q2.0.1'} // 0) == 1, $d->{'v:q2.0.1'});

print "\n== a voter who returns without their receipt ==\n";
$p = post('vote.pl', $ip2, id => $id, akey => $akey, q => 0);
ck('is told they have already voted', $p =~ /already/i, ($p =~ /<h1>(.*?)</)[0]);
ck('and no new ballot was made', scalar(split /\n/, raw($id)->{'v:recorded_voters'}) == 2);

print "\n== a bad receipt is refused ==\n";
$p = post('vote.pl', '10.1.0.9', id => $id, akey => $akey, q => 0,
          receipt => "$id/deadbeef");
ck('rejected', $p =~ /voter receipt[^<]*is incorrect/,
   ($p =~ /(<div class="contents">.{0,120})/s)[0]);
ck('and no ballot was made for it',
   scalar(split /\n/, raw($id)->{'v:recorded_voters'}) == 2);
ck('no ballot form is offered', $p !~ /name="Vote"/);

print "\n== hostile question indices and receipts ==\n";
# q selects a question, indexes @questions, and becomes part of database
# keys and of a downloaded file's name, so nothing but a small natural
# number may get through.
foreach my $bad ('-1', '999999', '007', '0.5', '../../etc/passwd', '1;rm',
                 '<script>', '1 OR 1=1', '', 'q1') {
    my $page = post('vote.pl', '10.9.0.1', id => $id, akey => $akey,
                    q => $bad, receipt => $receipt);
    my ($shown) = $page =~ /Question (\d+) of 3/;
    ck("q='$bad' falls back to a real question",
       defined($shown) && $shown >= 1 && $shown <= 3, $shown);
}
ck('no stray keys were created by any of that',
   !grep(/^v:q(?!\d+\.)/, keys %{raw($id)}),
   join(',', grep(/^v:q/, keys %{raw($id)})));

foreach my $bad ("$id/../../etc", "$id/deadbeef\nX", 'E_x/y', "$id/",
                 "/$id/00", "$id/00 ") {
    my $page = post('vote.pl', '10.9.0.2', id => $id, akey => $akey,
                    q => 0, receipt => $bad);
    ck("receipt '" . substr($bad, 0, 24) . "' is refused",
       $page =~ /voter receipt[^<]*is incorrect|already/,
       ($page =~ /(voter receipt[^<]{0,40})/)[0]);
}
ck('and the ballots are untouched',
   scalar(split /\n/, raw($id)->{'v:recorded_voters'}) == 2);

print "\n== a poll asking one question is unchanged ==\n";
my ($id1, $akey1) = make_poll(choices => "Red\r\nGreen", num_winners => 1);
$p = post('vote.pl', '10.2.0.1', id => $id1, akey => $akey1);
ck('no question numbering', $p !~ /Question 1 of/);
ck('no skip button', $p !~ /name="Skip"/);
ck('no previous button', $p !~ /name="Previous"/);
ck('one submit button', scalar(() = $p =~ /type="submit"/g) >= 1);
$p = post('vote.pl', '10.2.0.1', id => $id1, akey => $akey1, C0 => 1, C1 => 2, Vote => 'go');
ck('voting finishes at once', $p =~ /[Tt]hank/, ($p =~ /<h1>(.*?)</)[0]);
ck('with a receipt', defined(receipt_of($p)));
my $d1 = raw($id1);
my $b1 = $d1->{'v:recorded_voters'};
ck('stored under the plain ballot key', ($d1->{"v:$b1"} // '') eq '1,2');
ck('plain matrix keys', ($d1->{'v:0.1'} // 0) == 1);
ck('one vote', ($d1->{'v:num_votes'} // 0) == 1);
ck('no q1 keys anywhere', !grep(/^v:q\d/, keys %$d1), join(',', grep(/^v:q\d/, keys %$d1)));

print "\n", ($fails ? "$fails FAILED\n" : "all $checks checks passed\n");
exit($fails ? 1 : 0);
