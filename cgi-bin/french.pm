package french;

sub lang { 'fr-FR'; }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub Condorcet_Internet_Voting_Service {
    'Service de Vote Internet Condorcet (CIVS)';
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited 
    'Service de Vote Internet Condorcet (CIVS)';
}
sub about_civs {
    'Au sujet de CIVS';
}
sub create_new_poll {
    'Créer une nouvelle consultation';
}
sub about_security_and_privacy {
    'Au sujet de la sécurité et de la confidentialité';
}
sub FAQ {
    'FAQ';
}
sub CIVS_suggestion_box {
    'CIVS suggestion box';
}
sub unable_to_process {
    'CIVS ne peut traiter votre requette en raison d\'une erreur interne.';
}
sub CIVS_Error {
    'Erreur CIVS';
}
sub CIVS_server_busy {
    'Serveur CIVS occupé';
}
sub Sorry_the_server_is_busy {
    'Désolé, mais le serveur web CIVS est actuellement surchargé et il ne peut plus
     accepter de requettes. Merci de bien vouloir essayer de nouveau ultérieurement.';
}

# civs_create

sub mail_has_been_sent {
    "Un courrier électronique a été envoyé à l'adresse que vous nous avez communiqué (<tt>$_[1]</tt>).";
}

sub click_on_the_URL_to_start {
    "Cliquer sur le lien internet contenu dans ce courrier électronique pour commencer la consultation : <strong>$_[1]</strong>.";
}

sub here_is_the_control_URL {
    "Voici le lien internet permettant de gérer la nouvelle consultation. Dans le cas d\'une gestion ordinaire ce lien aurait été
     envoyé au responsable de la consultation par courrier électronique.";
}
sub the_poll_is_in_progress {
    'La consultation est en cours. Cliquer sur ce bouton pour la terminer : ';
}

sub CIVS_Poll_Creation {
    "CIVS Création de la consultation";
}
sub Poll_created {
    "Consultation créée: $_[1]"
}

sub Address_unacceptable { #addr
    "The address \"$_[1]\" is not acceptable";
}
sub Poll_must_have_two_choices {
    'Une consultation doit proposer un minimum de deux choix.';
}
sub Poll_directory_not_writeable {
    "The poll directory is not writeable";
}
sub CIVS_poll_created {
 "CIVS consultation créée : $_[1]";
}
sub creation_email_info1 { # title, url
"Ce courrier électronique confirme la création d'une nouvelle consultation,
$_[1]. Vous avez été désigné comme le responsable de cette consultation. Le lien Internet
 suivant vous permet de démarrer ou d'arrêter le déroulement de la consultation :

  $_[2]

";
}
sub creation_email_public_link { # url
"Cette consultation étant publique, vous pouvez communiquer aux votants le lien Internet suivant :

  $_[1]

";
}
sub for_more_information_about_CIVS { # url
"Le lien Internet suivant vous permet d'accéder à plus d\'informations concernant le Service de Vote Internet Condorcet (CIVS) :
  $_[1]";
}

sub Sending_result_key { # addr
    "Sending result key to '$_[1]'";
}
sub Results_of_CIVS_poll { # title
    "Résultats de la consultation CIVS: $_[1]";
}
sub Results_key_email_body { # title, url, civs_home
"Une nouvelle consultation CIVS a été créée, son nom est \"$_[1]\".
Le responsable de la consultation vous a autorisé en connaître le résultat.

Concervez ce courrier électronique. Si vous ne le conservez pas, il ne vous sera pas possible d'accéder aux résultats.
 Après la clôture de la consultation, les résultats seront accessible avec le lien Internet suivant:

  $_[2]

Ce lien est destiné à votre seul usage. Permettre à un tiers d'utiliser ce lien lui donnera accès
aux résultat de la consultation.
Le lien Internet suivant vous permet d'accéder à plus d'informations concernant le Service de Vote Internet Condorcet (CIVS) :
  $_[3]

";
}
  
# start

sub poll_started {
    'La consultation <strong>'.$_[1].'</strong> est commencée.';
}

# control

sub CIVS_Poll_Control {
    "CIVS Poll Control";
}
sub Poll_control {
    "Poll Control";
}
sub poll_has_not_yet_started {
    'La consultation n\'est pas encore commencée. Cliquer sur le bouton pour la commencer ';
}
sub Start_poll {
    'Start poll';
}
sub End_poll {
    'End poll';
}
sub ending_poll_cannot_be_undone {
    'La cloture d\'une consultation est une action définitive. Voulez-vous quand même continuer ? ';
}
sub writeins_have_been_disabled {
    'Le panachage à été dévalidé';
}
sub disallow_further_writeins {
    'Le panachage à été dévalidé';
}
sub voting_disabled_during_writeins {
    'Le vote est actuellement suspendu pendant la phase de panachage.';
}
sub allow_voting_during_writeins {
    "Permetre le vote durant la phase de panachage";
}
sub this_is_a_test_poll {
    'Ceci est une consultation de test.';
}

sub poll_supervisor { # name, email
    "Responsable de la consultation : $_[1] (<tt>$_[2]</tt>)";
}
sub no_authorized_yet { #waiting
    "0 ($_[1] votants seront autorisés en début de consultation)";
}
sub total_authorized_voters { # num_auth_string
    "Nombre total de votants autorisés: $_[1]";
}
sub actual_votes_so_far { # num
    "Nombre de votes actuellement exprimés: $_[1]";
}
sub poll_ends { # end
    "Poll ends $_[1].";
}
sub Poll_results_available_to_all_voters_when_poll_completes {
    'Le résultat de cette consultation sera à la disposition de tous les votants après la cloture de la consultation.';
}
sub Voters_can_choose_No_opinion {
    'Les votants peuvent choisir l\' &ldquo;abstention&rdquo;';
}
sub Voting_is_disabled_during_writeins {
    'Le vote est actuellement suspendu pendant la phase de panachage.';
}
sub Poll_results_will_be_available_to_the_following_users {
    'Les résultats de la consultation ne seront disponibles que pour les utilisateurs suivants :';
}
sub Poll_results_are_now_available_to_the_following_users {
    'Les résultats de la consultation sont maintenant disponibles pour les utilisateurs figurants dans la liste suivante.
	    Ces utilisateurs ont reçu un courrier électronique qui contenait un lient Internet leur permettant
	     de consulter ces résultats :';
}
sub results_available_to_the_following_users {
    'Les résultats de cette consultation n\'ont été communiqué qu\'a un nombre restreint d\'utilisateurs :';
}

sub Poll_results_are_available { #url
    "<a href=\"$_[1]\">See poll results</a>";
}
sub Poll_results_will_be_available { #url
    "<a href=\"$_[1]\">See poll results</a>";
}
sub Description {
    'Description :';
}
sub Candidates {
    'Candidats :';
}
sub Add_voters {
    'Ajouter des votants';
}

sub the_top_n_will_win { # num_winners
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt = "candidat";
    } else {
	$wintxt = "$_[1] candidats";
    }
    return "The top $wintxt will win.";
}

sub add_voter_instructions {
    "Saisir l'adresse du courrier électronique des votants, une adresse par ligne.
    Ces votants peuvent être de nouveaux votants ou des votants déjà enregistrés
    qui n'ont pas encore voté. Dans le cas d'une élection à bulletin secret, la 
    saisie d'un votant déjà enregistré <strong>ne permettra pas</strong> à ce votant
    de pouvoir voter une deuxième fois. Cette saisie ne provoquera que l'envoi d'un
    courrier électronique d'invitation au vote.
    Dans le cas d'une élection à main levée, In a public poll, only a token attempt is made to prevent
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
    "Ceci est une élection à main levée. Partagez le lien Internet ci-dessous avec les votants
        pour leur permettre d'exprimer leur suffrage :</p><p>
	&nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>";
}
sub The_poll_has_ended {
    'La consultation est terminée.';
}

# add voters

sub CIVS_Adding_Voters {
    'CIVS: Adding Voters';
}
sub Adding_voters {
    'Adding voters';
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
    'Désolé, des votants ne peuvent être ajoutés que si la consultation est en cours.';
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
sub Done {
    'Done.';
}

# vote

sub page_header_CIVS_Vote { # election_title
    'CIVS Vote: '.$_[1];
}

sub ballot_reporting_is_enabled {
    'Ballot reporting is enabled for this poll.
     Your ballot (the rankings you assign to candidates)
     will be made public when the poll ends.';
}
sub instructions1 { # num_winners, end, name, email
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt="single favorite choice";
    } else {
	$wintxt="$_[1] favorite choices";
    }
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
    '<strong>L\'adresse de votre courrier électronique sera inscrit sur votre bulletin de vote</strong>.';
}

sub ballot_will_be_anonymous {
    ' Néanmoins, votre vote reste anonyme, il ne contiendra aucune information
      permettant de vous identifier.';
}

sub submit_ranking {
    'Submit ranking';
}

sub only_writeins_are_permitted {
    'Le vote n\'est pas encore possible pour cette consultation. Néanmoins
             il vous est possible de consulter la liste des propositions offertes et
             de rajouter de nouvelles propositions. Utlisez le champs ci-dessous pour
             écrire vos nouvelles propositions.';
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
    'Ces boutons ont été désactivés car
	votre navigateur ne supporte pas Javascript.';
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
    "Si vous avez déjà voté, vous pouvez consulter 
	<a href=\"$_[1]\">les résultats de la consultation en cours</a>.";
}
sub thank_you_for_voting { #title, receipt
    "Merci. Votre vote pour la consultation <strong>$_[1]</strong> a été
	enregistré. Votre certificat de vote est <code>$_[2]</code>.";
}
sub name_of_writein_is_empty {
    "Name of write-in choice is empty";
}
sub writein_too_similar {
    "Désolé, votre proposition est trop proche d\'une proposition déjà existante";
}

# election

sub vote_has_already_been_cast {
    "Un vote a déjà été enregistré avec votre identifiant de votant.";
}
sub following_URL_will_report_results {
    'Les résultats de cette consultation seront disponibles après la fin de la consultation en utilisant le lien Internet suivant : ';
}
sub following_URL_reports_results {
    'Les résultats de cette consultation sont disponibles en utilisant le lien Internet suivant : ';
}
sub Already_voted {
    'A déjà voté';
}
sub Error {
    'Erreur';
}
sub Invalid_key {
    'Identifiant invalide. Vous devriez avoir reçu un courrier électronique avec un lien Internet 
        vous permettant de participer à la consultation. Cette incident a été enregistrée.';
}
sub Authorization_failure {
    'Authorization failure';
}

sub already_ended { # title 
    "Cette consulation (<strong>$_[1]</strong>) est déjà terminée.";
}
sub Poll_not_yet_ended {
    "Consultation non encore terminée";
}
sub The_poll_has_not_yet_been_ended { #title, name, email
    "Cette consultation ($_[1]) n'a pas encore été cloturée par son responsable,
    $_[2] ($_[3]),";
}
sub The_results_of_this_completed_poll_are_here {
    'The results of this completed poll are here:';
}

sub No_write_access_to_lock_poll {
    "Did not have the write access needed to lock the poll.";
}
sub This_poll_has_already_been_started { # title
    "Cette consultation ($_[1]) a déjà été commencée.";
}
sub No_write_access_to_start_poll {
    'Did not have write access to start a poll.';
}
sub Poll_does_not_exist_or_not_started {
    'Cette consultation n\'existe pas ou n\'a pas encore été commencée.';
}
sub Your_voter_key_is_invalid__check_mail { # voter
   my $voter = $_[1];
   if ($voter ne '') {
    "Votre identifiant de votant est invalide, $voter.
     Vous devriez avoir reçu un courrier électronique avec un lien Internet correcte.";
   } else {
    "Votre identifiant de votant est invalide. Vous devriez avoir reçu un courrier électronique avec un lien Internet correcte.";
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
    "Adresse de courrier électronique non valide";
}
sub Invalid_email_address { # addr
    "Adresse de courrier électronique non valide : $_[1]";
}
sub Sending_mail_to_voter_v {
    "Courrier électronique envoyé au votant \"$_[1]\"...";
}
sub CIVS_poll_supervisor {
    'Responsable de consultation CIVS';
}
sub voter_mail_intro { #title, name, email_addr
"La consultation <b>$_[1]</b> a été mise en place à l'aide du Service de Vote Internet Condorcet (CIVS).
Le responsable de cette consultation vous a désigné comme participant à cette consultation,
$_[2] (<a href=\"mailto:$_[3] ($_[2])\">$_[3]</a>).</p>";
}
sub Description_of_poll {
    'Description de la consultation : ';
}
sub if_you_would_like_to_vote_please_visit {
    'Si vous désirer voter, merci de cliquer sur l\'adresse Internet suivante : ';
}
sub This_is_your_private_URL {
'Cette adresse Internet n\'est destinée qu\'a vous. Ne la communiquez à personne, car elle pourrait être utilisée
pour voter à votre place.';
}
sub Your_privacy_will_not_be_violated {
'La confidentialité de votre vie privé ne sera pas menacée par votre vote. Ce service de consultation a déja
 supprimé l\'enregistrement qui contenait votre adresse electronique et ne communiquera aucune
information relative à votre choix de vote ou aux consultations auquelles vous avez participé.';
}
sub This_is_a_nonanonymous_poll {
'Le responsable de cette consultation a décidé que le vote se ferait <strong>à main levée</strong>.
 Si vous particpez à cette consultation, votre choix de vote sera rendu publique et votre adresse de
 courrier internet seront communiqués aux autres participants de cette consultation. Si vous ne participez
 pas à la consultation le responsable de la consultation en sera informé.';
}

sub poll_has_been_announced_to_end { #election_end
    "The poll has been announced to end $_[1].";
}

sub To_view_the_results_at_the_end {
    'Pour consulter les résultats de la consultations après sa clotûre, consultez : </p>';
}

sub For_more_information {
'Pour plus d\'informations concernant le Service de Vote Internet Condorcet (CIVS), consultez : ';
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
    'Les résultats de la consultation sont disponibles pour les utilisateurs autorisés.';
}

sub was_not_able_stop_the_poll {
    'N\'a pas pu clore la consultation';
}


# results

sub CIVS_poll_result {
    "Resultats de consultation CIVS";
}
sub Poll_results { # title
    "Resultats de la consultation : $_[1]";
}

sub Writeins_currently_allowed {
    'Write-in choices are currently allowed.';
}

sub Writeins_allowed {
    'Les candidats panachés sont permis.';
}
sub Writeins_not_allowed {
    'Les candidats panachés ne sont pas permis.';
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
    'L\'identité des votants (courrier électronique) sera publiquement associés à leur vote.';
}
sub Condorcet_completion_rule {
    'Condorcet completion rule:';
}
sub undefined_algorithm {
    'Erreur : Algorithm non défini.';
}
sub computing_results {
    'Dépouillement des résult...';
}
sub Supervisor { #name, email
    "Responsable : $_[1] ($_[2])";
}
sub Announced_end_of_poll {
    "Announced end of poll: $_[1]";
}
sub Actual_time_poll_closed { # close time
    "Actual time poll closed: $_[1]";
}
sub Poll_not_ended {
    'La consultation n\'est pas encore terminée.';
}
sub This_is_a_test_poll {
    'Ceci est une consultation de test.';
}
sub This_is_a_private_poll { #num_auth
    "Vote à bulletin secret ($_[1] participants autorisés)";
}
sub This_is_a_public_poll {
    'Ceci est une consultation à main levée.';
}

sub Actual_votes_cast { #num_votes
    "Actual votes cast: $_[1]";
}
sub Number_of_winning_candidates {
    'Nombre de candidast élus : ';
}
sub Poll_actually_has { #winmsg
    my $winmsg = '1 élu';
    if ($_[1] != 1) {
	$winmsg = $real_nwin.' élus';
    }
    "&nbsp;(Poll actually has $winmsg)";
}
sub poll_description_hdr {
    'Description de la consultation';
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
    'Montrer les détails';
}
sub Hide_details {
    'Cacher les détails';
}
sub Result_details {
    'Result details';
}
sub Ballot_report {
    'Ballot report'
}
sub Ballots_are_shown_in_random_order {
    "Les bulletin de vote sont affichés dans un ordre aléatoire.";
}
sub Download_ballots_as_a_CSV { # url
    "<a href=\"$_[1]\">Download ballots</a> as a CSV";
}
sub No_ballots_were_cast {
    "Aucun vote n'\a été exprimé lors de cette consultation.";
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
1; # package succeeded!
