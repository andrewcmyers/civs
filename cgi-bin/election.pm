$election_id = param('id');
$election_id =~ s/\.//g;
$election_id =~ s/\///g;

# set up filename paths

$election_dir = $home."/elections/".$election_id;
$started_file = $election_dir."/started";
$stopped_file = $election_dir."/stopped";
$election_data = $election_dir."/election_data";
$election_log = $election_dir."/vote_log";
$vote_data = $election_dir."/vote_data";
$election_lock = $election_dir."/lock";

# open databases

$db = tie %edata, "DB_File", $election_data, O_RDWR, 0666, $DB_HASH;
$vdb = tie %vdata, "DB_File", $vote_data, O_CREAT|O_RDWR, 0666, $DB_HASH;

# extract data from databases

$name = $edata{'name'};
$title = $edata{'title'};
$email_addr = $edata{'email_addr'};
$description = $edata{'description'};
$num_winners = $edata{'num_winners'};
$addresses = $edata{'addresses'};
@addresses = split /[\r\n]+/, $addresses;
$election_end = $edata{'election_end'};
$public = $edata{'public'};
$writeins = $edata{'writeins'};
$proportional = $edata{'proportional'};
$choices = $edata{'choices'};
@choices = split /[\r\n]+/, $choices;
$num_choices = $#choices + 1;
$num_auth = $edata{'num_auth'};
$num_votes = $vdata{'num_votes'};
$recorded_voters = $vdata{'recorded_voters'};

# utility routines

sub LockElection {
    sysopen(ELOCK, $lockfile, O_CREAT|O_RDWR);
    flock ELOCK, LOCK_EX;
}
sub UnlockElection {
    flock ELOCK, LOCK_UN;
    close(ELOCK);
}

sub StartElection {
    if (sysopen(STARTED, $started_file, O_RDONLY)) {
	print h1("Error");
	print p("This election ($title) has already been started"), end_html();
	exit 0;
    }
    if (sysopen(STARTED, $started_file, O_CREAT|O_EXCL)) {
	print STARTED "started\n";
	close(STARTED);
    } else {
	print h1("Error");
	print p("Did not have write access to start an election"), end_html();
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
	print p("This election does not exist or has not been started"), end_html();
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
    print "<a href=\"http://$thishost$civs_bin_path/results?id=$election_id\">
    <tt>http://$thishost$civs_bin_path/results?id=$election_id</tt></a></p>\n";
}
sub PointToResultsComplete {
    print "<p>The following web page has the results of this completed election:<br>\n";
    print "<a href=\"http://$thishost$civs_bin_path/results?id=$election_id\">
       <tt>http://$thishost$civs_bin_path/results?id=$election_id</tt></a></p>\n";
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
    if (!IsStopped() && (!$localdebug)) {
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
    if ($private_host_id eq '') {
	GetPrivateHostID;
    }
    $voter_key_check = substr(md5_hex("voter".$private_host_id.$election_id.$voter), 0, 16);
    if ($voter_key_check ne $voter_key) {
	Log("Invalid voter key $voter_key presented by $voter for election $election_id, expected $voter_key_check");
	print h1("Error"), p("Your voter key is invalid. You should have received a correct URL by email."), end_html();
	exit 0;
    }
}

sub CheckNotVoted {
    if ($vdata{$voter_key} ne '') {
	print h1("Already voted");
	print p("A vote has already been cast using your voter key.");
	PointToResults;
	print end_html();
	open(LOG, ">>$election_log");
	print LOG "Election: $title ($election_id) : Saw second vote from voter $voter, voter key $voter_key\n";
	close(LOG);
	exit 0;
    }
}

sub CheckControlKey {
    GetPrivateHostID;
    $control_key = param('key');
    $control_key_check = substr(md5_hex("control".$private_host_id.$election_id), 0, 16);
    if ($control_key ne $control_key_check) {
	print h1("Error"), p("Invalid key. You should have received a correct URL for controlling the election by email. This error has been logged.");
	print end_html();
	open(LOG, ">>$election_log");
	print LOG "Election: $title ($election_id) : invalid attempt to close election (wrong key)\n";
	close(LOG);
	exit 0;
    }
}

sub CheckElectionID {
    if (!($election_id =~ m/^E_[0123456789abcdef]+/)) {
	if ($election_id ne '') {
	    print h1("Invalid election identifier");
	    print p("The election identifier \"$election_id\" is not valid.\n");
	    Log("Attempt to provide a bogus election identifier: \"$election_id\"");
	    $election_id = '';
	}
	print end_html();
	exit 1;
    }
}

1; # ok!
