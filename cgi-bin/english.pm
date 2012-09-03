package english;

use base_language;

our $VERSION = 1.20;
our @ISA = ('base_language'); # go to base_language module for missing methods
sub lang { 'en-US' }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub style_file {
    'style.css'
}
sub Condorcet_Internet_Voting_Service {
    'Condorcet Internet Voting Service'
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited 
    'Condorcet Internet Voting Service'
}
sub about_civs {
    'About CIVS'
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
    'CIVS suggestion box'
}
sub unable_to_process {
    'CIVS is unable to process your request because of an internal error.'
}
sub CIVS_Error {
    'CIVS Error'
}
sub CIVS_server_busy {
    'CIVS server busy'
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
    "Click on the URL in that email to start the poll &ldquo;$_[1]&rdquo;.";
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
 "CIVS poll created: $_[1]";
}
sub creation_email_info1 { # title, url
"This email acknowledges the creation of a new poll,
$_[1]. You have been designated as the supervisor of this
poll. To start and stop the poll, please use the following URL:

  $_[2]

Save this email and keep it private. If you lose it you will not be able
to control the poll.

";
}
sub creation_email_public_link { # url
"Because this is a public poll, you may direct voters to the following URL:

  $_[1]

";
}
sub for_more_information_about_CIVS { # url
"For more information about the Condorcet Internet Voting Service, see
  $_[1]";
}

sub Sending_result_key { # addr
    "<p>Sending result key to <tt>$_[1]</tt>. Please allow this to complete...<br>"
}
sub Done_sending_result_key { # addr
    '...done sending result key.</p>'
}
sub Results_of_CIVS_poll { # title
    "Results of CIVS poll: $_[1]";
}
sub Results_key_email_body { # title, url, civs_home
"A new CIVS poll has been created named \"$_[1]\".
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

sub sending_keys_now {
    'Sending voter invitations now. Do not navigate away from this page
     until all invitations are sent.'
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
sub Start_poll {
    'Start poll';
}
sub End_poll {
    'End poll';
}
sub ending_poll_cannot_be_undone {
    'Ending a poll is an operation that cannot be undone. Continue?';
}
sub writeins_have_been_disabled {
    'Write-in choices have been disabled';
}
sub disallow_further_writeins {
    'Disallow further write-ins';
}
sub voting_disabled_during_writeins {
    'Voting is currently disabled during the write-in phase.';
}
sub allow_voting_during_writeins {
    "Allow voting during write-in phase";
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
	$wintxt = "choice";
    } else {
	$wintxt = "$_[1] choices";
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
	'No voters authorized to vote yet.';
    } elsif ($_[1] == 1) {
	'Only 1 voter authorized to vote so far.';
    } else {
	"Total of $_[1] voters authorized to vote.";
    }
}

sub Go_back_to_poll_control {
    'Go back to poll control';
}
sub Done {
    'Done.';
}

# vote

sub page_header_CIVS_Vote { # election_title
    'CIVS Vote: '.$_[1];
}

sub ordinal_of {
    my $n = $_[1];
    if ($n >= 4 && $n < 20) {
	return $n.'th'
    } elsif ($n % 10 == 1) {
	return $n.'st'
    } elsif ($n % 10 == 2) {
	return $n.'nd'
    } elsif ($n % 10 == 3) {
	return $n.'rd'
    } else {
	return $n.'th'
    }
}

sub ballot_reporting_is_enabled {
    'Ballot reporting is enabled for this poll.
     Your ballot (the rankings you assign to choices)
     will be visible in the poll results when the poll ends.';
}

sub Identifier_request {
    "<p>Please give your email address or other recognizable identifier:  \r\n".
    '<input type="text" name="email_address" size="50"></p>'.
    "\r\n"
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

sub Add_writein {
    'Add write-in';
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
       '<p>Rank the choices in one of three ways:</p>
	<ol>
	    <li>drag the rows</li>
	    <li>use pulldowns in Rank column</li>
	    <li>select rows and use buttons above</li>
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
sub Poll_not_yet_ended {
    "Poll not yet ended";
}
sub The_poll_has_not_yet_been_ended { #title, name, email
    "This poll ($_[1]) has not yet been ended by its supervisor,
    $_[2] ($_[3]).";
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
    "Invalid email address: $_[1]";
}
sub Sending_mail_to_voter_v {
    "Sending mail to voter \"$_[1]\"...";
}
sub CIVS_poll_supervisor { # name
    "\"$_[1] (CIVS poll supervisor)\""
}
sub Description_of_poll {
    'Description of poll:';
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
    'The poll supervisor has decided to make this a <strong>non-anonymous poll</strong>.
If you vote, your email address and how you voted will be visible to anyone
who has been given access to the poll results.'
}

sub poll_has_been_announced_to_end { #election_end
    "The poll has been announced to end $_[1].";
}

sub To_view_the_results_at_the_end {
    "To view the results of the poll once it has ended, visit:</p> $_[1]";
}

sub For_more_information {
    'For more information about the Condorcet Internet Voting Service, see:';
}

sub poll_email_subject { # title
    "Poll: $_[1]"
}

# close

sub CIVS_Ending_Poll {
    'CIVS: Ending Poll';
}

sub Ending_poll {
    'Ending a poll';
}
sub View_poll_results {
    'View poll results';
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

sub CIVS_poll_result {
    "CIVS poll result";
}
sub Poll_results { # title
    "Poll Results: $_[1]";
}

sub Writeins_currently_allowed {
    'Write-in choices are currently allowed.';
}

sub Writeins_allowed {
    'Write-in choices are allowed.';
}
sub Writeins_not_allowed {
    'Write-in choices are not allowed.';
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
'Voter identities (email) along with their ballots will be
visible to those authorized to see poll results.'
}
sub Condorcet_completion_rule {
    'Condorcet completion rule:';
}
sub undefined_algorithm {
    'Error: undefined algorithm.';
}
sub computing_results {
    'Computing results...';
}
sub Announced_end_of_poll {
    "Announced end of poll: $_[1]";
}
sub Actual_time_poll_closed { # close time
    if ($_[1] == 0) {
	"Actual time poll closed: $_[1]"
    } else {
	'Actual time poll closed: <script>document.write(new Date(' .
	    $_[1] * 1000 . 
	    ').toLocaleString())</script>';
    }
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
    "Actual votes cast: $_[1]";
}
sub Number_of_winning_candidates {
    'Number of winning choices: ';
}
sub Poll_actually_has { #winmsg
    my $winmsg = '1 winner';
    if ($_[1] != 1) {
	$winmsg = $_[1].' winners';
    }
    "&nbsp;(Poll actually has $winmsg)";
}
sub poll_description_hdr {
    'Poll description';
}
sub Ranking_result {
    'Result';
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
    'For simplicity, some details of the poll result are not shown. &nbsp;';
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
    "[<a href=\"$_[1]\">Download ballots in CSV format</a>]";
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
    '&nbsp;&nbsp;loses to '.$_[1].' by '.$_[2].'&ndash;'.$_[3];
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

sub What_is_this { # url
    '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>'. '(What is this?)</small></a>';
}

# rp

sub All_prefs_were_affirmed {
    'All preferences were affirmed. All
		  Condorcet methods will agree with this ranking.';
}

sub Presence_of_a_green_entry_etc {
    'The presence of a green entry below
	the diagonal (and a corresponding red one above)
	means that a preference was ignored because
	it conflicted with other, stronger preferences.';
}
sub Random_tie_breaking_used {
'Random tie breaking was used to
arrive at this ordering, as per the MAM
algorithm. This may have affected the ordering
of the choices.';
}
sub No_random_tie_breaking_used {
    'No random tie breaking was needed to arrive at this ordering.';
}

# beatpath

sub beatpath_matrix_explanation {
    'The following matrix shows the strength of the strongest
    beatpath connecting each pair of choices. Choice 1 is ranked above
    choice 2 if there is a stronger beatpath leading from 1 to 2
    than any leading from 2 to 1.';
}

sub no_pref {
    'none'
}

#rp

sub Some_voter_preferences_were_ignored {
    'Some voter preferences were ignored because they
     conflict with other, stronger preferences:'
}

sub preference_description {
    "The $_[1]&ndash;$_[2] preference for $_[3] over $_[4]."
}

1; # package succeeded!
