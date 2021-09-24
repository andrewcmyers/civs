package french;

use lib '@CGIBINDIR@';
use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

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
    'Comment améliorer CIVS';
}
sub unable_to_process {
    'CIVS ne peut traiter votre requête en raison d\'une erreur interne.';
}
sub CIVS_Error {
    'Erreur CIVS';
}
sub CIVS_server_busy {
    'Serveur CIVS occupé';
}
sub Sorry_the_server_is_busy {
    'Désolé, mais le serveur CIVS est actuellement surchargé et
     il ne peut plus accepter de requêtes. Merci de bien vouloir
     essayer de nouveau ultérieurement.';
}

# civs_create

sub mail_has_been_sent {
    "Un courrier électronique a été envoyé à l'adresse que vous nous avez communiqué (<tt>$_[1]</tt>).";
}

sub click_on_the_URL_to_start {
    "Cliquer sur le lien internet contenu dans ce courrier électronique pour commencer la consultation :<strong> $_[1]</strong>.";
}

sub here_is_the_control_URL {
    "Voici le lien internet permettant de gérer la nouvelle consultation.
     Dans le cas d\'une gestion ordinaire ce lien aurait été
     envoyé au responsable de la consultation par courrier électronique.";
}
sub the_poll_is_in_progress {
    'La consultation est en cours. Cliquer sur le bouton "Clôturer la consultation" pour la clôturer : ';
}

sub CIVS_Poll_Creation {
    "CIVS Création de la consultation";
}
sub Poll_created {
    "Consultation créée : $_[1]"
}

sub Address_unacceptable { #addr
    "Cette adresse \"$_[1]\" ne peut être acceptée";
}
sub Poll_must_have_two_choices {
    'Une consultation doit proposer un minimum de deux choix.';
}
sub Poll_directory_not_writeable {
    "Le répertoire de la consultation ne peut être écrit";
}
sub CIVS_poll_created {
 "CIVS consultation créée : $_[1]";
}
sub creation_email_info1 { # title, url
"Ce courrier électronique confirme la création d'une nouvelle consultation,
$_[1]. Vous avez été désigné comme le responsable de cette consultation.

Le lien Internet suivant vous permet de démarrer ou d'arrêter le déroulement de la consultation :

  $_[2]

";
}
sub creation_email_public_link { # url
"Cette consultation étant public, vous pouvez communiquer aux participants le lien Internet suivant :

  $_[1]

";
}
sub for_more_information_about_CIVS { # url
"Le lien Internet suivant vous permet d'accéder à plus d\'informations concernant le Service de Vote Internet Condorcet (CIVS) :

  $_[1]

";
}

sub Sending_result_key { # addr
    "Envoi de la clef de consultation des résultats à '$_[1]'";
}
sub Results_of_CIVS_poll { # title
    "Résultats de la consultation CIVS: $_[1]";
}
sub Results_key_email_body { # title, url, civs_home
"Une nouvelle consultation CIVS a été créée, son nom est \"$_[1]\".
Le responsable de la consultation vous a autorisé à en connaître le résultat.

Conservez ce courrier électronique. Si vous ne le conservez pas, il ne vous
sera pas possible d'accéder aux résultats. Après la clôture de la
consultation, les résultats seront accessible en utilisant le lien Internet
suivant :

  $_[2]

Ce lien est destiné à votre seul usage. Permettre à un tiers d'utiliser
ce lien lui donnera accès aux résultats de la consultation.

";
}
  
# start

sub poll_started {
    'La consultation <strong>'.$_[1].'</strong> est commencée.';
}

# control

sub CIVS_Poll_Control {
    "Gestion de la consultation CIVS";
}
sub Poll_control {
    "Gestion de la consultation";
}
sub poll_has_not_yet_started {
    'La consultation n\'est pas encore commencée. Cliquer sur le bouton "Commencer la consultation" pour la commencer : ';
}
sub Start_poll {
    'Commencer la consultation';
}
sub End_poll {
    'Clôturer la consultation';
}
sub ending_poll_cannot_be_undone {
    'La clôture d\'une consultation est une action définitive. Voulez-vous quand même continuer ? ';
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
    "Permettre le vote durant la phase de panachage";
}
sub this_is_a_test_poll {
    'Ceci est une consultation de test.';
}

sub poll_supervisor { # name, email
    "Responsable de la consultation : $_[1] (<tt>$_[2]</tt>)";
}
sub no_authorized_yet { #waiting
    "0 ($_[1] participants seront autorisés en début de consultation)";
}
sub total_authorized_voters { # num_auth_string
    "Nombre total de participants autorisés : $_[1]";
}
sub actual_votes_so_far { # num
    "Nombre de votes actuellement exprimés : $_[1]";
}
sub poll_ends { # end
    "Clôture de la consultation $_[1].";
}
sub Poll_results_available_to_all_voters_when_poll_completes {
    'Le résultat de cette consultation sera à la disposition de tous
     les participants après la clôture de la consultation.';
}
sub Voters_can_choose_No_opinion {
    'Les participants peuvent choisir l\' &ldquo;abstention&rdquo;';
}
sub Voting_is_disabled_during_writeins {
    'Le vote est actuellement suspendu pendant la phase de panachage.';
}
sub Poll_results_will_be_available_to_the_following_users {
    'Les résultats de la consultation ne seront accessibles qu\'aux utilisateurs suivants : ';
}
sub Poll_results_are_now_available_to_the_following_users {
    'Les résultats de la consultation sont maintenant accessibles aux
     utilisateurs figurants dans la liste suivante.
     Ces utilisateurs ont reçu un courrier électronique qui contient
     un lient Internet leur permettant d\'accéder à ces résultats : ';
}
sub results_available_to_the_following_users {
    'Les résultats de cette consultation n\'ont été communiqués qu\'à un nombre restreint d\'utilisateurs : ';
}

sub Poll_results_are_available { #url
    "<a href=\"$_[1]\">Accéder aux résultats de la consultation</a>";
}
sub Description {
    'Description : ';
}
sub Candidates {
    'Candidats ou Propositions : ';
}
sub Add_voters {
    'Ajouter des participants';
}

sub the_top_n_will_win { # num_winners
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt = "Un seul candidat ou une seule proposition sera gagnant";
    } else {
	$wintxt = "Les $_[1] premiers candidats ou premières propositions seront gagnantes";
    }
    return $wintxt ;
}

sub add_voter_instructions {
    "Saisir l'adresse du courrier électronique des participants, une adresse par
     ligne. Ces participants peuvent être de nouveaux participants ou des participants déjà
     enregistrés qui n'ont pas encore voté. Dans le cas d'une élection à
     bulletin secret, la saisie d'un participant déjà enregistré <strong>ne 
     permettra pas</strong> à ce participant de pouvoir voter une deuxième fois.
     Cette saisie ne provoquera que l'envoi d'un courrier électronique
     d'invitation à la consultation. Dans le cas d'une élection public,
     un système de jeton est utilisé pour éviter les doublons.";
}
sub Upload_file {
    'Télécharger le fichier : ';
}
sub Load_ballot_data {
    'Charger le fichier de la consultation';
}
sub File_to_upload_ballots_from {
    'File to upload ballots from:';
}
sub This_is_a_public_poll_plus_link {
    my $url = $_[1];
    "Ceci est une consultation public. Partagez le lien Internet
     ci-dessous avec les participants pour leur permettre d'exprimer leur
    suffrage :</p><p>&nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>";
}
sub The_poll_has_ended {
    'La consultation est terminée.';
}

# add voters

sub CIVS_Adding_Voters {
    'CIVS: Ajouter des participants';
}
sub Adding_voters {
    'Ajouter des participants';
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
    'Désolé, des participants ne peuvent être ajoutés que si la consultation
     est en cours.';
}

sub Total_of_x_voters_authorized { # x
    if ($_[1] == 0) {
	"Aucun participant n\'est actuellement autorisé à s\'exprimer.";
    } elsif ($_[1] == 1) {
	"Seul un participant est actuellement autorisé à s\'exprimer.";
    } else {
	"$_[1] participants autorisés à s'exprimer.", $cr, '</pre>';
    }
}

sub Go_back_to_poll_control {
    'Retour à la gestion de la consultation';
}
sub Done {
    'Terminé.';
}

# vote

sub page_header_CIVS_Vote { # election_title
    'CIVS Vote: '.$_[1];
}

sub ballot_reporting_is_enabled {
    'Cette consultation est public.
     Votre bulletin de vote sera donc rendu public
     à la fin de la consultation.';
}
sub instructions1 { # num_winners, end, name, email
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt="single favorite choice";
    } else {
	$wintxt="$_[1] favorite choices";
    }
    "Seulement les $_[1] premiers remporteront la consultation.<p>
	    La consultation sera clôturée le <b>$_[2]</b>.
	    Le responsable de la consultation est $_[3] (<tt>$_[4]</tt>).
	    N'hésitez pas à le contacter si vous avez besoin d'aide.";
}
sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
    my ($self, $no_opinion, $prop, $combined, $civs_url) = @_;
    my $ret;   
    if (!$prop || !$combined) {
	$ret = "Merci de bien vouloir classer les candidats ou les propositions
        suivants. Plus un candidat ou une proposition vous convient plus vous
        lui donnerez un rang élevé. Par conséquent votre candidat ou votre
        proposition préféré aura donc le rang 1.
        Si vous n'avez pas de préférence entre plusieurs candidats ou propositions,
        vous pouvez leur donner le même rang. Il vous est
        possible de ne pas utiliser toutes les rangs disponibles.
        Initialement toutes les candidats ou les propositions 
        possèdent le rang les plus faible. ". $cr;
	if ($no_opinion) {
	    $ret .= '<b>Note : </b> &ldquo;S\'abstenir&rdquo;
		    <i>n\'est pas</i> équivalent à attribuer le rang le 
                    plus faible à une proposition ou à un candidat.
                    S\'abstenir signifie que vous ne désirez pas classer
                    une proposition ou un candidat par rapport aux autres
                    propositions ou candidats.</p>';
	}
	if ($prop) {
	    $ret .= '<p>Cette consultation utilise une méthode expérimentale
            basée sur le vote Condorcet pour fournir une représentation
            proportionnelle. L\'algorithme utilisé suppose que vous désirez  It is assumed
	    by the voting algorithm that you want the ranking of your most
	    preferred <i>winning</i> choice to be as high as possible, and if two
	    sets of winning choices agree on the choice you prefer most, then you
	    would decide between them using the second most preferred choice, and
	    so on. ';
	}
    } else {
	$ret = '<p>Cette consultation utilise une méthode expérimentale
        basée sur le vote Condorcet pour fournir une représentation
        proportionnelle.
        Merci de donner aux candidats ou aux propositions suivants une
        <b>pondération</b> qui exprime votre intérêt pour
        que ces candidats ou ces propositions soient inclus dans le groupe
        des candidats ou des propositions retenus pour la suite de la
        consultation.
        L\'algorithme utilisé suppose que désirez que la somme des 
        pondérations des propositions ou des candidats retenus doit être
        la plus élevée possible.
        Touts les candidats ou les propositions possèdent une pondération
        initiale de 0, ce qui signifie que vous n\'avez aucun intérêt pour
        ces propositions.
        Une pondération ne peut être ni négative ni avoir une valeur
        supérieure à 999.
        Le fait d\'utiliser des valeurs de pondération plus importantes
        que celles des autres participants ne change en rien le résultat de
        la consultation. '.
	"<a href=\"$civs_url/proportional.html\">[Pour en savoir plus]</a>.</p>";
    }
    return $ret;
}
sub Rank {
    'Rang';
}
sub Choice {
    'Candidats ou Propositions';
}
sub Weight {
    'Pondération';
}

sub address_will_be_visible {
    '<strong>L\'adresse de votre courrier électronique sera inscrite sur votre bulletin de vote</strong>.';
}

sub ballot_will_be_anonymous {
    ' Néanmoins, votre vote reste anonyme, il ne contiendra aucune information
      permettant de vous identifier.';
}

sub submit_ranking {
    'Voter';
}

sub only_writeins_are_permitted {
    'Le vote n\'est pas encore possible pour cette consultation. Néanmoins
             il vous est possible de consulter la liste des propositions
             ou des candidats proposés et de rajouter de nouvelles
             propositions ou de nouveaux candidats. Utilisez le champs
             ci-dessous pour saisir vos propositions ou vos candidats.';
}

sub to_top {
    'Mettre en tête de liste';
}
sub to_bottom {
    'Mettre en queue de liste';
}
sub move_up {
    'Avancer vers la tête de liste d\'un rang';
}
sub move_down {
    'Reculer vers la queue de liste d\'un rang';
}
sub make_tie {
    'Rendre ex-æquo';
}
sub buttons_are_deactivated {
    'Ces boutons ont été désactivés car
	votre navigateur ne supporte pas Javascript.';
}
sub ranking_instructions {
       'Classer les propositions selon trois méthodes possibles :
	<ol>
	    <li>Déplacer les lignes en cliquant dessus,
	    <li>Cliquer dans les listes déroulantes de la colonne "Rang";
	    <li>Sélectionner une ou plusieurs lignes et utiliser les boutons ci-dessus.
	</ol>';
}

sub write_in_a_choice {
    'Saisissez une nouvelle proposition ou un nouveau candidat : ';
}
sub if_you_have_already_voted { #url
    "Si vous avez déjà voté, vous pouvez consulter 
	<a href=\"$_[1]\">les résultats de la consultation en cours</a>.";
}
sub thank_you_for_voting { #title, receipt
    "Merci. Votre vote pour la consultation <strong>$_[1]</strong> a été
	enregistré. Votre certificat de vote est   <code>$_[2]</code>.";
}
sub name_of_writein_is_empty {
    "Vous n\'avez pas saisi de nouveau candidat ou de nouvelle proposition";
}
sub writein_too_similar {
    "Désolé, votre proposition ou votre candidat est trop proche d\'une proposition ou d\'un candidat déjà existant";
}

# election

sub vote_has_already_been_cast {
    "Un vote a déjà été enregistré avec votre identifiant de participant.";
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
    'Identifiant de participation invalide. Vous devriez avoir reçu un courrier électronique
     contenant un lien Internet vous permettant de participer à la consultation.
     Cet incident a été enregistré.';
}
sub Authorization_failure {
    'Échec lors de l\'autorisation';
}

sub already_ended { # title 
    "Cette consultation (<strong>$_[1]</strong>) est déjà terminée.";
}
sub Poll_not_yet_ended {
    "Consultation non encore terminée";
}
sub The_poll_has_not_yet_been_ended { #title, name, email
    "Cette consultation ($_[1]) n'a pas encore été clôturée par son responsable,
    $_[2] ($_[3]),";
}
sub The_results_of_this_completed_poll_are_here {
    'Les résultats de cette consultation sont disponibles en cliquant sur le lien Internet suivant : ';
}

sub No_write_access_to_lock_poll {
    "Ne possède pas les droits d\'écriture nécessaires pour verrouiller la consultation.";
}
sub This_poll_has_already_been_started { # title
    "Cette consultation ($_[1]) a déjà été commencée.";
}
sub No_write_access_to_start_poll {
    'Ne possède pas les droits d\'écriture nécessaires pour commencer une consultation.';
}
sub Poll_does_not_exist_or_not_started {
    'Cette consultation n\'existe pas ou n\'a pas encore été commencée.';
}
sub Your_voter_key_is_invalid__check_mail { # voter
   my $voter = $_[1];
   if ($voter ne '') {
    "Identifiant de participation invalide, $voter.
     Vous devriez avoir reçu un courrier électronique contenant un lien
     Internet vous permettant de particper à la consultation.";
   } else {
    "Identifiant de participation invalide. Vous devriez avoir reçu un
     courrier électronique contenant un lien Internet vous permettant
     de participer à la consultation.";
   }
}
sub Invalid_result_key { # key
    "Identifiant de consultation des résultats invalide : \"$_[1]\".
     Vous devriez avoir reçu un courrier électronique contenant un lien
     Internet vous permettant la consultation des résultats de la
     consultation. Cet incident a été enregistré.";
}
sub Invalid_control_key { # key
    "Identifiant de gestion de la consultation invalide. Vous devriez avoir reçu un
     courrier électronique contenant un lien Internet vous permettant
     de gérer la consultation. Cet incident a été enregistré.";
}
sub Invalid_voting_key {
    "Identifiant de participation invalide. Vous devriez avoir reçu un
     courrier électronique conyenant un lien Internet vous permettant
     de participer à la consultation. Cet incident a été enregistré.";
}
sub Invalid_poll_id {
    "Invalid poll identifier";
}
sub Poll_id_not_valid { #id
    "The poll identifier \"$_[1]\" is not valid.";
}
sub Unable_to_append_to_poll_log {
    "Ne peut ajouter des informations à l'historique de la consultation.";
}
sub Voter_v_already_authorized {
    "Le participant \"$_[1]\" est déjà autorisé à voter.
     La clef de ce participant lui sera renvoyé.";
}
sub Invalid_email_address_hdr { # addr
    "Adresse de courrier électronique non valide";
}
sub Invalid_email_address { # addr
    "Adresse de courrier électronique non valide : $_[1]";
}
sub Sending_mail_to_voter_v {
    "Courrier électronique envoyé au participant \"$_[1]\"...";
}
sub CIVS_poll_supervisor { # name
    "\"$_[1], Responsable de la consultation CIVS\""
}
sub voter_mail_intro { #title, name, email_addr
"La consultation <b>$_[1]</b> a été mise en place à l'aide du Service de Vote Internet Condorcet (CIVS).
Le responsable de cette consultation, $_[2] (<a href=\"mailto:$_[3] ($_[2])\">$_[3]</a>), vous a désigné comme participant à cette consultation
 .</p>";
}
sub Description_of_poll {
    'Description de la consultation : ';
}
sub if_you_would_like_to_vote_please_visit {
    '
     Si vous désirez voter, merci de cliquer sur le lien Internet suivante : ';
}
sub This_is_your_private_URL {
'Ce lien Internet n\'est destiné qu\'à vous. Ne le communiquez à
 personne, car il pourrait être utilisé pour voter à votre place.';
}
sub Your_privacy_will_not_be_violated {
'La confidentialité de votre vie privé ne sera pas menacée par votre vote.
 Ce service de consultation a déjà  supprimé l\'enregistrement qui contenait
 votre adresse électronique et ne communiquera aucune information relative
 à votre choix de vote ou aux consultations auxquelles vous avez participé.';
}
sub This_is_a_nonanonymous_poll {
'Le responsable de cette consultation à décidé que cette consultation serait
 <strong>public</strong>. Si vous participez à cette consultation,
 votre choix de vote et votre adresse de courrier électronique seront
 communiqués aux autres participants de cette consultation.
 Si vous ne participez pas à cette consultation le responsable de la
 consultation en sera aussi informé.';
}

sub poll_has_been_announced_to_end { #election_end
    "Le consultation doit se terminer le $_[1].";
}

sub To_view_the_results_at_the_end {
    "Pour consulter les résultats de la consultations après sa clôture
    , cliquez sur le lien Internet suivant : </p> $_[1]";
}

sub For_more_information {
'Pour plus d\'informations concernant le Service de Vote Internet Condorcet
 (CIVS), consultez : '."\r\n$_[1]";
}


# close

sub CIVS_Ending_Poll {
    'CIVS: Clôture de Consultation';
}

sub Ending_poll {
    'Clôturer une consultation';
}
sub View_poll_results {
    'Accéder aux résultats de la consultation';
}
sub Poll_ended { #title
    "Consultation close le : $_[1]";
}

sub The_poll_has_been_ended { #election_end
    "Cette consultation est close. Sa date de clôture était initialement prévue le $_[1].";
}

sub poll_results_available_to_authorized_users {
    'Les résultats de la consultation sont disponibles aux les utilisateurs autorisés.';
}

sub was_not_able_stop_the_poll {
    'N\'a pas pu clore la consultation';
}


# results

sub CIVS_poll_result {
    "Résultats de la consultation CIVS";
}
sub Poll_results { # title
    "Résultats de la consultation : $_[1]";
}

sub Writeins_currently_allowed {
    'Les candidatures et les propositions panachées sont actuellement permises.';
}

sub Writeins_allowed {
    'Les candidatures et les propositions panachées sont permises.';
}
sub Writeins_not_allowed {
    'Les candidatures et les propositions panachées ne sont pas permises.';
}
sub Detailed_ballot_reporting_enabled {
    'Les résultats de la consultation seront détaillés.';
}
sub Detailed_ballot_reporting_disabled {
    'Les résultats de la consultation ne seront pas détaillés.';
}
sub Voter_identities_will_be_kept_anonymous {
    'La consultation aura lieu à bulletin secret';
}
sub Voter_identities_will_be_public {
    'L\'identité des participants (adresse du courrier électronique) sera publiquement associée à leur vote.';
}
sub Condorcet_completion_rule {
    'Règle de vote Condorcet :';
}
sub undefined_algorithm {
    'Erreur : Algorithme non défini.';
}
sub computing_results {
    'Dépouillement des résultats...';
}
sub Supervisor { #name, email
    "Responsable : $_[1] ($_[2])";
}
sub Announced_end_of_poll {
    "Date prévue de clôture de consultation : $_[1]";
}
sub Actual_time_poll_closed { # close time
    if ($_[1] == 0) {
	"Date de clôture de consultation : $_[1]"
    } else {
	'Date de clôture de consultation : <script>document.write(new Date(' .
	    $_[1] * 1000 . 
	    ').toLocaleString())</script>';
    }
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
    'Ceci est une consultation public.';
}

sub Actual_votes_cast { #num_votes
    "Nombre de votes actuellement exprimés : $_[1]";
}
sub Number_of_winning_candidates {
    'Nombre de candidats élus : ';
}
sub Poll_actually_has { #winmsg
    my $winmsg = '1 élu';
    if ($_[1] != 1) {
	$winmsg = ''.$_[1].' élus';
    }
    "&nbsp;(Poll actually has $winmsg)";
}
sub poll_description_hdr {
    'Description de la consultation';
}
sub Ranking_result {
    'Résultat du classement';
}
sub x_beats_y { # x y w l 
    "$_[1] bat $_[2] $_[3]&ndash;$_[4]";
}
sub x_ties_y { # x y w l 
    "$_[1] ex-æquo avec $_[2] $_[3]&ndash;$_[4]";
}
sub x_loses_to_y { # x y w l 
    "$_[1] perd contre $_[2] $_[3]&ndash;$_[4]";
}
sub some_result_details_not_shown {
    'Pour des raison de simplicité certains détails ne figurent pas dans les résultats de la consultations.';
}
sub Show_details {
    'Montrer les détails';
}
sub Hide_details {
    'Cacher les détails';
}
sub Result_details {
    'Résultats détaillés';
}
sub Ballot_report {
    'Compte rendu des bulletins de vote'
}
sub Ballots_are_shown_in_random_order {
    "Les bulletin de vote sont affichés dans un ordre aléatoire.";
}
sub Download_ballots_as_a_CSV { # url
    "<a href=\"$_[1]\">Télécharger les bulletins de vote</a> au format CSV";
}
sub No_ballots_were_cast {
    "Aucun vote n'a été exprimé lors de cette consultation.";
}
sub Ballot_reporting_was_not_enabled {
    "Un compte rendu des votes n'a pas été demandé pour cette consultation.";
}
sub Tied {
    "<i>Ex-æquo</i> : ";
}
sub loss_explanation { # loss_to, for, against
    ', perd en faveur de '. $_[1].' par '. $_[2] .'&ndash;'. $_[3];
}
sub loss_explanation2 {
    '&nbsp;&nbsp;perd en faveur de '.$_[1].' par '.$_[2].'&ndash;'.$_[3];
}
sub Condorcet_winner_explanation {
    '&nbsp;&nbsp;(Condorcet winner: wins contests with all other choices)';
}
sub undefeated_explanation {
    '&nbsp;&nbsp;(Not defeated in any contest vs. another choice)';
}
sub Choices_shown_in_red_have_tied {
    "Les propositions affichées en rouge sont à égalité pour être choisies.
	Vous pouvez les départager aléatoirement.";
}
sub Condorcet_winner {
    "Gagnant à la méthode Condorcet";
}
sub Choices_in_individual_pref_order {
    'Propositions (dans l\'ordre de préférence individuel)';
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
'Une méthode aléatoire a été utilisée pour éliminer les ex-æquo et obtenir ce classement selon les règles de l\'algorithme MAM. L\'ordre des propositions a pu en être altéré.';
}
sub No_random_tie_breaking_used {
    'Il n\'a pas été nécessaire d\'utiliser une méthode aléatoire pour départager les ex-æquo et obtenir ce classement.';
}
1; # package succeeded!
