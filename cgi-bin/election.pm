package election;  # should be CIVS::Election, or perhaps merged with CIVS
 # Also, this should really be an object-oriented package, where
 # the constructor is parameterized on election id.
 # Then we wouldn't have to have an init() function.

use strict;
use warnings;
use Encode qw(encode decode);

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
    &CheckStopped &CheckVoterKey &CheckNotVoted &CheckControlKey &CheckResultKey
    &IsWellFormedElectionID &CheckElectionID &ElectionLog &SendKeys
    &ElectionUsesAuthorizationKey &SyncVoterKeys &CloseDatabase &SendBody
    &IsWriteinName &GetEmailLoad &RevoteButton
    $election_id $election_dir $started_file $stopped_file
    $election_data $election_log $vote_data $election_lock $name
    $title $email_addr $description $num_winners $addresses @addresses
    $election_end $public $publicize $writeins $allow_voting $voting_enabled
    $shuffle $proportional $external_ballots $no_IP_check
    $use_combined_ratings $choices @choices $num_choices $num_auth $num_votes
    $recorded_voters $ballot_reporting $reveal_voters $authorization_key
    %used_voter_keys $restrict_results $result_addrs $hash_result_key $no_opinion
    $close_time $last_vote_time $election_begin $email_load
    %voter_keys %edata %vdata);
}

# Package imports
use civs_common;
use CGI qw(:standard -utf8);
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
     @addresses, $election_begin, $election_end, $public, $publicize, $writeins, $allow_voting, $voting_enabled,
     $proportional, $use_combined_ratings, $external_ballots,
     $choices, @choices, $num_choices, $num_auth,
     $num_votes, $recorded_voters, $ballot_reporting, $reveal_voters, $no_IP_check,
     $authorization_key, $shuffle, $no_opinion, %voter_keys, %used_voter_keys,
     $restrict_results, $result_addrs, $hash_result_key, $last_vote_time,
     $close_time, $email_load);

our $civs_supervisor = '@SUPERVISOR@';
our $auth_sender = '@AUTH_SENDER@';
our $mail_mgmt_url = "@PROTO@://$thishost$civs_bin_path/mail_mgmt@PERLEXT@";

# Non-exported variables
my ($db_is_open, $election_is_locked);

&init;

# Decode a database field using UTF-8. If FIXUTF8 option is enabled, Ad-hoc
# fixup is done of embedded Latin-1 characters and doubly encoded UTF-8.
# Returns undefined if the field is undefined.
sub DB_decode {
    (my $key) = @_;
    my $e = $edata{$key};
    return $e unless $e;
    my $d = fixUTF($e);
    if (@FIXUTF8@ && $d =~ m/\303[\202-\203]\302[\200-\277]/) {
        print STDERR "Fixing UTF-8 double encoding in $election_id\n";
        $d = decode('utf-8', $d);
        $edata{$key} = $d;
    }
    return decode('utf-8', $d);
}

sub init {
    # Get election ID
    $election_id = param('id') or do {
	&CIVS_Header($tx->Error);
        print p($tx->No_poll_ID), end_html();
        exit 0;
    };
    &IsWellFormedElectionID or do {
	&CIVS_Header($tx->Error);
        print p($tx->Ill_formed_poll_ID(escapeHTML($election_id))), end_html();
        exit 0;
    };

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
    #
    # There are roughly three kinds of data in database fields:
    #   byte strings (for numbers and ASCII data) - stored verbatim; must be escaped in HTML output using escapeHTML
    #   UTF-8 encoded strings                     - must be escaped in HTML output
    #   UTF-8 encoded HTML strings (which have been filtered) - should not be escaped in HTML output
    #
    $name = DB_decode('name');                 # name of supervisor: UTF-8
    $title = DB_decode('title');               # title of poll: HTML
    $email_addr = DB_decode('email_addr');     # email of supervisor: UTF-8
    $description = DB_decode('description');   # poll description: HTML
    $num_winners = $edata{'num_winners'};
    $addresses = DB_decode('addresses') || '';
    @addresses = split /[\r\n]+/, $addresses;
    $election_begin = $edata{'election_begin'};
    $election_end = DB_decode('election_end');  # HTML
    $public = $edata{'public'};
    $publicize = $edata{'publicize'} || 'no';
    $writeins = $edata{'writeins'};
    $allow_voting = $edata{'allow_voting'} || 'no';
    $voting_enabled = ($writeins ne 'yes' || $allow_voting eq 'yes');
    $proportional = $edata{'proportional'} // '';
    $use_combined_ratings = $edata{'use_combined_ratings'} || 0;
    $choices = DB_decode('choices') // '';    # list of newline-separated choices/candidates: HTML
    @choices = split /[\r\n]+/, $choices;
    $num_choices = $#choices + 1;
    $num_auth = $edata{'num_auth'};
    $shuffle = $edata{'shuffle'};
    $no_opinion = $edata{'no_opinion'} || 'yes';
    $num_votes = $vdata{'num_votes'} || 0;
    $close_time = $vdata{'close_time'};
    $recorded_voters = $vdata{'recorded_voters'};
    $ballot_reporting = $edata{'ballot_reporting'} // '';
    $external_ballots = $edata{'external_ballots'} // 'no';
    $reveal_voters = $edata{'reveal_voters'} // '';
    $restrict_results = $edata{'restrict_results'} // 'no';
    $result_addrs = DB_decode('result_addrs');
    $hash_result_key = 0;
    $last_vote_time = $vdata{'last_vote_time'};
    $email_load = $edata{'email_load'}; # timestamp num_mails
    $no_IP_check = $edata{'no_IP_check'} // 'no';
    if ($restrict_results eq 'yes') {
	$hash_result_key = $edata{'hash_result_key'};
    }
    %voter_keys = ();
    &LoadHash('voter_keys', \%voter_keys);
    &LoadHash('used_voter_keys', \%used_voter_keys);
}

END {
    &SyncVoterKeys;
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
        print h1($tx->Error);
        print p($tx->No_write_access_to_lock_poll);
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
        or die "Unable to tie poll db=$election_data: $!\n";
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
	print h1($tx->Error);
	print p($tx->This_poll_has_already_been_started), end_html();
	exit 0;
    }
    if (sysopen(STARTED, $started_file, &O_CREAT | &O_EXCL | &O_RDWR)) {
	print STARTED "started\n";
	close(STARTED);
    } else {
	print h1($tx->Error);
	print p($tx->No_write_access_to_start_poll), end_html();
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
	print h1($tx->Error);
	print p($tx->Poll_does_not_exist_or_not_started), end_html();
	exit 0;
    }
}

sub PointToResults {
    if ($restrict_results ne 'yes') {
	my $url = "@PROTO@://$thishost$civs_bin_path/results@PERLEXT@?id=$election_id";
	print '<p>';
	if ($public eq 'no') {
	    print $tx->future_result_link($url);
	} else {
	    print $tx->current_result_link($url);
	}
	print '</p>', $cr;
    } else {
	print p($tx->Poll_results_will_be_available_to_the_following_users);
	print '<ul>';
	my @result_addrs = split /(\r\n)+/, $result_addrs;
	foreach my $addr (@result_addrs) {
	    $addr = TrimAddr($addr);
	    if (CheckAddr($addr)) {
		print li($addr), $cr;
	    }
	}
	print '</ul>', $cr;
    }
}

# List the users who will be able to see the results
sub ReportResultReaders {
    print $tx->results_available_to_the_following_users;
    print '<div class="list">';
    my @result_addrs = split /(\r\n)+/, $result_addrs;
    foreach my $addr (@result_addrs) {
	$addr = TrimAddr($addr);
	if (CheckAddr($addr)) {
	    print tt($addr), br(), $cr;
	}
    }
    print '</div>'
}

sub PointToResultsComplete {
  if ($restrict_results eq 'yes') {
    &ReportResultReaders;
  } else {
    print "<p>", $tx->The_results_of_this_completed_poll_are_here, br, $cr;
    print "<a href=\"@PROTO@://$thishost$civs_bin_path/results@PERLEXT@?id=$election_id\">
       <tt>@PROTO@://$thishost$civs_bin_path/results@PERLEXT@?id=$election_id</tt></a></p>\n";
  }
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
	print h1("Poll already ended");
	print p($tx->already_ended($title));
	PointToResultsComplete;
	print end_html();
	exit 0;
    }
}

sub CheckStopped {
    if (!IsStopped() && (!$local_debug)) {
	print h1($tx->Poll_not_yet_ended);
	print p(
	    $tx->The_poll_has_not_yet_been_ended($title,$name,$email_addr),
	    $tx->poll_has_been_announced_to_end($election_end));
	PointToResults;
	print end_html();
	exit 0;
    }
}

sub CheckVoterKey {
    my ($voter_key) = @_;
    if (!$voter_keys{civs_hash($voter_key || '')}) {
        print h1($tx->Error), p($tx->Your_voter_key_is_invalid__check_mail('')),
            end_html();
        exit 0;
    }
}

sub IsWriteinName {
    $_[0] =~ m/\(write-in\)$/
}

# Check whether the voter has provided a correct receipt for a prior
# vote; if so, remove their old ballot and return their old ballot as a
# string.
sub CheckReceipt {
    (my $voter_key) = @_;
    my $receipt = bytesParam('receipt');
    if ($receipt) {
        my ($id, $release_key) = $receipt =~ m|(E_[0-9a-f]+)/([0-9a-f]+)|;
        my $ballot_key = $id ? civs_hash($release_key, $private_host_id) : '';
        my $used_voters_data = $vdata{'used_voters'};
        my @used_voters;
        if (defined($used_voters_data)) {
            @used_voters = split /\n/, $used_voters_data;
        }
        my @rv = split /\n/, $recorded_voters;
        if ($id && $id eq $election_id && $vdata{$ballot_key}) {
            my $ballot = $vdata{$ballot_key};
            delete $vdata{$ballot_key};
            $vdata{'num_votes'}--;
            delete $used_voter_keys{&civs_hash($voter_key)};
            my $found = 0;
            for (my $i = 0; $i <= $#rv; $i++) {
                if ($rv[$i] eq $ballot_key) {
                    splice @rv, $i, 1;
                    $vdata{'recorded_voters'} = join "\n", @rv;
                    $found = 1;
                    last;
                }
            }
            if (!$found) {
                Log "Warning: election $election_id revote: could not remove previous recorded voter $release_key (voter key $voter_key, ballot key $ballot_key)"
            } else {
                Log "Removed ballot from voter key $voter_key (ballot key $ballot_key, release key $release_key)"
            }
            SyncVoterKeys;

            my @rank = split /,/, $ballot;
            for (my $j = 0; $j < $num_choices; $j++) {
                if (!defined($rank[$j])) {
                    $rank[$j] = $num_choices;
                }
            }

            for (my $j = 0; $j < $num_choices; $j++) {
                for (my $k = 0; $k < $num_choices; $k++) {
                    my $jk = $vdata{"$j.$k"};
                    $jk = 0 if (!defined($jk));
                    if ($rank[$j] ne 'No opinion' &&
                        $rank[$k] ne 'No opinion' &&
                        $rank[$j] < $rank[$k]) {
                        $vdata{"$j.$k"} = $jk - 1;
                    }
                }
            }

            return $ballot;
        } else {
            if (!$id || !$ballot_key) {
                print $tx->invalid_release_key($receipt);
            }
            if (!$vdata{$ballot_key}) {
                print $tx->no_ballot_under_key($receipt);
            }
        }
    }
    return 0;
}

# Generate a form that lets voters try to vote again.
# If a fourth argument is provided containing a receipt,
# a simple button is generated. Otherwise a text field
# is also provided for the user to enter the receipt.
sub RevoteButton {
    my ($voter_key, $button_label, $receipt) = @_;
    print start_form(
        -name => 'receipt_form',
        -method => 'POST',
        -enctype => 'multipart/form-data',
        -accept_charset => 'UTF-8',
        -action => '@CIVSBINURL@/vote@PERLEXT@'
    ), $cr;
    print hidden(-name => 'id', -value => $election_id), $cr;
    print hidden(-name => 'key', -value => $voter_key), $cr;
    print hidden(-name => 'akey', -value => $authorization_key), $cr;
    if ($receipt) {
        print hidden(-name => 'receipt', -value => $receipt), $cr;
    } else {
        print textfield(-name => 'receipt'), $cr;
    }
    print submit($button_label), $cr;
    print end_form(), $cr;
}

# Check if the voter has already voted (and this is not a valid revote).
# If so, generate a page that lets them revote by providing a receipt, and exit.
sub CheckNotVoted {
    my ($voter_key) = @_;
    if ($voter_key && $used_voter_keys{&civs_hash($voter_key)}) {
        if (my $ballot = CheckReceipt($voter_key)) { return $ballot }
	print h1($tx->Already_voted), $cr;
	print p($tx->vote_has_already_been_cast), $cr;
	&PointToResults;
        print p($tx->if_you_want_to_change), $cr;
        &RevoteButton($voter_key, $tx->change_ballot); # no receipt provided
        &main::TrySomePolls;
        &CIVS_End;

        ElectionLog("Election: $title ($election_id) : Saw second vote "
                . "from voter key $voter_key");
	exit 0;
    }
}

sub ControlKeyError {
    print h1($tx->Error),
    p($tx->Invalid_key);
    print end_html();
    my $t = '<undefined title>';
    if (defined($title)) {
	$t = $title;
    }
    my $id = '<undefined poll id>';
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
    return (defined($edata{'hash_authorization_key'}) &&
	    $edata{'hash_authorization_key'} ne 'none' &&
	    $publicize ne 'yes');
}

sub CheckAuthorizationKey {
    my $authorization_key = shift;
    if (!&ElectionUsesAuthorizationKey) {
        # if the hash doesn't exist in the database, then this is
        # an election that was created before authorization keys
        # were added to the CIVS design. Or it is a publicized election.
        # In either case the test passes.
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

sub CheckResultKey {
    my $result_key = shift;
    if (defined($result_key) && (
	&civs_hash($result_key) eq $hash_result_key
# originally CIVS stored the hash of the key, but this provides little
# added security while interfering with usability
     || $result_key eq $hash_result_key)) {
	return;
    }
    ElectionLog("Election: $title ($election_id) : invalid attempt to view election results (wrong key)");
    print h1($tx->Authorization_failure);
    p($tx->Invalid_result_key($result_key));
    print end_html();
    exit 0;
}

sub CheckAuthorizationKeyForAddingVoter {
    my $authorization_key = shift;
    if (!CheckAuthorizationKey($authorization_key)) {
        print h1($tx->Error),
	p($tx->Invalid_control_key($authorization_key));
        print end_html();
        ElectionLog("Election: $title ($election_id) : invalid attempt to add voter (wrong key)");
        exit 0;
    }
}

sub CheckAuthorizationKeyForVoting {
    my $authorization_key = shift;
    if (!CheckAuthorizationKey($authorization_key)) {
        print h1($tx->Error), p($tx->Invalid_key);
        print end_html();
        ElectionLog("Election: $title ($election_id) : invalid attempt to add voter (wrong key)");
        exit 0;
    }
}

sub IsWellFormedElectionID {
    $election_id =~ m/^E_[0-9a-f]+$/
}

sub CheckElectionID {
    if (!IsWellFormedElectionID) {
	if (defined($election_id) && $election_id ne '') {
	    print h1($tx->Invalid_poll_id);
	    print p($tx->Poll_id_not_valid($election_id));
	    Log("Attempt to provide a bogus poll identifier: \"$election_id\"");
	    $election_id = '';
	}
	print end_html();
	exit 0;
    }
}

# Log the string provided
sub ElectionLog {
    my $log_msg = shift;
    $log_msg =~ s/(\s)+$//;
    my $now = strftime "%a %b %e %H:%M:%S %Y", localtime;
    # print pre("trying to log to $election_log");
    if (!open ELECTION_LOG, ">>$election_log") {
        print h1($tx->Error),
          p($tx->Unable_to_append_to_poll_log);
          end_html();
	exit 0;
    }
    binmode ELECTION_LOG, ':utf8';
    print ELECTION_LOG $now." ".$remote_ip_address." ".$log_msg."\n";
    close ELECTION_LOG;
}

# Generate a voter key as the hash of the voter's email,
# the election's authorization key, and the server's private key.
# Assumes that the authorization key has been validated and that
# the email address is in canonical form.
sub GenerateVoterKey {
    (my $voter_email, my $authorization_key) = @_;
    my $voter_email_bytes = encode('utf-8', $voter_email);
    my $voter_key = civs_hash($voter_email_bytes, $authorization_key,
                              $private_host_id);
    if ($reveal_voters eq 'yes') {
	$edata{"email_addr $voter_key"} = $voter_email_bytes;
    }
    return $voter_key;
}

# Send the body of an email message formatted as HTML.
# The body is sent in both HTML and plain text. HTML
# tags are removed in the plain text version. <code>
# tags are replaced with angle brackets.
sub SendBody {
    my $html = shift;
    my $boundary = 'CIVS-'.&SecureNonce;
    my $plain = $html;
    $plain =~ s|<code>(.*)</code>|[[$1]]|g;
    $plain =~ s/<[^>]+>//g;
    $plain =~ s/\r\n\r\n/\r\n/g;
    $plain =~ s/\n\n/\n/g;
    $plain =~ s/^\r*//g;
    $plain =~ s/^\n*//g;
    $plain =~ s|\[\[(.*)\]\]|<$1>|g;

    Send 'Mime-Version: 1.0';
    Send "Content-Type: multipart/alternative; boundary=$boundary";
    Send '';
    Send "--$boundary";
    Send 'Content-Encoding: 8bit';
    Send 'Content-Type: text/plain; charset=UTF-8; format=flowed';
    Send '';
    Send $plain;
    Send "--$boundary";
    Send 'Content-Encoding: 8bit';
    Send 'Content-Type: text/html; charset=UTF-8';
    Send '';
    Send $html;
    Send "--$boundary--";
}

# Record the email load for this election
sub SetEmailLoad {
    (my $now, my $load) = @_;
    $email_load = "$now $load";
    $edata{'email_load'} = $email_load;
}

my $mail_period = 1; # days over which mail is counted

# get the email load for this election.
# requires: $_[0] is current time.
sub GetEmailLoad {
    (my $now) = @_;
    my $load = 0;
    my $day = 86400;
    if (defined($email_load)) {
        my @load_fields = split / /, $email_load, 2;
        my $kt = ($load_fields[0] - $now) / $mail_period / $day;
        $load = $load_fields[1];
	if ($kt > -30.0) { $load *= exp($kt); } else { $load = 0; }
    }
    return $load;
}

# Return the proper URL for the voter.  Also update $num_auth and $voter_keys
# appropriately, and print a message about the user already being authorized if
# they are. The voter email address does not need to be in canonical form.
sub VotingUrl {
    my ($email, $election_id, $authorization_key, $resend) = @_;
    my $v = &CanonicalizeAddr($email);
    my $url = "";
    if ($public eq 'yes') {
        $url = "@PROTO@://$thishost$civs_bin_path/vote@PERLEXT@?id=$election_id";
        $url .= "&akey=$authorization_key"
            if (&ElectionUsesAuthorizationKey);
    } else {
        my $voter_key = &GenerateVoterKey($v, $authorization_key);
        my $hash_voter_key = civs_hash($voter_key);
        $url = "@PROTO@://$thishost$civs_bin_path/vote@PERLEXT@?id=$election_id"
                    ."&key=$voter_key";
        if ($voter_keys{$hash_voter_key}) {
            # This email address has already been added to the poll
            if ($resend || !$used_voter_keys{$hash_voter_key}) {
                print $tx->Voter_v_already_authorized($email), $cr;
            } else {
                print $tx->Skipping_already_voted($email), $cr;
                return '';
            }
        } else {
            $voter_keys{$hash_voter_key} = 1;
            $num_auth++; $edata{'num_auth'} = $num_auth;
        }
    }
    return $url
}

# Construct new voter keys for all of the voters sent in @_.
# Send all of the voters their keys, with logging to STDOUT.
# Record the keys in the database, and update the number of
# authorized voters accordingly.
sub SendKeys {
    my ($authorization_key, $addresses_ref, $resend) = @_;
    my @addresses =  &unique_elements( @{$addresses_ref} );
    my $now = time();
    my $load = GetEmailLoad($now);
    my $optouts = &GetOptouts();
    my @failures = ();
    OpenMail;
    foreach my $v (@addresses) {
	$v = TrimAddr($v);
	if ($v eq '') { next }
        my $url = &VotingUrl($v, $election_id, $authorization_key, $resend);
        if (!$url) { next }

        # print "Checking whether $email_addr can send to $v\n";
        if (!&UserActivated($optouts, $v)) {
            push @failures, [('not activated', $v)];
            &RecordInvitation($v, $url, $title);
            next;
        }
        if (&CheckOptOutSender($optouts, $v, $email_addr)) {
            push @failures, [('opted out', $v)];
            &RecordInvitation($v, $url, $title);
            next;
        }
	if (!CheckAddr($v)) {
	    print $tx->Invalid_email_address($v), $cr;
	    next;
	}
        $load++;

        if ($local_debug) {
            print "voter link: <a href=\"$url\">$url</a>\n";
        } else {
# XXX This should be factored out into its own subroutine
	    sub SendURL {
	      (my $url) = @_;
	      Send MakeURL($url);
	    }
	    sub MakeURL {
	      (my $url) = @_;
	      return "<pre>\r\n    <a href=\"$url\"><code>$url</code></a>\r\n</pre>";
	    }

            ElectionLog("Sending mail to a voter for poll $election_id\n");
            print $tx->Sending_mail_to_voter_v($v), $cr; STDOUT->flush();
	    my $uniqueid = &SecureNonce;
	    my $messageid = "CIVS-$election_id.$uniqueid\@$thishost";

            MailFrom($auth_sender) &&
            MailTo($v) &&
            StartMailData() || next;

	    SendHeader('From', $tx->From_poll_supervisor($name, $civs_supervisor), "<$civs_supervisor>");
            SendHeader('Sender', $civs_supervisor);
            SendHeader('Reply-To', $email_addr);
	    SendHeader('Message-ID', "<$messageid>");
            SendHeader('To', "<$v>");
	    SendHeader('Subject', $tx->poll_email_subject($title));
	    Send 'Content-Transfer-Encoding: 8bit';
            SendHeader('Return-Path', $email_addr);
            Send 'X-Mailer: CIVS';
	    my $html =
"<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">
<html>
<head>
<meta content=\"text/html;charset=UTF-8\" http-equiv=\"Content-Type\"
</head>
<body><p>";
	    $html .= $tx->voter_mail_intro($title, $name, $email_addr);
	    $html .= '</p>';

	    if (!($description =~ m/^(\s)*$/)) {
		$html .= '<div style="border-style: solid; border-width: 1px; background-color: #f0f0f0; color: black">'.$cr.$cr;
		$html .= '<b>' . $tx->Description_of_poll . '</b>' . $cr;
		$description =~ s/([\r\n])\.([\r\n])/$1 .$2/g; # escape lone dot
		$html .= $description.'</div>'.$cr;
	    }
	    $html .= $cr.$cr.'<p>'. $tx->if_you_would_like_to_vote_please_visit;
	    $html .= MakeURL($url);

	    $html .= $tx->This_is_your_private_URL . '</p><p>';
	    if ($reveal_voters ne 'yes') {
		$html .= $tx->Your_privacy_will_not_be_violated;
	    } else {
		$html .= $tx->This_is_a_nonanonymous_poll;
	    }
	    $html .= $cr."</p><p>".$tx->poll_has_been_announced_to_end($election_end);
            if ($restrict_results ne 'yes') {
		$html .= ' ' .
		  $tx->To_view_the_results_at_the_end(&MakeURL("@PROTO@://$thishost$civs_bin_path/".
				"results@PERLEXT@?id=$election_id"));
	    }
	    $html .= '<p>'
                  .   $tx->For_more_information(&MakeURL($civs_home), &MakeURL($mail_mgmt_url))
                  .  '</p>
</body>
</html>';
	    SendBody $html;
            EndMailData;
        }
    }
    SetEmailLoad($now, $load);
    CloseMail;
    STDOUT->flush();
    return \@failures;
}

# Record that a voter has been invited to vote, so that they
# can be given a link to vote later.
sub RecordInvitation {
    (my $addr, my $url) = @_;
    $addr = CanonicalizeAddr($addr);
    my $key = &OptOutKey($addr);
    my $fname = "@CIVSDATADIR@/invites/$key";
    if (open(INVITES, ">>", $fname)) {
        binmode INVITES, ':utf8';
        print INVITES "$url $title\n";
    } else {
        Log("Could not open invite file $fname for writing\n");
    }
    close(INVITES) || Log("Error closing invite file $fname");
}
