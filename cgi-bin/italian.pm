package italian;

use lib '@CGIBINDIR@';
use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

sub lang { return 'it-IT'; }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub Condorcet_Internet_Voting_Service {
    'Servizio di voto Condorcet on-line (CIVS)';
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited 
    'Servizio di voto Condorcet on-line (CIVS)';
}
sub about_civs {
    'Informazioni su CIVS';
}
sub create_new_poll {
    'Crea una nuova votazione';
}
sub about_security_and_privacy {
    'Informazioni su sicurezza e privacy';
}
sub FAQ {
    'FAQ';
}
sub CIVS_suggestion_box {
    'Cassetta dei suggerimenti per CIVS';
}
sub unable_to_process {
    'Si è verificato un errore interno al sistema CIVS. La richiesta non è stata gestita.';
}
sub CIVS_Error {
    'Errore CIVS';
}
sub CIVS_server_busy {
    'Il server CIVS è occupato';
}
sub Sorry_the_server_is_busy {
    'Al momento il server CIVS è sovraccarico e non può
     gestire nuove richieste. Si prega di riprovare più tardi.';
}

# civs_create

sub mail_has_been_sent {
    "L'e-mail è stata inviata all'indirizzo fornito (<tt>$_[1]</tt>).";
}

sub click_on_the_URL_to_start {
    "Fare clic sul link fornito nell'e-mail per aprire la votazione: <strong>$_[1]</strong>.";
}

sub here_is_the_control_URL {
    'Questo è l\'indirizzo della pagina di controllo della votazione. Ordinariamente
             l\'indirizzo sarebbe inviato al supervisore tramite e-mail.';
}
sub the_poll_is_in_progress {
    'La votazione è in corso. Fare clic sul bottone per chiuderla: ';
}

sub CIVS_Poll_Creation {
    "Creazione votazione CIVS";
}
sub Poll_created {
    "Votazione creata: $_[1]";
}

sub Address_unacceptable { #addr
    "L'indirizzo \"$_[1]\" non è valido";
}
sub Poll_must_have_two_choices {
    'Una votazione deve riguardare almeno due alternative.';
}
sub Poll_directory_not_writeable {
    "Impossibile scrivere nella directory della votazione";
}
sub CIVS_poll_created {
 "Votazione CIVS creata: $_[1]";
}
sub creation_email_info1 { # title, url
"È stata creata una nuova votazione, $_[1]. Sei stato designato 
come supervisore di questa votazione.
Per aprire o chiudere la votazione, utilizzare il seguente link:

  $_[2]

";
}
sub creation_email_public_link { # url
"Questa è una votazione pubblica. Inviare agli elettori il seguente link:

  $_[1]

";
}
sub for_more_information_about_CIVS { # url
"Per maggiori informazioni sul servizio di voto Condorcet on-line:
  $_[1]";
}

sub Sending_result_key { # addr
    "Invio della chiave per i risultati a '$_[1]'";
}
sub Results_of_CIVS_poll { # title
    "Risultati della votazione CIVS: $_[1]";
}
sub Results_key_email_body { # title, url, civs_home
"È stata creata la votazione \"$_[1]\".
Ti è stato dato il permesso di visualizzare i risultati della votazione.

Si consiglia di salvare questa e-mail. Senza il link seguente non sarà
possibile accedere ai risultati. Al termine della votazione, i risultati
saranno disponibili al seguente indirizzo:

  $_[2]

Questo indirizzo va mantenuto riservato. Evitare che utenti non autorizzati
vengano a conoscenza dell'indirizzo della pagina dei risultati.

Per maggiori informazioni sul servizio di voto Condorcet on-line:
  $_[3]

";
}
  
# start

sub poll_started {
    'La votazione <strong>'.$_[1].'</strong> è stata aperta.';
}

# control

sub CIVS_Poll_Control {
    "Gestione votazione CIVS";
}
sub Poll_control {
    "Gestione votazione";
}
sub poll_has_not_yet_started {
    'Questa votazione non è ancora aperta. Fare clic sul bottone per avviarla: ';
}
sub Start_poll {
    'Apri votazione';
}
sub End_poll {
    'Chiudi votazione';
}
sub ending_poll_cannot_be_undone {
    'La chiusura di una votazione è un\'operazione che non può essere annullata. Continuare?';
}
sub writeins_have_been_disabled {
    'L\'inserimento di ulteriori candidature da parte degli elettori è disabilitato';
}
sub disallow_further_writeins {
    'L\'inserimento di ulteriori candidature da parte degli elettori è stato disabilitato';
}
sub voting_disabled_during_writeins {
    'Non è possibile votare durante la fase di inserimento di ulteriori candidature da parte degli elettori.';
}
sub allow_voting_during_writeins {
    "Permetti il voto durante la fase di inserimento di ulteriori candidature da parte degli elettori";
}
sub this_is_a_test_poll {
    'Questa è una votazione di prova.';
}

sub poll_supervisor { # name, email
    "Supervisore della votazione: $_[1] (<tt>$_[2]</tt>)";
}
sub no_authorized_yet { #waiting
    "0 ($_[1] elettori saranno autorizzati al momento dell'apertura della votazione)";
}
sub total_authorized_voters { # num_auth_string
    "Totale elettori autorizzati: $_[1]";
}
sub actual_votes_so_far { # num
    "Voti espressi finora: $_[1]";
}
sub poll_ends { # end
    "Termine della votazione: $_[1].";
}
sub Poll_results_available_to_all_voters_when_poll_completes {
    'Al termine della votazione, i risultati saranno disponibili a tutti gli elettori.';
}
sub Voters_can_choose_No_opinion {
    'È ammesso il voto per &ldquo;Nessuna opinione&rdquo;';
}
sub Voting_is_disabled_during_writeins {
    'Non è possibile votare durante la fase di inserimento di ulteriori candidature da parte degli elettori.';
}
sub Poll_results_will_be_available_to_the_following_users {
    'I risultati della votazione saranno disponibili solo ai seguenti utenti:';
}
sub Poll_results_are_now_available_to_the_following_users {
    'I risultati della votazione saranno disponibili solo ai seguenti utenti,
	    a cui è stata inviata una e-mail contenente l\'indirizzo della
	     pagina dei risultati:';
}
sub results_available_to_the_following_users {
    'I risultati di questa votazione sono noti solo ai seguenti utenti:';
}

sub Poll_results_are_available { #url
    "<a href=\"$_[1]\">Mostra risultati</a>";
}
sub Description {
    'Descrizione:';
}
sub Candidates {
    'Candidati:';
}
sub Add_voters {
    'Aggiungi elettori';
}

sub the_top_n_will_win { # num_winners
    if ($_[1] == 1) {
	return "Risulterà vincitore il primo classificato";
    } else {
	$wintxt = "Risulteranno vincitori i primi $_[1] classificati";
    }
}

sub add_voter_instructions {
    "Inserire gli indirizzi e-mail degli elettori, uno per riga. È
    possibile inserire nuovi votanti o inviare un sollecito a elettori 
    registrati che non hanno ancora votato.
    Per un'elezione privata, inviare un sollecito <strong>non</strong> 
    permetterà all'elettore di votare più volte.
    Nelle elezioni pubbliche non è tecnicamente possibile proibire 
    il voto multiplo.";
}
sub Upload_file {
    'Caricare un file: ';
}
sub Load_ballot_data {
    'Caricamento voti da file';
}
sub File_to_upload_ballots_from {
    'File da cui caricare i voti:';
}
sub This_is_a_public_poll_plus_link {
    my $url = $_[1];
    "Questa è un'elezione pubblica. La pagina di voto
     è all'indirizzo:</p><p>
	&nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>
	</p><p>Inviare il link a tutti gli elettori";
}
sub The_poll_has_ended {
    'La votazione è terminata.';
}

# add voters

sub CIVS_Adding_Voters {
    'CIVS: Aggiunta elettori';
}
sub Adding_voters {
    'Aggiunta elettori';
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
    'Non è possibile aggiungere elettori a una votazione in corso.';
}

sub Total_of_x_voters_authorized { # x
    if ($_[1] == 0) {
	"Nessun elettore registrato.";
    } elsif ($_[1] == 1) {
	"C'è un solo elettore registrato.";
    } else {
	"$_[1] elettori registrati.";
    }
}

sub Go_back_to_poll_control {
    'Torna alla pagina di gestione della votazione';
}
sub Done {
    'Fatto.';
}

# vote

sub page_header_CIVS_Vote { # election_title
    'Votazione CIVS: '.$_[1];
}

sub winners_text {
    if ($_[1] == 1) {
	return "un solo vincitore";
    } else {
	return "$num_winners vincitori";
    }
}
sub ballot_reporting_is_enabled {
    'È stato abilitato il voto palese.
     La tua scheda (il punteggio assegnato ai candidati)
     sarà resa pubblica al termine della votazione.';
}
sub instructions1 { # winners_text, end, name, email
    "Questa elezione avrà $_[1].<p>
	    Termine della votazione: <b>$_[2]</b>.
	    Supervisore della votazione: $_[3] (<tt>$_[4]</tt>).
	    Contattare il supervisore in caso di problemi.";
}
sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
    my ($self, $no_opinion, my $prop, my $combined, my $civs_url) = @_;
    my $ret;
    if (!$prop || !$combined) {
	$ret = "Classifica tutte le scelte disponibili in base
        alla tua preferenza. Numeri minori corrispondono a posizioni
        più alte in classifica.
        Puoi creare dei \"pari merito\" impostando la stessa posizione
        in classifica per più scelte. Puoi anche saltare posizioni.
        Inizialmente tutti i candidati sono alla pari in ultima posizione. ". $cr;
	if ($no_opinion) {
	    $ret .= '<b>Nota: votare </b> "Nessuna opinione"
		    <i>non</i> non è la stessa cosa di assegnare l\'ultima 
		    posizione in classifica. Significa non si vuole favorire
		    o sfavorire in alcun modo il candidato rispetto agli altri.</p>';
	}
	if ($proportional) {
	    $ret .= '<p>L\'esito di questa votazione sarà deciso tramite un metodo
	    sperimentale che cerca di fornire una rappresentazione proporzionale.
	    Tra due insiemi di candidati, si assume che tu voglia
	    It is assumed
	    by the voting algorithm that you want the ranking of your most
	    preferred <i>winning</i> choice to be as high as possible, and if two
	    sets of winning choices agree on the choice you prefer most, then you
	    would decide between them using the second most preferred choice, and
	    so on. ';
	}
    } else {
	$ret = '<p>L\'esito di questa votazione sarà deciso tramite un metodo
	sperimentale che cerca di fornire una rappresentazione proporzionale.
	Per ogni candidato inserire un <b>peso</b> (un indice di gradimento) che 
	esprima quanto fortemente si vuole che il candidato faccia parte 
	dell\'insieme dei vincitori.
	Si assume che tu voglia che la somma dei pesi dei vincitori sia la più
	grande possibile.
	Inizialmente tutte le scelte hanno peso pari a zero. Un peso nullo 
	significa che non si ha interesse a veder vincere il candidato.
	I pesi devono essere compresi tra 0 e 999.
	Non importa che i propri pesi siano più alti di quelli degli altri
	elettori, i confronti saranno fatti solo all\'interno della propria
	scheda.'.
	"<a href=\"$civs_url/proportional.html\">[Maggiori informazioni]</a>.</p>";
    }
    return $ret;
}
sub Rank {
    'Posizione';
}
sub Choice {
    'Scelta';
}
sub Weight {
    'Peso';
}

sub address_will_be_visible {
    "<strong>Il tuo indirizzo e-mail sarà visibile </strong> insieme con la scheda.";
}

sub ballot_will_be_anonymous {
    ' Tuttavia, la scheda sarà anonima:
      non comparirà alcuna informazione identificativa.';
}

sub submit_ranking {
    'Invia la classifica';
}

sub only_writeins_are_permitted {
    'Non è ancora permesso votare in questa elezione. Tuttavia,
             è possibile vedere le scelte possibili ed aggiungerne di nuove.
	     Utilizzare la casella di testo sottostante per aggiungere nuovi candidati.';
}

sub to_top {
    'porta in cima';
}
sub to_bottom {
    'porta in fondo';
}
sub move_up {
    'sposta su';
}
sub move_down {
    'sposta giù';
}
sub make_tie {
    'imposta pari';
}
sub buttons_are_deactivated {
    'I bottoni non funzioneranno,
	il tuo browser non supporta Javascript.';
}
sub ranking_instructions {
       'Ordinare le scelte possibili:
	<ol>
	    <li>trascinando le righe
	    <li>utilizzando le caselle nella colonna Posizione
	    <li>selezionando una riga e utilizzando i bottoni
	</ol>';
}

sub write_in_a_choice {
    'Aggiungi una scelta: ';
}
sub if_you_have_already_voted { #url
    "Se hai già votato, puoi visualizzare
	<a href=\"$_[1]\">i risultati parziali</a>.";
}
sub thank_you_for_voting { #title, receipt
    "Grazie. Il tuo voto per <strong>$_[1]</strong> è
	stato registrato con successo. Il tuo codice di verifica del voto è <code>$_[2]</code>.";
}
sub name_of_writein_is_empty {
    "Il nome della scelta da aggiungere è vuoto.";
}
sub writein_too_similar {
    "Il nome dell\'aggiunta proposta è troppo simile a una delle scelte già registrate";
}

# election

sub vote_has_already_been_cast {
    "È già stato espresso un voto con le credenziali fornite.";
}
sub following_URL_will_report_results {
    'Al termine della votazione, i risultati saranno disponibili all\'indirizzo:';
}
sub following_URL_reports_results {
    'I risultati attuali sono disponibili all\'indirizzo:';
}
sub Already_voted {
    'Già votato';
}
sub Error {
    'Errore';
}
sub Invalid_key {
    'Chiave errata. L\'indirizzo corretto per la gestione della
        votazione dovrebbe essere stato inviato via e-mail. Questo errore è stato registrato.';
}
sub Authorization_failure {
    'Autorizzazione fallita';
}

sub already_ended { # title 
    "Questa votazione (<strong>$_[1]</strong>) è già terminata.";
}
sub Poll_not_yet_ended {
    "La votazione non è ancora terminata";
}
sub The_poll_has_not_yet_been_ended { #title, name, email
    "Questa votazione ($_[1]) non è ancora stata terminata dal supervisore,
    $_[2] ($_[3]),";
}
sub The_results_of_this_completed_poll_are_here {
    'La votazione è terminata e i risultati sono disponibili all\'indirizzo:';
}

sub No_write_access_to_lock_poll {
    "Non si dispone dei diritti di scrittura necessari per acquisire il lock sulla votazione.";
}
sub This_poll_has_already_been_started { # title
    "Questa votazione ($_[1]) è già cominciata.";
}
sub No_write_access_to_start_poll {
    'Non si dispone dei diritti di scrittura necessari per avviare una votazione.';
}
sub Poll_does_not_exist_or_not_started {
    'Questa votazione non esiste o non è ancora cominciata.';
}
sub Your_voter_key_is_invalid__check_mail { # voter
   my $voter = $_[1];
   if ($voter ne '') {
    "La tua chiave di voto non è valida, $voter.
     L'indirizzo corretto dovrebbe essere stato inviato via e-mail.";
   } else {
    "La tua chiave di voto non è valida. L'indirizzo corretto dovrebbe essere stato inviato via e-mail.";
   }
}
sub Invalid_result_key { # key
    "Chiave risultati non valida: \"$_[1]\". L'indirizzo corretto per la visualizzazione dei risultati dovrebbe 
    essere stato inviato via e-mail. Questo errore è stato registrato.";
}
sub Invalid_control_key { # key
    "Chiave di gestione non valida: \"$_[1]\". L'indirizzo corretto per la gestione della votazione dovrebbe 
    essere stato inviato via e-mail. Questo errore è stato registrato.";
}
sub Invalid_voting_key {
    "Chiave di voto non valida: \"$_[1]\". L'indirizzo corretto per la pagina di voto dovrebbe 
    essere stato inviato via e-mail. Questo errore è stato registrato.";
}
sub Invalid_poll_id {
    "Identificatore di votazione non valido";
}
sub Poll_id_not_valid { #id
    "L'identificatore di votazione \"$_[1]\" non è valido.";
}
sub Unable_to_append_to_poll_log {
    "Impossibile scrivere nel registro della votazione.";
}
sub Voter_v_already_authorized {
    "L'elettore \"$_[1]\" è già autorizzato a votare.
     Sarà rimandata la chiave di voto.";
}
sub Invalid_email_address_hdr { # addr
    "Indirizzo e-mail non valido";
}
sub Invalid_email_address { # addr
    "Indirizzo e-mail non valido: $_[1]";
}
sub Sending_mail_to_voter_v {
    "Invio e-mail a \"$_[1]\"...";
}
sub CIVS_poll_supervisor {
    "\"$_[1], Supervisiore della votazione CIVS\""
}
sub voter_mail_intro { #title, name, email_addr
"Una votazione di nome <b>$_[1]</b> è stata creata nel sistema di voto Condorcet on-line (CIVS).
Sei stato designato come supervisore della votazione,
$_[2] (<a href=\"mailto:$_[3] ($_[2])\">$_[3]</a>).</p>";
}
sub Description_of_poll {
    'Descrizione della votazione:';
}
sub if_you_would_like_to_vote_please_visit {
    'Per votare, visitare la pagina al seguente indirizzo:';
}
sub This_is_your_private_URL {
'Questo indirizzo contiene le tue credenziali personali per il voto. 
Mantienilo privato, altrimenti altri potrebbero votare al tuo posto';
}
sub Your_privacy_will_not_be_violated {
'La tua privacy non sarà compromessa in alcun modo dal voto. Il sistema
di voto non ha mantenuto alcuna informazione che permetta di risalire al
tuo indirizzo e-mail. Non sarà quindi rintracciabile né il tuo voto né
una tua eventuale astensione.';
}
sub This_is_a_nonanonymous_poll {
'Questa è una <strong>votazione non anonima (voto palese)</strong>. Se
voterai, la tua scheda sarà visibile, insieme al tuo indirizzo e-mail.
L\'astensione sarà indirettamente rilevabile da chi avesse una lista
delle persone autorizzate al voto.';
}

sub poll_has_been_announced_to_end { #election_end
    "Termine annunciato per l'elezione: $_[1].";
}

sub To_view_the_results_at_the_end {
    "Al termine della votazione, i risultati saranno disponibili all\'indirizzo:</p>
     $_[1]";
}

sub For_more_information {
'Per maggiori informazioni sul servizio di voto Condorcet on-line (CIVS):';
}


# close

sub CIVS_Ending_Poll {
    'CIVS: Chiusura votazione';
}

sub Ending_poll {
    'Chiusura votazione';
}
sub View_poll_results {
    'Visualizzare_risultati_votazione';
}
sub Poll_ended { #title
    "Votazione chiusa: $_[1]";
}

sub The_poll_has_been_ended { #election_end
    "La votazione è stata chiusa. La chiusura era stata annunciata per $_[1].";
}

sub poll_results_available_to_authorized_users {
    'Gli utenti autorizzati potranno ora visulizzare i risultati.';
}

sub was_not_able_stop_the_poll {
    'Impossibile chiudere la votazione';
}


# results

sub CIVS_poll_result {
    "Risultati votazione CIVS";
}
sub Poll_results { # title
    "Risultati votazione: $_[1]";
}

sub Writeins_currently_allowed {
    'È attualmente permessa l\'aggiunta di candidati da parte degli elettori.';
}

sub Writeins_allowed {
    'È permessa l\'aggiunta di candidati da parte degli elettori.';
}
sub Writeins_not_allowed {
    'Non è permessa l\'aggiunta di candidati da parte degli elettori.';
}
sub Detailed_ballot_reporting_enabled {
    'La visualizzazione dettagliata delle schede è abilitata.';
}
sub Detailed_ballot_reporting_disabled {
    'La visualizzazione dettagliata delle schede non è abilitata.';
}
sub Voter_identities_will_be_kept_anonymous {
    'Le identità dei votanti saranno mantenute anonime.';
}
sub Voter_identities_will_be_public {
    'L\'indentità del votante (indirizzo e-mail) sarà pubblicamente visibile insieme con la scheda.';
}
sub Condorcet_completion_rule {
    'Metodo di completamento di Condorcet:';
}
sub undefined_algorithm {
    'Errore: algoritmo non definito.';
}
sub computing_results {
    'Calcolo dei risultati in corso...';
}
sub Supervisor { #name, email
    "Supervisore: $_[1] ($_[2])";
}
sub Announced_end_of_poll {
    "Termine annunciato della votazione: $_[1]";
}
sub Actual_time_poll_closed { # close time
    if ($_[1] == 0) {
	"Effettiva chiusura della votazione: $_[1]"
    } else {
	'Effettiva chiusura della votazione: <script>document.write(new Date(' .
	    $_[1] * 1000 . 
	    ').toLocaleString())</script>';
    }
}
sub Poll_not_ended {
    'La votazione non è ancora terminata.';
}
sub This_is_a_test_poll {
    'Questa è una votazione di prova.';
}
sub This_is_a_private_poll { #num_auth
    "Votazione privata ($_[1] elettori autorizzati)";
}
sub This_is_a_public_poll {
    'Questa è una votazione pubblica.';
}

sub Actual_votes_cast { #num_votes
    "Voti espressi: $_[1]";
}
sub Number_of_winning_candidates {
    'Numero di candidati vincitori: ';
}
sub Poll_actually_has { #winmsg
    my $winmsg = '1 vincitore';
    if ($_[1] != 1) {
	$winmsg = ''.$_[1].' vincitori';
    }
    "&nbsp;(la votazione ha effettivamente avuto $winmsg)";
}
sub poll_description_hdr {
    'Descrizione della votazione';
}
sub Ranking_result {
    'Ranking result';
}
sub x_beats_y { # x y w l 
    "$_[1] batte $_[2] $_[3]&ndash;$_[4]";
}
sub x_ties_y { # x y w l 
    "$_[1] pareggia con $_[2] $_[3]&ndash;$_[4]";
}
sub x_loses_to_y { # x y w l 
    "$_[1] perde contro $_[2] $_[3]&ndash;$_[4]";
}
sub some_result_details_not_shown {
    'Per semplicità, alcuni dettagli sui risultati dell\'elezione sono nascosti.';
}
sub Show_details {
    'Mostra dettagli';
}
sub Hide_details {
    'Nascondi dettagli';
}
sub Result_details {
    'Dettagli risultato';
}
sub Ballot_report {
    'Dettagli schede';
}
sub Ballots_are_shown_in_random_order {
    "Le schede sono visualizzate in ordine casuale.";
}
sub Download_ballots_as_a_CSV { # url
    "<a href=\"$_[1]\">Scarica i voti</a> come CSV";
}
sub No_ballots_were_cast {
    "Nessun voto è stato espresso per questa votazione.";
}
sub Ballot_reporting_was_not_enabled {
    "La visualizzazione dei dettagli delle schede non era abilitata per questa votazione.";
}
sub Tied {
    "<i>Pareggio</i>:";
}
sub loss_explanation { # loss_to, for, against
    ', perde contro '. $_[1].' per '. $_[2] .'&ndash;'. $_[3];
}
sub loss_explanation2 {
    '&nbsp;&nbsp;perde contro '.$_[1].' per '.$_[2].'&ndash;'.$_[3];
}
sub Condorcet_winner_explanation {
    '&nbsp;&nbsp;(Vincitore di Condorcet: vince contro tutte le altre opzioni)';
}
sub undefeated_explanation {
    '&nbsp;&nbsp;(Non sconfitto in alcuna sfida con altre opzioni)';
}
sub Choices_shown_in_red_have_tied {
    "Le opzioni in rosso sono in pari.
	Si consiglia di scegliere a caso tra di esse.";
}
sub Condorcet_winner {
    'Vincitore di Condorcet';
}
sub Choices_in_individual_pref_order {
    'Scelte (in ordine di preferenza individuale)';
}

# rp

sub All_prefs_were_affirmed {
    'Tutte le preferenze calcolate sono acicliche.
    Ogni metodo Condorcet concorderebbe su questa classifica.';
}

sub Presence_of_a_green_entry_etc {
    'La presenza di una casella varde al di sotto della diagonale
        (e di una casella rossa corrispondente al di sopra)
	significa che una preferenza è stata ignorata poiché
	era in conflitto con altre preferenze più forti.';
}
sub Random_tie_breaking_used {
    'Per ottenere questa classifica sono stati utilizzati degli spareggi
    casuali (algoritmo MAM). La particolare scelta degli spareggi può
    avere effetto sulla classifica.';
}
sub No_random_tie_breaking_used {
    'Non è stato necessario ricorrere a spareggi casuali.';
}

1;
