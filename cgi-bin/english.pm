package english;

sub lang { 'en-US'; }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub Condorcet_Internet_Voting_Service {
    'Condorcet Internet Voting Service';
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited 
    'Condorcet Internet Voting Service';
}
sub about_civs {
    'About CIVS';
}
sub create_new_poll {
    'Create new poll';
}
sub about_security_and_privacy {
    'About security and privacy';
}
sub FAQ {
    'FAQ';
}
sub CIVS_suggestion_box {
    'CIVS suggestion box';
}
sub unable_to_process {
    'CIVS is unable to process your request because of an internal error.';
}
sub CIVS_Error {
    'CIVS Error';
}
sub CIVS_server_busy {
    'CIVS server busy';
}
sub Sorry_the_server_is_busy {
    'Sorry, the CIVS web server is very busy right now and
     cannot handle more requests. Please try again a little later.';
}

# civs_create

sub mail_has_been_sent {
    "Mail has been sent to the address you provided (<tt>$_[1]</tt>).";
}

sub click_on_the_URL_to_start {
    "Click on the URL in that email to start the poll: <strong>$_[1]</strong>.";
}

sub here_is_the_control_URL {
    'Here is the URL to control the new poll. In ordinary operation
             this would be sent to the supervisor via e-mail.';
}
sub the_poll_is_in_progress {
    'The poll is in progress. Press this button to end it: ';
}

sub CIVS_Poll_Creation {
    "CIVS Poll Creation";
}
sub Poll_created {
    "Poll created: $_[1]"
}

sub Address_unacceptable { #addr
    "The address \"$_[1]\" is not acceptable";
}
sub Poll_must_have_two_choices {
    'A poll must have at least two choices.';
}
sub Poll_directory_not_writeable {
    "The poll directory is not writeable";
}
sub CIVS_poll_created {
 "CIVS poll created: $title";
}
sub creation_email_info1 { # title, url
"This email acknowledges the creation of a new poll,
$_[1]. You have been designated as the supervisor of this
poll. To start and stop the poll, please use the following URL:

  $url

";
}
sub creation_email_public_link { # url
"Because this is a public poll, voters may be directed to the following URL:

  $_[1]

";
}
sub for_more_information_about_CIVS { # url
"For more information about the Condorcet Internet Voting Service, see
  $_[1]";
}

sub Sending_result_key { # addr
    "Sending result key to '$_[1]'";
}
sub Results_of_CIVS_poll { # title
    "Results of CIVS poll: $title";
}
sub Results_key_email_body { # title, url, civs_home
"A new CIVS poll has been created named $_[1].
You have been designated as a user who is permitted to see the
result of this poll.

Save this email. If you lose it you will not have access to
the results. Once the poll has been closed, results will be
available at the following URL:

  $_[2]

This URL is private. Allowing unauthorized users access to this
URL will permit them to see the poll results.
For more information about the Condorcet Internet Voting Service, see
  $_[3]

";
}
  
# start

sub poll_started {
    'The poll <strong>'.$_[1].'</strong> has been started.';
}

# control

sub CIVS_Poll_Control {
    "CIVS Poll Control";
}
sub Poll_control {
    "Poll Control";
}
sub poll_has_not_yet_started {
    'The poll has not yet started. Press this button to start it: ';
}
sub start_poll {
    'Start poll';
}
sub End_poll {
    'End poll';
}
sub ending_poll_cannot_be_undone {
    'Ending a poll is an operation that cannot be undone. Continue?';
}
sub writeins_have_been_disabled {
    'Write-in candidates have been disabled';
}
sub disallow_further_writeins {
    'Write-in candidates have been disabled';
}
sub voting_disabled_during_writeins {
    'Voting is currently disabled during the write-in phase.';
}
sub allow_voting_during_writeins {
    "Allow voting during write-in phase";
}
sub this_is_a_test_poll {
    'This is a test poll.';
}

sub poll_supervisor { # name, email
    "Poll supervisor: $_[1] (<tt>$_[2]</tt>)";
}
sub no_authorized_yet { #waiting
    "0 ($_[1] voters will be authorized when the poll is started)";
}
sub total_authorized_voters { # num_auth_string
    "Total authorized voters: $_[1]";
}
sub actual_votes_so_far { # num
    "Actual votes cast thus far: $_[1]";
}
sub poll_ends { # end
    "Poll ends $_[1].";
}
sub Poll_results_available_to_all_voters_when_poll_completes {
    'Poll results available to all voters when poll completes.';
}
sub Voters_can_choose_No_opinion {
    'Voters can choose &ldquo;No opinion&rdquo;';
}
sub Voting_is_disabled_during_writeins {
    'Voting is disabled during the write-in period.';
}
sub Poll_results_will_be_available_to_the_following_users {
    'Poll results will be available only to the following users:';
}
sub Poll_results_are_now_available_to_the_following_users {
    'Poll results are now available only to the following users,
	    who were earlier sent an email containing a URL for
	     viewing results:';
}
sub results_available_to_the_following_users {
    'The results of this poll have been released only to a limited set of users:';
}

sub Poll_results_are_available { #url
    "<a href=\"$_[1]\">See poll results</a>";
}
sub Poll_results_will_be_available { #url
    "<a href=\"$_[1]\">See poll results</a>";
}
sub Description {
    'Description:';
}
sub Candidates {
    'Candidates:';
}
sub Add_voters {
    'Add voters';
}

sub the_top_n_will_win { # num_winners
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt = "candidate";
    } else {
	$wintxt = "$_[1] candidates";
    }
    return "The top $wintxt will win.";
}

sub add_voter_instructions {
    "Enter e-mail addresses of voters, one per line. These
    may be new voters or existing voters who have not voted yet.
    In a private poll, giving the e-mail address of an already 
    existing voter <strong>will not</strong> let that voter vote twice.
    It will only resend the voter an invitation to vote.
    In a public poll, only a token attempt is made to prevent
    multiple voting.";
}
sub Upload_file {
    'Upload file: ';
}
sub Load_ballot_data {
    'Load ballot data';
}
sub File_to_upload_ballots_from {
    'File to upload ballots from:';
}
sub This_is_a_public_poll_plus_link {
    my $url = $_[1];
    "This is a public poll. Share the following link
	with voters to allow them to vote:</p><p>
	&nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>";
}
sub The_poll_has_ended {
    'The poll has ended.';
}

# add voters

sub CIVS_Adding_Voters {
    'CIVS: Adding Voters';
}
sub Adding_voters {
    'Adding voters';
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
    'Sorry, voters can only be added to an poll in progress.';
}

sub Total_of_x_voters_authorized { # x
    if ($_[1] == 0) {
	print "No voters authorized to vote yet.", $cr, '</pre>';
    } elsif ($_[1] == 1) {
	print "Only 1 voter authorized to vote so far.", $cr, '</pre>';
    } else {
	print "Total of $_[1] voters authorized to vote.", $cr, '</pre>';
    }
}

sub Go_back_to_poll_control {
    'Go back to poll control';
}

# vote

sub page_header_CIVS_Vote { # election_title
    'CIVS Vote: '.$_[1];
}

sub winners_text {
    if ($_[1] == 1) {
	return "single favorite choice";
    } else {
	return "$num_winners favorite choices";
    }
}
sub ballot_reporting_is_enabled {
    'Ballot reporting is enabled for this poll.
     Your ballot (the rankings you assign to candidates)
     will be made public when the poll ends.';
}
sub instructions1 { # winners_text, end, name, email
    "Only the $_[1] will win the poll.<p>
	    The poll ends <b>$_[2]</b>.
	    The poll supervisor is $_[3] (<tt>$_[4]</tt>).
	    Contact the poll supervisor if you need help.";
}
sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
    my ($no_opinion, my $prop, my $combined, my $civs_url) = @_;
    my $ret;
    if (!$prop || !$combined) {
	$ret = "Give each of the following choices
	    a rank, where a smaller-numbered rank means that you
	    prefer that choice more.
	    For example, give your top choice the rank 1.
	    Give choices the same rank if you have no
	    preference between them. You do not have to use all the
	    possible ranks. All choices initially have the
	    lowest possible rank. ". $cr;
	if ($no_opinion) {
	    $ret .= '<b>Note:</b> &ldquo;No opinion&rdquo;
		    is <i>not</i> the same as the lowest possible rank; it means
		    that you choose not to rank this choice with respect to the
		    other choices.</p>';
	}
	if ($proportional) {
	    $ret .= '<p>This poll is decided using an experimental Condorcet-based
	    method designed to provide proportional representation. It is assumed
	    by the voting algorithm that you want the ranking of your most
	    preferred <i>winning</i> choice to be as high as possible, and if two
	    sets of winning choices agree on the choice you prefer most, then you
	    would decide between them using the second most preferred choice, and
	    so on. ';
	}
    } else {
	$ret = '<p>This poll is decided using an experimental
	Condorcet-based algorithm designed to provide proportional
	representation.
	Please give each of the following choices a
	<b>weight</b> that expresses how much you want that
	choice to be part of the winning set of choices.
	It is assumed by the voting algorithm that you want
	  the sum of weights of winning choices to be as large
	as possible.  All choices
	are currently given a weight of zero, meaning that you
	have no interest in seeing them win.
	Weights cannot be negative or larger than 999.
	It doesn\'t help you to make your weights larger
	than other voters\' weights, because your weights are only compared
	against each other.'.
	"<a href=\"$civs_url/proportional.html\">[See more information]</a>.</p>";
    }
    return $ret;
}
sub Rank {
    'Rank';
}
sub Choice {
    'Choice';
}
sub Weight {
    'Weight';
}

sub address_will_be_visible {
    '<strong>Your email address will be visible</strong> along with your ballot.';
}

sub ballot_will_be_anonymous {
    ' However, your ballot will still be anonymous:
      no personally identifying information will appear.';
}

sub submit_ranking {
    'Submit ranking';
}

sub only_writeins_are_permitted {
    'Voting is not yet permitted in this poll. However,
             you may view the available choices and write in new
	     choices. Use the text field below to write in new choices.';
}

sub to_top {
    'to top';
}
sub to_bottom {
    'to bottom';
}
sub move_up {
    'move up';
}
sub move_down {
    'move down';
}
sub make_tie {
    'make tie';
}
sub buttons_are_deactivated {
    'These buttons are deactivated because
	your browser does not support Javascript.';
}
sub ranking_instructions {
       'Rank the choices in one of three ways:
	<ol>
	    <li>drag the rows
	    <li>use pulldowns in Rank column
	    <li>select rows and use buttons above
	</ol>';
}

sub write_in_a_choice {
    'Write in a new choice: ';
}
sub if_you_have_already_voted { #url
    "If you have already voted, you may see
	<a href=\"$_[1]\">the current poll results</a>.";
}
sub thank_you_for_voting { #title, receipt
    "Thank you. Your vote for <strong>$_[1]</strong> has been
	successfully cast. Your voter receipt is <code>$_[2]</code>.";
}
sub name_of_writein_is_empty {
    "Name of write-in choice is empty";
}
sub writein_too_similar {
    "Sorry, the name of the write-in is too similar to an existing choice";
}

# election

sub vote_has_already_been_cast {
    "A vote has already been cast using your voter key.";
}
sub following_URL_will_report_results {
    'The following URL will report poll results once the poll ends:';
}
sub following_URL_reports_results {
    'The following URL reports the current poll results:';
}
sub Already_voted {
    'Already voted';
}
sub Error {
    'Error';
}
sub Invalid_key {
    'Invalid key. You should have received a correct URL for
        controlling the poll by email. This error has been logged.';
}
sub Authorization_failure {
    'Authorization failure';
}

sub already_ended { # title 
    "This poll (<strong>$_[1]</strong>) has already been ended.";
}
sub The_results_of_this_completed_poll_are_here {
    'The results of this completed poll are here:';
}

sub No_write_access_to_lock_poll {
    "Did not have the write access needed to lock the poll.";
}
sub This_poll_has_already_been_started { # title
    "This poll ($_[1]) has already been started.";
}
sub No_write_access_to_start_poll {
    'Did not have write access to start a poll.';
}
sub Poll_does_not_exist_or_not_started {
    'This poll does not exist or has not been started.';
}
sub Your_voter_key_is_invalid__check_mail { # voter
   my $voter = $_[1];
   if ($voter ne '') {
    "Your voter key is invalid, $voter.
     You should have received a correct URL by email.";
   } else {
    "Your voter key is invalid. You should have received a correct URL by email.";
   }
}
sub Invalid_result_key { # key
    "Invalid result key: \"$_[1]\". You should have received a correct URL for
        viewing poll results by email. This error has been logged.";
}
sub Invalid_control_key { # key
    "Invalid control key. You should have received a correct URL for controlling the poll by email. This error has been logged.";
}
sub Invalid_voting_key {
    "Invalid voting key. You should have received a correct URL for voting by email. This error has been logged.";
}
sub Invalid_poll_id {
    "Invalid poll identifier";
}
sub Poll_id_not_valid { #id
    "The poll identifier \"$_[1]\" is not valid.";
}
sub Unable_to_append_to_poll_log {
    "Unable to append to the poll log.";
}
sub Voter_v_already_authorized {
    "Voter \"$_[1]\" is already authorized.
     The voter's key will be resent to the voter.";
}
sub Invalid_email_address_hdr { # addr
    "Invalid email address";
}
sub Invalid_email_address { # addr
    "Invalid email address: $v";
}
sub Sending_mail_to_voter_v {
    "Sending mail to voter \"$_[1]\"...";
}
sub CIVS_poll_supervisor {
    'CIVS poll supervisor';
}
sub voter_mail_intro { #title, name, email_addr
"A Condorcet Internet Voting Service election named <b>$_[1]</b> has been created.
You have been designated as a voter by the election supervisor,
$_[2] (<a href=\"mailto:$_[3] ($_[2])\">$_[3]</a>).</p>";
}
sub description_of_poll {
    "Description of poll:";
}
sub if_you_would_like_to_vote_please_visit {
    'If you would like to vote, please visit the following URL:';
}
sub This_is_your_private_URL {
'This is your private URL. Do not give it to anyone else, because they could use
it to vote for you.';
}
sub Your_privacy_will_not_be_violated {
'Your privacy will not be violated by voting.  The voting service has already
destroyed the record of your email address and will not release any information
about whether or how you have voted.';
}
sub This_is_a_nonanonymous_poll {
'The poll supervisor has decided to make this a <strong>non-anonymous poll</strong>.  If
you vote, how you voted will be publicly visible along with your
email address. If you do not vote, the poll supervisor will also be able
to determine this.';
}

sub poll_has_been_announced_to_end { #election_end
    "The poll has been announced to end $_[1].";
}

sub To_view_the_results_at_the_end {
    'To view the results of the poll once it has ended, visit:</p>';
}

sub For_more_information {
'For more information about the Condorcet Internet Voting Service, see:';
}


# close

sub CIVS_Ending_Poll {
    'CIVS: Ending Poll';
}

sub Ending_poll {
    'Ending a poll';
}
sub View_poll_results {
    'View_poll_results';
}
sub Poll_ended { #title
    "Poll ended: $_[1]";
}

sub The_poll_has_been_ended { #election_end
    "The poll has been ended. It was announced to end $_[1].";
}

sub poll_results_available_to_authorized_users {
    'The poll results are now available to authorized users.';
}

sub was_not_able_stop_the_poll {
    'Was not able to stop the poll';
}


# results

sub Writeins_currently_allowed {
    'Write-in choices are currently allowed.';
}

sub Writeins_allowed {
    'Write-in candidates are allowed.';
}
sub Writeins_not_allowed {
    'Write-in candidates are not allowed.';
}
sub Detailed_ballot_reporting_enabled {
    'Detailed ballot reporting is enabled.';
}
sub Detailed_ballot_reporting_disabled {
    'Detailed ballot reporting is disabled.';
}
sub Voter_identities_will_be_kept_anonymous {
    'Voter identities will be kept anonymous';
}
sub Voter_identities_will_be_public {
    'Voter identities (email) will be publicly associated with their ballots.';
}
sub undefined_algorithm {
    'Error: undefined algorithm.';
}
sub computing_results {
    'Computing results...';
}
sub Supervisor { #name, email
    "Supervisor: $_[1] ($_[2])";
}
sub Announced_end_of_poll {
    "Announced end of poll: $_[1]";
}
sub Actual_time_poll_closed { # close time
    "Actual time poll closed: $_[1]";
}
sub Poll_not_ended {
    'Poll has not yet ended.';
}
sub This_is_a_test_poll {
    'This is a test poll.';
}
sub This_is_a_private_poll { #num_auth
    "Private poll ($_[1] authorized voters)";
}
sub This_is_a_public_poll {
    'This is a public poll.';
}

sub Actual_votes_cast { #num_votes
    "Actual votes cast: $num_votes";
}
sub Number_of_winning_candidates {
    'Number of winning candidates: ';
}
sub Poll_actually_has { #winmsg
    my $winmsg = '1 winner';
    if ($_[1] != 1) {
	$winmsg = $real_nwin.' winners';
    }
    "&nbsp;(Poll actually has $winmsg)";
}
sub poll_description_hdr {
    'Poll description';
}
sub Ranking_result {
    'Ranking result';
}
sub x_beats_y { # x y w l 
    "$_[1] beats $_[2] $_[3]&ndash;$_[4]";
}
sub x_ties_y { # x y w l 
    "$_[1] ties $_[2] $_[3]&ndash;$_[4]";
}
sub x_loses_to_y { # x y w l 
    "$_[1] loses to $_[2] $_[3]&ndash;$_[4]";
}
sub some_result_details_not_shown {
    'For simplicity, some details of the poll result are not shown.';
}
sub Show_details {
    'Show details';
}
sub Hide_details {
    'Hide details';
}
sub Result_details {
    'Result details';
}
sub Ballot_report {
    'Ballot report'
}
sub Ballots_are_shown_in_random_order {
    "Ballots are shown in a randomly generated order.";
}
sub Download_ballots_as_a_CSV { # url
    "<a href=\"$url\">Download ballots</a> as a CSV";
}
sub No_ballots_were_cast {
    "No ballots were cast in this poll.";
}
sub Ballot_reporting_was_not_enabled {
    "Ballot reporting was not enabled for this poll.";
}
sub Tied {
    "<i>Tied</i>:";
}
sub loss_explanation { # loss_to, for, against
    ', loses to '. $_[1].' by '. $_[2] .'&ndash;'. $_[3];
}
sub loss_explanation2 {
    '&nbsp;&nbsp;loses to '.$choices[$condorcet_winner].' by '.
	$matrix[$condorcet_winner][$winner[$i]].'&ndash;'.
	$matrix[$winner[$i]][$condorcet_winner];
}
sub Condorcet_winner_explanation {
    '&nbsp;&nbsp;(Condorcet winner: wins contests with all other choices)';
}
sub undefeated_explanation {
    '&nbsp;&nbsp;(Not defeated in any contest vs. another choice)';
}
sub Choices_shown_in_red_have_tied {
    "Choices shown in red have tied for being selected.
	You may wish to select among them randomly.";
}
sub Condorcet_winner {
    "Condorcet winner";
}
sub Choices_in_individual_pref_order {
    'Choices (in individual preference order)';
}
1; # package succeeded!