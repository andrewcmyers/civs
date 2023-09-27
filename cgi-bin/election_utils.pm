package election_utils;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.00;
    @ISA         = qw(Exporter);
    @EXPORT      = qw($name $title $email_addr $description
                      $num_winners $addresses @addresses
                      $election_begin $election_end $public
                      $publicize $writeins $allow_voting
                      $voting_enabled $proportional
                      $use_combined_ratings $external_ballots
                      $choices @choices $num_choices $num_auth
                      $num_votes $recorded_voters $ballot_reporting
                      $reveal_voters $authorization_key $shuffle
                      $no_opinion %voter_keys %used_voter_keys
                      $restrict_results $result_addrs
                      $hash_result_key $last_vote_time $close_time
                      $email_load &GetElectionData);

   $ENV{'PATH'} = $ENV{'PATH'}.'@ADDTOPATH@';
}

our ($name, $title, $email_addr, $description, $num_winners, $addresses,
     @addresses, $election_begin, $election_end, $public, $publicize,
     $writeins, $allow_voting, $voting_enabled, $proportional,
     $use_combined_ratings, $external_ballots, $choices, @choices,
     $num_choices, $num_auth, $num_votes, $recorded_voters,
     $ballot_reporting, $reveal_voters, $authorization_key, $shuffle,
     $no_opinion, %voter_keys, %used_voter_keys, $restrict_results,
     $result_addrs, $hash_result_key, $last_vote_time, $close_time,
     $email_load);

# Extract data from databases. This should be factored out into common
# code that is used both here and in election.pm
#
# ExtractData($eref, $vref) expects references to the election data map
# and the voting data map, set up using `tie`.
sub GetElectionData {
    my ($eref, $vref) = @_;
    $name = $eref->{'name'};
    if (!defined($name)) {
        print STDERR "Cannot read election data file -- wrong BDB version?\n";
        return 0;
    }
    $title = $eref->{'title'};
    $email_addr = $eref->{'email_addr'};
    $description = $eref->{'description'};
    $num_winners = $eref->{'num_winners'};
    $addresses = $eref->{'addresses'} or $addresses = "";
    @addresses = split /[\r\n]+/, $addresses;
    $election_begin = $eref->{'election_begin'};
    $election_end = $eref->{'election_end'};
    $public = $eref->{'public'};
    $publicize = $eref->{'publicize'};
    $writeins = $eref->{'writeins'};
    $allow_voting = $eref->{'allow_voting'} || 'no';
    $voting_enabled = (($writeins && $writeins ne 'yes') || $allow_voting eq 'yes');
    $proportional = $eref->{'proportional'} or $proportional = "";
    $use_combined_ratings = $eref->{'use_combined_ratings'};
    $choices = $eref->{'choices'} or $choices = "";
    @choices = split /[\r\n]+/, $choices;
    $num_choices = $#choices + 1;
    $num_auth = $eref->{'num_auth'};
    $shuffle = $eref->{'shuffle'};
    $no_opinion = $eref->{'no_opinion'} or $no_opinion = 'yes';
    $num_votes = $vref->{'num_votes'} or $num_votes = 0;
    $close_time = $vref->{'close_time'};
    $recorded_voters = $vref->{'recorded_voters'};
    $ballot_reporting = $eref->{'ballot_reporting'} or $ballot_reporting = '';
    $external_ballots = $eref->{'external_ballots'} or $external_ballots = 'no';
    $reveal_voters = $eref->{'reveal_voters'} or $reveal_voters = '';
    $restrict_results = $eref->{'restrict_results'};
    $result_addrs = $eref->{'result_addrs'};
    $hash_result_key = 0;
    $last_vote_time = $vref->{'last_vote_time'};
    $email_load = $eref->{'email_load'}; # timestamp num_mails
    if ($restrict_results eq 'yes') {
	$hash_result_key = $eref->{'hash_result_key'};
    }
    1
}

1
