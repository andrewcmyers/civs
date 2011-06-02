package spanish;

our $VERSION = 1.0;

use lib '@CGIBINDIR@';

use english;
our @ISA = ('english'); # go to AmE module for missing methods

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
    "Haga clic en la dirección en que el correo electrónico para iniciar la encuesta: <strong>$_[1]</strong>."
}

sub here_is_the_control_URL { 
    "Aquí está la dirección para controlar la nueva encuesta. En funcionamiento normal 
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
"Because this is a public poll, you may direct voters to the following URL:

  $_[1] 

"; 
}
sub for_more_information_about_CIVS { # url
    "Para obtener más información acerca de la votación de Condorcet Internet Service, consulte
  $_[1]"
}

sub Sending_result_key { # addr
    "Sending result key to '$_[1]'";
}
sub Results_of_CIVS_poll { # title
    "Results of CIVS poll: $_[1]";
}
sub Results_key_email_body { # title, url, civs_home
"Una nueva encuesta CIVS ha sido creado con nombre \"$_[1]\".
Usted ha sido designado como un usuario que está autorizado a ver las
resultado de esta encuesta.

Guardar este mensaje. Si lo pierde no tendrá acceso a
los resultados. Una vez que la encuesta ha sido cerrada, los resultados serán
disponible en la siguiente URL:

  $_[2] 

Esta URL es privada. Permitir el acceso de usuarios no autorizados a esta 
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
    "CIVS control encuesta"
}
sub Poll_control { 
    "Encuesta de control"
}
sub poll_has_not_yet_started { 
    "La encuesta no ha comenzado todavía. Pulse este botón para empezar: "
}
sub Start_poll { 
    'La encuesta de Inicio '
}
sub End_poll { 
    'La encuesta final'
}
sub ending_poll_cannot_be_undone { 
    'Finalización de una encuesta es una operación que no se puede deshacer. Continuar?'; 
}
sub writeins_have_been_disabled { 
    'Escribir-en las opciones han sido con discapacidad'
}
sub disallow_further_writeins { 
    'No permitir más escribir-ins '; 
}
sub voting_disabled_during_writeins {
    'El voto es desactivado durante la escritura en fase.'
}
sub allow_voting_during_writeins { 
    "Permitir a los votantes durante la escritura-en fase"; 
}
sub this_is_a_test_poll { 
    'Esta es una encuesta de prueba. '; 
}

sub poll_supervisor {# nombre, correo electrónico 
    "Encuesta supervisor: $_[1] (<tt>$_[2]</tt>)"; 
}
sub no_authorized_yet {# esperando 
    "0 ($_[1] los votantes será autorizado cuando la encuesta se inicia)"; 
}
sub total_authorized_voters {# num_auth_string 
    "Total de votantes autorizados: $_[1]"; 
}
sub actual_votes_so_far {#numero 
    "Votos reales emitidos hasta la fecha: $_[1]"; 
}
sub poll_ends {# end 
    "Encuesta termina $_[1]."; 
}
sub Poll_results_available_to_all_voters_when_poll_completes { 
    'Resultados de la encuesta a disposición de todos los votantes, cuando la encuesta completa. '; 
}
sub Voters_can_choose_No_opinion { 
    "Los votantes pueden elegir la opción no tengo opinión "; 
}
sub Voting_is_disabled_during_writeins { 
    "El voto es desactivado durante la escritura en el período."; 
}
sub Poll_results_will_be_available_to_the_following_users { 
    'Resultados de la encuesta estarán disponibles sólo para los siguientes usuarios: '; 
}
sub Poll_results_are_now_available_to_the_following_users { 
    "Resultados de la encuesta están disponibles sólo para los siguientes usuarios, 
que fueron enviados a principios de un correo electrónico con una dirección 
Ver resultados: "; 
}
sub results_available_to_the_following_users { 
    'Los resultados de esta encuesta han sido puestos en libertad sólo a un conjunto limitado de usuarios: '; 
}

sub Poll_results_are_available {#url
    "<a href=\"$_[1]\">Ver resultados de la encuesta </a>"; 
}
sub Description { 
    'Descripción:'; 
}
sub Candidates { 
    'Los candidatos: '; 
}
sub Add_voters { 
    'Añadir los votantes'
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
    En un sondeo privado, lo que la dirección de correo electrónico de un ya 
    existentes <strong>votante no</strong> permiten que el voto de los votantes en dos ocasiones. 
    Sólo se volverá a enviar al votante una invitación a votar. 
    En una encuesta pública, sólo un gesto simbólico, se hace para evitar 
    voto múltiple. " 
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
    "Esta es una encuesta pública. Compartir el siguiente enlace 
    con los votantes para que puedan votar: </p> 
    <tt><a href=\"$url\">$url</a></tt>"; 
}
sub The_poll_has_ended { 
    'La encuesta ha terminado. '; 
}

# Añadir los votantes 

sub CIVS_Adding_Voters { 
    'CIVS: Agregar los votantes'; 
}
sub Adding_voters { 
    "Adición de los votantes"; 
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress { 
    'Lo siento, sólo los votantes pueden agregar a una encuesta en curso.'; 
}

sub Total_of_x_voters_authorized {# x 
    if ($_[1] == 0) { 
	'No los votantes autorizados a votar todavía. '; 
    } elsif ($_[1] == 1) { 
	'Sólo un votante autorizado a votar hasta ahora. '; 
    } else {
	"Total de $_[1] los votantes autorizados a votar."; 
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
    'Presentación de informes de boleta está habilitado para esta encuesta. 
     Su boleta (la clasificación que se asigna a las opciones) 
     se harán públicos cuando se termina la encuesta. '
}
sub instructions1 {# num_winners, al final, el nombre, correo electrónico 
    my $wintxt; 
    if ($_[1] == 1) { 
	$wintxt = "opción preferida único"; 
    } else { 
	$wintxt ="$_[ 1] opciones preferidas "; 
    } 
    "Sólo el $wintxt $ganará las elecciones. <p> 
    La encuesta termina <b>$_[2]</b>. 
    El supervisor de la encuesta es de $_[3] (<tt>$_[4]</tt>). 
    Póngase en contacto con el supervisor de la encuesta si necesita ayuda. " 
}
sub instructions2 {# no_opinion, combined_ratings proporcional, civs_url 
    my ($self, $no_opinion, $apoyo, $combinado, $civs_url) = @ _; 
    my $ret; 
    if (! $prop || !$combinados) { 
	$Ret = "Dar a cada uno de las siguientes opciones 
	un rango, donde un pequeño rango de número significa que usted 
	prefieren que la elección más. 
	Por ejemplo, dar su mejor opción el rango 1. 
	Dar opciones del mismo valor si no tiene 
	preferencia entre ellos. Usted no tiene que utilizar todos los 
	filas posibles. Todas las opciones tienen, en principio la 
	rango más bajo posible. ". $cr; 
    }
    if ($no_opinion) { 
	$ret .= "<b>Nota:</b> &ldquo;No opinion&rdquo;
	<i>no</i> es el mismo que el rango más bajo posible, sino que significa 
	que no optar por clasificar esta elección con respecto a la 
	otras opciones.</p>"; 
    } 
    if ($prop) { 
	$Ret .= "<p> Esta encuesta se decidió usar un Condorcet experimental basado
	en método diseñado para proporcionar la representación proporcional. Se
	supone por el algoritmo de votación que desea que el rango de la mayoría de
	su <i> preferido ganar </i> opción de ser lo más alta posible, y si dos
	conjuntos de ganar elecciones ponerse de acuerdo sobre la elección que
	prefiere la mayoría, entonces decidirá entre ellos con la opción preferida
	segundo, y etc."; 
    } else {
	$Ret = '<p> Esta encuesta se decidió usar un experimentales 
	algoritmo de Condorcet, diseñado para proporcionar proporcional 
	representación. 
	Por favor, cada una de las opciones después de un 
	<b>peso</b> que expresa la cantidad que desea que 
	elección para formar parte del conjunto ganador de las elecciones. 
	Se supone por el algoritmo de votación que desea 
	la suma de pesos de ganar elecciones a ser tan grande 
	como sea posible. Todas las opciones 
	En este momento una ponderación de cero, lo que significa que 
	no tienen ningún interés en ver a ganar. 
	Pesos no puede ser negativo o mayor que 999. 
	Doesn\'t ayudará a hacer su peso más grande 
	que otros votantes \'pesos, debido a que su peso sólo se comparan 
	uno contra el otro. '. 
	"<a Href=\"$civs_url/proportional.html\"> [Ver más información] </a> </p>."; 
    } 
    return $ret; 
}
sub Rank {
    'Rango'; 
}
sub Choice { 
    'Choice'; 
}
sub Weight { 
    'Weight'; 
}

sub address_will_be_visible { 
    '<strong>Su dirección de correo electrónico será visible</strong> junto con su boleta. '; 
}

sub ballot_will_be_anonymous { 
    'No obstante, su voto seguirá siendo anónimo: 
      ninguna información de identificación personal aparecerá.'; 
}

sub submit_ranking { 
    'Enviar'; 
}

sub only_writeins_are_permitted { 
    "El voto no es todavía permitido en esta encuesta. Sin embargo, 
             usted puede ver las opciones disponibles y escribir en los nuevos 
    opciones. Utilice el campo de texto de abajo para escribir en nuevas opciones." 
}

sub Add_writein { 
    'Añadir escribir en '
}

sub to_top { 
    'Arriba'; 
}
sub to_bottom { 
    'Hacia abajo'; 
}
sub move_up { 
    'Subir'; 
}
sub move_down { 
    'Bajar'; 
}
sub make_tie { 
    'Make empate';
}
sub buttons_are_deactivated { 
    "Estos botones están desactivados, porque su navegador no soporta Javascript."; 
}
sub ranking_instructions { 
       'Rango de las opciones en una de tres maneras: 
<ol> 
<li> arrastre las filas 
<li> jalones uso en nivel de columna 
<li> filas seleccionar y utilizar los botones arriba 
</ol> '; 
}

sub write_in_a_choice { 
    'Escribir en una nueva opción: '; 
}
sub if_you_have_already_voted {#url
    "Si ya han votado, puede ver <a href=\"$_[1]\"> la actual encuesta de resultados </a>." 
}
sub thank_you_for_voting {# título, el recibo 
    "Gracias. Su voto por <strong>$_[1]</strong> ha sido 
se logra lanzar. Su recibo de votante es <code> $_[2] </code>. " 
}
sub name_of_writein_is_empty { 
    "Nombre de la escritura en la elección está vacío"; 
}
sub writein_too_similar { 
    "Lo siento, el nombre de la escritura en es demasiado similar a una opción existente"; 
}

# Elecciones 

sub vote_has_already_been_cast { 
    "La votación ya se ha fundido con su clave de elector."; 
}
sub following_URL_will_report_results { 
    'La dirección URL siguiente informe resultados de la encuesta una vez que la encuesta termina: '; 
}
sub following_URL_reports_results { 
    "El siguiente URL los informes de los resultados de la encuesta actual: "; 
}
sub Already_voted { 
    "Ya hemos votado"; 
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
    "Encuesta no terminado todavía"; 
}
sub The_poll_has_not_yet_been_ended {# title, nombre, correo electrónico 
    "Esta encuesta ($_[1]) aún no ha sido terminado por su supervisor, $_[2] ($_[3])."; 
}
sub The_results_of_this_completed_poll_are_here { 
    "Los resultados de esta encuesta completa está aquí:"; 
}

sub No_write_access_to_lock_poll { 
    "¿No tienen el acceso de escritura necesarias para bloquear la votación. "; 
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
    "La clave de elector no es válido Usted debe haber recibido una URL correcta por correo electrónico.."; 
   } 
}
sub Invalid_result_key  {#tecla
    "No válido de resultado clave: \"$_[1]\". Usted debería haber recibido una dirección URL correcta para 
        ver resultados de la encuesta por correo electrónico. Este error se ha registrado. " 
}
sub Invalid_control_key {# tecla
    "No válido de control clave Debería haber recibido una dirección URL correcta para el control de la encuesta por correo electrónico Este error se ha registrado..."; 
}
sub Invalid_voting_key { 
    "Clave no válida la votación Debería haber recibido una dirección URL correcta para la votación por correo electrónico Este error se ha registrado."; 
}
sub Invalid_poll_id { 
    "Encuesta no válida de identificación"
}
sub Poll_id_not_valid {# Identificación 
    "La encuesta identificador \"$_[1]\" no es válida."
}
sub Unable_to_append_to_poll_log { 
    'No se puede añadir en el registro electoral.'
}
sub Voter_v_already_authorized { 
    "Votantes \"$_[1]\" ya está autorizada. 
     La clave de elector se resienten al votante."
}
sub Invalid_email_address_hdr {# dir
    "Dirección de correo electrónico no válida"; 
}
sub Invalid_email_address {# dir
    "No válida dirección de correo electrónico: $_[1]"; 
}
sub Sending_mail_to_voter_v { 
    "El envío de correo a los votantes \"$[1]\"..."; 
}
sub CIVS_poll_supervisor {#nombre
    "\"$_[1], el supervisor de la encuesta CIVS \"" 
}
sub voter_mail_intro {# título, nombre, EMAIL_ADDR 
"Una votación por Internet elección de Condorcet servicio llamado <b>$_[1]</b> se ha creado. 
Usted ha sido designado como elector por el supervisor de elecciones, 
$_[2] (<a href=\"mailto:$_[3] ($_[2])\"> $_[3] </a >).</p> "; 
}
sub Description_of_poll { 
    'Descripción de la encuesta:'; 
}
sub if_you_would_like_to_vote_please_visit { 
    "Si usted quiere votar, por favor visite la siguiente dirección URL: "; 
}
sub This_is_your_private_URL { 
'Esta es tu URL privada. No se lo dé a nadie más, porque podría utilizar 
a votar por usted.'; 
}
sub Your_privacy_will_not_be_violated { 
"Su privacidad no serán violados por votación. El servicio de votación ya ha 
destruyó el registro de su dirección de correo electrónico y no divulgará ninguna información 
acerca de si o cómo han votado."; 
}
sub This_is_a_nonanonymous_poll { 
"El supervisor de la encuesta ha decidido hacer de esto una <strong>encuesta no anónimo</strong>. Si 
de votar, cómo votó será visible al público junto con su 
dirección de correo electrónico. Si usted no vota, el supervisor de la encuesta también podrán 
para determinar esto."; 
}

sub poll_has_been_announced_to_end {# election_end 
    "La encuesta ha sido anunciada para poner fin a $_[1]."; 
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
    "Resultados de Encuesta: $_[1]"; 
}

sub Writeins_currently_allowed { 
    "Escribir-en las opciones están permitidos."; 
}

sub Writeins_allowed { 
    "Escribir-en las opciones están permitidos."; 
}
sub Writeins_not_allowed { 
    "Escribir-en las opciones no están permitidas."; 
}
sub Detailed_ballot_reporting_enabled { 
    "Presentación de informes detallados boleta está habilitado."; 
}
sub Detailed_ballot_reporting_disabled { 
    "Presentación de informes de votación detallada con discapacidad."; 
}
sub Voter_identities_will_be_kept_anonymous { 
    "Las identidades del votante se mantendrá anónima";
}
sub Voter_identities_will_be_public { 
    "Las identidades del votante (correo electrónico) se harán públicos asociados con su voto. "; 
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
	"El tiempo real de la encuesta cerrada: $_[1]" 
    } else {
	'La encuesta de tiempo real cerrada: <script>document.write (new Date ('.
	    ($_[1] * 1000) .
	') toLocaleString())</script>.' 
    } 
}
sub Poll_not_ended { 
    "Encuesta no ha terminado todavía."; 
}
sub This_is_a_test_poll { 
    "Esta es una encuesta de prueba. "; 
}
sub This_is_a_private_poll {# num_auth 
    "Encuesta privada ($_[1] los votantes autorizados)"; 
}
sub This_is_a_public_poll { 
    "Esta es una encuesta pública. "; 
}

sub Actual_votes_cast {# num_votes 
    "Votos emitidos real: $_[1]"; 
}
sub Number_of_winning_candidates { 
    'Número de ganar elecciones:'; 
}
sub Poll_actually_has {# winmsg 
    my $winmsg = '1 ganador'; 
    if ($_[1] != 1) { 
	$winmsg = $real_nwin.' los ganadores'; 
    } 
    "(Encuesta de hecho tiene $winmsg)"; 
}
sub poll_description_hdr { 
    'Descripción Encuesta '
}
sub Ranking_result { 
    'Resultado'
}
sub x_beats_y {# x l w 
    "$_[1] latidos $_[2], $_[3 ]-$_[ 4]"; 
}
sub x_ties_y {# x l w 
    "$_[1] lazos $_[2], $_[3 ]-$_[ 4]"; 
}
sub x_loses_to_y {# x l w 
    "$_[1] pierde a $_[2], $_[3 ]-$_[ 4]"; 
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
    'Detalles de resultados'
}
sub Ballot_report { 
    'Informe de boleta'
}
sub Ballots_are_shown_in_random_order { 
    'Las boletas se muestran en un orden al azar generados.'; 
}
sub Download_ballots_as_a_CSV {# url
    "[<a href=\"$_[1]\"> papeletas descargar en formato CSV </a>]"
}
sub No_ballots_were_cast { 
    'No hay votos fueron emitidos en esta encuesta.'
}
sub Ballot_reporting_was_not_enabled { 
    'Boleta de presentación de informes no se ha habilitado para esta encuesta.'
}
sub Tied { 
    '<i>Atado</i>:'
}
sub loss_explanation {# loss_to, favor, en contra 
    ', Pierde a ' . $_[1] . ' de ' . $_[2] . '-' . $_[3]; 
}
sub loss_explanation2 { 
    'Pierde a'.$_[1].' por'.$_[2].'-'.$_[3]; 
}
sub Condorcet_winner_explanation { 
    '(Ganador de Condorcet: concursos gana con todas las otras opciones)'
}
sub undefeated_explanation { 
    '(No derrotado en una contienda frente a otra opción)'
}
sub Choices_shown_in_red_have_tied { 
    "Las opciones se muestran en rojo han atado para ser seleccionado. 
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
    "Todas las preferencias se afirmaron. Todos los 
    los métodos de Condorcet estarán de acuerdo con este ranking."; 
}

sub Presence_of_a_green_entry_etc { 
    'La presencia de una entrada de verde por debajo de 
    la diagonal (y correspondiente rojo arriba) 
    significa que la preferencia fue ignorado por 
    entraba en conflicto con otras preferencias, más fuerte.'; 
}
sub Random_tie_breaking_used { 
    "Ruptura al azar de empate se utilizó para 
    llegar a este ordenamiento, de acuerdo con el MAM 
    algoritmo. Esto puede haber afectado el orden 
    de las elecciones."; 
}
sub No_random_tie_breaking_used { 
    'No hay lazo que rompe al azar que se necesitaba para llegar a este pedido. '; 
}

# beatpath

sub beatpath_matrix_explanation { 
    'La siguiente matriz muestra la fuerza del más fuerte 
    beatpath conectar cada par de opciones. La opción 1 se sitúa por encima de 
    opción 2, si hay un líder fuerte beatpath 1 a 2 
    que cualquier líder 2 a 1.'
}

sub no_pref { 
    'Ninguno' 
}

#rp

sub Some_voter_preferences_were_ignored { 
    'Algunas preferencias de los votantes fueron ignoradas, ya que 
     conflicto con las preferencias de otros, más fuerte: ' 
}

sub preference_description { 
    "Los $_[1]-$_[2] preferencia por $_[3] de más de $_[4]." 
}

1; # package succeeded!
