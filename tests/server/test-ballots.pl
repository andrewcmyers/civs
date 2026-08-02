#!/usr/bin/perl
# Downloading and uploading ballots for a poll that asks several
# questions: one question's ballots at a time, in the format a poll asking
# one question has always used.
use strict; use warnings;
use DB_File; use Fcntl;

my $inst = shift @ARGV or die "usage: test-ballots.pl <install dir> [source dir]\n";
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
    my ($script, $ip, $method, $upload, %params) = @_;
    local %ENV = (%ENV, SCRIPT_NAME => "/$script", REMOTE_ADDR => $ip,
                        HTTP_HOST => 'localhost');
    my $tmp = "/tmp/civs-bal-$$";
    my $body;
    if ($method eq 'GET') {
        $ENV{REQUEST_METHOD} = 'GET';
        $ENV{QUERY_STRING} = join '&',
            map { urlencode($_) . '=' . urlencode($params{$_}) } sort keys %params;
        $body = '';
    } elsif ($upload) {
        # A file upload has to be multipart.
        my $b = 'civsboundary';
        $ENV{REQUEST_METHOD} = 'POST';
        $ENV{CONTENT_TYPE} = "multipart/form-data; boundary=$b";
        delete $ENV{QUERY_STRING};
        $body = '';
        foreach my $k (sort keys %params) {
            $body .= "--$b\r\nContent-Disposition: form-data; name=\"$k\"\r\n\r\n"
                   . "$params{$k}\r\n";
        }
        $body .= "--$b\r\nContent-Disposition: form-data;"
               . " name=\"$upload->[0]\"; filename=\"ballots.txt\"\r\n"
               . "Content-Type: text/plain\r\n\r\n$upload->[1]\r\n";
        $body .= "--$b--\r\n";
        $ENV{CONTENT_LENGTH} = length($body);
    } else {
        $ENV{REQUEST_METHOD} = 'POST';
        $ENV{CONTENT_TYPE} = 'application/x-www-form-urlencoded';
        delete $ENV{QUERY_STRING};
        $body = join '&',
            map { urlencode($_) . '=' . urlencode($params{$_}) } sort keys %params;
        $ENV{CONTENT_LENGTH} = length($body);
    }
    open(my $w, '>', $tmp) or die $!; print $w $body; close $w;
    open(my $fh, '-|') or do {
        open(STDIN, '<', $tmp) or die $!;
        exec($^X, "-I$cgi", "$cgi/$script") or die $!;
    };
    local $/; my $out = <$fh>; close $fh;
    unlink $tmp;
    return $out;
}
sub post   { my ($s,$ip,%p) = @_; return request($s,$ip,'POST',undef,%p) }
sub get    { my ($s,$ip,%p) = @_; return request($s,$ip,'GET',undef,%p) }
sub upload { my ($s,$ip,$u,%p) = @_; return request($s,$ip,'POST',$u,%p) }

sub vdata {
    my ($id) = @_;
    my (%v, %copy);
    tie %v, 'DB_File', "$data/elections/$id/vote_data", O_RDONLY, 0666, $DB_HASH or die $!;
    %copy = %v;
    untie %v;
    return \%copy;
}

sub make_poll {
    my (%params) = @_;
    my $out = post('create_election.pl', '10.0.0.1',
        name => 'Tester', email_addr => 'tester@example.invalid',
        title => 'Outing', description => 'd', election_end => 'never',
        public => 'yes', no_opinion => 'yes', shuffle => 'no',
        ballot_reporting => 'yes', %params);
    my ($id)   = $out =~ m{control[^?]*\?id=(E_[0-9a-f]+)};
    my ($key)  = $out =~ m{control[^?]*\?id=E_[0-9a-f]+&key=([0-9a-f]+)};
    my ($akey) = $out =~ m{&akey=([0-9a-f]+)};
    die "could not create poll\n$out" unless $id && $key;
    return ($id, $key, $akey || '');
}

sub start { my ($id,$key,$akey) = @_;
    post('start_election.pl', '10.0.0.1', id=>$id, key=>$key, akey=>$akey) }

sub cast {
    my ($id, $akey, $ip, @answers) = @_;
    my $receipt = '';
    for (my $q = 0; $q <= $#answers; $q++) {
        my %ranks;
        if (defined $answers[$q]) {
            my @r = @{$answers[$q]};
            for (my $i = 0; $i <= $#r; $i++) { $ranks{"C$i"} = $r[$i] }
            $ranks{'Vote'} = 'go';
        } else { $ranks{'Skip'} = 'skip' }
        my $page = post('vote.pl', $ip, id=>$id, akey=>$akey, q=>$q,
                        ($receipt ? (receipt=>$receipt) : ()), %ranks);
        if (!$receipt) { ($receipt) = $page =~ m{(E_[0-9a-f]+/[0-9a-f]+)} }
    }
}

# The CSV body of a download, without the HTTP headers.
sub csv {
    my ($page) = @_;
    my ($body) = $page =~ /\r?\n\r?\n(.*)/s;
    return defined($body) ? $body : '';
}

print "\n== downloading a poll's ballots, question by question ==\n";
my ($id, $key, $akey) = make_poll(
    num_questions     => 2,
    question_title    => 'Where?',  choices => "Pizza\r\nTacos", num_winners => 1,
    q1_question_title => 'How?', q1_choices => "Walk\r\nBus\r\nTrain",
    q1_num_winners    => 1,
);
start($id, $key, $akey);
cast($id, $akey, '10.6.0.1', [1, 2], [3, 2, 1]);
cast($id, $akey, '10.6.0.2', [2, 1], undef);      # skips question 2
post('close.pl', '10.0.0.1', id => $id, key => $key, confirmation => 'close');

my $d0 = csv(get('download_ballots.pl', '10.7.0.1', id => $id));
my $d1 = csv(get('download_ballots.pl', '10.7.0.1', id => $id, q => 1));
ck('question 1 names its own choices', $d0 =~ /\APizza,Tacos\n/, (split /\n/, $d0)[0]);
ck('question 2 names its own choices', $d1 =~ /\AWalk,Bus,Train\n/, (split /\n/, $d1)[0]);
ck('question 1 has both ballots',
   scalar(grep { /\S/ } (split /\n/, $d0)[1..2]) == 2, $d0);
ck('question 2 has only the ballot that answered it',
   scalar(grep { /\S/ } split /\n/, $d1) == 2, $d1);
ck('and it is the right one', $d1 =~ /\n3,2,1\n?\z/, $d1);
ck('the files are named apart',
   get('download_ballots.pl', '10.7.0.1', id => $id, q => 1)
       =~ /civs_ballots_q2\.csv/);

print "\n== a poll asking one question downloads as before ==\n";
my ($id1, $key1, $akey1) = make_poll(choices => "Red\r\nGreen", num_winners => 1);
start($id1, $key1, $akey1);
cast($id1, $akey1, '10.8.0.1', [1, 2]);
post('close.pl', '10.0.0.1', id => $id1, key => $key1, confirmation => 'close');
my $one = get('download_ballots.pl', '10.8.0.9', id => $id1);
ck('the plain filename', $one =~ /civs_ballots\.csv/ && $one !~ /_q\d/);
ck('choices then ballots', csv($one) =~ /\ARed,Green\n1,2\n?\z/, csv($one));

print "\n== uploading ballots for a test poll, question by question ==\n";
my ($tid, $tkey, $takey) = make_poll(
    external_ballots  => 'yes', num_questions => 2,
    question_title    => 'Where?',  choices => "Pizza\r\nTacos", num_winners => 1,
    q1_question_title => 'How?', q1_choices => "Walk\r\nBus\r\nTrain",
    q1_num_winners    => 1,
);
my $p = upload('upload_ballots.pl', '10.0.0.1', ['ballot_data', "1,2\n2,1\n1,2\n"],
               id => $tid, key => $tkey, akey => $takey, q => 0);
ck('question 1 accepted', $p =~ /uploaded successfully/, ($p =~ /(Errors.*)/)[0]);
my $v = vdata($tid);
ck('three ballots recorded',
   ($v->{'recorded_voters'} // '') eq "ext0\next1\next2", $v->{'recorded_voters'});
ck('stored under the plain ballot keys', ($v->{'ext0'} // '') eq '1,2');
ck('question 1 matrix', ($v->{'0.1'} // 0) == 2 && ($v->{'1.0'} // 0) == 1);
ck('question 1 answer count', ($v->{'answered'} // 0) == 3);

$p = upload('upload_ballots.pl', '10.0.0.1', ['ballot_data', "3,2,1\n3,2,1\n"],
            id => $tid, key => $tkey, akey => $takey, q => 1);
ck('question 2 accepted', $p =~ /uploaded successfully/, ($p =~ /(Errors.*)/)[0]);
$v = vdata($tid);
ck('question 1 ballots survived the second upload',
   ($v->{'ext0'} // '') eq '1,2' && ($v->{'ext2'} // '') eq '1,2',
   $v->{'ext0'});
ck('the recorded voters were not lost',
   ($v->{'recorded_voters'} // '') eq "ext0\next1\next2", $v->{'recorded_voters'});
ck('question 2 stored under its prefix', ($v->{'q1.ext0'} // '') eq '3,2,1');
ck('question 2 has no answer from the third ballot', !defined($v->{'q1.ext2'}));
ck('question 2 matrix is its own', ($v->{'q1.2.0'} // 0) == 2);
ck('the counts differ',
   ($v->{'answered'} // 0) == 3 && ($v->{'q1.answered'} // 0) == 2,
   ($v->{'answered'} // 0) . '/' . ($v->{'q1.answered'} // 0));
ck('the poll holds as many ballots as its longest question',
   ($v->{'num_votes'} // 0) == 3, $v->{'num_votes'});

print "\n== re-uploading a question replaces it ==\n";
$p = upload('upload_ballots.pl', '10.0.0.1', ['ballot_data', "1,2\n"],
            id => $tid, key => $tkey, akey => $takey, q => 0);
ck('accepted', $p =~ /uploaded successfully/);
$v = vdata($tid);
ck('the surplus ballots are gone', !defined($v->{'ext1'}) && !defined($v->{'ext2'}));
ck('the count follows', ($v->{'answered'} // 0) == 1);
ck('the matrix follows', ($v->{'0.1'} // 0) == 1 && ($v->{'1.0'} // 0) == 0);
ck('the poll still holds the other question\'s two ballots',
   ($v->{'num_votes'} // 0) == 2 &&
   ($v->{'recorded_voters'} // '') eq "ext0\next1", $v->{'recorded_voters'});

print "\n== the control page asks which question a file is for ==\n";
$p = post('control.pl', '10.0.0.1', id => $tid, key => $tkey, akey => $takey);
ck('a question selector appears', $p =~ /name="q"/ && $p =~ /Question 2/);
my ($sid, $skey, $sakey) = make_poll(external_ballots => 'yes',
                                     choices => "Red\r\nGreen", num_winners => 1);
$p = post('control.pl', '10.0.0.1', id => $sid, key => $skey, akey => $sakey);
ck('but not for a poll asking one question',
   $p !~ /These ballots answer/, ($p =~ /(These ballots[^<]*)/)[0]);

print "\n", ($fails ? "$fails FAILED\n" : "all $checks checks passed\n");
exit($fails ? 1 : 0);
