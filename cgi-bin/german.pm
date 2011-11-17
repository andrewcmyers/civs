package german;

use lib '@CGIBINDIR@';

use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

our $VERSION = 1.000;

sub lang { return 'de-DE'; }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub Condorcet_Internet_Voting_Service {
    'Condorcet Internet Voting Service';
    # translate this string
}

# civs_common
sub Condorcet_Internet_Voting_Service {
    'Condorcet Internet Voting Service';
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited 
    'Condorcet Internet Voting Service';
}
sub about_civs {
    'Über CIVS';
}
sub create_new_poll {
    'Neue Abstimmung anlegen';
}
sub about_security_and_privacy {
    'Zu Sicherheit und Privatsphäre';
}
sub FAQ {
    'FAQ';
}
sub CIVS_suggestion_box {
    'CIVS-Anregungskasten';
}
sub unable_to_process {
    'Aufgrund eines internen Fehlers konnte die Anfrage von CIVS nicht bearbeitet werden.';
}
sub CIVS_Error {
    'CIVS-Fehler';
}
sub CIVS_server_busy {
    'CIVS-Server ist überlastet';
}
sub Sorry_the_server_is_busy {
    'Leider ist der CIVS-Webserver überlastet und kann gerade keine
     weiteren Anfragen bearbeiten.  Bitte versuchen Sie es später noch einmal.';
}

# civs_create

sub mail_has_been_sent {
    "Eine Nachricht wurde an die angegebene E-Mail-Adresse gesandt (<tt>$_[1]</tt>).";
}

sub click_on_the_URL_to_start {
    "Rufen Sie die URL in dieser Nachricht auf, um die Abstimmung zu starten: <strong>$_[1]</strong>.";
}

sub here_is_the_control_URL {
    'Dies ist die URL zur Verwaltung der Abstimmung. Normalerweise würde
             diese per E-Mail an den Abstimmungsleiter geschickt.';
}
sub the_poll_is_in_progress {
    'Die Abstimmung ist geöffnet. Drücken Sie diesen Knopf, um sie zu beenden: ';
}

sub CIVS_Poll_Creation {
    "Erstellung einer CIVS-Abstimmung";
}
sub Poll_created {
    "Abstimmung erstellt: $_[1]"
}

sub Address_unacceptable { #addr
    "Die Adresse \"$_[1]\" ist ungültig";
}
sub Poll_must_have_two_choices {
    'Eine Abstimmung muss mindestens zwei Kandidaten haben.';
}
sub Poll_directory_not_writeable {
    "In das Abstimmungsverzeichnis kann nicht geschrieben werden";
}
sub CIVS_poll_created {
 "CIVS-Abstimmung erstellt: $_[1]";
}
sub creation_email_info1 { # title, url
"Diese Nachricht bestätigt die Erstellung einer neuen Abstimmung:
$_[1]. Sie wurden als Leiter dieser Abstimmung benannt.
Um die Abstimmung zu starten und zu beenden, nutzen Sie bitte die folgende URL:

  $_[2]

";
}
sub creation_email_public_link { # url
"Da dies eine öffentliche Abstimmung ist, können die Wähler folgende URL nutzen:

  $_[1]

";
}
sub for_more_information_about_CIVS { # url
"Für weitere Informationen über den Condorcet Internet Voting Service siehe:
  $_[1]";
}

sub Sending_result_key { # addr
    "Sende Schlüssel für Abstimmungsergebnis an '$_[1]'";
}
sub Results_of_CIVS_poll { # title
    "Ergebnis der CIVS-Abstimmung: $_[1]";
}
sub Results_key_email_body { # title, url, civs_home
"Eine neue CIVS-Abstimmung namens \"$_[1]\" wurde erstellt.
Sie wurden als Berechtigter zur Einsicht des Abstimmungsergebnisses
benannt.

Bewahren Sie diese Nachricht auf — falls Sie sie verlieren, erhalten
Sie keinen Zugang zum Abstimmungsergebnis. Sobald die Abstimmung
geschlossen ist, ist das Ergebnis unter der folgenden URL abrufbar:

  $_[2]

Diese URL ist geheim. Die Weitergabe dieser URL an Unberechtigte
ermöglicht diesen die Einsicht des Abstimmungsergebnisses.
Für weitere Informationen über den Condorcet Internet Voting Service siehe:
  $_[3]

";
}
  
# start

sub poll_started {
    'Die Abstimmung <strong>'.$_[1].'</strong> ist eröffnet.';
}

# control

sub CIVS_Poll_Control {
    "CIVS-Abstimmungsverwaltung";
}
sub Poll_control {
    "Abstimmungsverwaltung";
}
sub poll_has_not_yet_started {
    'Die Abstimmung ist noch nicht geöffnet. Drücken Sie diesen Knopf, um sie zu eröffnen: ';
}
sub Start_poll {
    'Abstimmung eröffnen';
}
sub End_poll {
    'Abstimmung schließen';
}
sub ending_poll_cannot_be_undone {
    'Die Abstimmung kann nach Schließung nicht wieder geöffnet werden. Fortfahren?';
}
sub writeins_have_been_disabled {
    'Freie Nominierung von Kandidaten ist deaktiviert.';
}
sub disallow_further_writeins {
    'Freie Nominierung von Kandidaten deaktivieren';
}
sub voting_disabled_during_writeins {
    'Abstimmung während Kandidatennominierung ist deaktiviert.';
}
sub allow_voting_during_writeins {
    "Abstimmung schon während Kandidatennominierung eröffnen";
}
sub this_is_a_test_poll {
    'Dies ist eine Testabstimmung.';
}

sub poll_supervisor { # name, email
    "Abstimmungsleiter: $_[1] (<tt>$_[2]</tt>)";
}
sub no_authorized_yet { #waiting
    "0 ($_[1] Wähler werden zugelassen, sobald die Abstimmung eröffnet wird)";
}
sub total_authorized_voters { # num_auth_string
    "Gesamte zugelassene Wähler: $_[1]";
}
sub actual_votes_so_far { # num
    "Bislang abgegebene Stimmen: $_[1]";
}
sub poll_ends { # end
    "Abstimmungsschluss: $_[1].";
}
sub Poll_results_available_to_all_voters_when_poll_completes {
    'Das Ergebnis ist nach Abstimmungsschluss für alle Wähler einsehbar.';
}
sub Voters_can_choose_No_opinion {
    'Wähler können mit Möglichkeiten mit “egal” bewerten';
}
sub Voting_is_disabled_during_writeins {
    'Abstimmung bleibt während Kandidatennominierung geschlossen.';
}
sub Poll_results_will_be_available_to_the_following_users {
    'Das Ergebnis ist nach Abstimmungsschluss ausschließlich für die folgenden Personen einsehbar:';
}
sub Poll_results_are_now_available_to_the_following_users {
    'Das Abstimmungsergebnis ist jetzt ausschließlich für die folgenden Personen einsehbar,
            welche zuvor eine Nachricht mit einer URL zur Ansicht des
            Ergebnisses erhalten haben:';
}
sub results_available_to_the_following_users {
    'Das Ergebnis dieser Abstimmung wurde ausschließlich folgenden Personen zugänglich gemacht:';
}

sub Poll_results_are_available { #url
    "<a href=\"$_[1]\">Abstimmungsergebnis ansehen</a>";
}
sub Description {
    'Beschreibung:';
}
sub Candidates {
    'Kandidaten:';
}
sub Add_voters {
    'Wähler hinzufügen';
}

sub the_top_n_will_win { # num_winners
    if ($_[1] == 1) {
	return "Der beste Kandidat gewinnt.";
    } else {
        return "Die $_[1] besten Kandidaten gewinnen.";
    }
}

sub add_voter_instructions {
    "Geben Sie die E-Mail-Adressen der Wähler ein — eine pro Zeile.
    Es kann sich um neue Wähler oder um Wähler handeln, die noch nicht
    abgestimmt haben. Bei einer privaten Abstimmung erlaubt das erneute
    Eingeben eines Wählers, der bereits abgestimmt hat, diesem Wähler
    keine zweite Stimmabgabe; dem Wähler wird lediglich die
    Abstimmungs&shy;aufforderung erneut zugesandt.
    Bei öffentlichen Abstimmungen gibt es nur oberflächliche Maßnahmen
    gegen mehrfache Stimmabgabe.";
}
sub Upload_file {
    'Datei hochladen: ';
}
sub Load_ballot_data {
    'Stimmdaten hochladen';
}
sub File_to_upload_ballots_from {
    'Datei mit Stimmdaten:';
}
sub This_is_a_public_poll_plus_link {
    my $url = $_[1];
    "Dies ist eine öffentliche Abstimmung. Teilen Sie den Wählern den
        folgenden Link zur Abstimmung mit:</p><p>
	&nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>";
}
sub The_poll_has_ended {
    'Die Abstimmung ist geschlossen.';
}

# add voters

sub CIVS_Adding_Voters {
    'CIVS: Wähler hinzufügen';
}
sub Adding_voters {
    'Wähler hinzufügen';
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
    'Das Hinzufügen von Wählern ist nur bei bereits laufender Abstimmung möglich.';
}

sub Total_of_x_voters_authorized { # x
    if ($_[1] == 0) {
	"Noch keine Wähler zur Abstimmung zugelassen.";
    } else {
	"Bislang $_[1] Wähler zur Abstimmung zugelassen.";
    }
}

sub Go_back_to_poll_control {
    'Zurück zur Abstimmungsverwaltung';
}
sub Done {
    'Fertig.';
}

# vote

sub page_header_CIVS_Vote { # election_title
    'CIVS-Abstimmung: '.$_[1];
}

sub ballot_reporting_is_enabled {
    'Die Stimmoffenlegung ist für diese Abstimmung aktiviert.
     Ihre Stimme (mit der Rangfolge, die Sie den Kandidaten zuweisen)
     wird nach Abstimmungsschluss veröffentlicht.';
}
sub instructions1 { # num_winners, end, name, email
    my $wintxt = ($_[1] == 1) ? 'genau einen Sieger' : "$_[1] Sieger";
    "Es wird $wintxt geben.<p>
	    Abstimmungsschluss: <b>$_[2]</b>.
	    Der Abstimmungsleiter ist $_[3] (<tt>$_[4]</tt>).
	    Nehmen Sie mit dem Abstimmungsleiter Kontakt auf, falls Sie Hilfe benötigen.";
}
sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
    my ($self, $no_opinion, $proportional, $combined, $civs_url) = @_;
    my $ret;
    if (!$proportional || !$combined) {
	$ret = "Teilen Sie jedem der folgenden Kandidaten
            einen Rang zu. Ein niedrigerer Rang bedeutet eine stärkere
            Präferenz für einen Kandidaten.
            Geben Sie z.B. ihrer ersten Wahl den Rang 1.
            Geben Sie mehreren Kandidaten denselben Rang wenn sie keinen
            von diesen den anderen gegenüber vorziehen.
            Sie müssen nicht alle möglichen Ränge vergeben.
            Alle Kandidaten haben zu Beginn den niedrigstmöglichen
            Rang. ". $cr;
	if ($no_opinion) {
	    $ret .= '<b>Achtung:</b> “egal” ist <i>nicht</i> dasselbe
                    wie der niedrigstmögliche Rang; es bedeutet vielmehr
                    dass Sie für den Kandidaten keine Präferenz gegenüber
                    den anderen Kandidaten ausdrücken wollen.</p>';
	}
	if ($proportional) {
            # Best-candidate proportional representation:
	    $ret .= '<p>Diese Abstimmung wird nach einem experimentellen
            Condorcet-basierten Verhältniswahlverfahren entschieden.
            Das Verfahren geht davon aus, dass Sie Ihren am stärksten
            bevorzugten Kandidaten möglichst unter den Gewinnern sehen möchten,
            und dass der Rang weiterer von Ihnen bevozugter Kandidaten für Sie
            nur eine Rolle spielt, wenn dies bereits entschieden ist.';
	}
    } else {
        # Combined-weights proportional representation:
	$ret = '<p>Diese Abstimmung wird nach einem experimentellen
        Condorcet-basierten Verhältniswahlverfahren entschieden.
        Bitte geben Sie jedem der folgenden Kandidaten ein <b>Gewicht</b>,
        das ausdrückt, wie sehr Sie ihn unter den Gewinnern sehen möchten.
        Das Verfahren geht davon aus, dass Sie das Gesamtgewicht der unter
        den Gewinnern befindlichen Kandidaten aus Ihrer Sicht maximieren
        möchten.
        Gewichte können nicht negativ oder größer als 999 sein.
        Es bringt nichts, größere Gewichte (z.B. 999) zu wählen als andere
        Wähler es vielleich tun, da die von Ihnen gewählten Gewichte nur
        <i>untereinander</i> verglichen werden, nicht mit den von anderen
        Wählern gewählten Gewichten.'.
	"<a href=\"$civs_url/proportional.html\">[Mehr Informationen]</a>.</p>";
    }
    return $ret;
}
sub Rank {
    'Rang';
}
sub Choice {
    'Kandidat';
}
sub Weight {
    'Gewicht';
}

sub address_will_be_visible {
    '<strong>Ihre E-Mail-Adresse wird zusammen mit Ihrer Stimme veröffentlicht.</strong>.';
}

sub ballot_will_be_anonymous {
    ' Ihre Stimme bleibt allerdings anonym;
      keine persönlichen Informationen sind einsehbar.';
}

sub submit_ranking {
    'Stimme abgeben';
}

sub only_writeins_are_permitted {
    'Diese Abstimmung ist noch nicht für die Stimmabgabe geöffnet.
             Sie können aber die eingereichten Kandidaten ansehen und
             über das untige Eingabefeld weitere Kandidaten nominieren.';
}

sub to_top {
    'nach ganz oben';
}
sub to_bottom {
    'nach ganz unten';
}
sub move_up {
    'eins hoch';
}
sub move_down {
    'eins runter';
}
sub make_tie {
    'unentschieden';
}
sub buttons_are_deactivated {
    'Diese Knöpfe sind deaktiviert, weil Ihr Webbrowser kein JavaScript unterstützt.';
}
sub ranking_instructions {
       'Sie können die Kandidatenreihung auf folgende Weisen anpassen:
	<ol>
	    <li>ziehen Sie die Zeilen,
	    <li>verwenden Sie die Auswahlfelder in der Rang-Spalte, oder
	    <li>wählen Sie Zeilen aus und verwenden Sie die obigen Knöpfe.
	</ol>';
}

sub write_in_a_choice {
    'Einen weiteren Kandidaten nominieren: ';
}
sub if_you_have_already_voted { #url
    "Wenn Sie Ihre Stimme bereits abgegeben haben, können Sie
	<a href=\"$_[1]\">das derzeitige Abstimmungsergebnis ansehen</a>.";
}
sub thank_you_for_voting { #title, receipt
    "Danke. Sie haben Ihre Stimme zu <strong>$_[1]</strong> erfolgreich
	abgegeben. Ihre Abstimmungsquittung ist <code>$_[2]</code>.";
}
sub name_of_writein_is_empty {
    "Sie haben keine Kandidatenbezeichnung eingegeben.";
}
sub writein_too_similar {
    "Es gibt bereits einen gleich lautenden Kandidaten.";
}

# election

sub vote_has_already_been_cast {
    "Mit Ihrem Wählerschlüssel wurde bereits eine Stimme abgegeben.";
}
sub following_URL_will_report_results {
    'Das Ergebnis wird nach Abstimmungsschluss unter der folgenden URL einsehbar sein:';
}
sub following_URL_reports_results {
    'Das derzeitige Abstimmungsergebnis ist unter der folgenden URL einsehbar:';
}
sub Already_voted {
    'Bereits abgestimmt';
}
sub Error {
    'Fehler';
}
sub Invalid_key {
    'Ungültiger Schlüssel. Sie sollten per E-Mail eine gültige URL
        zur Abstimmungsverwaltung erhalten haben. Dieser Zugriffsversuch wurde aufgezeichnet.';
}
sub Authorization_failure {
    'Autorisierung fehlgeschlagen';
}

sub already_ended { # title 
    "Diese Abstimmumg (<strong>$_[1]</strong>) ist bereits beendet.";
}
sub Poll_not_yet_ended {
    "Abstimmung noch nicht beendet";
}
sub The_poll_has_not_yet_been_ended { #title, name, email
    "Diese Abstimmung ($_[1]) wurde durch den Abstimmungsleiter noch nicht geschlossen,
    $_[2] ($_[3]),";
}
sub The_results_of_this_completed_poll_are_here {
    'Das Ergebnis dieser beendeten Abstimmung kann hier eingesehen werden:';
}

sub No_write_access_to_lock_poll {
    "Konnte Abstimmung mangels Schreibrechten nicht sperren.";
}
sub This_poll_has_already_been_started { # title
    "Diese Abstimmung ($_[1]) wurde bereits eröffnet.";
}
sub No_write_access_to_start_poll {
    'Konnte Abstimmung mangels Schreibrechten nicht eröffnen.';
}
sub Poll_does_not_exist_or_not_started {
    'Die Abfrage existiert nicht oder wurde nicht eröffnet.';
}
sub Your_voter_key_is_invalid__check_mail { # voter
   my $voter = $_[1];
   if ($voter ne '') {
    "Ihr Wählerschlüssel ist ungültig, $voter.
     Sie sollten per E-Mail eine gültige URL erhalten haben.";
   } else {
    "Ihr Wählerschlüssel ist ungültig. Sie sollten per E-Mail eine gültige URL erhalten haben.";
   }
}
sub Invalid_result_key { # key
    "Ungültiger Ergebnisschlüssel: \"$_[1]\". Sie sollten per E-Mail eine gültige URL zur
        Einsicht des Abstimmungsergebnisses erhalten haben. Dieser Zugriffsversuch wurde aufgezeichnet.";
}
sub Invalid_control_key { # key
    "Ungültiger Verwaltungsschlüssel. Sie sollten per E-Mail eine gültige URL zur
         Abstimmungsverwaltung erhalten haben. Dieser Zugriffsversuch wurde aufgezeichnet.";
}
sub Invalid_voting_key {
    "Ungültiger Wählerschlüssel. Sie sollten per E-Mail eine gültige URL zur
         Stimmabgabe erhalten haben. Dieser Zugriffsversuch wurde aufgezeichnet.";
}
sub Invalid_poll_id {
    "Ungültige Abstimmungs-ID";
}
sub Poll_id_not_valid { #id
    "Die Abstimmungs-ID \"$_[1]\" ist ungültig.";
}
sub Unable_to_append_to_poll_log {
    "Kann nicht in Log-Datei schreiben.";
}
sub Voter_v_already_authorized {
    "Der Wähler \"$_[1]\" wurde bereits registriert.
     Dem Wähler wird sein Wählerschlüssel erneut zugesandt.";
}
sub Invalid_email_address_hdr { # addr
    "Ungültige E-Mail-Adresse";
}
sub Invalid_email_address { # addr
    "Ungültige E-Mail-Adresse: $_[1]";
}
sub Sending_mail_to_voter_v {
    "Sende E-Mail an Wähler \"$_[1]\"...";
}
sub CIVS_poll_supervisor {
    "\"$_[1], CIVS-Abstimmungsleiter\""
}
sub voter_mail_intro { #title, name, email_addr
"Es wurde eine Abstimmung beim Condorcet Internet Voting Service namens <b>$_[1]</b>
erstellt.
Sie wurden vom Abstimmungsleiter, $_[2] (<a href=\"mailto:$_[3] ($_[2])\">$_[3]</a>),
als Wähler benannt.</p>";
}
sub Description_of_poll {
    'Beschreibung der Abstimmung:';
}
sub if_you_would_like_to_vote_please_visit {
    'Um Ihre Stimme abzugeben, rufen Sie bitte die folgende URL auf:';
}
sub This_is_your_private_URL {
'Dies ist ihre private URL. Geben Sie sie an niemanden weiter, da sonst jemand
anders für Sie abstimmen könnte.';
}
sub Your_privacy_will_not_be_violated {
'Die Geheimheit der Wahl wird bei der Abstimmung gewahrt.  CIVS hat die Aufzeichnung
Ihrer E-Mail-Adresse bereits vernichtet und wird keine Informationen darüber
herausgeben, ob Sie abgestimmt haben oder nicht.';
}
sub This_is_a_nonanonymous_poll {
'Der Abstimmungsleider hat entschieden, diese <strong>Wahl offen</strong>
durchzuführen. Falls Sie Ihre Stimme abgeben, wird diese zusammen mit Ihrer
E-Mail-Adresse öffentlich einsehbar sein. Falls Sie Ihre Stimme nicht abgeben,
kann der Abstimmungsleiter dies ebenfalls feststellen.';
}

sub poll_has_been_announced_to_end { #election_end
    "Das Abstimmungsschluss wurde für $_[1] verkündet.";
}

sub To_view_the_results_at_the_end {
    'Das Ergebnis wird nach Abstimmungsschluss hier einsehbar sein:</p>';
}

sub For_more_information {
'Für weitere Informationen über den Condorcet Internet Voting Service siehe:';
}


# close

sub CIVS_Ending_Poll {
    'CIVS: Abstimmung schließen';
}

sub Ending_poll {
    'Abstimmung schließen';
}
sub View_poll_results {
    'Abstimmungsergebnis ansehen';
}
sub Poll_ended { #title
    "Abstimmung geschlossen: $_[1]";
}

sub The_poll_has_been_ended { #election_end
    "Die Abstimmung wurde geschlossen. Der Abstimmungsschluss war für $_[1] angekündigt.";
}

sub poll_results_available_to_authorized_users {
    'Das Abstimmungsergebnis ist jetzt für Berechtigte einsehbar.';
}

sub was_not_able_stop_the_poll {
    'Konnte die Abstimmung nicht schließen';
}


# results

sub CIVS_poll_result {
    "CIVS: Abstimmungsergebnis";
}
sub Poll_results { # title
    "Abstimmungsergebnis: $_[1]";
}

sub Writeins_currently_allowed {
    'Freie Nominierung von Kandidaten ist derzeit möglich.';
}

sub Writeins_allowed {
    'Freie Nominierung von Kandidaten ist möglich.';
}
sub Writeins_not_allowed {
    'Freie Nominierung von Kandidaten ist nicht möglich.';
}
sub Detailed_ballot_reporting_enabled {
    'Detaillierter Stimmbericht ist aktiviert.';
}
sub Detailed_ballot_reporting_disabled {
    'Detaillierter Stimmbericht ist deaktiviert.';
}
sub Voter_identities_will_be_kept_anonymous {
    'Wähler sind anonym';
}
sub Voter_identities_will_be_public {
    'Identitäten der Wähler (E-Mail-Adressen) sowie ihr Abstimmungsverhalten werden öffentlich einsehbar sein.';
}
sub Condorcet_completion_rule {
    'Verfahren zur Condorcet-Vervollständigung:';
}
sub undefined_algorithm {
    'Fehler: unbestimmtes Verfahren zur Condorcet-Vervollständigung.';
}
sub computing_results {
    'Berechne Ergebnis ...';
}
sub Supervisor { #name, email
    "Abstimmungsleiter: $_[1] ($_[2])";
}
sub Announced_end_of_poll {
    "Angekündigter Abstimmungsschluss: $_[1]";
}
sub Actual_time_poll_closed { # close time
    if ($_[1] == 0) {
	"Tatsächlicher Abstimmungsschluss: $_[1]"
    } else {
	'Tatsächlicher Abstimmungsschluss: <script>document.write(new Date(' .
	    $_[1] * 1000 . 
	    ').toLocaleString())</script>';
    }
}
sub Poll_not_ended {
    'Abstimmung ist noch nicht geschlossen.';
}
sub This_is_a_test_poll {
    'Dies ist eine Testabstimmung.';
}
sub This_is_a_private_poll { #num_auth
    "Private Abstimmung ($_[1] zugelassene Wähler)";
}
sub This_is_a_public_poll {
    'Dies ist eine öffentliche Abstimmung.';
}

sub Actual_votes_cast { #num_votes
    "Abgegebene Stimmen: $_[1]";
}
sub Number_of_winning_candidates {
    'Anzahl der Sieger: ';
}
sub Poll_actually_has { #winmsg
    "&nbsp;(Es gibt tatsächlich $_[1] Sieger)";
}
sub poll_description_hdr {
    'Abstimmungsbeschreibung';
}
sub Ranking_result {
    'Kandidatenreihung';
}
sub x_beats_y { # x y w l 
    "$_[1] schlägt $_[2] $_[3]&ndash;$_[4]";
}
sub x_ties_y { # x y w l 
    "$_[1] unentschieden zu $_[2] $_[3]&ndash;$_[4]";
}
sub x_loses_to_y { # x y w l 
    "$_[1] verliert gegen $_[2] $_[3]&ndash;$_[4]";
}
sub some_result_details_not_shown {
    'Zwecks Übersichtlichkeit sind einige Ergebnisdetails versteckt.';
}
sub Show_details {
    'Details anzeigen';
}
sub Hide_details {
    'Details verstecken';
}
sub Result_details {
    'Ergebnisdetails';
}
sub Ballot_report {
    'Stimmbericht'
}
sub Ballots_are_shown_in_random_order {
    "Die Stimmen werden in zufälliger Reihenfolge angezeigt.";
}
sub Download_ballots_as_a_CSV { # url
    "<a href=\"$_[1]\">Stimmen im CSV-Format herunterladen</a>";
}
sub No_ballots_were_cast {
    "In dieser Abstimmung wurden keine Stimmen abgegeben.";
}
sub Ballot_reporting_was_not_enabled {
    "Diese Abstimmung sah keinen Stimmbericht vor.";
}
sub Tied {
    "<i>Unentschieden</i>:";
}
sub loss_explanation { # loss_to, for, against
    ', verliert gegen '. $_[1].' um '. $_[2] .'&ndash;'. $_[3];
}
sub loss_explanation2 {
    '&nbsp;&nbsp;verliert gegen '.$_[1].' um '.$_[2].'&ndash;'.$_[3];
}
sub Condorcet_winner_explanation {
    '&nbsp;&nbsp;(Condorcet-Sieger: schlägt jeden anderen Kandidaten)';
}
sub undefeated_explanation {
    '&nbsp;&nbsp;(Verliert gegenüber keinem anderen Kandidaten)';
}
sub Choices_shown_in_red_have_tied {
    "Zwischen den rot markierten Kandidaten ist die Wahl unentschieden.
	Der Gleichstand könnte z.B. zufällig aufgelöst werden.";
}
sub Condorcet_winner {
    "Condorcet-Sieger";
}
sub Choices_in_individual_pref_order {
    'Kandidaten (in Reihenfolge gemäß Einzelpräferenzen)';
}

# rp

sub All_prefs_were_affirmed {
    'Alle Präferenzen wurden bestätigt.
     Alle Condorcet-Verfahren führen zu dieser Rangfolge.';
}

sub Presence_of_a_green_entry_etc {
    'Ein grünes Feld unterhalb der Diagonalen (und ein entsprechendes
        oberhalb) bedeutet, dass eine Präferenz ignoriert wurde, da
        sie von einer gegensätzlichen, stärkeren geschlagen wurde.';
}
sub Random_tie_breaking_used {
'Gleichstände wurden gemäß dem MAM-Verfahren mit Zufallsentscheiden
aufgelöst. Dies kann die Rangfolge beeinflusst haben.';
}
sub No_random_tie_breaking_used {
    'Es wurden keine Gleichstände per Zufallsentscheid aufgelöst.';
}
1; # package succeeded!
