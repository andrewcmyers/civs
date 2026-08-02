#!/usr/bin/perl
# Round-trip test for the multi-question storage layer: create polls through
# create_election, then read them back through election.pm.
use strict; use warnings;
use DB_File; use Fcntl;

my $inst = shift @ARGV or die "usage: test-storage.pl <install dir> [source dir]\n";
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

# POST to a CGI script and return its output.
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
    # A real file, not an in-memory handle: the body has to survive exec.
    my $tmp = "/tmp/civs-post-$$";
    open(my $w, '>', $tmp) or die $!; print $w $body; close $w;
    open(my $fh, '-|') or do {
        open(STDIN, '<', $tmp) or die $!;
        exec($^X, "-I$cgi", "$cgi/$script") or die $!;
    };
    local $/; my $out = <$fh>; close $fh;
    unlink $tmp;
    return $out;
}

# Read a poll's raw database.
sub raw {
    my ($id) = @_;
    my %e;
    tie %e, 'DB_File', "$data/elections/$id/election_data", O_RDONLY, 0666, $DB_HASH
        or die "cannot read $id: $!";
    my %copy = %e;
    untie %e;
    return \%copy;
}

# Load a poll through election.pm and report what it saw.
sub load {
    my ($id) = @_;
    local %ENV = (%ENV, REQUEST_METHOD => 'GET', QUERY_STRING => "id=$id",
                  SCRIPT_NAME => '/probe', REMOTE_ADDR => '127.0.0.1');
    my $probe = <<'PERL';
use lib shift @ARGV;
use election;
print "\nPROBE num_questions=$num_questions\n";
print "PROBE poll_title=$title\n";
print "PROBE q0_globals choices=", join('|', @choices),
      " num_choices=$num_choices num_winners=$num_winners",
      " writeins=", (defined $writeins ? $writeins : 'undef'),
      " prop=$proportional\n";
for (my $q = 0; $q < $num_questions; $q++) {
    my $h = $questions[$q];
    print "PROBE q$q text=", (defined $h->{question_title} ? $h->{question_title} : ''),
          " choices=", join('|', @{$h->{choice_list}}),
          " num_winners=", (defined $h->{num_winners} ? $h->{num_winners} : 'undef'),
          " writeins=", (defined $h->{writeins} ? $h->{writeins} : 'undef'), "\n";
}
PERL
    open(my $fh, '-|') or do {
        open(STDIN, '<', '/dev/null') or die $!;
        exec($^X, '-e', $probe, '--', $cgi) or die $!;
    };
    local $/; my $out = <$fh>; close $fh;
    return $out;
}

sub probe_lines {
    my ($out) = @_;
    return join "\n", grep { /^PROBE / } split /\n/, $out;
}

my %common = (
    name => 'Tester', email_addr => 'tester@example.invalid',
    title => 'Lunch and transport', description => 'A poll',
    election_end => 'never', public => 'no', shuffle => 'no',
    writeins => 'yes', proportional => 'no', no_opinion => 'yes',
);

print "\n== a poll asking one question, posting legacy field names ==\n";
my $out1 = post('create_election.pl', %common,
                choices => "Pizza\r\nTacos\r\nSushi", num_winners => 1);
my ($id1) = $out1 =~ m{control[^?]*\?id=(E_[0-9a-f]+)};
ck('poll created', defined($id1), ($out1 =~ /Error/ ? 'reported an error' : 'no id in output'));
if (!defined $id1) { print $out1; exit 1 }
my $r1 = raw($id1);
ck('num_questions stored as 1', ($r1->{num_questions} // '') eq '1', $r1->{num_questions});
ck('choices under the unprefixed key', ($r1->{choices} // '') eq "Pizza\nTacos\nSushi\n", $r1->{choices});
ck('num_winners under the unprefixed key', ($r1->{num_winners} // '') eq '1');
ck('no q1 keys written', !grep(/^q1\./, keys %$r1), join(',', grep(/^q\d/, keys %$r1)));
print probe_lines(load($id1)), "\n";

print "\n== choices separated by bare newlines ==\n";
# A browser submits a textarea with CRLF, but anything arriving with plain
# newlines used to collapse into a single choice and be rejected for
# having fewer than two.
my $lf = post('create_election.pl', %common,
              num_questions => 2,
              question_title => 'A?', choices => "Pizza\nTacos", num_winners => 1,
              q1_question_title => 'B?', q1_choices => "Walk\nBus",
              q1_num_winners => 1);
my ($lf_id) = $lf =~ m{control[^?]*\?id=(E_[0-9a-f]+)};
ck('the poll is created', defined($lf_id),
   join(' | ', $lf =~ m{<li>(.*?)</li>}g));
if (defined $lf_id) {
    my $r = raw($lf_id);
    ck('both choices of question 1', ($r->{choices} // '') eq "Pizza\nTacos\n");
    ck('both choices of question 2', ($r->{'q1.choices'} // '') eq "Walk\nBus\n");
}

print "\n== a question the form never submitted ==\n";
# num_questions says two, but nothing was sent for the second.
my $missing = post('create_election.pl', %common,
                   num_questions => 2,
                   choices => "Pizza\r\nTacos", num_winners => 1,
                   question_title => 'A?');
ck('it says so, rather than blaming the choices',
   $missing =~ /Nothing was submitted for this question/,
   join(' | ', $missing =~ m{<li>(.*?)</li>}g));

print "\n== a poll asking three questions ==\n";
my $out3 = post('create_election.pl', %common,
    num_questions  => 3,
    question_title => 'Where for lunch?',
    choices        => "Pizza\r\nTacos",
    num_winners    => 1,
    q1_question_title => 'How shall we travel?',
    q1_choices        => "Walk\r\nBus\r\nTrain",
    q1_num_winners    => 2,
    q2_question_title => 'What time?',
    q2_choices        => "Noon\r\nOne",
    q2_num_winners    => 1,
);
my ($id3) = $out3 =~ m{control[^?]*\?id=(E_[0-9a-f]+)};
ck('poll created', defined($id3), ($out3 =~ /Error/ ? 'reported an error' : 'no id'));
if (!defined $id3) { print $out3; exit 1 }
my $r3 = raw($id3);
ck('num_questions stored as 3', ($r3->{num_questions} // '') eq '3', $r3->{num_questions});
ck('question 0 keeps unprefixed keys',
   ($r3->{choices} // '') eq "Pizza\nTacos\n" && ($r3->{question_title} // '') eq 'Where for lunch?',
   $r3->{choices});
ck('question 1 prefixed', ($r3->{'q1.choices'} // '') eq "Walk\nBus\nTrain\n", $r3->{'q1.choices'});
ck('question 1 winners', ($r3->{'q1.num_winners'} // '') eq '2');
ck('question 2 prefixed', ($r3->{'q2.choices'} // '') eq "Noon\nOne\n");
ck('poll title is not a question title',
   ($r3->{title} // '') eq 'Lunch and transport' && $r3->{title} ne ($r3->{question_title} // ''));
ck('poll-wide settings copied to each question',
   ($r3->{'q1.writeins'} // '') eq 'yes' && ($r3->{'q2.writeins'} // '') eq 'yes',
   $r3->{'q1.writeins'});
ck('no stray q0. keys', !grep(/^q0\./, keys %$r3), join(',', grep(/^q0\./, keys %$r3)));
my $p3 = load($id3);
print probe_lines($p3), "\n";
ck('loads as three questions', $p3 =~ /num_questions=3/);
ck('globals still describe question 0', $p3 =~ /q0_globals choices=Pizza\|Tacos num_choices=2 num_winners=1/);
ck('question 1 read back', $p3 =~ /q1 text=How shall we travel\? choices=Walk\|Bus\|Train num_winners=2/);

print "\n== a poll written before multiple questions existed ==\n";
# Same keys a pre-2.30 CIVS would have left behind: no num_questions, no
# question_title, everything per-question under the unprefixed names.
my $legacy = 'E_deadbeefdeadbeef';
mkdir "$data/elections/$legacy";
{
    my %e;
    tie %e, 'DB_File', "$data/elections/$legacy/election_data",
        O_CREAT|O_RDWR, 0666, $DB_HASH or die $!;
    %e = (name => 'Old', title => 'An old poll', email_addr => 'old@example.invalid',
          description => 'legacy', election_end => 'never', election_begin => 1000000,
          public => 'no', publicize => 'no', writeins => 'no', allow_voting => 'no',
          no_opinion => 'yes', shuffle => 'yes', proportional => 'no',
          use_combined_ratings => 0, external_ballots => 'no', no_IP_check => 'no',
          choices => "Red\nGreen\nBlue\n", num_winners => 2, num_auth => 0,
          hash_control_key => 'x', hash_authorization_key => 'y');
    untie %e;
}
my $pl = load($legacy);
print probe_lines($pl), "\n";
ck('legacy poll loads as one question', $pl =~ /num_questions=1/);
ck('its choices are question 0', $pl =~ /q0 text= choices=Red\|Green\|Blue num_winners=2/);
ck('globals unchanged for legacy poll',
   $pl =~ /q0_globals choices=Red\|Green\|Blue num_choices=3 num_winners=2 writeins=no/);
ck('no num_questions key was added on read', !defined(raw($legacy)->{num_questions}));

print "\n== the offline tools' reader, election_utils.pm ==\n";
# tabulate and dump_elections are run from cgi-bin rather than installed,
# and read bytes rather than decoded characters.
sub load_offline {
    my ($id) = @_;
    my $probe = <<'PERL';
use lib shift @ARGV;
use election_utils;
use DB_File; use Fcntl;
my ($dir) = @ARGV;
my (%e, %v);
tie %e, 'DB_File', "$dir/election_data", O_RDONLY, 0666, $DB_HASH or die $!;
tie %v, 'DB_File', "$dir/vote_data", O_CREAT|O_RDWR, 0666, $DB_HASH or die $!;
my $ok = GetElectionData(\%e, \%v);
print "PROBE readable=$ok num_questions=$num_questions\n";
print "PROBE globals choices=", join('|', @choices), " num_winners=$num_winners\n";
for (my $q = 0; $q < $num_questions; $q++) {
    print "PROBE q$q choices=", join('|', @{$questions[$q]{choice_list}}),
          " num_winners=$questions[$q]{num_winners}\n";
}
untie %e; untie %v;
PERL
    open(my $fh, '-|') or do {
        open(STDIN, '<', '/dev/null') or die $!;
        exec($^X, '-e', $probe, '--', "$root/cgi-bin", "$data/elections/$id")
            or die $!;
    };
    local $/; my $out = <$fh>; close $fh;
    return $out;
}
my $po = load_offline($id3);
print probe_lines($po), "\n";
ck('offline reader sees three questions', $po =~ /readable=1 num_questions=3/, $po);
ck('offline globals describe question 0', $po =~ /globals choices=Pizza\|Tacos num_winners=1/);
ck('offline question 1 read back', $po =~ /q1 choices=Walk\|Bus\|Train num_winners=2/);

print "\n", ($fails ? "$fails FAILED\n" : "all $checks checks passed\n");
exit($fails ? 1 : 0);
