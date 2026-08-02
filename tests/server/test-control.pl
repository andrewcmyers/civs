#!/usr/bin/perl
# The supervisor's control page for a poll that asks several questions.
use strict; use warnings;
use DB_File; use Fcntl;

my $inst = shift @ARGV or die "usage: test-control.pl <install dir> [source dir]\n";
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
    my $tmp = "/tmp/civs-control-$$";
    open(my $w, '>', $tmp) or die $!; print $w $body; close $w;
    open(my $fh, '-|') or do {
        open(STDIN, '<', $tmp) or die $!;
        exec($^X, "-I$cgi", "$cgi/$script") or die $!;
    };
    local $/; my $out = <$fh>; close $fh;
    unlink $tmp;
    return $out;
}

sub edata {
    my ($id) = @_;
    my (%e, %copy);
    tie %e, 'DB_File', "$data/elections/$id/election_data", O_RDONLY, 0666, $DB_HASH or die $!;
    %copy = %e;
    untie %e;
    return \%copy;
}

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
    return ($id, $key, $akey || '');
}

print "\n== a poll asking three questions ==\n";
my ($id, $key, $akey) = make_poll(
    num_questions     => 3,   writeins => 'yes',
    question_title    => 'Where?',   choices => "Pizza\r\nTacos",       num_winners => 1,
    q1_question_title => 'How?',  q1_choices => "Walk\r\nBus\r\nTrain", q1_num_winners => 2,
    q1_proportional => 'yes', q1_rating_interpretation => 'combined_ratings',
    q2_question_title => 'When?', q2_choices => "Noon\r\nOne",          q2_num_winners => 1,
);
my $p = post('control.pl', '10.0.0.1', id => $id, key => $key, akey => $akey);
ck('the control page loads', $p =~ /Poll Control|Poll control/i);
ck('each question gets a heading',
   $p =~ /Question 1/ && $p =~ /Question 2/ && $p =~ /Question 3/);
ck('each question shows its text',
   $p =~ /Where\?/ && $p =~ /How\?/ && $p =~ /When\?/);
ck('each question lists its own choices',
   $p =~ /Pizza/ && $p =~ /Walk/ && $p =~ /Noon/);
ck('one candidate list per question',
   scalar(() = $p =~ /class='candidates'/g) == 3,
   scalar(() = $p =~ /class='candidates'/g));
ck('the differing winner counts are both reported',
   $p =~ /top 2|two/i, ($p =~ /(top [^<.]*)/)[0]);

print "\n== proportional representation belongs to one question ==\n";
my $e0 = edata($id);
ck('only the question that asked for it has it',
   ($e0->{'proportional'} // 'no') eq 'no' && ($e0->{'q1.proportional'} // '') eq 'yes'
   && ($e0->{'q2.proportional'} // 'no') eq 'no',
   join(',', map { $e0->{$_} // 'undef' } qw(proportional q1.proportional q2.proportional)));
ck('and its rating interpretation goes with it',
   ($e0->{'q1.use_combined_ratings'} // 0) eq '1'
   && ($e0->{'use_combined_ratings'} // 0) eq '0',
   ($e0->{'use_combined_ratings'} // 'undef') . '/' . ($e0->{'q1.use_combined_ratings'} // 'undef'));
ck('the control page says which question it applies to',
   $p =~ /Question 2: uses the proportional representation/,
   ($p =~ /(Question \d+: uses[^<.]*)/)[0]);
ck('and does not claim it for the whole poll',
   $p !~ /This poll uses the proportional/);

print "\n== a write-in added to the second question ==\n";
post('vote.pl', '10.1.0.1', id => $id, akey => $akey, q => 1,
     AddWritein => 'add', writein => 'Cycle');
my $d = edata($id);
ck('it went into that question', ($d->{'q1.choices'} // '') =~ /Cycle \(write-in\)/,
   $d->{'q1.choices'});
ck('and not into another', ($d->{'choices'} // '') !~ /Cycle/, $d->{'choices'});

$p = post('control.pl', '10.0.0.1', id => $id, key => $key, akey => $akey);
ck('the control page offers to remove it', $p =~ /Cycle \(write-in\)/ && $p =~ /remove/i);
# CGI.pm escapes the quotes inside an attribute, so compare unescaped.
my $unescaped = $p;
$unescaped =~ s/&#39;/'/g;
ck('the remove button names the question it belongs to',
   $unescaped =~ /elements\.writein\.value = '3';\s*document\.RemoveWritein\.elements\.q\.value = '1'/,
   ($unescaped =~ /(elements\.q\.value = '\d')/)[0]);

print "\n== removing it ==\n";
$p = post('remove_writein.pl', '10.0.0.1',
          id => $id, key => $key, akey => $akey, q => 1, writein => 3);
$d = edata($id);
ck('gone from that question', ($d->{'q1.choices'} // '') !~ /Cycle/, $d->{'q1.choices'});
ck('that question keeps its other choices',
   ($d->{'q1.choices'} // '') =~ /Walk/ && ($d->{'q1.choices'} // '') =~ /Train/);
ck('other questions untouched', ($d->{'choices'} // '') =~ /Pizza/);

print "\n== disallowing write-ins ==\n";
ck('they are allowed to start with',
   ($d->{'writeins'} // '') eq 'yes' && ($d->{'q1.writeins'} // '') eq 'yes');
$p = post('control.pl', '10.0.0.1',
          id => $id, key => $key, akey => $akey, nowriteins => 'stop');
$d = edata($id);
ck('turned off for every question',
   ($d->{'writeins'} // '') eq 'no' && ($d->{'q1.writeins'} // '') eq 'no'
   && ($d->{'q2.writeins'} // '') eq 'no',
   join(',', map { $d->{$_} // 'undef' } qw(writeins q1.writeins q2.writeins)));
ck('and the page says so', $p =~ /disabled|not allowed/i);

print "\n== counts once people have voted ==\n";
# One voter answers everything; another skips the middle question.
my $r1 = post('vote.pl', '10.2.0.1', id => $id, akey => $akey, q => 0,
              C0 => 1, C1 => 2, Vote => 'go');
my ($rec1) = $r1 =~ m{(E_[0-9a-f]+/[0-9a-f]+)};
post('vote.pl', '10.2.0.1', id => $id, akey => $akey, q => 1, receipt => $rec1,
     C0 => 1, C1 => 2, C2 => 3, Vote => 'go');
post('vote.pl', '10.2.0.1', id => $id, akey => $akey, q => 2, receipt => $rec1,
     C0 => 1, C1 => 2, Vote => 'go');
my $r2 = post('vote.pl', '10.2.0.2', id => $id, akey => $akey, q => 0,
              C0 => 2, C1 => 1, Vote => 'go');
my ($rec2) = $r2 =~ m{(E_[0-9a-f]+/[0-9a-f]+)};
post('vote.pl', '10.2.0.2', id => $id, akey => $akey, q => 1, receipt => $rec2,
     Skip => 'skip');
post('vote.pl', '10.2.0.2', id => $id, akey => $akey, q => 2, receipt => $rec2,
     C0 => 1, C1 => 2, Vote => 'go');

$p = post('control.pl', '10.0.0.1', id => $id, key => $key, akey => $akey);
ck('two ballots reported', $p =~ /cast so far:\s*2/, ($p =~ /(cast so far:[^<]*)/)[0]);
ck('question 1 answered twice', $p =~ /Question 1 was answered by 2 voters/);
ck('question 2 answered once', $p =~ /Question 2 was answered by 1 voters/,
   ($p =~ /(Question 2 was answered[^<]*)/)[0]);
ck('question 3 answered twice', $p =~ /Question 3 was answered by 2 voters/);

print "\n== a poll asking one question is unchanged ==\n";
my ($id1, $key1, $akey1) = make_poll(choices => "Red\r\nGreen", num_winners => 1);
$p = post('control.pl', '10.0.0.1', id => $id1, key => $key1, akey => $akey1);
ck('no question headings', $p !~ /<h3>Question/);
ck('no per-question counts', $p !~ /was answered by/);
ck('one candidate list', scalar(() = $p =~ /class='candidates'/g) == 1);
ck('the choices are listed', $p =~ /Red/ && $p =~ /Green/);
ck('remove-writein still posts question 0',
   $p =~ /name="q" value="0"/, ($p =~ /(name="q"[^>]*)/)[0]);

print "\n", ($fails ? "$fails FAILED\n" : "all $checks checks passed\n");
exit($fails ? 1 : 0);
