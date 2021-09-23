package base_language;

use CGI qw(:standard);

our $VERSION = 1.00;

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
sub new_user {
    'Activate user'
}
sub public_polls {
    'Public polls'
}
sub create_new_poll {
    'Create new poll'
}
sub about_security_and_privacy {
    'Security and privacy'
}
sub FAQ {
    'FAQ'
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
             this would be sent to the supervisor via email.';
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
    "Configuration error? Unable to create the poll directory <tt>$_[1]</tt>"
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

sub opted_out { # addr
  "Sorry, you cannot send any email to &lt;$_[1]&gt; via CIVS."
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
    'Start poll'
}
sub End_poll {
    'End poll'
}
sub Edit_button {
    'edit'
}
sub ResendLink_button {
    'resend link'
}
sub ResendLinkAck {
    'sent'
}
sub Save_button {
    'save'
}
sub Remove_button {
    'remove'
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
sub this_is_a_test_poll {
    'This is a test poll.'
}
sub file_to_upload_from {
    'File to upload ballots from:'
}
sub Load_ballots {
    'Load ballots'
}
sub poll_supervisor { # name, email
    "Poll supervisor: $_[1] <tt>&lt;$_[2]&gt;</tt>"
}
sub no_authorized_yet { #waiting
    "0 ($_[1] voters will be authorized when the poll is started)"
}
sub total_authorized_voters { # num_auth_string
    "Total authorized voters: $_[1]"
}
sub actual_votes_so_far { # num
    "Actual votes cast thus far: $_[1]"
}
sub poll_ends { # end
    "Announced end of poll: $_[1]"
}
sub email_load {
    my $msg = "Email load: ".sprintf("%4.2f", $_[1]);
    if ($_[1] > @MAX_EMAIL_LOAD@) {
        $msg .= " (Must be less than @MAX_EMAIL_LOAD@ to send email)";
    }
    return $msg;
}
sub Poll_results_available_to_all_voters_when_poll_completes {
    'Poll results available to all voters when poll completes.'
}
sub Voters_can_choose_No_opinion {
    'Voters can choose &ldquo;No opinion&rdquo;.';
}
sub Voting_is_disabled_during_writeins {
    'Voting is disabled during the write-in period.'
}
sub Poll_results_will_be_available_to_the_following_users {
    'Poll results will be available only to the following users:'
}
sub Poll_results_are_now_available_to_the_following_users {
    'Poll results are now available only to the following users,
	    who were earlier sent an email containing a URL for
	     viewing results:'
}
sub results_available_to_the_following_users {
    'The results of this poll have been released only to a limited set of users:';
}

sub Poll_results_are_available { #url
    "<a href=\"$_[1]\">[&nbsp;See poll results&nbsp;]</a>";
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
    "Enter email addresses of voters, one per line. These
    may be new voters or existing voters who have not voted yet.
    In a private poll, giving the email address of an already 
    existing voter <strong>will not</strong> let that voter vote twice.
    It will only resend the voter an invitation to vote.
    In a public poll, only a token attempt is made to prevent
    multiple voting.";
}
sub Upload_file {
    'Upload file: '
}
sub Load_ballot_data {
    'Load ballot data'
}
sub File_to_upload_ballots_from {
    'File to upload ballots from:'
}
sub Upload_instructions {
    'Upload a text file formatted with one ballot per line. Each
      line contains the ranks of the N choices, which are numbers from 1
      to N, or a dash (<kbd>-</kbd>) to represent no opinion. Ranks should be
      separated by whitespace or a comma. Lines may be terminated
      with LF or CR/LF. Whitespace is ignored; lines whose first
      non-whitespace character is # are also ignored. A line may begin
      with <i>m</i><kbd>X</kbd> where <i>m</i> is a number, which
      signifies <i>m</i> identical ballots described by the rest of
      the line.'
}
sub Examples_of_ballots {
    'Examples of ballots:'
}
sub Ballot_examples {
    '1,4,3,2,5        <i>A simple ballot ranking five choices.</i>
    5 - 2 - 3        <i>Another ranking of five choices. Dashes indicate unranked choices.</i>
    8X1 4 3 2 5      <i>Eight ballots like the first example ballot.</i>'
}
sub Or_paste_this_code {
    'Or paste this HTML code into your own web page:'
}
sub This_is_a_public_poll_plus_link {
    my ($self, $url, $pub) = @_;
    if ($pub) {
	return "This is a public poll. Share the following link
	    with voters to allow them to vote:</p><p>
	    &nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>. This
	    poll will also be publicized by CIVS.";
    } else {
	return "This is a public poll. Share the following link
	    with voters to allow them to vote:</p><p>
	    &nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>";
    }
}
sub The_poll_has_ended {
    'The poll has ended.';
}

# add voters

sub CIVS_Adding_Voters {
    'CIVS: Adding Voters'
}
sub Adding_voters {
    'Adding voters'
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
    'Sorry, voters can only be added to an poll in progress.'
}
sub Too_many_voters_added {
    'Sorry, you can only add @MAX_VOTER_ADD@ voters at a time.'
}
sub Too_much_email {
    'Sorry, CIVS places limits on how much email is generated. Please add more voters later.'
}

sub Total_of_x_voters_authorized { # x
    if ($_[1] == 0) {
	'No voters authorized to vote yet.';
    } elsif ($_[1] == 1) {
	'Only 1 voter authorized to vote so far.';
    } else {
	"A total of $_[1] voters are authorized to vote.";
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
    'CIVS Vote: '.$_[1]
}

sub ballot_reporting_is_enabled {
    'Ballot reporting is enabled for this poll.
     Your ballot (the rankings you assign to choices)
     will be visible in the poll results when the poll ends.'
}
sub instructions1 { # num_winners, end, name, email
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt="single favorite choice";
    } else {
	$wintxt="$_[1] favorite choices";
    }
    "Only the $wintxt will win the poll.<br />
	    The poll ends <b>$_[2]</b>.
	    The poll supervisor is $_[3] (<tt>$_[4]</tt>).
	    Contact the poll supervisor if you need help.";
}
sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
    my ($self, $no_opinion, $prop, $combined, $civs_url) = @_;
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
	if ($prop) {
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

sub Identifier_request {
    "<p>Please give your email address or other recognizable identifier:  \r\n".
    '<input type="text" name="email_address" size="50"></p>'.
    "\r\n"
}

sub Rank { 'Rank' }
sub Choice { 'Choice' }
sub Weight { 'Weight' }

# overridden in english.pm
sub ordinal_of {
    "$_[1]"
}

sub address_will_be_visible {
    '<strong>Your email address will be visible</strong> along with your ballot.';
}

sub however_results_restricted {
    my @users = @{$_[1]};
    my $r = ' However, results will be made available only to a limited set of users: ';
    my $first=1;
    foreach my $u (@users) {
	if (!$first) { $r .= ', '; $first=0; }
	$r .= "<tt>$u</tt>";
    }
    $r .= '.';
    return $r;
}

sub ballot_will_be_anonymous {
    ' However, your ballot will still be anonymous:
      no personally identifying information will appear.'
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
sub try_some_public_polls {
    "Feel like voting on something else? Try one of these public polls:"
}
sub name_of_writein_is_empty {
    "Name of write-in choice is empty";
}
sub writein_too_similar {
    "Sorry, the name of the write-in is too similar to an existing choice";
}

# election

sub No_poll_ID {
    "No poll ID was provided. Perhaps a copy-paste error?"
}
sub Ill_formed_poll_ID {
    "An ill-formed poll identifier was provided. Perhaps a copy-paste error? (" . $_[1] . ")"
}
sub vote_has_already_been_cast {
    "A vote has already been cast using your voter key.";
}
#deprecated, use future_result_link
sub following_URL_will_report_results {
    'The following URL will report poll results once the poll ends:';
}
sub future_result_link {
    (my $self, my $url) = @_;
    "The following URL will report poll results once the poll ends: <tt>$url</tt>"
}
#deprecated
sub following_URL_reports_results {
    'The following URL reports the current poll results:'
}
sub current_result_link {
    (my $self, my $url) = @_;
    "<a href=\"$url\" class=result_link>Go to current poll results</a>"
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

# deprecated
sub The_results_of_this_completed_poll_are_here {
    'The results of this completed poll are here:';
}
sub completed_results_link {
    (my $self, my $url) = @_;
    "<a href=\"$url\" class=result_link>Go to completed poll results</a>"
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
sub Address_opted_out { # addr
    "This address has opted out from CIVS email: $_[1]"
}
sub Sending_mail_to_voter_v {
    "Sending mail to voter \"$_[1]\"...";
}
sub CIVS_poll_supervisor { # name
    "\"$_[1] (CIVS poll supervisor)\""
}
sub voter_mail_intro { #title, name, email_addr
"A Condorcet Internet Voting Service poll named <b>$_[1]</b> has been created.
You have been designated as a voter by the poll supervisor,
$_[2] (<a href=\"mailto:$_[3] ($_[2])\">$_[3]</a>).</p>";
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
    "The poll has been announced to end $_[1]."
}

sub To_view_the_results_at_the_end {
    "To view the results of the poll once it has ended, visit:</p> $_[1]"
}

sub for_more_information_about_CIVS { # url
  "For more information about the Condorcet Internet Voting Service, see $_[1]"
}

sub For_more_information { # url, mail mgmt url
  ($self, $home, $mail_mgmt) = @_;
  "For more information about the Condorcet Internet Voting Service, see
   $home. To control future email sent from CIVS, see $mail_mgmt"
}

sub poll_email_subject { # title
    "Poll: $_[1]"
}

# close

sub CIVS_Ending_Poll {
    'CIVS: Ending Poll'
}

sub Ending_poll {
    'Ending a poll'
}
sub View_poll_results {
    'View poll results'
}
sub Poll_ended { #title
    "Poll ended: $_[1]"
}

sub The_poll_has_been_ended { #election_end
    "The poll has been ended. It was announced to end $_[1]."
}

sub poll_results_available_to_authorized_users {
    'The poll results are now available to authorized users.'
}

sub was_not_able_stop_the_poll {
    'Was not able to stop the poll'
}


# results

sub CIVS_poll_result {
    "CIVS poll result"
}
sub Poll_results { # title
    "Poll Results: $_[1]"
}

sub Writeins_currently_allowed {
    'Write-in choices are currently allowed.'
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
sub Supervisor { #name, email
    "Supervisor: $_[1] <tt>&lt;$_[2]&gt;</tt>";
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
    'Ballot reporting was not enabled for this poll.'
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
    'Choices shown in red have tied for being selected.
	You may wish to select among them randomly.'
}
sub Condorcet_winner {
    "Condorcet winner"
}
sub Choices_in_individual_pref_order {
    'Choices (in individual preference order)'
}

sub What_is_this { # url
    '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>'. '(What is this?)</small></a>';
}

# rp

sub All_prefs_were_affirmed {
    'All preferences were affirmed.'
}

sub Presence_of_a_green_entry_etc {
    'The presence of a green entry below
	the diagonal (and a corresponding red one above)
	means that a preference was ignored because
	it conflicted with other, stronger preferences.'
}
sub Random_tie_breaking_used {
'Random tie breaking was used to
arrive at this ordering, as per the MAM
algorithm. This may have affected the ordering
of the choices.'
}
sub No_random_tie_breaking_used {
    'No random tie breaking was needed to arrive at this ordering.'
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

sub mail_management_instructions {
    p("CIVS does not store email addresses of voters and it only sends mail when
       a poll supervisor who already knows your address requests that mail be sent.
       You can prevent CIVS from sending you mail, by entering your email address below.").
    p("Click the button on the right to request a deactivation code by email. This authentication
       step is necessary to prevent people from blocking other users' email.").
    p(b("Warning:"), "If you block mail from CIVS, it will be difficult to re-enable it, because CIVS
      does user authentication using email addresses. You will not be able to vote in any CIVS polls
      and you will not be able to create CIVS polls.")
}

sub mail_address {
    'Email address: '
}
sub deactivation_code {
    'Deactivation code: '
}
sub filter_question {
    'Filter pattern <small>(can be left blank; hover for help)</small>'
}
sub filter_explanation {
    'You can enter one or more patterns here to specify which poll supervisors to prevent email from. The pattern can be the email address of a supervisor or a pattern describing email addresses.  The pattern may use * to represent any sequence of characters. For example, the pattern *@inmano.com would prevent supervisors with an @inmano.com address from sending you poll invitations. If you leave this field blank, deactivation/reactivation will apply to all email addresses.'
}
sub send_deactivation_code {
    'Send deactivation code by email'
}
sub cant_send_email {
    'You cannot send email to this user using CIVS. Email to this user must first be reactivated using a previously sent deactivation code.'
}
sub submit_deact_react {
    'Submit deactivation/reactivation'
}
sub codes_dont_match {
    "Sorry, the provided code and email address do not match. You can request another code if you have not previously blocked email from CIVS."
}
sub deactivation_successful {
    my ($self, $pattern) = @_;
    "CIVS will not send any more mail to this address if its sender
     matches this pattern: \"$pattern\". You can reactivate mail from CIVS
     only by using this web page with the same code you just used."
}
sub reactivation_successful {
    'You have successfully reactivated mail to this address.'
}
sub someone_has_requested {
"Someone has requested a code for preventing CIVS from sending email
to you. If it was you, you will know what to do with it. The code is:

    $_[1]

Keep this email because you will need this code if you want to use the
service in the future."
}
sub deactivation_code_subject {
    'Deactivation code for CIVS mail'
}
sub mail_mgmt_title {
    'Mail Management'
}

## User activation

sub user_activation {
    'Activate user'
}
sub activation_code_subject {
    'Activation code for using CIVS'
}
sub user_activation_instructions {
    my ($self, $mail_mgmt_url) = @_;
    p('To vote in private CIVS polls, you must opt in to email
	communication from the service. CIVS does not store your email
        address, and there are no automated mailings.
	You only receive email from the service at the explicit request
	of poll supervisors, containing credentials needed to vote in private
	polls or to see the results of polls.').
    p("To opt in, please enter your email address and click the button below. You should then
        receive an email containing an activation code.
        Note that if you have previously opted out from email, you must use
        the <a href=\"$mail_mgmt_url\">mail management page</a> to reactivate email.
        If you use a mail blocking service, you may need to whitelist the
        CIVS email address as an authorized sender (".'@SUPERVISOR@'.").
        ")
}
sub opt_in_label {
    'Request activation code'
}
sub activation_code {
    'Activation code: '
}
sub someone_has_requested_activation {
    my ($self, $address, $code, $mail_mgmt_url) = @_;
"Someone has requested that the CIVS voting system activate the email address <$address>
for voting in polls. To activate this address, you will need the following activation code:

    $code

If you did not initiate this request, you can ignore this email.

If you want to control further email from CIVS, use this link: $mail_mgmt_url.
"
}
sub already_activated {
    'This email address is already activated.'
}
sub activation_successful
{
    'Email address successfully activated.'
}
sub pending_invites {
    (my $self, my $pats, my $invites) = @_;
    my @invites = @{$invites};
    if ($#invites >= 0) {
        my @rows = ();
        foreach $invite (@invites) {
            (my $url, my $title) = @{$invite};
            push @rows, a({-href => $url}, $title);
        }
        return div(p('Pending poll invitation(s):'),
                   ul(\@rows));
    } else {
        return "";
    }
}
sub submit_activation_code {
    'Complete activation'
}
sub user_not_activated {
    my ($self, $address) = @_;
    "Sorry, no user has activated address &lt;$address&gt; to receive email.";
}
sub mail_failure_reason {
    my ($self, $reason) = @_;
    if ($reason eq 'not activated') {
        'This email address has not been activated by the recipient.'
    } elsif ($reason eq 'opted out') {
        'This user has opted out from CIVS email.'
    } else {
        'Unknown reason'
    }
}
sub see_the_failure_table {
    my ($self, $activate_url, $mail_mgmt_url) = @_;
    "<p>It was not possible to send mail to some voters, for reasons listed in the
    table below. Voters will not be able to vote until they receive their personal key,
    so you should contact them directly. Voters are likely to find the following
    links useful:</p>
    <ul>
    <li>Activate an email address with CIVS: <a href='$activate_url'>$activate_url</a></li>
    <li>Deactivate/reactivate an email address: <a href='$mail_mgmt_url'>$mail_mgmt_url</a></li>
    </ul>
    <p>
    Note that when voters activate their email addresses, they are notified about any
    pending invitations to vote in polls.
    </p>
    "
}
sub download_failures {
    'Download table as CSV'
}

1; # package succeeded!
