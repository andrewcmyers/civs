#!/usr/bin/perl
# A poll created before polls could ask more than one question, with
# ballots already cast, has to go on working untouched. The fixture is a
# poll made the ordinary way and then stripped of every key that only
# exists now, which is what such a poll looks like on disk.
use strict; use warnings;
use DB_File; use Fcntl;

my $inst = shift @ARGV or die "usage: test-legacy.pl <install dir> [source dir]\n";
my $root = shift @ARGV || '.';
my $cgi  = "$inst/cgi";
my $data = "$inst/data";

my ($fails, $checks) = (0, 0);
# See the note in test-storage.pl: the prototype keeps a failing match from
# shifting the arguments along and turning a failure into a pass.
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
    my $tmp = "/tmp/civs-legacy-$$";
    if ($method eq 'GET') {
        $ENV{REQUEST_METHOD} = 'GET'; $ENV{QUERY_STRING} = $body;
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
sub post { my ($s,$ip,%p) = @_; return request($s,$ip,'POST',%p) }
sub get  { my ($s,$ip,%p) = @_; return request($s,$ip,'GET',%p) }

sub db {
    my ($id, $which, $mode) = @_;
    my %h;
    tie %h, 'DB_File', "$data/elections/$id/$which", $mode, 0666, $DB_HASH
        or die "$which: $!";
    return \%h;
}
sub snapshot {
    my ($id) = @_;
    my $e = db($id, 'election_data', O_RDONLY);
    my $v = db($id, 'vote_data', O_RDONLY);
    my %c = (%$e, map { ("v:$_" => $v->{$_}) } keys %$v);
    untie %$e; untie %$v;
    return \%c;
}

print "\n== building a poll and ageing it back ==\n";
my $out = post('create_election.pl', '10.0.0.1',
    name => 'Tester', email_addr => 'tester@example.invalid',
    title => 'Old poll', description => 'from before', election_end => 'never',
    public => 'yes', no_opinion => 'yes', shuffle => 'no', writeins => 'yes',
    allow_voting => 'yes',
    ballot_reporting => 'yes', choices => "Red\r\nGreen\r\nBlue", num_winners => 1);
my ($id)   = $out =~ m{control[^?]*\?id=(E_[0-9a-f]+)};
my ($key)  = $out =~ m{control[^?]*\?id=E_[0-9a-f]+&key=([0-9a-f]+)};
my ($akey) = $out =~ m{&akey=([0-9a-f]+)};
die "could not create poll\n$out" unless $id && $key;
post('start_election.pl', '10.0.0.1', id=>$id, key=>$key, akey=>$akey);

# Three ballots: Red first twice, Green first once.
foreach my $b (['10.9.1.1', 1, 2, 3], ['10.9.1.2', 1, 2, 3], ['10.9.1.3', 2, 1, 3]) {
    my ($ip, @r) = @$b;
    post('vote.pl', $ip, id=>$id, akey=>$akey, C0=>$r[0], C1=>$r[1], C2=>$r[2],
         Vote=>'go');
}

# Strip everything a poll from before this work would not have had.
{
    my $e = db($id, 'election_data', O_RDWR);
    delete $e->{'num_questions'};
    delete $e->{'question_title'};
    untie %$e;
    my $v = db($id, 'vote_data', O_RDWR);
    delete $v->{'answered'};
    untie %$v;
}
my $s = snapshot($id);
ck('no num_questions, as an old poll has none', !defined($s->{'num_questions'}));
ck('no question_title either', !defined($s->{'question_title'}));
ck('no answer counter', !defined($s->{'v:answered'}));
ck('but three ballots are recorded', ($s->{'v:num_votes'} // 0) == 3);
ck('under the plain ballot keys',
   scalar(grep { /^v:[0-9a-f]{16}$/ } keys %$s) == 3,
   join(',', grep { /^v:[0-9a-f]+$/ } keys %$s));
ck('with a plain matrix', ($s->{'v:0.1'} // 0) == 2 && ($s->{'v:1.0'} // 0) == 1);

print "\n== the control page ==\n";
my $p = post('control.pl', '10.0.0.1', id=>$id, key=>$key, akey=>$akey);
ck('loads', $p =~ /Poll Control|Poll control/i);
ck('no question headings', $p !~ /<h3>Question/);
ck('no per-question counts', $p !~ /was answered by/);
ck('the choices are listed', $p =~ /Red/ && $p =~ /Green/ && $p =~ /Blue/);
ck('three votes reported', $p =~ /cast so far:\s*3/, ($p =~ /(cast so far:[^<]*)/)[0]);

print "\n== results ==\n";
post('close.pl', '10.0.0.1', id=>$id, key=>$key, confirmation=>'close');
$p = get('results.pl', '10.9.2.1', id=>$id);
ck('the poll is tabulated', $p =~ /Poll results/i);
ck('from the old matrix, Red wins', $p =~ m{<b>Red</b>}, ($p =~ m{(<b>[^<]*</b>)})[0]);
ck('no question heading', $p !~ /<h2>Question 1<\/h2>/);
# A heading row and one row per ballot.
my ($ballot_table) = $p =~ /(<table class="ballots".*?<\/table>)/s;
ck('the ballot report holds all three',
   defined($ballot_table) && scalar(() = $ballot_table =~ /<tr>/g) == 4,
   defined($ballot_table) ? scalar(() = $ballot_table =~ /<tr>/g) : 'no table');

print "\n== downloading its ballots ==\n";
my $csv = get('download_ballots.pl', '10.9.2.2', id=>$id);
ck('named as before', $csv =~ /civs_ballots\.csv/ && $csv !~ /_q\d/);
my ($body) = $csv =~ /\r?\n\r?\n(.*)/s;
ck('choices then three ballots',
   ($body // '') =~ /\ARed,Green,Blue\n(\d,\d,\d\n){3}\z/, $body);

print "\n== a write-in added to a poll that already has votes ==\n";
# The new choice has to count as ranked last by everyone who has already
# voted, which is what the matrix column records. Before questions
# existed that came from the poll's vote count.
my ($id2, $key2, $akey2);
{
    my $o = post('create_election.pl', '10.0.0.1',
        name => 'Tester', email_addr => 'tester@example.invalid',
        title => 'Old poll 2', description => 'd', election_end => 'never',
        public => 'yes', no_opinion => 'yes', shuffle => 'no', writeins => 'yes',
    allow_voting => 'yes',
        choices => "Red\r\nGreen", num_winners => 1);
    ($id2)   = $o =~ m{control[^?]*\?id=(E_[0-9a-f]+)};
    ($key2)  = $o =~ m{control[^?]*\?id=E_[0-9a-f]+&key=([0-9a-f]+)};
    ($akey2) = $o =~ m{&akey=([0-9a-f]+)};
    post('start_election.pl', '10.0.0.1', id=>$id2, key=>$key2, akey=>$akey2);
    foreach my $ip ('10.9.3.1', '10.9.3.2') {
        post('vote.pl', $ip, id=>$id2, akey=>$akey2, C0=>1, C1=>2, Vote=>'go');
    }
    my $e = db($id2, 'election_data', O_RDWR);
    delete $e->{'num_questions'}; delete $e->{'question_title'};
    untie %$e;
    my $v = db($id2, 'vote_data', O_RDWR);
    delete $v->{'answered'};
    untie %$v;
}
post('vote.pl', '10.9.3.3', id=>$id2, akey=>$akey2,
     AddWritein=>'add', writein=>'Blue');
my $s2 = snapshot($id2);
ck('the write-in was added', ($s2->{'choices'} // '') =~ /Blue \(write-in\)/);
ck('and the two existing voters rank it last',
   ($s2->{'v:0.2'} // 0) == 2 && ($s2->{'v:1.2'} // 0) == 2,
   ($s2->{'v:0.2'} // 'undef') . '/' . ($s2->{'v:1.2'} // 'undef'));

print "\n== removing a write-in once votes exist ==\n";
$p = post('remove_writein.pl', '10.0.0.1',
          id=>$id2, key=>$key2, akey=>$akey2, writein=>2);
ck('refused, because votes have been cast',
   $p =~ /votes have been cast/i, ($p =~ /(<p>[^<]{0,60})/)[0]);
ck('and the choice is still there',
   (snapshot($id2)->{'choices'} // '') =~ /Blue \(write-in\)/);

print "\n== voting on an old poll still works ==\n";
$p = post('vote.pl', '10.9.4.1', id=>$id2, akey=>$akey2);
ck('the ballot has no question numbering', $p !~ /Question 1 of/);
ck('and no skip button', $p !~ /name="Skip"/);
$p = post('vote.pl', '10.9.4.1', id=>$id2, akey=>$akey2,
          C0=>1, C1=>2, C2=>3, Vote=>'go');
ck('the vote is thanked', $p =~ /[Tt]hank/);
my $s3 = snapshot($id2);
ck('three ballots now', ($s3->{'v:num_votes'} // 0) == 3);
ck('stored under a plain ballot key, not a prefixed one',
   !grep(/^v:q\d+\./, keys %$s3), join(',', grep(/^v:q\d/, keys %$s3)));
ck('the plain matrix was updated', ($s3->{'v:0.1'} // 0) == 3);

print "\n", ($fails ? "$fails FAILED\n" : "all $checks checks passed\n");
exit($fails ? 1 : 0);
