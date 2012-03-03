package spanish;

our $VERSION = 1.0;

use lib '@CGIBINDIR@';

use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

sub lang { 'es-ES' }

sub init { 
    my $self = {}; 
    bless $self; 
    return $self; 
}

# Civs_common 
sub Condorcet_Internet_Voting_Service { 
    'Internet Condorcet Servicio de Votación' 
}
sub Condorcet_Internet_Voting_Service_email_hdr {
    'Internet Condorcet Servicio de Votación' 
}
sub about_civs {
    "Sobre CIVS"; 
}
sub create_new_poll { 
    'Crear una nueva encuesta'; 
}
sub about_security_and_privacy { 
    "Acerca de la seguridad y la privacidad"; 
}
sub FAQ { 
    'Preguntas frecuentes'; 
}
sub CIVS_suggestion_box { 
    'CIVS buzón de sugerencias '; 
}
sub unable_to_process { 
    'CIVS no puede procesar su petición debido a un error interno. '; 
}
sub CIVS_Error { 
    'Error CIVS'; 
}
sub CIVS_server_busy { 
    'CIVS servidor ocupado '; 
}
sub Sorry_the_server_is_busy { 
    'Lo sentimos, el servidor web CIVS está muy ocupado en este momento y 
     no puede manejar más solicitudes. Por favor, inténtelo de nuevo un poco más tarde .'; 
}

# civs_create

sub mail_has_been_sent { 
    "El correo ha sido enviado a la dirección que nos ha facilitado (<tt>$_[1]</tt >)."; 
}

sub click_on_the_URL_to_start { 
    "Haga clic en la dirección que aparece en que el correo electrónico para iniciar la encuesta: <strong>$_[1]</strong>."
}

sub here_is_the_control_URL { 
    "Esta es la dirección para controlar la nueva encuesta. En funcionamiento normal 
             esto sería enviado al supervisor a través del correo electrónico."; 
}
sub the_poll_is_in_progress { 
    "La encuesta está en curso. Presione este botón para acabar con ella: "
}

sub CIVS_Poll_Creation { 
    "CIVS Encuesta"
}
sub Poll_created { 
    "Encuesta de creación: $_[1]" 
}

sub Address_unacceptable {#dir
    "La dirección de \"$_[1]\"no es aceptable"; 
}
sub Poll_must_have_two_choices { 
    'Una encuesta debe tener al menos dos opciones.'
}
sub Poll_directory_not_writeable { 
    "El directorio de la encuesta no se puede escribir"; 
}
sub CIVS_poll_created { 
 "CIVS encuesta ha sido creado: $_[1]"; 
}
sub creation_email_info1 { # title, url
    "Este correo electrónico reconoce la creación de una nueva encuesta, 
    $_[1]. Usted ha sido designado como el supervisor de esta 
    encuesta. Para iniciar y detener la encuesta, por favor use la siguiente URL: 
  $_[2]"
}
sub creation_email_public_link { # url
"Dado que es una encuesta pública, puedes dirigir a los votantes a la siguiente URL:

  $_[1] 

"; 
}
sub for_more_information_about_CIVS { # url
    "Para obtener más información acerca de la votación de Condorcet Internet Service, consulte
  $_[1]"
}

sub Sending_result_key { # addr
    "Enviando la clave de resultado a '$_[1]'";
}
sub Results_of_CIVS_poll { # title
    "Resultados de la encuesta CIVS: $_[1]";
}
sub Results_key_email_body { # title, url, civs_home
"Ha sido creada una nueva encuesta CIVS con nombre \"$_[1]\".
Usted ha sido designado como un usuario que está autorizado a ver el
resultado de esta encuesta.

Guarde este mensaje, si lo pierde no tendrá acceso a
los resultados. Una vez que la encuesta haya sido cerrada, los resultados estarán
disponibles en la siguiente URL:

  $_[2] 

Esta URL es privada. El acceso de usuarios no autorizados a esta 
URL les permitirá ver los resultados de la encuesta. 
Para obtener más información acerca de la votación de Condorcet Internet Service, consulte 
  $_[3] 

"; 
}
   
# Inicio 

sub poll_started { 
    'La encuesta <strong>'.$_[1].'</strong> se ha iniciado. '; 
}

# De control 

sub CIVS_Poll_Control { 
    "Encuesta de control CIVS"
}
sub Poll_control { 
    "Encuesta de control"
}
sub poll_has_not_yet_started { 
    "La encuesta no ha comenzado aún. Pulse este botón para empezar: "
}
sub Start_poll { 
    'Inicio de la encuesta'
}
sub End_poll { 
    'Fin de la encuesta'
}
sub ending_poll_cannot_be_undone { 
    'La finalización de una encuesta es una operación que no se puede deshacer. ¿Continuar?'; 
}
sub writeins_have_been_disabled { 
    'Se ha deshabilitado la escritura en las opciones'
}
sub disallow_further_writeins { 
    'No permitir más escrituras en las opciones'; 
}
sub voting_disabled_during_writeins {
    'El voto está desactivado durante la escritura en las opciones.'
}
sub allow_voting_during_writeins { 
    "Se permite votar durante la escritura en las opciones"; 
}
sub this_is_a_test_poll { 
    'Esta es una encuesta de prueba. '; 
}

sub poll_supervisor {# nombre, correo electrónico 
    "Supervisor de encuesta: $_[1] (<tt>$_[2]</tt>)"; 
}
sub no_authorized_yet {# esperando 
    "0 ($_[1] los votantes será autorizados cuando la encuesta se inicie)"; 
}
sub total_authorized_voters {# num_auth_string 
    "Total de votantes autorizados: $_[1]"; 
}
sub actual_votes_so_far {#numero 
    "Votos reales emitidos hasta la fecha: $_[1]"; 
}
sub poll_ends {# end 
    "La encuesta termina el $_[1]."; 
}
sub Poll_results_available_to_all_voters_when_poll_completes { 
    'Los resultados estarán a disposición de todos los votantes cuando se complete la encuesta. '; 
}
sub Voters_can_choose_No_opinion { 
    "Los votantes pueden elegir la opción no tengo opinión "; 
}
sub Voting_is_disabled_during_writeins { 
    "El voto está desactivado durante la escritura en las opciones"; 
}
sub Poll_results_will_be_available_to_the_following_users { 
    'Los resultados de la encuesta estarán disponibles sólo para los siguientes usuarios: '; 
}
sub Poll_results_are_now_available_to_the_following_users { 
    "Los resultados de la encuesta, que fueron enviados primero por correo electrónico,
 están ya disponibles sólo para los siguientes usuarios: "; 
}
sub results_available_to_the_following_users { 
    'Los resultados están disponibles sólo para los siguientes usuarios: '; 
}

sub Poll_results_are_available {#url
    "<a href=\"$_[1]\">Ver los resultados de la encuesta </a>"; 
}
sub Description { 
    'Descripción:'; 
}
sub Candidates { 
    'Los candidatos: '; 
}
sub Add_voters { 
    'Añadir votantes'
}

sub the_top_n_will_win {# num_winners 
    my $wintxt; 
    if ($_[1] == 1) { 
	$wintxt = "elección"; 
    } else { 
	$wintxt = "$_[1] opciones"; 
    } 
    return "El $wintxt superior va a ganar."; 
}

sub add_voter_instructions { 
    "Introduzca las direcciones de correo electrónico de los electores, uno por línea. Estos 
    pueden ser nuevos votantes o electores existentes que no han votado todavía. 
    En un sondeo privado, por lo que la dirección de correo electrónico de un votante ya 
    existente <strong>no permite</strong> el voto por segunda vez. Sólo se enviará al 
    votante una invitación a votar. En una encuesta pública, sólo un gesto simbólico, se hace para evitar 
    el voto múltiple. " 
}
sub Upload_file { 
    'Subir archivo:'; 
}
sub Load_ballot_data { 
    'Cargar datos de votación'; 
}
sub File_to_upload_ballots_from { 
    'Archivo para cargar las papeletas de: '; 
}
sub This_is_a_public_poll_plus_link { 
    my $url = $_[1]; 
    "Esta es una encuesta pública. Comparte el siguiente enlace 
    con los votantes para que puedan participar: </p> 
    <tt><a href=\"$url\">$url</a></tt>"; 
}
sub The_poll_has_ended { 
    'La encuesta ha terminado. '; 
}

# Añadir los votantes 

sub CIVS_Adding_Voters { 
    'CIVS: Añadir votantes'; 
}
sub Adding_voters { 
    "Añadir los votantes"; 
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress { 
    'Lo siento, los votantes sólo se pueden añadir a una encuesta en curso.'; 
}

sub Total_of_x_voters_authorized {# x 
    if ($_[1] == 0) { 
	'No hay votantes autorizados todavía. '; 
    } elsif ($_[1] == 1) { 
	'Sólo un votante autorizado a votar hasta ahora. '; 
    } else {
	"Hay un total de $_[1] votantes autorizados a participar."; 
    } 
}

sub Go_back_to_poll_control { 
    'Volver a la encuesta de control'; 
}
sub Done { 
    "Hecho."; 
}

# Voto 

sub page_header_CIVS_Vote {# election_title 
    'CIVS Votación:'.$_[ 1]; 
}

sub ballot_reporting_is_enabled { 
    'La presentación de informes está habilitada para esta encuesta. 
     Su cuestionario (la clasificación que se asigna a las opciones) 
     se hará público cuando se termine la encuesta. '
}
sub instructions1 {# num_winners, al final, el nombre, correo electrónico 
    my $wintxt; 
    if ($_[1] == 1) { 
	$wintxt = "única opción preferida"; 
    } else { 
	$wintxt ="$_[ 1] opciones preferidas "; 
    } 
    "Sólo el $wintxt ganará las elecciones. <p> 
    La encuesta termina <b>$_[2]</b>. 
    El supervisor de la encuesta es $_[3] (<tt>$_[4]</tt>). 
    Póngase en contacto con el supervisor de la encuesta si necesita ayuda. " 
}
sub instructions2 {# no_opinion, combined_ratings proporcional, civs_url 
    my ($self, $no_opinion, $apoyo, $combinado, $civs_url) = @ _; 
    my $ret; 
    if (! $prop || !$combinados) { 
	$Ret = "Dar a cada una de las siguientes opciones 
	una puntuación, donde un valor pequeño significa que usted 
	prefieren esa opción. 
	Por ejemplo, su mejor opción tendrá una puntuación de 1. 
	Puede dar opciones del mismo valor si no tiene 
	preferencia entre ellos. No tiene que utilizar todas las 
	filas posibles. Todas las opciones tienen, en principio la puntuación 
        más baja posible. ". $cr; 
    }
    if ($no_opinion) { 
	$ret .= "<b>Nota:</b> &ldquo;Sin opinión&rdquo;
	<i>no</i> es igual que la puntuación más baja posible, sino que significa 
	que optas por no calificar esta elección con respecto a la 
	otras opciones.</p>"; 
    } 
    if ($prop) { 
	$Ret .= "<p> En esta encuesta se decide usando un método experimental basado
	en Condorcet y diseñado para proporcionar una representación proporcional. Se
	supone por el algoritmo de votación que desea que la puntuación de 
	su opción <i> preferida para ganar </i> sea lo más alta posible, y si dos
	conjuntos de opciones coinciden sobre la elección que
	prefiere la mayoría, entonces decidirá entre ellos con su opción preferida,
	y así sucesivamente."; 
    } else {
	$Ret = '<p> Esta encuesta se decide usando un método experimental 
	basado en el algoritmo de Condorcet, diseñado para proporcionar una representación
	proporcional. 
	Por favor, otorgue a cada una de las opciones un 
	<b>peso</b> que expresa cuánto desea que esa
	elección forme parte del conjunto ganador. 
	Se supone por el algoritmo de votación que desea que
	la suma de pesos de las opciones ganadoras sea tan grande 
	como sea posible. Todas las opciones inicialmente 
	tienen una puntuación de cero, lo que significa que 
	no tiene ningún interés en ver a ninguna ganar. 
	Los pesos no pueden ser negativos o mayores que 999. 
	No ayudará hacer su peso más grande 
	que el de otros votantes, debido a que sus pesos sólo se comparan 
	uno contra el otro. '. 
	"<a Href=\"$civs_url/proportional.html\"> [Para más información] </a> </p>."; 
    } 
    return $ret; 
}
sub Rank {
    'Posición'; 
}
sub Choice { 
    'Elección'; 
}
sub Weight { 
    'Peso'; 
}

sub address_will_be_visible { 
    '<strong>Su dirección de correo electrónico será visible</strong> junto con su encuesta. '; 
}

sub ballot_will_be_anonymous { 
    'No obstante, su voto seguirá siendo anónimo: 
      ninguna información de identificación personal aparecerá.'; 
}

sub submit_ranking { 
    'Enviar'; 
}

sub only_writeins_are_permitted { 
    "El voto no esta todavía habilitado en esta encuesta. Sin embargo, 
    usted puede ver las opciones disponibles y escribir nuevas 
    opciones. Utilice el campo de texto de abajo para escribir en nuevas opciones." 
}

sub Add_writein { 
    'Añadir una opción '
}

sub to_top { 
    'Ir al principio'; 
}
sub to_bottom { 
    'Ir al final'; 
}
sub move_up { 
    'Subir'; 
}
sub move_down { 
    'Bajar'; 
}
sub make_tie { 
    'Hacer empatar';
}
sub buttons_are_deactivated { 
    "Estos botones están desactivados porque su navegador no soporta Javascript."; 
}
sub ranking_instructions { 
       'Clasifique las opciones en una de tres maneras: 
<ol> 
<li> arrastre las filas 
<li> use los desplegables
<li> seleccione filas y utilice los botones que hay arriba 
</ol> '; 
}

sub write_in_a_choice { 
    'Escribir en una nueva opción: '; 
}
sub if_you_have_already_voted {#url
    "Si ya ha votado, puede ver <a href=\"$_[1]\"> los resultados de la encuesta actual </a>." 
}
sub thank_you_for_voting {# título, el recibo 
    "Gracias. Su voto por <strong>$_[1]</strong> ha sido hecho correctamente. 
    Su recibo como votante es <code> $_[2] </code>. " 
}
sub name_of_writein_is_empty { 
    "El nombre de la opción está vacío"; 
}
sub writein_too_similar { 
    "Lo siento, el nombre de la opción en es demasiado similar a otra existente"; 
}

# Elecciones 

sub vote_has_already_been_cast { 
    "La votación ya se ha enviado con su clave de elector."; 
}
sub following_URL_will_report_results { 
    'La siguiente dirección URL informará de los resultados una vez que la encuesta termine: '; 
}
sub following_URL_reports_results { 
    "La siguiente URL informa de los resultados de la encuesta actual: "; 
}
sub Already_voted { 
    "Ya ha votado"; 
}
sub Error { 
    "Error"; 
}
sub Invalid_key { 
    "Clave no válida. Debería haber recibido una dirección URL correcta para 
        el control de la encuesta por correo electrónico. Este error se ha registrado ."; 
}
sub Authorization_failure { 
    "Error de autorización"; 
}

sub already_ended {# título 
    "Esta encuesta (<strong>$_[1]</strong>) ya se ha terminado."; 
}
sub Poll_not_yet_ended { 
    "La encuesta no ha terminado todavía"; 
}
sub The_poll_has_not_yet_been_ended {# title, nombre, correo electrónico 
    "Esta encuesta ($_[1]) aún no ha sido finalizada por su supervisor, $_[2] ($_[3])."; 
}
sub The_results_of_this_completed_poll_are_here { 
    "Los resultados de esta encuesta finalizada está aquí:"; 
}

sub No_write_access_to_lock_poll { 
    "No tienen permisos de escritura para bloquear la votación. "; 
}
sub This_poll_has_already_been_started {# título 
    "Esta encuesta ($_[1]) ya se ha iniciado."; 
}
sub No_write_access_to_start_poll { 
    "¿No tiene acceso de escritura para iniciar una encuesta. "; 
}
sub Poll_does_not_exist_or_not_started { 
    "Esta encuesta no existe o no se ha iniciado. "; 
}
sub Your_voter_key_is_invalid__check_mail {# votantes
   my $votantes = $_[1]; 
   if ($votantes ne '') { 
    "La clave de elector no es válido, $votantes. 
     Usted debería haber recibido una URL correcta por correo electrónico. " 
   } else { 
    "La clave de elector no es válido. Usted debe haber recibido una URL correcta por correo electrónico."; 
   } 
}
sub Invalid_result_key  {#tecla
    "Clave de resultado no válida: \"$_[1]\". Usted debería haber recibido una dirección URL correcta para 
        ver resultados de la encuesta por correo electrónico. Este error se ha registrado. " 
}
sub Invalid_control_key {# tecla
    "Clave de control no válida. Debería haber recibido una dirección URL correcta para el control de la
     encuesta por correo electrónico Este error se ha registrado."; 
}
sub Invalid_voting_key { 
    "Clave de votación no válida. Debería haber recibido una dirección URL correcta para la votación por correo electrónico. Este error se ha registrado."; 
}
sub Invalid_poll_id { 
    "Identificador de encuesta no válido"
}
sub Poll_id_not_valid {# Identificación 
    "El identificador de la encuesta \"$_[1]\" no es válido."
}
sub Unable_to_append_to_poll_log { 
    'No se puede añadir al registro de la votación.'
}
sub Voter_v_already_authorized { 
    "El votante \"$_[1]\" ya está autorizado. 
     La clave de elector se volverá a enviar al votante."
}
sub Invalid_email_address_hdr {# dir
    "Dirección de correo electrónico no válida"; 
}
sub Invalid_email_address {# dir
    "Dirección de correo electrónico no válida: $_[1]"; 
}
sub Sending_mail_to_voter_v { 
    "Enviando correo electrónico al votante \"$[1]\"..."; 
}
sub CIVS_poll_supervisor {#nombre
    "\"$_[1], el supervisor de la encuesta CIVS \"" 
}
sub voter_mail_intro {# título, nombre, EMAIL_ADDR 
"Una votación Condorcet por Internet llamada <b>$_[1]</b> se ha creado. 
Usted ha sido designado como elector por el supervisor de la votación, 
$_[2] (<a href=\"mailto:$_[3] ($_[2])\"> $_[3] </a >).</p> "; 
}
sub Description_of_poll { 
    'Descripción de la encuesta:'; 
}
sub if_you_would_like_to_vote_please_visit { 
    "Si usted quiere votar, por favor visite la siguiente dirección URL: "; 
}
sub This_is_your_private_URL { 
'Esta es su URL privada. No se lo dé a nadie más, porque podría utilizarla
para votar por usted.'; 
}
sub Your_privacy_will_not_be_violated { 
"Su privacidad no será violada por votar. El servicio de votación ya ha 
destruido el registro de su dirección de correo electrónico y no divulgará ninguna información 
acerca de usted o de cómo han votado."; 
}
sub This_is_a_nonanonymous_poll { 
"El supervisor de la encuesta ha decidido hacer de esto una <strong>encuesta no anónima</strong>. Si 
usted votar, su voto será visible al público junto con su 
dirección de correo electrónico."; 
}

sub poll_has_been_announced_to_end {# election_end 
    "La encuesta ha sido anunciada para finalizar el $_[1]."; 
}

sub To_view_the_results_at_the_end { 
    "Para ver los resultados de la encuesta una vez que ha terminado, visite: </p> $_[1]"; 
}

sub For_more_information { 
    "Para obtener más información acerca de la votación de Condorcet Internet Service, consulte: "; 
}

sub poll_email_subject {# título 
    "Encuesta: $_[1]" 
}

# Cerca 

sub CIVS_Ending_Poll { 
    'CIVS: Poner fin a la encuesta'; 
}

sub Ending_poll { 
    "Poner fin a una encuesta"; 
}
sub View_poll_results { 
    'Ver resultados de la encuesta'; 
}
sub Poll_ended {# título 
    "Encuesta finaliza: $_[1]"; 
}

sub The_poll_has_been_ended {# election_end 
    "La encuesta ha terminado, se anunció a finales $_[1].."; 
}

sub poll_results_available_to_authorized_users { 
    "Los resultados de la encuesta están disponibles para usuarios autorizados. "; 
}

sub was_not_able_stop_the_poll { 
    "No fue capaz de detener la encuesta"; 
}


# resultados

sub CIVS_poll_result { 
    "CIVS resultado de la encuesta"; 
}
sub Poll_results {#title
    "Resultados de la encuesta: $_[1]"; 
}

sub Writeins_currently_allowed { 
    "Añadir opciones está permitido."; 
}

sub Writeins_allowed { 
    "Añadir opciones está permitido."; 
}
sub Writeins_not_allowed { 
    "Añadir opciones no está permitido."; 
}
sub Detailed_ballot_reporting_enabled { 
    "El informe detallado de la votación está habilitado."; 
}
sub Detailed_ballot_reporting_disabled { 
    "El informe detallado de la votación no está habilitado."; 
}
sub Voter_identities_will_be_kept_anonymous { 
    "La identidad del votante se mantendrá anónima";
}
sub Voter_identities_will_be_public { 
    "La identidad del votante (correo electrónico) se hará pública asociada con su voto. "; 
}
sub Condorcet_completion_rule { 
    "La regla de Condorcet ejecución: "; 
}
sub undefined_algorithm { 
    'Error: algoritmo definido.'; 
}
sub computing_results { 
    'Resultados de Informática ...'; 
}
sub Supervisor {# nombre, correo electrónico 
    "Supervisor: $_[1] ($_[2])"; 
}
sub Announced_end_of_poll { 
    "Fin anunciado de la encuesta: $_[1]"; 
}
sub Actual_time_poll_closed {# tiempo de cierre 
    if ($_[1] == 0) { 
	"El tiempo real de cierre de la encuesta: $_[1]" 
    } else {
	'El tiempo real de cierre de la encuesta: <script>document.write (new Date ('.
	    ($_[1] * 1000) .
	') toLocaleString())</script>.' 
    } 
}
sub Poll_not_ended { 
    "La encuesta no ha terminado todavía."; 
}
sub This_is_a_test_poll { 
    "Esta es una encuesta de prueba. "; 
}
sub This_is_a_private_poll {# num_auth 
    "Esta es una encuesta privada para ($_[1] votantes autorizados)"; 
}
sub This_is_a_public_poll { 
    "Esta es una encuesta pública. "; 
}

sub Actual_votes_cast {# num_votes 
    "Votos emitidos reales: $_[1]"; 
}
sub Number_of_winning_candidates { 
    'Número de candidatos a ganar elecciones:'; 
}
sub Poll_actually_has {# winmsg 
    my $winmsg = '1 ganador'; 
    if ($_[1] != 1) { 
	$winmsg = $_[1].' ganadores'; 
    } 
    "(La encuesta tiene $winmsg)"; 
}
sub poll_description_hdr { 
    'Descripción de la encuesta '
}
sub Ranking_result { 
    'Resultado'
}
sub x_beats_y {# x l w 
    "$_[1] vence a $_[2], $_[3 ]-$_[ 4]"; 
}
sub x_ties_y {# x l w 
    "$_[1] empata con $_[2], $_[3 ]-$_[ 4]"; 
}
sub x_loses_to_y {# x l w 
    "$_[1] pierde con $_[2], $_[3 ]-$_[ 4]"; 
}
sub some_result_details_not_shown { 
    'Por razones de simplicidad, algunos detalles del resultado de la encuesta no se muestran. '
}
sub Show_details { 
    'Mostrar detalles'
}
sub Hide_details { 
    'Ocultar detalles'
}
sub Result_details { 
    'Detalles de los resultados'
}
sub Ballot_report { 
    'Informe del formulario'
}
sub Ballots_are_shown_in_random_order { 
    'Los formularios se muestran en un orden generado al azar.'; 
}
sub Download_ballots_as_a_CSV {# url
    "[<a href=\"$_[1]\"> descargue todo el formulario en formato CSV </a>]"
}
sub No_ballots_were_cast { 
    'No hay votos emitidos en esta encuesta.'
}
sub Ballot_reporting_was_not_enabled { 
    'El informe de los formularios no se ha habilitado para esta encuesta.'
}
sub Tied { 
    '<i>Empate</i>:'
}
sub loss_explanation {# loss_to, favor, en contra 
    ', pierde a ' . $_[1] . ' de ' . $_[2] . '-' . $_[3]; 
}
sub loss_explanation2 { 
    '&nbsp;&nbsp;pierde a '.$_[1].' por '.$_[2].'-'.$_[3]; 
}
sub Condorcet_winner_explanation { 
    '&nbsp;&nbsp;(Ganador de Condorcet: concursos gana con todas las otras opciones)'
}
sub undefeated_explanation { 
    '(No derrotado en ninguna contienda con otra opción)'
}
sub Choices_shown_in_red_have_tied { 
    "Las opciones que se muestran en rojo han empatado. 
	Si lo desea, para seleccionar entre ellos al azar. " 
}
sub Condorcet_winner { 
    "Condorcet ganador"; 
}
sub Choices_in_individual_pref_order { 
    "Las opciones (en orden de preferencia individual)";
}

sub What_is_this {# url
    '<a href="$_[1]."><small>. (¿Qué es esto) </small> </a>'; 
}

# rp

sub All_prefs_were_affirmed { 
    "Todas las preferencias se confirmaron. Todos los 
    los métodos de Condorcet estarán de acuerdo con este ranking."; 
}

sub Presence_of_a_green_entry_etc { 
    'La presencia de una entrada de verde por debajo de 
    la diagonal (y correspondiente rojo arriba) 
    significa que la preferencia fue ignorado porque 
    entraba en conflicto con otras preferencias, más fuertes.'; 
}
sub Random_tie_breaking_used { 
    "Su utilizó ruptura al azar de un empate para 
    llegar a este orden, de acuerdo con el algoritmo MAM.
    Esto puede haber afectado el orden de las opciones."; 
}
sub No_random_tie_breaking_used { 
    'No hubo ningún empate que romper al azar para llegar a esta clasificación. '; 
}

# beatpath

sub beatpath_matrix_explanation { 
    'La siguiente matriz muestra la fuerza del más fuerte 
    beatpath conecta cada par de opciones. La opción 1 se sitúa por encima de 
    opción 2, si hay un líder fuerte beatpath 1 a 2 
    que cualquier líder 2 a 1.'
}

sub no_pref { 
    'Ninguno' 
}

#rp

sub Some_voter_preferences_were_ignored { 
    'Algunas preferencias de los votantes fueron ignoradas, ya que hay
     conflicto con otras preferencias, más fuertes: ' 
}

sub preference_description { 
    "Los $_[1]-$_[2] preferencia por $_[3] de más de $_[4]." 
}

1; # package succeeded!
