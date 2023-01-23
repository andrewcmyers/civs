package dutch;

use lib '@CGIBINDIR@';
use CGI qw(:standard -utf8);
use utf8;

use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

our $VERSION = 1.000;

sub lang { 'nl-NH' }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

### BEGIN TRANSLATIONS ###

# civs_common

sub style_file {
  'style.css'
}
sub Condorcet_Internet_Voting_Service {
  'Condorcet Internet Stemdienst'
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited
  'Condorcet Internet Stemdienst'
}
sub CIVS_sender {
    my ($self) = @_;
    $self->Condorcet_Internet_Voting_Service_email_hdr
# UNTRANSLATED
}
sub about_civs {
  'Over CIVS'
}
sub new_user {
  'Activeer gebruiker'
}
sub public_polls {
  'Openbare peilingen'
}
sub create_new_poll {
  'Nieuwe peiling maken'
}
sub about_security_and_privacy {
  'Veiligheid en privacy'
}
sub FAQ {
  'FAQ'
}
sub CIVS_suggestion_box {
  'CIVS-ideeënbus'
}
sub unable_to_process {
  'CIVS kan uw verzoek niet verwerken vanwege een interne fout.'
}
sub CIVS_Error {
  'CIVS-fout'
}
sub CIVS_server_busy {
  'CIVS-server bezet'
}
sub Sorry_the_server_is_busy {
  'Sorry, de CIVS-webserver is momenteel erg druk en kan niet meer verzoeken verwerken. Probeer het later nog eens.'
}

# civs_create

sub mail_has_been_sent {
  "E-mail is verzonden naar het door u opgegeven adres (<tt>$_[1]</tt>)."
}

sub click_on_the_URL_to_start {
  "Klik op de URL in die e-mail om de peiling te starten â$_[1]â."
}

sub here_is_the_control_URL {
  'Hier is de URL om de nieuwe peiling te beheren. Bij normaal gebruik wordt dit per e-mail naar de supervisor gestuurd.'
}
sub the_poll_is_in_progress {
  'De peiling is bezig. Druk op deze knop om het te beëindigen:'
}

sub CIVS_Poll_Creation {
  "CIVS-enquête maken"
}
sub Poll_created {
  "Poll gemaakt: $_[1]"
}

sub Address_unacceptable { #addr
  "Het adres \"$_[1]\" is niet acceptabel"
}
sub Poll_must_have_two_choices {
  'Een peiling moet minimaal twee keuzes hebben.'
}
sub Poll_exceeds_max_choices {
    my ($self, $count) = @_;
  "Een poll kan maximaal $count keuzes hebben."
}
sub Poll_directory_not_writeable {
  "Configuratiefout? Kan de poll-directory <tt>$_[1]</tt> niet maken"
}
sub CIVS_poll_created {
  "CIVS-enquête gemaakt: $_[1]"
}
sub creation_email_info1 { # title, url
  "Deze e-mail bevestigt de aanmaak van een nieuwe peiling, $_[1]. U bent aangewezen als supervisor van deze peiling. Gebruik de volgende URL om de peiling te starten en te stoppen:
 <$_[2]>
Bewaar deze e-mail en houd deze privé. Als je het verliest, kun je de peiling niet controleren.
"
}
sub creation_email_public_link { # url
  "Omdat dit een openbare peiling is, kunt u kiezers naar de volgende URL leiden:
 <$_[1]>
"
}

sub opted_out { # addr
  "Sorry, je kunt geen e-mail sturen naar &lt;$_[1]&gt; via CIVS."
}

sub Sending_result_key { # addr (escaped)
  "<p>Resultaatsleutel wordt verzonden naar <tt>$_[1]</tt>. Sta dit toe om te voltooien...<br>"
}
sub Done_sending_result_key { # addr
  '...klaar met het verzenden van de resultaatsleutel.</p>'
}
sub Results_of_CIVS_poll { # title
  "Resultaten van CIVS-enquête: $_[1]"
}
sub Results_key_email_body { # title, url, civs_home
  "Er is een nieuwe CIVS-peiling gemaakt met de naam \"$_[1]\". U bent aangewezen als gebruiker die het resultaat van deze peiling mag zien.
Bewaar deze e-mail. Als je het verliest, heb je geen toegang tot de resultaten. Zodra de peiling is gesloten, zijn de resultaten beschikbaar op de volgende URL:
 <$_[2]>
Deze URL is privé. Door niet-geautoriseerde gebruikers toegang te geven tot deze URL, kunnen ze de pollresultaten zien.
"
}

# start

sub poll_started {
  "De poll <strong>$_[1]</strong> is gestart."
}

sub sending_keys_now {
  'We sturen nu kiezersuitnodigingen. Navigeer niet weg van deze pagina totdat alle uitnodigingen zijn verzonden.'
}

# control

sub CIVS_Poll_Control {
  "CIVS Poll-controle"
}
sub Poll_control {
  "Poll controle"
}
sub poll_has_not_yet_started {
  'De peiling is nog niet gestart. Druk op deze knop om het te starten:'
}
sub Start_poll {
  'Enquête starten'
}
sub End_poll {
  'Einde peiling'
}
sub Edit_button {
  'Bewerk'
}
sub ResendLink_button {
  'link opnieuw sturen'
}
sub ResendLinkAck {
  'verzonden'
}
sub Save_button {
  'sparen'
}
sub Remove_button {
  'verwijderen'
}
sub confirm_ending_poll_cannot_be_undone {
  'Het beëindigen van een peiling is een bewerking die niet ongedaan kan worden gemaakt. Om te bevestigen dat u de peiling wilt sluiten, typt u &#34;sluiten&#34; en druk op OK'
}
sub writeins_have_been_disabled {
  'Inschrijfkeuzes zijn uitgeschakeld'
}
sub disallow_further_writeins {
  'Verdere schrijfacties niet toestaan'
}
sub voting_disabled_during_writeins {
  'Stemmen is momenteel uitgeschakeld tijdens de inschrijffase.'
}
sub allow_voting_during_writeins {
  'Sta stemmen toe tijdens de inschrijffase'
}
sub this_is_a_test_poll {
  'Dit is een testpeiling.'
}
sub file_to_upload_from {
  'Bestand om stembiljetten te uploaden van:'
}
sub Load_ballots {
  'Stembiljetten laden'
}
sub poll_supervisor { # name, email
  "Opinieleider: $_[1] <tt>&lt;$_[2]&gt;</tt>"
}
sub no_authorized_yet { #waiting
    my ($self, $auth) = @_;
    if ($auth > 0) {
        "0 ($_[1] voters will be authorized when the poll is started)"
    } else {
        '0'
    }
# UNTRANSLATED
}
sub total_authorized_voters { # num_auth_string
  "Totaal aantal gemachtigde kiezers: $_[1]"
}
sub actual_votes_so_far { # num
  "Aantal daadwerkelijk uitgebrachte stemmen tot nu toe: $_[1]"
}
sub poll_ends { # end
  "Aangekondigd einde peiling: $_[1]"
}
sub email_load {
    my $msg = "Email load: ".sprintf("%4.2f", $_[1]);
    if ($_[1] > @MAX_EMAIL_LOAD@) {
        $msg .= " (Must be less than @MAX_EMAIL_LOAD@ to send email)";
    }
    return $msg;
# UNTRANSLATED
}
sub Poll_results_available_to_all_voters_when_poll_completes {
  'Enquêteresultaten beschikbaar voor alle kiezers wanneer de peiling is voltooid.'
}
sub Voters_can_choose_No_opinion {
  'Kiezers kunnen kiezen voor &ldquo;Geen mening&rdquo;.'
}
sub Voting_is_disabled_during_writeins {
  'Tijdens de inschrijfperiode is stemmen uitgeschakeld.'
}
sub Poll_results_will_be_available_to_the_following_users {
  'Enquêteresultaten zijn alleen beschikbaar voor de volgende gebruikers:'
}
sub Poll_results_are_now_available_to_the_following_users {
  'Enquêteresultaten zijn nu alleen beschikbaar voor de volgende gebruikers, die eerder een e-mail hebben ontvangen met een URL voor het bekijken van de resultaten:'
}
sub results_available_to_the_following_users {
  'De resultaten van deze peiling zijn alleen vrijgegeven aan een beperkt aantal gebruikers:'
}

sub Poll_results_are_available { #url
  "<a href=\"$_[1]\">[&nbsp;Bekijk enquêteresultaten&nbsp;]</a>"
}
sub Description {
  'Beschrijving:'
}
sub Candidates {
  'Kandidaten:'
}
sub Add_voters {
  'Voeg kiezers toe'
}

sub the_top_n_will_win { # num_winners
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt = "choice";
    } else {
	$wintxt = "$_[1] choices";
    }
    return "The top $wintxt will win.";
# UNTRANSLATED
}

sub add_voter_instructions {
  'Voer e-mailadressen van kiezers in, één per regel. Dit kunnen nieuwe kiezers zijn of bestaande kiezers die nog niet hebben gestemd. Als u in een privépeiling het e-mailadres van een reeds bestaande kiezer <strong>geeft</strong>, zal die kiezer niet twee keer stemmen. Het zal de kiezer alleen opnieuw een uitnodiging sturen om te stemmen. Bij een openbare peiling wordt alleen een symbolische poging gedaan om meervoudig stemmen te voorkomen.'
}
sub resend_question {
  'Zelfs kiezers uitnodigen die al hebben gestemd?'
}
sub Upload_file {
  'Upload bestand:'
}
sub Load_ballot_data {
  'Stemgegevens laden'
}
sub File_to_upload_ballots_from {
  'Bestand om stembiljetten te uploaden van:'
}
sub Upload_instructions {
  'Upload een tekstbestand dat is opgemaakt met één stembiljet per regel. Elke regel bevat de rangorde van de N keuzes, dit zijn getallen van 1 tot N, of een streepje (<kbd>-</kbd>) om geen mening weer te geven. Rangen moeten worden gescheiden door witruimte of een komma. Lijnen kunnen worden afgesloten met LF of CR/LF. Witruimte wordt genegeerd; regels waarvan het eerste niet-spatieteken # is, worden ook genegeerd. Een regel kan beginnen met <i>m</i><kbd>X</kbd> waarbij <i>m</i> een getal is, wat staat voor <i>m</i> identieke stembiljetten beschreven door de rest van de lijn.'
}
sub Examples_of_ballots {
  'Voorbeelden van stembiljetten:'
}
sub Ballot_examples {
  ' 1,4,3,2,5 <i>Een eenvoudige stemming met vijf keuzes.</i> 5 - 2 - 3 <i>Nog een ranglijst met vijf keuzes. Streepjes geven ongerangschikte keuzes aan.</i> 8X1 4 3 2 5 <i>Acht stembiljetten zoals het eerste voorbeeldstembiljet.</i>'
}
sub Or_paste_this_code {
  'Of plak deze HTML-code in uw eigen webpagina:'
}
sub This_is_a_public_poll_plus_link {
    my ($self, $url, $pub) = @_;
    if ($pub) {
	'This is a public poll. Share the following link
	    with voters to allow them to vote:<br>
	    &nbsp;&nbsp;'
        . $self->CopyableURL('poll_link', $url)
        . '</p><p>This poll will also be publicized by CIVS.';
    } else {
	'This is a public poll. Share the following link
	    with voters to allow them to vote:<br>
	    &nbsp;&nbsp;'
        . $self->CopyableURL('poll_link', $url)
        . '</p>';
    }
# UNTRANSLATED
}
sub The_poll_has_ended {
  'De peiling is afgelopen.'
}

# add voters

sub CIVS_Adding_Voters {
  'CIVS: Kiezers toevoegen'
}
sub Adding_voters {
  'kiezers toevoegen'
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
  'Sorry, kiezers kunnen alleen worden toegevoegd aan een lopende peiling.'
}
sub Too_many_voters_added {
  'Sorry, je kunt maar @MAX_VOTER_ADD@ kiezers tegelijk toevoegen.'
}
sub Too_much_email {
  'Sorry, CIVS stelt limieten aan de hoeveelheid e-mail die wordt gegenereerd. Voeg later meer kiezers toe.'
}
sub Out_of_upload_space {
  'De server heeft mogelijk geen schijfruimte meer voor uploads.'
}
sub Uploaded_file_empty {
    my ($self, $desc) = @_;
  "Geüploade $desc is leeg."
}
sub No_upload_file_provided {
    my ($self, $desc) = @_;
  "Geen $desc opgegeven. Upload mislukt."
}
sub Didnt_get_plain_text {
    my ($self, $type) = @_;
  "Geüploade invoer moet een gewoon tekstbestand of CSV-bestand zijn (in plaats daarvan <b>$type</b> ontvangen)"
}

sub Total_of_x_voters_authorized { # x
    if ($_[1] == 0) {
	'No voters authorized to vote yet.'
    } elsif ($_[1] == 1) {
	'Only 1 voter authorized to vote so far.'
    } else {
	"A total of $_[1] voters are authorized to vote."
    }
# UNTRANSLATED
}

sub Go_back_to_poll_control {
  'Ga terug naar peilingbeheer'
}
sub Done {
  'Gedaan.'
}

sub Email_voters_who_have_not_activated {
  'E-mail kiezers die niet zijn geactiveerd'
}

sub Activate_mail_subject {
  'Activeer uw e-mailadres op CIVS'
}
sub Address {
  'Adres'
}
sub Reason {
  'Reden'
}

sub Activate_mail_body {
    my ($self, $supervisor, $name, $title, $url) = @_;
  "Je bent uitgenodigd door $name <$supervisor> om te stemmen in een poll met de titel â$titleâ.
 Om te stemmen, activeert u uw e-mailadres met het CIVS-stemsysteem op: <$url>"
}


# vote

sub page_header_CIVS_Vote { # election_title
  'CIVS-stem: '.$_[1]
}

sub ballot_reporting_is_enabled {
  'Stembiljetrapportage is ingeschakeld voor deze peiling. Uw stembiljet (de rangschikking die u aan keuzes toewijst) zal zichtbaar zijn in de peilingresultaten wanneer de peiling eindigt.'
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
# UNTRANSLATED
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
	    possible ranks.";
        if (!$no_opinion) {
            $ret .= ' All choices initially have the lowest possible rank.</p>'. $cr;
        } else {
	    $ret .= '</p><p><b>Note:</b> All choices initially have the rank “No opinion”. This
                    rank is <i>not</i> the same as the lowest possible rank; it means
		    that you choose not to rank this choice with respect to the
		    other choices.</p>' . $cr;
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
# UNTRANSLATED
}

sub report_authorized {
    my ($self, $num_auth) = @_;
    if ($num_auth == 1) {
        'You are the only authorized voter.'
    } else {
        "A total of $num_auth voters have been authorized to vote."
    }
# UNTRANSLATED
}

sub Identifier_request {
  'Geef uw e-mailadres of een andere herkenbare identificatiecode op:'
}
sub Need_identifier {
  'Sorry, u moet zich legitimeren om te kunnen stemmen.'
}

sub Rank {
  'Rang'
}
sub Choice {
  'Keuze'
}
sub Weight {
  'Gewicht'
}

# overridden in english.pm
sub ordinal_of {
  "$_[1]"
}

sub address_will_be_visible {
  '<strong>Uw e-mailadres zal zichtbaar zijn</strong> samen met uw stembiljet.'
}

sub however_results_restricted {
    my @users = @{$_[1]};
    my $r = ' However, results will be made available only to a limited set of users: ';
    my $first=1;
    foreach my $u (@users) {
	if (!$first) { $r .= ', '; $first=0; }
	$r .= tt(escapeHTML($u));
    }
    $r .= '.';
    return $r;
# UNTRANSLATED
}

sub ballot_will_be_anonymous {
  ' Uw stembiljet blijft echter anoniem: er wordt geen persoonlijk identificeerbare informatie weergegeven.'
}

sub submit_ranking {
  'Rangschikking indienen'
}

sub only_writeins_are_permitted {
  'Stemmen is nog niet toegestaan in deze poll. U kunt echter de beschikbare keuzes bekijken en nieuwe keuzes invoeren. Gebruik het onderstaande tekstveld om nieuwe keuzes in te voeren.'
}

sub Add_writein {
  'Schrijf in'
}

sub to_top {
  'naar boven'
}
sub to_bottom {
  'Tot op de bodem'
}
sub move_up {
  'omhoog gaan'
}
sub move_down {
  'Naar beneden verplaatsen'
}
sub make_tie {
  'stropdas maken'
}
sub buttons_are_deactivated {
  'Deze knoppen zijn uitgeschakeld omdat uw browser geen Javascript ondersteunt.'
}
sub ranking_instructions {
  '<p>Rangschik de keuzes op een van de volgende drie manieren:</p> <ol> <li>sleep de rijen</li> <li>gebruik vervolgkeuzelijsten in de kolom Rangschikking</li> <li>selecteer rijen en gebruik de bovenstaande knoppen </li> </ol>'
}
sub write_in_a_choice {
  'Schrijf een nieuwe keuze in:'
}
sub show_qr_code {
  'Toon QR-code voor deze peiling.'
}
sub if_you_have_already_voted { #url
  "Als u al heeft gestemd, ziet u mogelijk <a href=\"$_[1]\">de huidige enquêteresultaten</a>."
}
sub thank_you_for_voting { #title, receipt
  "Dank je. Uw stem op <strong>$_[1]</strong> is succesvol uitgebracht.<br> Uw stembewijs is <code>$_[2]</code>. Deze kwitantie heeft u nodig als u uw stembiljet later wilt wijzigen."
}
sub try_some_public_polls {
  "Zin om op iets anders te stemmen? Probeer een van deze openbare peilingen:"
}
sub you_can_change_ballot_now {
  'Vanaf deze pagina kunt u het uitgebrachte stembiljet wissen en opnieuw stemmen.'
}
sub change_ballot {
  'Herstemmen'
}
sub name_of_writein_is_empty {
  "Naam van inschrijfkeuze is leeg"
}
sub writein_too_similar {
  "Sorry, de naam van de write-in lijkt te veel op een bestaande keuze"
}
sub doublecheck_msg {
  'Uw stemming heeft geen effect omdat alle kandidaten waarover u een mening heeft, gebonden zijn. Wil je alsnog inleveren?'
}

# election

sub No_poll_ID {
  "Er is geen peiling-ID opgegeven. Misschien een kopieer-plakfout?"
}
sub Ill_formed_poll_ID {
  "Er is een onjuist gevormde peiling-ID opgegeven. Misschien een kopieer-plakfout? (" . $_[1] . ")"
}
sub vote_has_already_been_cast {
  "Er is al een stem uitgebracht met uw stemsleutel."
}
#deprecated, use future_result_link
sub following_URL_will_report_results {
  'De volgende URL zal de peilingresultaten rapporteren zodra de peiling eindigt:'
}
sub future_result_link {
    my ($self, $url) = @_;
  "De volgende URL zal de peilingresultaten rapporteren zodra de peiling eindigt: <a href='$url'><code>$url</code></a>"
}
#deprecated
sub following_URL_reports_results {
  'De volgende URL rapporteert de huidige peilingresultaten:'
}
sub if_you_want_to_change {
  'U kunt uw vorige stem verwijderen en opnieuw stemmen door hier uw stembewijs in te voeren:'
}
sub invalid_release_key {
    my ($self, $receipt) = @_;
  'Het verstrekte ontvangstbewijs van de kiezer ('.$receipt.') is onjuist. Het zou moeten lijken op '.code('E_2ad1ca99ac3cac7a/3a191bd9fb00ef73').'.'
}
sub no_ballot_under_key {
    my ($self, $key) = @_;
  "Er is geen eerder stembiljet gevonden voor de kwitantie $key"
}
sub current_result_link {
    my ($self, $url) = @_;
  "<a href=\"$url\" class=result_link>Ga naar huidige enquêteresultaten</a>"
}
sub Already_voted {
  'Reeds gestemd'
}
sub Error {
  'Fout'
}
sub Invalid_key {
  'Ongeldige sleutel. U zou een correcte URL moeten hebben ontvangen om de peiling per e-mail te beheren. Deze fout is geregistreerd.'
}
sub Authorization_failure {
  'Autorisatie mislukt'
}

sub already_ended { # title
  "Deze peiling (<strong>$_[1]</strong>) is al beëindigd."
}
sub Poll_not_yet_ended {
  "Poll nog niet afgelopen"
}
sub The_poll_has_not_yet_been_ended { #title, name, email
  "Deze peiling ($_[1]) is nog niet beëindigd door zijn supervisor, $_[2] ($_[3])."
}

# deprecated
sub The_results_of_this_completed_poll_are_here {
  'De resultaten van deze voltooide peiling zijn hier:'
}
sub completed_results_link {
    my ($self, $url) = @_;
  "<a href=\"$url\" class=result_link>Ga naar voltooide peilingresultaten</a>"
}

sub No_write_access_to_lock_poll {
  "Had niet de schrijfrechten die nodig zijn om de peiling te vergrendelen."
}
sub This_poll_has_already_been_started { # title
  "Deze peiling ($_[1]) is al gestart."
}
sub No_write_access_to_start_poll {
  'Had geen schrijftoegang om een peiling te starten.'
}
sub Poll_does_not_exist_or_not_started {
  'Deze poll bestaat niet of is nog niet gestart.'
}
sub Your_voter_key_is_invalid__check_mail { # voter
   my $voter = $_[1];
   if ($voter ne '') {
    "Your voter key is invalid, $voter.
     You should have received a correct URL by email.";
   } else {
    "Your voter key is invalid. You should have received a correct URL by email.";
   }
# UNTRANSLATED
}
sub Invalid_result_key { # key
  "Ongeldige resultaatsleutel: \"$_[1]\". U zou een correcte URL moeten hebben ontvangen om de resultaten van de peiling per e-mail te bekijken. Deze fout is geregistreerd."
}
sub Invalid_control_key { # key
  "Ongeldige bedieningssleutel. U zou een correcte URL moeten hebben ontvangen om de peiling per e-mail te beheren. Deze fout is geregistreerd."
}
sub Invalid_voting_key {
  "Ongeldige stemsleutel. U zou een correcte URL voor het stemmen per e-mail moeten hebben ontvangen. Deze fout is geregistreerd."
}
sub Invalid_poll_id {
  "Ongeldige poll-ID"
}
sub Poll_id_not_valid { #id
  "De poll-ID \"$_[1]\" is niet geldig."
}
sub Unable_to_append_to_poll_log {
  "Kan niet toevoegen aan het poll-logboek."
}
sub Voter_v_already_authorized {
  "Kiezer &lt;$_[1]&gt; is al geautoriseerd. De sleutel van de kiezer wordt teruggestuurd naar de kiezer."
}
sub Skipping_already_voted {
  "Overslaande kiezer &lt;$_[1]&gt;: heeft al gestemd."
}
sub Invalid_email_address_hdr { # addr
  "Ongeldig e-mailadres"
}
sub Invalid_email_address { # addr
  "Ongeldig e-mailadres: $_[1]"
}
sub Address_opted_out { # addr
  "Dit adres heeft zich afgemeld voor CIVS-e-mail: $_[1]"
}
sub Sending_mail_to_voter_v {
  "E-mail verzenden naar kiezer \"$_[1]\"..."
}
sub CIVS_poll_supervisor { # name
  "\"Condorcet Internet Voting Service (namens $_[1])\""
}
sub From_poll_supervisor {
    my ($self, $name) = @_;
    $self->CIVS_poll_supervisor($name)
# UNTRANSLATED
}
sub voter_mail_intro { #title, name, email_addr
  "Er is een peiling van de Condorcet Internet Voting Service gemaakt met de naam <b>$_[1]</b>. U bent aangewezen als kiezer door de enquêteleider, $_[2] (<a href=\"mailto:$_[3] ($_[2])\"><code>$_[3]< /code></a>).</p>"
}
sub Description_of_poll {
  'Beschrijving van de peiling:'
}
sub if_you_would_like_to_vote_please_visit {
  'Als u wilt stemmen, gaat u naar de volgende URL:'
}
sub This_is_your_private_URL {
  'Dit is uw privé-URL. Geef het niet aan iemand anders, want zij zouden het kunnen gebruiken om op u te stemmen.'
}
sub Your_privacy_will_not_be_violated {
  'Uw privacy wordt niet geschonden door te stemmen. De stemservice heeft het record van uw e-mailadres al vernietigd en geeft geen informatie vrij over of en hoe u hebt gestemd.'
}
sub This_is_a_nonanonymous_poll {
  'De enquêteleider heeft besloten om er een <strong>niet-anonieme enquête</strong> van te maken. Als u stemt, zijn uw e-mailadres en hoe u hebt gestemd zichtbaar voor iedereen die toegang heeft gekregen tot de pollresultaten.'
}


sub poll_has_been_announced_to_end { #election_end
  "Er is aangekondigd dat de peiling $_[1] zal beëindigen."
}

sub To_view_the_results_at_the_end {
  "Ga naar:</p> $_[1] om de resultaten van de peiling te bekijken zodra deze is beëindigd."
}

sub for_more_information_about_CIVS { # url
  "Voor meer informatie over de Condorcet Internet Voting Service, zie $_[1]"
}

sub For_more_information { # url, mail mgmt url
  ($self, $home, $mail_mgmt) = @_;
  "For more information about the Condorcet Internet Voting Service, see
   $home. To control future email sent from CIVS, see $mail_mgmt"
# UNTRANSLATED
}

sub poll_email_subject { # title
  "Enquête: $_[1]"
}

# close

sub CIVS_Ending_Poll {
  'CIVS: peiling beëindigen'
}

sub Ending_poll {
  'Een peiling beëindigen'
}
sub View_poll_results {
  'Poll resultaten bekijken'
}
sub Poll_ended { #title
  "Poll beëindigd: $_[1]"
}

sub The_poll_has_been_ended { #election_end
  "De peiling is beëindigd. Er werd aangekondigd om $_[1] te beëindigen."
}

sub poll_results_available_to_authorized_users {
  'De resultaten van de peiling zijn nu beschikbaar voor geautoriseerde gebruikers.'
}

sub was_not_able_stop_the_poll {
  'Kon de peiling niet stoppen'
}


# results

sub CIVS_poll_result {
  "CIVS-enquêteresultaat"
}
sub Poll_results { # title
  "Enquêteresultaten: $_[1]"
}

sub Writeins_currently_allowed {
  'Inschrijfkeuzes zijn momenteel toegestaan.'
}

sub Writeins_allowed {
  'Inschrijfkeuzes zijn toegestaan.'
}
sub Writeins_not_allowed {
  'Inschrijfkeuzes zijn niet toegestaan.'
}
sub Detailed_ballot_reporting_enabled {
  'Gedetailleerde stembiljetrapportage is ingeschakeld.'
}
sub Detailed_ballot_reporting_disabled {
  'Gedetailleerde stembiljetrapportage is uitgeschakeld.'
}
sub Voter_identities_will_be_kept_anonymous {
  'De identiteit van de kiezers wordt anoniem gehouden'
}
sub Voter_identities_will_be_public {
  'De identiteit van de kiezer (e-mail) samen met hun stembiljetten zijn zichtbaar voor degenen die bevoegd zijn om de resultaten van de peilingen te bekijken.'
}
sub Condorcet_completion_rule {
  'Condorcet-voltooiingsregel:'
}
sub undefined_algorithm {
  'Fout: ongedefinieerd algoritme.'
}
sub computing_results {
  'Resultaten berekenen...'
}
sub Supervisor { #name, email
  "Begeleider: $_[1] <tt>&lt;$_[2]&gt;</tt>"
}
sub Announced_end_of_poll {
  "Aangekondigd einde peiling: $_[1]"
}
sub Actual_time_poll_closed { # close time
    if ($_[1] == 0) {
	"Actual time poll closed: $_[1]"
    } else {
	'Actual time poll closed: <script>document.write(new Date(' .
	    $_[1] * 1000 .
	    ').toLocaleString())</script>';
    }
# UNTRANSLATED
}
sub Poll_not_ended {
  'Poll is nog niet afgelopen.'
}
sub This_is_a_test_poll {
  'Dit is een testpeiling.'
}
sub This_is_a_private_poll { #num_auth
  "Privépeiling ($_[1] geautoriseerde kiezers)"
}
sub This_is_a_public_poll {
  'Dit is een openbare peiling.'
}

sub Actual_votes_cast { #num_votes
  "Daadwerkelijk uitgebrachte stemmen: $_[1]"
}
sub Number_of_winning_candidates {
  'Aantal winnende keuzes:'
}
sub Poll_actually_has { #winmsg
    my $winmsg = '1 winner';
    if ($_[1] != 1) {
	$winmsg = $_[1].' winners';
    }
    "&nbsp;(Poll actually has $winmsg)";
# UNTRANSLATED
}
sub poll_description_hdr {
  'Poll beschrijving'
}
sub Ranking_result {
  'Resultaat'
}
sub x_beats_y { # x y w l
  "$_[1] verslaat $_[2] $_[3]&ndash;$_[4]"
}
sub x_ties_y { # x y w l
  "$_[1] stropdassen $_[2] $_[3]&ndash;$_[4]"
}
sub x_loses_to_y { # x y w l
  "$_[1] verliest van $_[2] $_[3]&ndash;$_[4]"
}
sub some_result_details_not_shown {
  'Omwille van de eenvoud worden sommige details van het peilingresultaat niet getoond.'
}
sub Show_details {
  'Toon details'
}
sub Hide_details {
  'Verberg details'
}
sub Result_details {
  'Resultaat details'
}
sub Ballot_report {
  'Stemrapport'
}
sub Ballots_are_shown_in_random_order {
  "Stembiljetten worden weergegeven in een willekeurig gegenereerde volgorde."
}
sub Download_ballots_as_a_CSV { # url
  "[<a href=\"$_[1]\">Download stembiljetten in CSV-formaat</a>]"
}
sub No_ballots_were_cast {
  "Er zijn geen stemmen uitgebracht in deze peiling."
}
sub Ballot_reporting_was_not_enabled {
  'Stembiljetrapportage was niet ingeschakeld voor deze peiling.'
}
sub Tied {
  "<i>Gebonden</i>:"
}
sub loss_explanation { # loss_to, for, against
  ', verliest van '. $_[1].' door '. $_[2] .'&ndash;'. $_[3]
}
sub loss_explanation2 {
  '&nbsp;&nbsp;verliest van '.$_[1].' door '.$_[2].'&ndash;'.$_[3]
}
sub Condorcet_winner_explanation {
  '&nbsp;(Condorcet-winnaar: wint wedstrijden met alle andere keuzes)'
}
sub undefeated_explanation {
  '&nbsp;(Niet verslagen in een wedstrijd versus een andere keuze)'
}
sub Choices_shown_in_red_have_tied {
  'Keuzes die in het rood worden weergegeven, zijn gelijk geselecteerd. Misschien wilt u er willekeurig uit kiezen.'
}
sub Condorcet_winner {
  "Condorcet-winnaar"
}
sub Choices_in_individual_pref_order {
  'Keuzes (in volgorde van individuele voorkeur)'
}

sub Unknown_email {
  '(onbekend)'
}

sub What_is_this { # url
  '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>(Wat is dit?)</small></a>'
}

# rp

sub All_prefs_were_affirmed {
  'Alle voorkeuren werden bevestigd.'
}

sub Presence_of_a_green_entry_etc {
  'De aanwezigheid van een groen item onder de diagonaal (en een corresponderende rode erboven) betekent dat een voorkeur werd genegeerd omdat deze in strijd was met andere, sterkere voorkeuren.'
}
sub Random_tie_breaking_used {
  'Willekeurige tie-breaking werd gebruikt om tot deze volgorde te komen, volgens het MAM-algoritme. Dit kan de volgorde van de keuzes hebben beïnvloed.'
}
sub No_random_tie_breaking_used {
  'Er was geen willekeurige tiebreak nodig om tot deze volgorde te komen.'
}

# beatpath

sub beatpath_matrix_explanation {
  'De volgende matrix toont de sterkte van het sterkste beatpad dat elk paar keuzes verbindt. Keuze 1 wordt gerangschikt boven keuze 2 als er een sterker beatpad is dat van 1 naar 2 leidt dan een van 2 naar 1.'
}

sub no_pref {
  'geen'
}

#rp

sub Some_voter_preferences_were_ignored {
  'Sommige voorkeuren van kiezers werden genegeerd omdat ze in strijd zijn met andere, sterkere voorkeuren:'
}

sub preference_description {
  "De $_[1]-$_[2] voorkeur voor $_[3] boven $_[4]."
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
# UNTRANSLATED
}

sub mail_address {
  'E-mailadres:'
}
sub deactivation_code {
  'Deactiveringscode:'
}
sub filter_question {
  'Filterpatroon <small>(kan blanco worden gelaten; plaats de muisaanwijzer voor hulp)</small>'
}
sub filter_explanation {
  'U kunt hier een of meer patronen invoeren om aan te geven van welke poll-supervisors u geen e-mail wilt ontvangen. Het patroon kan het e-mailadres van een supervisor zijn of een patroon dat e-mailadressen beschrijft. Het patroon kan * gebruiken om elke reeks tekens weer te geven. Het patroon *@inmano.com zou bijvoorbeeld voorkomen dat supervisors met een @inmano.com-adres u poll-uitnodigingen sturen. Als u dit veld leeg laat, is deactivering/reactivering van toepassing op alle e-mailadressen.'
}
sub send_deactivation_code {
  'Stuur deactiveringscode per e-mail'
}
sub cant_send_email {
  'U kunt geen e-mail naar deze gebruiker verzenden via CIVS. E-mail aan deze gebruiker moet eerst opnieuw worden geactiveerd met een eerder verzonden deactiveringscode.'
}
sub submit_deact_react {
  'Dien deactivering/heractivering in'
}
sub codes_dont_match {
  "Sorry, de opgegeven code en het e-mailadres komen niet overeen. U kunt een andere code aanvragen als u niet eerder e-mail van CIVS heeft geblokkeerd."
}
sub deactivation_successful {
    my ($self, $pattern) = @_;
  "CIVS zal geen mail meer naar dit adres sturen als de afzender overeenkomt met dit patroon: \"$pattern\". Je kunt mail van CIVS alleen opnieuw activeren door deze webpagina te gebruiken met dezelfde code die je zojuist hebt gebruikt."
}
sub reactivation_successful {
  'Je hebt met succes e-mail naar dit adres opnieuw geactiveerd.'
}
sub someone_has_requested {
  "Iemand heeft om een code gevraagd om te voorkomen dat CIVS e-mail naar u kan sturen. Als jij het was, weet je wat je ermee moet doen. De code is:
 $_[1]
Bewaar deze e-mail want u heeft deze code nodig als u in de toekomst gebruik wilt maken van de dienst."
}
sub deactivation_code_subject {
  'Deactiveringscode voor CIVS-mail'
}
sub mail_mgmt_title {
  'Postbeheer'
}

## User activation

sub user_activation {
  'Activeer gebruiker'
}
sub activation_code_subject {
  'Activeringscode voor het gebruik van CIVS'
}
sub user_activation_instructions1 {
  'Om te stemmen in privé-CIVS-peilingen, moet u zich aanmelden voor e-mailcommunicatie van de service. CIVS slaat uw e-mailadres niet op en er zijn geen geautomatiseerde mailings. U ontvangt alleen e-mail van de service op uitdrukkelijk verzoek van poll-supervisors, met inloggegevens die nodig zijn om te stemmen in privé-polls of om de resultaten van polls te zien.'
}
sub user_activation_instructions2 {
  "Om u aan te melden, voert u uw e-mailadres in en klikt u op de onderstaande knop. U ontvangt dan een e-mail met een activeringscode. Houd er rekening mee dat als u zich eerder heeft afgemeld voor e-mail, u de <a href=\"$_[1]\">e-mailbeheerpagina</a> moet gebruiken om e-mail opnieuw te activeren. Als u een dienst voor het blokkeren van e-mail gebruikt, moet u mogelijk het CIVS-e-mailadres op de witte lijst zetten als geautoriseerde afzender (".'@SUPERVISOR@'.")."
}
sub user_activation_instructions {
    my ($self, $mail_mgmt_url) = @_;
    p($self->user_activation_instructions1).
    p($self->user_activation_instructions2($mail_mgmt_url))
# UNTRANSLATED
}
sub opt_in_label {
  'Activeringscode aanvragen'
}
sub activation_code {
  'Activatie code:'
}
sub someone_has_requested_activation {
    my ($self, $address, $code, $mail_mgmt_url) = @_;
  "Iemand heeft het CIVS-stemsysteem verzocht het e-mailadres <$address> te activeren voor stemmen in peilingen. Om dit adres te activeren heeft u de volgende activatiecode nodig:
 $code
Als u dit verzoek niet heeft ingediend, kunt u deze e-mail negeren.
Beheer e-mail van CIVS met behulp van deze link: $mail_mgmt_url."
}
sub already_activated {
  'Dit e-mailadres is al geactiveerd.'
}
sub activation_successful
{
    'Email address successfully activated.'
}
sub pending_invites_hdr {
  'In afwachting van poll-uitnodigingen:'
}
sub submit_activation_code {
  'Volledige activering'
}
sub pending_invites {
    my ($self, $pats, $invites) = @_;
    my @invites = @{$invites};
    if ($#invites >= 0) {
        my @rows = ();
        foreach $invite (@invites) {
            my ($url, $title) = @{$invite};
            push @rows, a({-href => $url}, $title);
        }
        return div(p($self->pending_invites_hdr), ul(\@rows));
    } else {
        return '';
    }
# UNTRANSLATED
}
sub user_not_activated {
    my ($self, $address) = @_;
  "Sorry, geen enkele gebruiker heeft adres &lt;$address&gt; geactiveerd om e-mail te ontvangen."
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
# UNTRANSLATED
}
sub see_the_failure_table {
    my ($self, $activate_url, $mail_mgmt_url) = @_;
  "<p>Het was voor CIVS niet mogelijk om mail te sturen naar sommige kiezers, om redenen die in onderstaande tabel staan vermeld. Kiezers kunnen pas stemmen als ze hun persoonlijke sleutel hebben ontvangen, dus u dient rechtstreeks contact met hen op te nemen. Kiezers zullen de volgende links waarschijnlijk nuttig vinden:</p> <ul> <li>Activeer een e-mailadres met CIVS: <a href='$activate_url'>$activate_url</a></li> <li>Deactiveer /heractiveer een e-mailadres: <a href='$mail_mgmt_url'>$mail_mgmt_url</a></li> </ul> <p> Houd er rekening mee dat wanneer kiezers hun e-mailadres activeren, ze op de hoogte worden gesteld van openstaande uitnodigingen om te stemmen in peilingen. </p>"
}
sub download_failures {
  'Tabel downloaden als CSV'
}

sub code_requested {
  'Code gevraagd. Controleer uw e-mail.'
}

sub code_requested_but_something_wrong {
  'Code gevraagd maar er ging iets mis.'
}

sub error_handling_code_request {
  "Fout bij het afhandelen van codeverzoek"
}
sub invalid_email_address {
  'Ongeldig e-mailadres'
}
sub unexpected_error {
  '<b>Onverwachte fout:</b>'
}
sub optin_error {
  'Fout:'
}
sub submitted {
  'ingediend'
}

1; # package succeeded!
