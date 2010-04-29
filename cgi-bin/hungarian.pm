package hungarian;

our @ISA = ('english'); # go to AmE module for missing methods

sub lang { return 'hu-HU'; }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub Condorcet_Internet_Voting_Service {
    return 'Condorcet Internet Szavazási Szolgáltatás';
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

# start

sub poll_started {
    return 'A <strong>'.$_[1].'</strong> szavazás elindult.';
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
sub start_poll {
    return 'Szavazás elindítása';
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

# vote

sub page_header_CIVS_Vote { # election_title
    return 'CIVS Szavazás: '.$_[1];
}

sub winners_text {
    if ($_[1] == 1) {
	return "Egy győztes van";
    } else {
	return "$num_winners győztes van";
    }
}
sub ballot_reporting_is_enabled {
    return 'A szavazatok kimutatása engedélyezve van ehhez a szavazáshoz.
	    A szavazatod (a választási lehetségekhez rendelt rangsorod)
	    nyilvános lesz amikor a szavazás lezárul.';
}
sub instructions1 { # winners_text, end, name, email
    return "Csak a $_[1] fogja megnyerni a szavazást.<p>
	    A szavazás vége: <b>$_[2]</b>.
	    A szavazás gazdája $_[3] (<tt>$_[4]</tt>).
	    Ha segítségre van szükséged, keresd a szavazás gazdáját.";
}
sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
    my ($no_opinion, my $prop, my $combined, my $civs_url) = @_;
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
	if ($proportional) {
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
	"<a href=\"$civs_url/proportional.html\">[További információk]</a>.</p>";
    }
    return $ret;
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
	sieresen leadva. A szavazói nyugtád kódja: ". code($_[2]).".";
}
sub name_of_writein_is_empty {
    return "A választási lehetőség neve üres";
}
sub writein_too_similar {
    return "Sajnáljuk, a választási lehetőség neve túlságosan hasonló egy már létezőhöz";
}

# results

1; # package succeeded!
