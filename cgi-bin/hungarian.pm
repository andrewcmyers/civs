package hungarian;

use lib '@CGIBINDIR@';
use base_language;

our @ISA = ('base_language'); # go to this module for missing methods

sub lang { return 'hu-HU'; }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub Condorcet_Internet_Voting_Service {
    return 'Condorcet Internet Szavazási Szolgáltatás<br>(CIVS)';
}

sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited 
    'Condorcet Internet Szavazási Szolgáltatás';
}
sub about_civs {
    return 'A CIVS-ről';
}
sub create_new_poll {
    return 'Új szavazás létrehozása';
}
sub about_security_and_privacy {
    return 'A biztonságról és a személyes adatok védelméről';
}
sub FAQ {
    return 'GYakran Ismételt Kérdések';
}
sub CIVS_suggestion_box {
    return 'CIVS javaslattár';
}
sub unable_to_process {
    return 'A CIVS belső hiba miatt nem tudja végrehajtani a kérést.';
}

sub CIVS_Error {
    'CIVS Error';
}
sub CIVS_server_busy {
    'A CIVS kiszolgáló le van terhelve';
}
sub Sorry_the_server_is_busy {
    'Sajnáljuk, a CIVS kiszolgáló nagyon le van most terhelve, és nem tud több kérést feldolgozni. Légy szíves térj vissza később.';
}

# civs_create
sub mail_has_been_sent {
    return "Levelet küldtünk az általad megadott címre(<tt>$_[1]</tt>).";
}

sub click_on_the_URL_to_start {
    return "Kattints a levélben lévő URL-re a szavazás elindításához: <strong>$_[1]</strong>.";
}

sub here_is_the_control_URL {
    return 'Itt az URL új szavazás vezérléséhez. Normál működésben
             e-mailben küldenénk el a szavazás szervezőjének.';
}
sub the_poll_is_in_progress {
    return 'A szavazás folyamatban van. Nyomd meg ezt a gombot a befejezéshez:';
}

sub CIVS_Poll_Creation {
    return "CIVS Szavazás Létrehozása";
}
sub Poll_created {
    return "Szavazás létrehozva: $_[1]"
}

sub Address_unacceptable { #addr
    "Ez a cím (\"$_[1]\") nem elfogadható";
}
sub Poll_must_have_two_choices {
    'Egy szavazásnak legalább két választása kell legyen.';
}
sub Poll_directory_not_writeable {
    "A szavazás könyvtára nem írható";
}
sub CIVS_poll_created {
 "CIVS szavazás létrehozva: $_[1]";
}
sub creation_email_info1 { # title, url
"Ez az email visszaigazolja egy új szavazás létrehozását,
$_[1] néven. Te vagy a szavazás gazdája.
A szavazás elindításához és leállításához kérlek használd a következő URL-t:

  $_[2]

";
}
sub creation_email_public_link { # url
"Mivel ez egy nyílt szavazás, a szavazókat a következő URL-re lehet irányítani:

  $_[1]

";
}
sub for_more_information_about_CIVS { # url
"A Condorcet Internet Szavazási szolgáltatásról további információkat
az alábbi címen találsz:
  $_[1]";
}

sub Sending_result_key { # addr
    "Az eredmény kulcsának küldése '$_[1]' részére";
}
sub Results_of_CIVS_poll { # title
    "A $_[1] CIVS szavazás eredményei";
}

sub Results_key_email_body { # title, url, civs_home
"Egy új CIVS szavazás indult $_[1] néven.
A szavazás eredményének megtekintése a te számodra engedélyezett.

Mentsd el ezt a levelet, mert ha elveszted, nem lesz hozzáférésed az eredményekhez.
Ha a szavazás lezárult, az eredmények a következő címen lesznek elérhetőek:

  $_[2]

Ez a cím bizalmas. Ha jogosulatlan személyek számára ismertté válik ez a cím,
akkor megnézhetik a szavazás eredményét.

";
}


# start
sub poll_started {
    "Elindult a szavazás <strong>$_[1]</strong> néven.";
}

# control
sub CIVS_Poll_Control {
    return "CIVS Szavazás Vezérlése";
}
sub Poll_control {
    return "A szavazás vezérlése";
}
sub poll_has_not_yet_started {
    return 'A szavazás még nem kezdődött el. Nyomd meg ezt a gombot az elindításához: ';
}
sub Start_poll {
    return 'Szavazás elindítása';
}

sub End_poll {
    return 'Szavazás leállítása';
}
sub ending_poll_cannot_be_undone {
    return 'A szavazás leállítását nem lehet visszacsinálni. Folytassuk?';
}
sub writeins_have_been_disabled {
    return 'A választási lehetőségek beírása le van tiltva';
}
sub disallow_further_writeins {
    return 'A választási lehetőségek beírásának letiltása';
}
sub voting_disabled_during_writeins {
    return 'A szavazás most a választási lehetőségek gyűjtése közben le van tiltva.';
}
sub allow_voting_during_writeins {
    return "Szavazás engedélyezése a választási lehetőségek gyűjtése közben";
}
sub this_is_a_test_poll {
    return 'Ez egy teszt szavazás.';
}

sub poll_supervisor { # name, email
    return "A szavazás gazdája: $_[1] (<tt>$_[2]</tt>)";
}
sub no_authorized_yet { #waiting
    return "0 ($_[1] jogosult szavazó lesz ha a szavazás elindul)";
}
sub total_authorized_voters { # num_auth_string
    return "A szavazásra jogosultak száma: $_[1]";
}
sub actual_votes_so_far { # num
 return "Az eddig leadott szavazatok száma: $_[1]";
}

sub poll_ends { # end
    return "A szavazás vége: $_[1].";
}

sub Poll_results_available_to_all_voters_when_poll_completes {
    return 'A szavazás eredménye elérhető minden szavazónak ha a szavazás lezárult.';
}
sub Voters_can_choose_No_opinion {
    return 'A szavazók választhatják a &ldquo;Nincs vélemény&rdquo; lehetőséget';
}
sub Voting_is_disabled_during_writeins {
    return 'A szavazás az új lehetőségek felvitele közben letiltva.';
}
sub Poll_results_will_be_available_to_the_following_users {
    return 'A szavazás eredménye a következő felhasználóknak lesz elérhető:';
}
sub Poll_results_are_now_available_to_the_following_users {
    return 'A szavazás eredménye most csak a következő felhasználóknak érhető el,
	    akiknek régebben ki lett küldve egy email a szavazás eredményéhez szóló URL-el:';
}
sub results_available_to_the_following_users {
    'A szavazás eredménye csak a következő felhasználóknak elérhető:';
}

sub Poll_results_are_available { #url
    return "<a href=\"$_[1]\">A szavazás eredménye</a>";
}
sub Description {
    return 'Leírás:';
}
sub Candidates {
    return 'Lehetőségek:';
}
sub Add_voters {
    return 'Szavazó hozzáadása';
}

sub the_top_n_will_win { # num_winners
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt = "lehetőség";
    } else {
	$wintxt = "$_[1] lehetőség";
    }
    return "A legjobb $wintxt fog nyerni.";
}

sub add_voter_instructions {
    "Add meg a szavazók email címeit, minden sorban egyet.
    ezek lehetnek új szavazók, vagy létező szavazók akik még nem szavaztak.
    Egy zártkörű szavazásnál egy már létező szavazó e-mail címének megadása
    <strong>nem fogja</strong> azt okozni, hogy az a szavazó kétszer szavazhasson,
    csupán újraküldi a meghívót a szavazáshoz.
    Egy nyílt szavazásnál csak jelképes próbálkozás történik a többszörös szavazás
    kivédésére.";
}
sub Upload_file {
    'Fájl feltöltése: ';
}
sub Load_ballot_data {
    'Szavazat adat betöltése';
}
sub File_to_upload_ballots_from {
    'Fájl a szavazat adatok betöltésére:';
}
sub This_is_a_public_poll_plus_link { #url
    my $url = $_[1];
    "Ez egy nyílt szavazás. Oszd meg a következő hivatkozást
    a szavazókkal, hogy szavazhassanak:</p><p>
	&nbsp;&nbsp;<tt><a href=\"$_[1]\">$_[1]</a></tt>";
}
sub The_poll_has_ended {
    'A szavazás lezárult.';
}

# add voters

sub CIVS_Adding_Voters {
    'CIVS: Szavazók hozzáadása';
}
sub Adding_voters {
    'Szavazók hozzáadása';
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
    'Sajnáljuk, szavazókat csak folyamatban lévő szavazáshoz lehet hozzáadni.';
}

sub Total_of_x_voters_authorized { # x
    if ($_[1] == 0) {
        "Üres a szavazói névjegyzék.";
    } else {
        "Összesen $_[1] szavazó van a névjegyzékben.";
    }
}

sub Go_back_to_poll_control {
    'Vissza a szavazás irányítására';
}
sub Done {
    'Kész.';
}



# vote

sub page_header_CIVS_Vote { # election_title
    return 'CIVS Szavazás: '.$_[1];
}

sub ballot_reporting_is_enabled {
    return 'A szavazatok kimutatása engedélyezve van ehhez a szavazáshoz.
        A szavazatod (a választási lehetségekhez rendelt rangsorod)
        nyilvános lesz amikor a szavazás lezárul.';
}
sub instructions1 { # num_winners, end, name, email
    return "A szavazásnak $_[1] győztese lesz.<p>
        A szavazás vége: <b>$_[2]</b>.
        A szavazás gazdája $_[3] (<tt>$_[4]</tt>).
        Ha segítségre van szükséged, keresd a szavazás gazdáját.";
}
sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
    my ($self, $no_opinion, $prop, $combined, $civs_url) = @_;
    my $ret;
    if (!$prop || !$combined) {
    $ret = "Rendelj a következő lehetőségek mindegyikéhez egy rangot,
        ahol <b>a kisebb szám jelöli a szerinted jobb megoldást</b>.
        Például a szerinted legjobb legyen az 1-es.
        Azoknak a lehetőségeknek, amelyeket ugyanolyannak tartasz,
        add ugyanazt a számot.
        Nem kell minden lehetséges számot felhasználnod.
        Minden lehetőség alapértelmezetten a legalacsonyabb lehetséges
        rangot kapja. ". $cr;
    if ($no_opinion) {
        $ret .= '<b>Figyelem:</b> A &ldquo;Nincs vélemény&rdquo;
            <i>nem</i> ugyanaz, mint a lehetséges legalacsonyabb rang;
            azt jelenti, hogy nem akarod a lehetőséget rangsorolni a többi
            lehetőséghez képest.</p>';
    }
    if ($prop) {
        $ret .= '<p>Ezt a szavazást egy kísérleti Condorcet alapú módszerrel
        számoljuk ki, amelyet arra terveztek, hogy arányos képviseletet biztosítson.
        A szavazás algoritmusa azt feltételezi, hogy a szerinted legjobb <i>nyerő</i>
        lehetőséget olyan magasra rangsorolod, amennyire csak lehet, és ha
        a nyerő lehetőségek két halmaza egyezik az általad legjobban preferált
        lehetőségben, akkor te a második helyen rangsorolt alapján döntenél,
        és így tovább. ';
    }
    } else {
    $ret = '<p>Ezt a szavazást egy kísérleti Condorcet alapú módszerrel
    számoljuk ki.
    Adj a következő lehetőségeknek egy <b>súlyozást<b> amely
    kifejezi azt, hogy mennyire szeretnéd az adott lehetőséget
    a nyerő lehetőségek halmazában látni.
    Az algoritmus feltételezi, hogy a súlyozások összegét
    olyan nagynak szeretnéd látni, amekkora csak lehet.
    Minden lehetőség alapértelmezetten nulla súlyozást kap,
    ami azt jelenti hogy nem szeretnéd nyertesnek látni.
    A súlyok nem lehetnek negatívak vagy nagyobbak mint 999.
    Nem segít ha a súlyozást nagyobbra veszed mint más szavazók
    súlyozása, mert a te súlyaidat csak egymással hasonlítjuk össze.'.
    "<a href=\"$_[4]/proportional.html\">[További információk]</a>.</p>";
    }
    return $ret;
}

sub Rank {
    return 'Rang';
}
sub Choice {
    return 'Választás';
}
sub Weight {
    return 'Súly';
}
sub address_will_be_visible {
    return '<strong>Az email címed látható lesz</strong> a szavazatodon.';
}

sub ballot_will_be_anonymous {
    return ' Mindazonáltal a szavazatod titkos les: '
     . 'nem jelenik meg személyes adat rajta.';
}

sub submit_ranking {
    return 'Rangsor megadása';
}

sub only_writeins_are_permitted {
    return 'Ebben a szavazásban a szavazás még nem engedélyezett.
         De megtekintheted a rendelkezésre álló választási lehetőségeket,
        és adhatsz hozzá új lehetőségeket.';
}

sub to_top {
    return 'tetejére';
}
sub to_bottom {
    return 'aljára';
}
sub move_up {
    return 'felfelé';
}
sub move_down {
    return 'lefelé';
}
sub make_tie {
    return 'legyen döntetlen';
}
sub buttons_are_deactivated {
    return 'Ezek a gombok nem aktívak, mert a böngésződ nem támogatja a javascriptet.';
}
sub ranking_instructions {
    return
       'Rangsorold a lehetőségeket az alábbi módok valamelyikével:
    <ol>
        <li>húzd a sort a helyére
        <li>Használd a rangsor oszlopban a legördülő menüt
        <li>válassz ki sorokat és használd a fenti gombokat
    </ol>';
}

sub write_in_a_choice {
    return 'Adj meg új választási lehetőséget: ';
}
sub if_you_have_already_voted { #url
    return "Ha már szavaztál, megnézheted
    <a href=\"$_[1]\">az aktuális eredményeket</a>.";
}
sub thank_you_for_voting { #title, receipt
    return "Köszönjük. A szavazatod <strong>$_[1]</strong> témában
    sieresen leadva. A szavazói nyugtád kódja: <code>$_[2]</code>.";
}
sub name_of_writein_is_empty {
    return "A választási lehetőség neve üres";
}
sub writein_too_similar {
    return "Sajnáljuk, a választási lehetőség neve túlságosan hasonló egy már létezőhöz";
}

# election

sub vote_has_already_been_cast {
    return 'A szavazási kulcsoddal már van szavazat leadva';
}

sub following_URL_will_report_results {
    return 'A szavazás eredményét a következő helyen nézheted meg ha vége a szavazásnak:';
}

sub following_URL_reports_results {
    return 'A szavazás eredményét a következő helyen nézheted meg:';
}

sub Already_voted {
    return 'Már szavaztál';
}

sub Error {
    'Hiba';
}
sub Invalid_key {
    'Hibás kulcs. Egy megfelelő URL-t kellett kapjál emailben a szavazás
    irányításához. Ez a hiba naplózva lett.';
}
sub Authorization_failure {
    'Jogosultsági hiba';
}

sub already_ended { # title 
    "Ez a szvazás (<strong>$_[1]</strong>) már lezárult.";
}
sub Poll_not_yet_ended {
    "A szavazás még nem ért véget";
}
sub The_poll_has_not_yet_been_ended { #title, name, email
    "A $_[1] című szavazásnak még nem vetett véget a gazdája,
    $_[2] ($_[3]),";
}
sub The_results_of_this_completed_poll_are_here {
    'Ennek a lezárult szvazásnak az eredménye itt van:';
}

sub No_write_access_to_lock_poll {
    "Nincs írásjogunk a szavazás zárolásához.";
}
sub This_poll_has_already_been_started { # title
    "Ez a szavazás ($_[1]) már elindult.";
}
sub No_write_access_to_start_poll {
    'nincs írásjogunk a szavazás indításához.';
}
sub Poll_does_not_exist_or_not_started {
    'Ez a szavazás nem létezik vagy még nem indult el.';
}
sub Your_voter_key_is_invalid__check_mail { # voter
   my $voter = $_[1];
   if ($voter ne '') {
    "A szavazási kulcsod hibás, $voter.
     A megfelelú URL-t emailben meg kellett volna kapnod.";
   } else {
    "A szavazási kulcsod hibás.
     A megfelelú URL-t emailben meg kellett volna kapnod.";
   }
}
sub Invalid_result_key { # key
    "Hibás kulcs az eredményhez: \"$_[1]\". A szavazás eredményének megtekintéséhez
    e-mailben kellett volna megkapd a megfelelő URL-t. Ez a hiba naplózva lett."
}
sub Invalid_control_key { # key
    "Hibás vezérlő kulcs. E-mailben kellett volna megkapd a megfelelő URL-t. Ez a hiba naplózva lett.";
}
sub Invalid_voting_key {
    "Hibás szavazó kulcs. E-mailben kellett volna megkapd a megfelelő URL-t. Ez a hiba naplózva lett.";
}
sub Invalid_poll_id {
    "Hibás szavazás azonosító";
}
sub Poll_id_not_valid { #id
    "A szavazás azonosítója (\"$_[1]\") hibás.";
}
sub Unable_to_append_to_poll_log {
    "Nem bírok a szavazás naplójához hozzáadni.";
}
sub Voter_v_already_authorized {
    "A szavazó (\"$_[1]\") már a névjegyzékben van.
     A szavazó kulcsát újraküldöm.";
}
sub Invalid_email_address_hdr { # addr
    "Hibás email cím";
}

sub Invalid_email_address { # addr
    "Hibás email cím: $_[1]";
}
sub Sending_mail_to_voter_v {
    "Levél küldése a szavazónak: \"$_[1]\"...";
}

sub CIVS_poll_supervisor {
    "\"$_[1], CIVS szavazásgazda\""
}

sub voter_mail_intro { #title, name, email_addr
"Egy szavazás indult a Condorcet Internetes Szavazási Szolgáltatásban <b>$_[1]</b> néven.
A szavazás gazdája felvett téged a szavazók jegyzékébe,
$_[2] (<a href=\"mailto:$_[3] ($_[2])\">$_[3]</a>).</p>";
}
sub Description_of_poll {
    "A szavazás leírása:";
}
sub if_you_would_like_to_vote_please_visit {
    'A szavazáshoz kérlek látogasd meg a következő webhelyet:';
}
sub This_is_your_private_URL {
'Ez a te személyes címed. Ne add oda senki másnek, mert akkor helyetted tudnának szavazni.';
}
sub Your_privacy_will_not_be_violated {
'A magánéletedet a szavazás nem sérti. A szavazási szolgáltatás már letörölte az e-mail címedet tartalmazó bejegyzést, és nem szolgáltat semmilyen információt arról, hogy szavaztál-e, és hogyan.';
}
sub This_is_a_nonanonymous_poll {
'A szavazás gazdája úgy döntött, hogy ez egy <strong>név szerinti szavazás</strong>. 
Ha szavazol, a szavazatod nyilvánosan látható lesz az e-mail címeddel együtt. Ha nem szavazol,
a szavazás gazdája azt is ki tudja deríteni.';
}

sub poll_has_been_announced_to_end { #election_end
    "A szavazás végének időpontja: $_[1].";
}

sub To_view_the_results_at_the_end {
    "A szavazás eredményének megtekintéséhez annak lezárása után a következő címet tekintsd meg:</p> $_[1]";
}

sub For_more_information {
  "A Condorcet Internetes Szavazási Szolgáltatásról további információkat a következő címen tuhatsz meg:\r\n$_[1]"
}


# close

sub CIVS_Ending_Poll {
    'CIVS: Szavazás befejezése';
}

sub Ending_poll {
    'Egy szavazás befejezése';
}
sub View_poll_results {
    'A szavazás eredményének megtekintése';
}
sub Poll_ended { #title
    return "Szavazás lezárult: $_[1]";
}

sub The_poll_has_been_ended { #election_end
    "A szavazás már lezárult. A szavazás vége a következő időpontra lett meghirdetve: $_[1].";
}

sub poll_results_available_to_authorized_users {
    'A szavazás eredménye a jogosult felhasználók számára már látható.';
}

sub was_not_able_stop_the_poll {
    'Nem bírom leállítani a szavazást.';
}


# results

sub CIVS_poll_result {
    "CIVS szavazás eredménye";
}
sub Poll_results { # title
    "A szavazás eredményei: $_[1]";
}

sub Writeins_currently_allowed {
    'Új lehetőségek hozzáadása most engedélyezett.';
}

sub Writeins_allowed {
    'Új lehetőségek hozzáadása engedélyezett.';
}
sub Writeins_not_allowed {
    'Write-in candidates are not allowed.';
}
sub Detailed_ballot_reporting_enabled {
    'Új lehetőségek hozzáadása nem engedélyezett.';
}
sub Detailed_ballot_reporting_disabled {
    'Részletes szavazatkimutatás letiltva.';
}
sub Voter_identities_will_be_kept_anonymous {
    'A szavazás titkos.';
}
sub Voter_identities_will_be_public {
    'A szavazás név szerinti. A szavazók e-mail címe publikálva lesz a szavazatukkal együtt.';
}
sub Condorcet_completion_rule {
    'Condorcet kifejtési szabály:';
}
sub undefined_algorithm {
    'Error: undefined algorithm.';
}
sub computing_results {
    'Eredmények kiszámítása...';
}
sub Supervisor { #name, email
    "A szavazás gazdája: $_[1] ($_[2])";
}
sub Announced_end_of_poll {
    "A szavazás lezárásának meghírdetett ideje: $_[1]";
}
sub Actual_time_poll_closed { # close time
    if ($_[1] == 0) {
	"A szavazás lezárásának valós ideje: $_[1]"
    } else {
	'A szavazás lezárásának valós ideje: <script>document.write(new Date(' .
	    $_[1] * 1000 . 
	    ').toLocaleString())</script>';
    }
}
sub Poll_not_ended {
    'A szavazás még nem zárult le.';
}
sub This_is_a_test_poll {
    'Ez egy teszt szavazás.';
}
sub This_is_a_private_poll { #num_auth
    "Privát szavazás ($_[1] szavazásra jogosult)";
}
sub This_is_a_public_poll {
    'Ez egy nyilvános szavazás.';
}

sub Actual_votes_cast { #num_votes
    "Leadott szavazatok száma: $_[1]";
}
sub Number_of_winning_candidates {
    'A győztes lehetőségek száma: ';
}
sub Poll_actually_has { #real_nwin
    my $winmsg = $_[1];
    "&nbsp;(A szavazásnak valójában $winmsg győztese van.)";
}
sub poll_description_hdr {
    'Szavazás leírása';
}
sub Ranking_result {
    'Rangsorolás eredménye';
}
sub x_beats_y { # x y w l 
    "$_[1] jobb mint $_[2] ($_[3]&ndash;$_[4])";
}
sub x_ties_y { # x y w l 
    "$_[1] és $_[2] holtversenyben van ($_[3]&ndash;$_[4])";
}
sub x_loses_to_y { # x y w l 
    "$_[1] rosszabb mint $_[2] ($_[3]&ndash;$_[4])";
}
sub some_result_details_not_shown {
    'Az egyszerűség kedvéért a szavazás eredményének néhány részletét nem mutatjuk.';
}
sub Show_details {
    'Részletek mutatása';
}
sub Hide_details {
    'Részletek elrejtése';
}
sub Result_details {
    'Az eredmény részletei';
}
sub Ballot_report {
    'Szavazat részletek';
}
sub Ballots_are_shown_in_random_order {
    "A szavazatokat véletlenszerű sorrendben mutatjuk.";
}
sub Download_ballots_as_a_CSV { # url
    "<a href=\"$_[1]\">Szavazatok letöltése</a> CSV-ként.";
}
sub No_ballots_were_cast {
    "Ebben a szavazásban nem szavazott senki.";
}
sub Ballot_reporting_was_not_enabled {
    "A szavazatok kimutatása ebben a szavazásban nem engedélyezett.";
}
sub Tied {
    "<i>Holtverseny</i>:";
}
sub loss_explanation { # loss_to, for, against
    ', gyengébb mint '. $_[1].' ennyivel: '. $_[2] .'&ndash;'. $_[3];
}
sub loss_explanation2 {
    '&nbsp;&nbsp;gyengébb mint '.$_[1].' ennyivel '. $_[2] .'&ndash;'. $_[3];
}
sub Condorcet_winner_explanation {
    '&nbsp;&nbsp;(Condorcet nyertes: minden más lehetőséggel szemben nyert)';
}
sub undefeated_explanation {
    '&nbsp;&nbsp;(Nem verte meg másik lehetőség.)';
}
sub Choices_shown_in_red_have_tied {
    "A pirossal jelölt lehetőségek holtversenyben vannak.
	Lehet hogy véletlenszerűen akarsz választani közülük.";
}
sub Condorcet_winner {
    "Condorcet nyertes";
}
sub Choices_in_individual_pref_order {
    'Lehetőségek (az egyéni preferencia sorrendjében)';
}

# rp

sub All_prefs_were_affirmed {
    'Minden preferencia megerősített.'
}

sub Presence_of_a_green_entry_etc {
    'A zöld bejegyzés léte az átló alatt
        (és a megfelelő vörös az átló felett)
        azt jelenti, hogy egy preferencia figyelmen kívül
        lett hagyva mert más, erősebb preferenciákkal ütközik.';
}
sub Random_tie_breaking_used {
'Ez a sorrend úgy alakult ki, hogy egy vagy több
holtversenyben véletlenszerű döntés született, a MAM algoritmus szerint.
Ez befolyásolhatta a lehetőségek sorrendjét.';
}
sub No_random_tie_breaking_used {
    'Nem volt szükség véletlenszerű döntésre ennek a sorrendnek az eléréséhez.';
}

1; # package succeeded!
