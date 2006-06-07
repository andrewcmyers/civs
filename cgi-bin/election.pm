package election;  # should be CIVS::Election, or perhaps merged with CIVS
 # Also, this should really be an object-oriented package, where
 # the constructor is parameterized on election id. 
 # Then we wouldn't have to have an init() function.

use strict;
use warnings;

# Export the package interface
BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.02;
    @ISA         = qw(Exporter);
    @EXPORT = qw(&init &ExtractVoterKeys &SaveVoterKeys 
    &CheckAuthorizationKeyForAddingVoter &CheckAuthorizationKeyForVoting
    &LockElection &UnlockElection &StartElection &IsStarted
    &CheckStarted &PointToResults &IsStopped &CheckNotStopped
    &CheckStopped &CheckVoterKey &CheckNotVoted &CheckControlKey
    &IsWellFormedElectionID &CheckElectionID &ElectionLog &SendKeys
    &ElectionUsesAuthorizationKey &SyncVoterKeys
    $election_id $election_dir $started_file $stopped_file
    $election_data $election_log $vote_data $election_lock $name
    $title $email_addr $description $num_winners $addresses @addresses
    $election_end $public $writeins $shuffle $proportional $use_combined_ratings
    $choices @choices $num_choices $num_auth $num_votes $recorded_voters
    $ballot_reporting $authorization_key %used_voter_keys
    %voter_keys %edata %vdata);
}

# Package imports
use civs_common;
use CGI qw(:standard);
use POSIX qw(strftime);
use mail;
use Fcntl qw(:DEFAULT :flock);
use Digest::MD5 qw(md5_hex);
use DB_File;

# Declare exported variables
our $election_id = '';
our ($election_dir, $started_file, $stopped_file, $election_data, $election_log, $vote_data, $election_lock);

our (%edata, %vdata);
our ($name, $title, $email_addr, $description, $num_winners, $addresses,
     @addresses, $election_end, $public, $writeins, $proportional,
     $use_combined_ratings, $choices, @choices, $num_choices, $num_auth,
     $num_votes, $recorded_voters, $ballot_reporting, $authorization_key,
     $shuffle, %voter_keys, %used_voter_keys);

our $civs_supervisor = '@SUPERVISOR@';

# Non-exported variables
my ($db_is_open, $election_is_locked);

&init;

sub init {
    # Get election ID
    $election_id = param('id') or die "No election ID provided\n";
    &IsWellFormedElectionID or die "Ill-formed election ID: $election_id\n";
    
    # Set up filename paths
    $election_dir = $home."/elections/".$election_id;
    $started_file = $election_dir."/started";
    $stopped_file = $election_dir."/stopped";
    $election_data = $election_dir."/election_data";
    $election_log = $election_dir."/vote_log";
    $vote_data = $election_dir."/vote_data";
    $election_lock = $election_dir."/lock";

    &LockElection;
    &OpenDatabase;

    # Extract data from databases
    $name = $edata{'name'};
    $title = $edata{'title'};
    $email_addr = $edata{'email_addr'};
    $description = $edata{'description'};
    $num_winners = $edata{'num_winners'};
    $addresses = $edata{'addresses'} or $addresses = "";
    @addresses = split /[\r\n]+/, $addresses;
    $election_end = $edata{'election_end'};
    $public = $edata{'public'};
    $writeins = $edata{'writeins'};
    $proportional = $edata{'proportional'} or $proportional = "";
    $use_combined_ratings = $edata{'use_combined_ratings'};
    $choices = $edata{'choices'} or $choices = "";
    @choices = split /[\r\n]+/, $choices;
    $num_choices = $#choices + 1;
    $num_auth = $edata{'num_auth'};
    $shuffle = $edata{'shuffle'};
    $num_votes = $vdata{'num_votes'} or $num_votes = 0;
    $recorded_voters = $vdata{'recorded_voters'};
    $ballot_reporting = $edata{'ballot_reporting'} or $ballot_reporting = "";
    %voter_keys = ();
    &LoadHash('voter_keys', \%voter_keys);
    &LoadHash('used_voter_keys', \%used_voter_keys);
}

END {
    &SyncVoterKeys();
    &CloseDatabase;
    &UnlockElection;
}

# utility routines

sub SyncVoterKeys {
    &SaveHash('voter_keys', \%voter_keys);
    &SaveHash('used_voter_keys', \%used_voter_keys);
}

sub LoadHash {
    my $hash_name = shift;
    my $hash_ref = shift;
    my $s;
    $s = $edata{$hash_name} or $s = "";
    my @a = split /[\r\n]+/, $s;
    foreach my $k (@a) {
    $$hash_ref{$k} = 1;
    }
}

sub SaveHash {
    my $hash_name = shift;
    my $hash_ref = shift;
    my $s = '';
    my $k;
    foreach $k (keys %{$hash_ref}) {
        $s .= ($k.$cr);
    }
    $edata{$hash_name} = $s;
}

sub LockElection {
    if (!sysopen(ELOCK, $election_lock, &O_CREAT | &O_RDWR)) {
        print h1("Error");
        print p("Did not have the write access needed to acquire an election lock."), 
          end_html();
        exit 0;
    }
    flock ELOCK, &LOCK_EX;
    $election_is_locked = 1;
}

sub UnlockElection {
    if ($election_is_locked) {
        flock ELOCK, &LOCK_UN;
        close(ELOCK);
        $election_is_locked = 0;
    }
}

sub OpenDatabase {
    tie %edata, "DB_File", $election_data, &O_RDWR, 0666, $DB_HASH
        or die "Unable to tie election db=$election_data: $!\n";
    tie %vdata, "DB_File", $vote_data, &O_CREAT|&O_RDWR, 0666, $DB_HASH
        or die "Unable to tie voter db=$vote_data: $!\n";
    $db_is_open = 1;
}

sub CloseDatabase {
    if ($db_is_open) {
        untie %edata;
        untie %vdata;
        $db_is_open = 0;
    }
}

sub StartElection {
    if (sysopen(STARTED, $started_file, &O_RDONLY)) {
	print h1("Error");
	print p("This election ($title) has already been started."), end_html();
	exit 0;
    }
    if (sysopen(STARTED, $started_file, &O_CREAT | &O_EXCL | &O_RDWR)) {
	print STARTED "started\n";
	close(STARTED);
    } else {
	print h1("Error");
	print p("Did not have write access to start an election."), end_html();
	exit 0;
    }
}

sub IsStarted {
    if (!open(STARTED, $started_file)) {
	return 0;
    } else {
	return 1;
    }
}

sub CheckStarted {
    if (!IsStarted()) {
	print h1("Error");
	print p("This election does not exist or has not been started."), end_html();
	exit 0;
    }
}

sub PointToResults {
    if ($public eq 'no') {
	print "<p>The following URL will report the results of the election once\n";
	print "it is complete:<br>\n";
	} else {
	print "<p>The following URL reports the current results of the election:<br>\n";
    }
    print "<a href=\"http://$thishost$civs_bin_path/results@PERLEXT@?id=$election_id\">
    <tt>http://$thishost$civs_bin_path/results@PERLEXT@?id=$election_id</tt></a></p>\n";
}
sub PointToResultsComplete {
    print "<p>The following web page has the results of this completed election:<br>\n";
    print "<a href=\"http://$thishost$civs_bin_path/results@PERLEXT@?id=$election_id\">
       <tt>http://$thishost$civs_bin_path/results@PERLEXT@?id=$election_id</tt></a></p>\n";
}

sub IsStopped {
    if (open(STOPPED, $stopped_file)) {
	close(STOPPED);
	return 1;
    } else {
	return 0;
    }
}
sub CheckNotStopped {
    if (IsStopped()) {
	print h1("Election already closed");
	print p("This election (<strong>$title</strong>) has already been closed.");
	PointToResultsComplete;
	print end_html();
	exit 0;
    }
}

sub CheckStopped {
    if (!IsStopped() && (!$local_debug)) {
	print h1("Election not yet closed");
	print p(
    "This election (<strong>$title</strong>) has not yet been closed
    by its supervisor, $name (<tt>$email_addr</tt>).
    The election has been announced to end $election_end.");
	PointToResults;
	print end_html();
	exit 0;
    }
}

sub CheckVoterKey {
    my ($voter_key, $old_voter_key, $voter) = @_;
 
    if ($old_voter_key and !$voter_key) {
        my $voter_key_check = civs_hash("voter".$private_host_id.$election_id.$voter);
        if ($voter_key_check ne $old_voter_key) {
            Log("Invalid voter key $old_voter_key presented by $voter " .
                "for election $election_id, expected $voter_key_check");
            print h1("Error"), p("Your voter key is invalid, $voter. ",
                "You should have received a correct URL by email."), 
                end_html();
            exit 0;
        }
    } else {
        if (!$voter_keys{civs_hash($voter_key)}) {
            print h1("Error"), p("Your voter key is invalid. ", 
                "You should have received a correct URL by email."),
                end_html(); 
            exit 0;
        }
    }
}

sub CheckNotVoted {
    my ($voter_key, $old_voter_key, $voter) = @_;
    if ($used_voter_keys{&civs_hash($voter_key)}) {
	print h1("Already voted");
	print p("A vote has already been cast using your voter key.");
	PointToResults;
	print end_html();
	if ($voter_key) {
	    ElectionLog("Election: $title ($election_id) : Saw second vote "
		    . "from voter key $voter_key");
	} else {
	    ElectionLog("Election: $title ($election_id) : Saw second vote "
		    . "from (voter,key) = ($voter, $old_voter_key)");
	}
	exit 0;
    }
}

sub ControlKeyError {
    print h1("Error"),
    p("Invalid key. You should have received a correct URL for
        controlling the election by email. This error has been logged.");
    print end_html();
    my $t = '<undefined title>';
    if (defined($title)) {
	$t = $title;
    }
    my $id = '<undefined election id>';
    if (defined($election_id)) {
	$id = $election_id;
    }
    ElectionLog("Election: $t ($id) : invalid attempt to close election (wrong key)");
    exit 0;
}

sub CheckControlKey {
    my $control_key = shift; 
    
    if (defined($edata{'hash_control_key'})) {
        my $hash_control_key = civs_hash($control_key);
        my $hash_control_key_check = $edata{'hash_control_key'};
        if ($hash_control_key ne $hash_control_key_check) {
            &ControlKeyError;
        }
    } else {
        my $control_key_check = civs_hash("control".$private_host_id.$election_id);
        if ($control_key ne $control_key_check) {
            &ControlKeyError;
        }
    }
}

sub ElectionUsesAuthorizationKey {
    return (defined($edata{'hash_authorization_key'}));
}

sub CheckAuthorizationKey {
    my $authorization_key = shift;
    if (!&ElectionUsesAuthorizationKey) {
        # if the hash doesn't exist in the database, then this is
        # an election that was created before authorization keys
        # were added to the CIVS design.  In order to keep those elections
        # running, we'll go ahead and let the key check pass. 
        return 1;
    }
    if (!defined($authorization_key)) {
        # if the key is undefined, then the CGI script didn't receive
        # the parameter.  That's either an authorization violation,
        # or an old election that didn't use an auth. key.  Since
        # we've already checked the second case, assume the first.
        return 0;
    }
    my $hash_authorization_key = civs_hash($authorization_key);
    my $hash_authorization_key_check = $edata{'hash_authorization_key'};
    return $hash_authorization_key eq $hash_authorization_key_check;
}

sub CheckAuthorizationKeyForAddingVoter {
    my $authorization_key = shift;
    if (!CheckAuthorizationKey($authorization_key)) {   
        print h1("Error"), p("Invalid key. You should have received a correct URL for controlling the election by email. This error has been logged.");
        print end_html();
        ElectionLog("Election: $title ($election_id) : invalid attempt to add voter (wrong key)");
        exit 0;
    }
}

sub CheckAuthorizationKeyForVoting {
    my $authorization_key = shift;
    if (!CheckAuthorizationKey($authorization_key)) {   
        print h1("Error"), p("Invalid key. You should have received a correct URL for voting in the election. This error has been logged.");
        print end_html();
        ElectionLog("Election: $title ($election_id) : invalid attempt to add voter (wrong key)");
        exit 0;
    }
}

sub IsWellFormedElectionID {
    return $election_id =~ m/^E_[0123456789abcdef]+/;
}

sub CheckElectionID {
    if (!IsWellFormedElectionID) {
    if (defined($election_id) && $election_id ne '') {
        print h1("Invalid election identifier");
        print p("The election identifier \"$election_id\" is not valid.\n");
        Log("Attempt to provide a bogus election identifier: \"$election_id\"");
        $election_id = '';
    }
    print end_html();
    exit 0;
    }
}

# Log the string provided
sub ElectionLog {
    my $log_msg = shift;
    chomp($log_msg);
    my $now = strftime "%a %b %e %H:%M:%S %Y", localtime;
    # print pre("trying to log to $election_log");
    if (!open ELECTION_LOG, ">>$election_log") {
        print h1("Error"),
          p("Unable to append to the election log."),
          end_html();
	exit 0;
    }
    print ELECTION_LOG $now." ".$remote_ip_address." ".$log_msg."\n";
    close ELECTION_LOG;
}

# Generate a voter key as the hash of the voter's email,
# the election's authorization key, and the server's private key.
# Assumes that the authorization key has been validated.
sub GenerateVoterKey {
    my $voter_email = shift;
    my $authorization_key = shift;
    my $voter_key = civs_hash($voter_email, $authorization_key,
        $private_host_id);
    return $voter_key;
}

# Construct new voter keys for all of the voters sent in @_.
# Send all of the voters their keys, with logging to STDOUT.
# And record the keys in the database.
sub SendKeys {
    my $authorization_key = shift;
    my $addresses_ref = shift;
    my @addresses =  &unique_elements( @{$addresses_ref} );
    my $num_added = 0;
    if (!($local_debug)) { ConnectMail; }
    foreach my $v (@addresses) {
	$v =~ s/^(\s)+//;
	$v =~ s/(\s)+$//;
	$v =~ s/\s+/ /;
        my $url = "";
        if ($public eq 'yes') {
            $url = "http://$thishost$civs_bin_path/vote@PERLEXT@?id=$election_id";
            $url .= "&akey=$authorization_key"
                if (&ElectionUsesAuthorizationKey);
        } else {
            my $voter_key = GenerateVoterKey($v, $authorization_key);
            my $hash_voter_key = civs_hash($voter_key);
            if ($voter_keys{$hash_voter_key}) {
                # This email address has already been added to the election
                print "Voter \"$v\" is already an authorized voter. ",
                      "The voter's key will be resent to the voter.\n";
            } else {
                $voter_keys{$hash_voter_key} = 1;
                $num_added++;
            }
            $url = "http://$thishost$civs_bin_path/vote@PERLEXT@?id=$election_id"
                        ."&key=$voter_key";
        }

        if ($local_debug) {
            print "voter link: <a href=\"$url\">$url</a>\n";
        } else {
            print "Sending mail to voter \"$v\"...\n"; STDOUT->flush();
                Send "mail from: $civs_supervisor"; ConsumeSMTP;
            Send "rcpt to: $v"; ConsumeSMTP;
            Send "data"; ConsumeSMTP;
            Send "From: $email_addr ($name, CIVS election supervisor)";
            Send "Sender: $email_addr";
            Send "Errors-To: $email_addr";
            Send "Reply-To: $email_addr";
            Send "To: $v";
            Send "Subject: CIVS Election now available for voting: $title";
            Send "";
            Send "A Condorcet Internet Voting Service election named $title has been created.";
            Send "You have been designated as a voter by the election supervisor,";
            Send "$name ($email_addr).";
	    if (!($description =~ m/^(\s)*$/)) {
		Send '';
		Send 'Description of election:';
		Send $description;
		Send '';
	    }
	    Send 'If you would like to vote, please visit the following URL:';
            Send '';
            Send "  $url";
            Send '';
            Send 'This is your private URL. Do not give it to anyone else because';
            Send 'they could use it to vote for you. Your privacy will not be violated';
            Send 'by voting. The voting service does not keep track of your email address';
            Send 'or release any information about whether or how you have voted.';
            Send '';
            Send "The election has been announced to end $election_end.";
            Send 'To view the results of the election once it is closed, visit:';
            Send "http://$thishost$civs_bin_path/results@PERLEXT@?id=$election_id";
	    Send '';
            Send "For more information about the Condorcet Internet Voting Service, see";
            Send "$civs_home";
            Send '.'; ConsumeSMTP;
        }
    }
    if (!($local_debug)) {
        CloseMail;
    }
    STDOUT->flush();

    return $num_added;
}

1; # ok!
