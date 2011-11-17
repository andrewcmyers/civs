package portuguese;

use lib '@CGIBINDIR@';
use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

our $VERSION = 1.000;

sub lang { 'pt-BR'; }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub Condorcet_Internet_Voting_Service {
    'Serviço de Votação Condorcet pela Internet (CIVS)';
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited 
    'Servico de Votacao Condorcet pela Internet (CIVS)';
}
sub about_civs {
    'Sobre o CIVS';
}
sub create_new_poll {
    'Criar uma nova votação';
}
sub about_security_and_privacy {
    'Sobre segurança e privacidade';
}
sub FAQ {
    'Perguntas frequentes';
}
sub CIVS_suggestion_box {
    'Sugestões de melhorias para o CIVS';
}
sub unable_to_process {
    'CIVS não conseguiu processar seu pedido devido a um erro interno.';
}
sub CIVS_Error {
    'Erro no CIVS';
}
sub CIVS_server_busy {
    'Servidor CIVS sobrecarregado';
}
sub Sorry_the_server_is_busy {
    'O servidor CIVS está sobrecarregado no momento.
     Por favor tente novamente mais tarde.';
}

# civs_create

sub mail_has_been_sent {
    "Foi enviada uma mensagem ao endereço que você forneceu (<tt>$_[1]</tt>).";
}

sub click_on_the_URL_to_start {
    "Clique na URL contida na mensagem para iniciar a votação: <strong>$_[1]</strong>.";
}

sub here_is_the_control_URL {
    'Este é o endereço para controlar a nova votação.
     Em operação normal, ele seria enviado em uma mensagem ao supervisor.';
}
sub the_poll_is_in_progress {
    'A votação está ativa. Aperte este botão para encerrá-la: ';
}

sub CIVS_Poll_Creation {
    "CIVS: Criação de Votação";
}
sub Poll_created {
    "Votação criada: $_[1]"
}

sub Address_unacceptable { #addr
    "O endereço \"$_[1]\" não pode ser aceito";
}
sub Poll_must_have_two_choices {
    'Uma votação deve ter pelo menos duas opções.';
}
sub Poll_directory_not_writeable {
    "Não foi possível escrever no diretório da votação";
}
sub CIVS_poll_created {
 "CIVS: Votação criada: $_[1]";
}
sub creation_email_info1 { # title, url
"Esta mensagem sinaliza a criação de uma nova votação no CIVS,
chamada $_[1].
Você foi designado o supervisor dessa votação. Para iniciar ou
encerrar a votação, conecte no endereço abaixo:

  $_[2]

";
}
sub creation_email_public_link { # url
"Como esta é uma votação pública, você pode informar aos participantes este endereço:

  $_[1]

";
}
sub for_more_information_about_CIVS { # url
"Para mais informação sobre o CIVS, veja
  $_[1]";
}

sub Sending_result_key { # addr
    "Enviando a chave de acesso aos resultados para '$_[1]'";
}
sub Results_of_CIVS_poll { # title
    "Resultados da votação CIVS: $_[1]";
}
sub Results_key_email_body { # title, url, civs_home
"Foi criada uma nova votação CIVS, chamada \"$_[1]\".
Você foi designado como um usuário com direito de acesso aos
resultados dessa votação.

Guarde esta mensagem. Se perdê-la, não terá acesso aos resultados.
Quando a votação for encerrada, os resultados estarão disponíveis em:

  $_[2]

Esse endereço é privado. Caso usuários não autorizados tenham
acesso a esse endereço, poderão ver os resultados da votação.
Para mais informação sobre o CIVS, acesse
  $_[3]

";
}
  
# start

sub poll_started {
    'A votação <strong>'.$_[1].'</strong> foi iniciada.';
}

# control

sub CIVS_Poll_Control {
    "CIVS: Controle de Votação";
}
sub Poll_control {
    "Controle de Votação";
}
sub poll_has_not_yet_started {
    'Esta votação ainda não foi iniciada. Use este botão para iniciá-la: ';
}
sub Start_poll {
    'Iniciar Votação';
}
sub End_poll {
    'Encerrar Votação';
}
sub ending_poll_cannot_be_undone {
    'A finalização de uma votação é uma operação que não pode ser desfeita.
     Deseja continuar?';
}
sub writeins_have_been_disabled {
    'A adição de candidatos foi desabilitada';
}
sub disallow_further_writeins {
    'Desabilitar a adição de mais candidatos';
}
sub voting_disabled_during_writeins {
    'A votação está desabilitada durante a fase de adição de novos candidatos.';
}
sub allow_voting_during_writeins {
    "Permitir a votação durante a fase de adição de candidatos";
}
sub this_is_a_test_poll {
    'Esta é uma votação de teste.';
}

sub poll_supervisor { # name, email
    "Supervisor da votação: $_[1] (<tt>$_[2]</tt>)";
}
sub no_authorized_yet { #waiting
    "0 ($_[1] votantes serão autorizados quando a votação for iniciada)";
}
sub total_authorized_voters { # num_auth_string
    "Total de votantes autorizados: $_[1]";
}
sub actual_votes_so_far { # num
    "Número de votos registrados: $_[1]";
}
sub poll_ends { # end
    "Término da votação: $_[1].";
}
sub Poll_results_available_to_all_voters_when_poll_completes {
    'Os resultados serão disponibilizados a todos os votantes quando votação encerrar.';
}
sub Voters_can_choose_No_opinion {
    'Votantes podem escolher &ldquo;Sem opinião&rdquo;';
}
sub Voting_is_disabled_during_writeins {
    'Votação é desabilitada durante período de adição de candidatos.';
}
sub Poll_results_will_be_available_to_the_following_users {
    'Os resultados da votação serão disponibilizados somente aos usuários:';
}
sub Poll_results_are_now_available_to_the_following_users {
    'Foi enviada uma mensagem com o endereço de consulta aos resultados
     para os usuários abaixo.';
}
sub results_available_to_the_following_users {
    'Os resultados desta votação somente estão disponíveis a alguns usuários:';
}

sub Poll_results_are_available { #url
    "<a href=\"$_[1]\">Veja os resultados da votação</a>";
}
sub Description {
    'Descrição:';
}
sub Candidates {
    'Candidatos:';
}
sub Add_voters {
    'Adicionar votantes';
}

sub the_top_n_will_win { # num_winners
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt = "Será escolhido um candidato entre os candidatos abaixo.";
    } else {
	$wintxt = "Serão escolhidos $_[1] candidatos entre os candidatos abaixo.";
    }
    return $wintxt;
}

sub add_voter_instructions {
    "Adicione os endereços de correio eletrônico dos votantes,
    um por linha. Podem ser novos votantes ou votantes existentes
    que ainda não votaram. Em uma votação privada, colocar
    o endereço de um votante já existente <strong>não</strong> permitirá
    que ele vote duas vezes, somente lhe será enviado um novo convite.
    Em uma votação pública, uma tentativa de evitar votos múltiplos é
    realizada, com o uso de \"tokens\"."
}
sub Upload_file {
    'Carregar arquivo: ';
}
sub Load_ballot_data {
    'Carregar votos a partir de um arquivo';
}
sub File_to_upload_ballots_from {
    'Arquivo com os votos:';
}
sub This_is_a_public_poll_plus_link {
    my $url = $_[1];
    "Esta é uma votação pública. Distribua este endereço aos votantes:</p><p>
	&nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>";
}
sub The_poll_has_ended {
    'Esta votação foi encerrada.';
}

# add voters

sub CIVS_Adding_Voters {
    'CIVS: Adicionando votantes';
}
sub Adding_voters {
    'Adicionando votantes';
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
    'Votantes só podem ser adicionados a uma votação em progresso.';
}

sub Total_of_x_voters_authorized { # x
    if ($_[1] == 0) {
	'Nenhum votante autorizado.';
    } elsif ($_[1] == 1) {
	'Um votante autorizado.';
    } else {
	"$_[1] votantes autorizados.";
    }
}

sub Go_back_to_poll_control {
    'Voltar ao controle da votação';
}
sub Done {
    'Feito.';
}

# vote

sub page_header_CIVS_Vote { # election_title
    'Voto CIVS: '.$_[1];
}

sub ballot_reporting_is_enabled {
    'O relatório de votos está habilitado para esta votação.
     Seu voto será publicado quando a votação for encerrada.';
}
sub instructions1 { # num_winners, end, name, email
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt="um vencedor";
    } else {
	$wintxt="$_[1] vencedores";
    }
    "A votação terá $wintxt.<p>
	    Término da votação: <b>$_[2]</b>.<p>
	    Supervisor da votação: $_[3] (<tt>$_[4]</tt>).
            Não hesite em contactá-lo se precisar de ajuda.";
}
sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
    my ($self, $no_opinion, $prop, $combined, $civs_url) = @_;
    my $ret;
    if (!$prop || !$combined) {
	$ret = "Atribua um valor a cada uma das opções abaixo.
            Quanto menor o valor, maior a preferência pela opção.
            Por exemplo, a sua opção preferida terá o valor 1.
            Dê o mesmo valor a opções quando a escolha de uma ou
            outra for indiferente para você. Você não precisa usar
            todos os valores possíveis. Inicialmente todas as 
            opções estão com o valor mínimo. ". $cr;
	if ($no_opinion) {
	    $ret .= '<b>Nota:</b> &ldquo;Sem opinião&rdquo;
		    <i>não é</i> o mesmo que o menor valor possível;
                    significa que você escolhe não posicionar essa opção
                    em relação às demais.</p>';
	}
	if ($prop) {
	    $ret .= '<p>Esta votação é decidida usando um método experimental baseado
            em Condorcet para prover uma representação proporcional. O algoritmo
            pressupõe que você quer que a posição da sua opção mais preferida seja
            a mais alta possível, e que se dois conjuntos de opções têm essa sua
            opção na mesma posição, você decidiria entre eles usando a sua segunda
            opção mais preferida, e assim por diante. ';
	}
    } else {
	$ret = '<p>Esta votação é decidida usando um método experimental baseado
        em Condorcet para prover uma representação proporcional. Por favor
        atribua a cada opção um <b>peso</b> que expressa o quanto você quer
        essa opção faça parte do conjunto de opções vencedoras. O algoritmo
        pressupõe que você quer que a soma dos pesos das opções ganhadoras 
        seja a mais alta possível. Todas as opções estão inicialemente com 
        o peso zerado, o que significa que você não tem interesse em que 
        elas ganhem. Pesos não podem ser negativos nem maiores que 999.
        Os pesos atribuídos por você só são comparados com os demais pesos
        atribuídos por você, não há comparação direta com os pesos atribuídos
        por outros votantes.'.
	"<a href=\"$civs_url/proportional.html\">[Veja mais informação]</a>.</p>";
    }
    return $ret;
}
sub Rank {
    'Posição';
}
sub Choice {
    'Opção';
}
sub Weight {
    'Peso';
}

sub address_will_be_visible {
    '<strong>Seu endereço eletrônico será visível</strong> juntamente com seu voto.';
}

sub ballot_will_be_anonymous {
    ' Entretanto, seu voto será anônimo:
      nenhuma informação de identificação pessoal será mostrada.';
}

sub submit_ranking {
    'Enviar voto';
}

sub only_writeins_are_permitted {
    'Esta votação ainda não foi iniciada.
             Você pode ver as opções existentes e acrescentar novas opções.';
}

sub Add_writein {
    'Acrescentar opção';
}

sub to_top {
    'colocar em primeiro';
}
sub to_bottom {
    'colocar em último';
}
sub move_up {
    'subir uma posição';
}
sub move_down {
    'descer uma posição';
}
sub make_tie {
    'empatar';
}
sub buttons_are_deactivated {
    'Estes botões estão desativados porque seu
        navegador não suporta Javascript.';
}
sub ranking_instructions {
       'Ordene as opções. Você pode fazê-lo de três formas:
	<ol>
	    <li>arrastando as opções;
	    <li>usando os botões da coluna &ldquo;Posição&rdquo;;
	    <li>selecionando opções e usando os botões acima.
	</ol>';
}

sub write_in_a_choice {
    'Adicione uma opção: ';
}
sub if_you_have_already_voted { #url
    "Se você já votou, pode ver
	<a href=\"$_[1]\">os resultados atuais da votação</a>.";
}
sub thank_you_for_voting { #title, receipt
    "Obrigado. O seu voto para <strong>$_[1]</strong> foi registrado com sucesso.
	Seu recibo é <code>$_[2]</code>.";
}
sub name_of_writein_is_empty {
    "Nome da opção a adicionar está vazio";
}
sub writein_too_similar {
    "O nome da nova opção é muito similar ao de uma já existente";
}

# election

sub vote_has_already_been_cast {
    "Um voto já foi registrado com essa chave.";
}
sub following_URL_will_report_results {
    'O seguinte endereço conterá os resultados da votação quando ela for encerrada:';
}
sub following_URL_reports_results {
    'O seguinte endereço contém os resultados da votação:';
}
sub Already_voted {
    'Já votou';
}
sub Error {
    'Erro';
}
sub Invalid_key {
    'Chave inválida. Você deve ter recebido o endereço correto para
        controlar a votação em uma mensagem de correio eletrônico.
        Este erro foi registrado.';
}
sub Authorization_failure {
    'Não autorizado';
}

sub already_ended { # title 
    "Esta votação (<strong>$_[1]</strong>) já foi encerrada.";
}
sub Poll_not_yet_ended {
    "Votação ainda não encerrada";
}
sub The_poll_has_not_yet_been_ended { #title, name, email
    "Esta votação ($_[1]) ainda não foi encerrada pelo supervisor,
    $_[2] ($_[3]).";
}
sub The_results_of_this_completed_poll_are_here {
    'Os resultados desta votação já encerrada estão aqui:';
}

sub No_write_access_to_lock_poll {
    "Sem a permissão necessária para bloquear a votação.";
}
sub This_poll_has_already_been_started { # title
    "Esta votação ($_[1]) já foi iniciada.";
}
sub No_write_access_to_start_poll {
    "Sem a permissão necessária para iniciar a votação.";
}
sub Poll_does_not_exist_or_not_started {
    'Votação inexistente ou ainda não iniciada.';
}
sub Your_voter_key_is_invalid__check_mail { # voter
   my $voter = $_[1];
   if ($voter ne '') {
    "Sua chave de votação é inválida, $voter.
     Você deve ter recebido o endereço correto em uma mensagem de correio eletrônico.";
   } else {
    "Sua chave de votação é inválida.
     Você deve ter recebido o endereço correto em uma mensagem de correio eletrônico.";
   }
}
sub Invalid_result_key { # key
    "Chave de resultados inválida: \"$_[1]\".
     Você deve ter recebido o endereço correto em uma mensagem de
     correio eletrônico. Este erro foi registrado.";
}
sub Invalid_control_key { # key
    "Chave de controle inválida.
     Você deve ter recebido o endereço correto em uma mensagem de
     correio eletrônico. Este erro foi registrado.";
}
sub Invalid_voting_key {
    "Chave de votação inválida.
     Você deve ter recebido o endereço correto em uma mensagem de
     correio eletrônico. Este erro foi registrado.";
}
sub Invalid_poll_id {
    "identificador de votação inválido";
}
sub Poll_id_not_valid { #id
    "O identificador de votação \"$_[1]\" não é válido.";
}
sub Unable_to_append_to_poll_log {
    "Impossível acrescentar ao arquivo de registros da votação.";
}
sub Voter_v_already_authorized {
    "O votante \"$_[1]\" já está autorizado.
     A chave de votação será reenviada.";
}
sub Invalid_email_address_hdr { # addr
    "Endereço de correio eletrônico inválido";
}
sub Invalid_email_address { # addr
    "Endereço de correio eletrônico inválido: $_[1]";
}
sub Sending_mail_to_voter_v {
    "Enviando mensagem ao votante \"$_[1]\"...";
}
sub CIVS_poll_supervisor {
    'CIVS: Supervisor de votação';
}
sub voter_mail_intro { #title, name, email_addr
"Foi criada no sistema CIVS uma votação chamada <b>$_[1]</b>.
Você foi designado como um votante pelo supervisor da votação,
$_[2] (<a href=\"mailto:$_[3] ($_[2])\">$_[3]</a>).</p>";
}
sub Description_of_poll {
    'Descrição da votação:';
}
sub if_you_would_like_to_vote_please_visit {
    'Para votar, use o seguinte endereço:';
}
sub This_is_your_private_URL {
'Este é seu endereço privado. Não permita que outra pessoa o acesse, porque poderá votar em seu nome.';
}
sub Your_privacy_will_not_be_violated {
'Sua privacidade será resguardada. O serviço de votação já descartou o
registro de seu endereço de correio eletrônico e não liberará nenhuma
informação sobre você já ter votado ou não.';
}
sub This_is_a_nonanonymous_poll {
'O supervisor da votação decidiu que esta é uma <strong>votação não anônima</strong>.
Se você votar, seu voto será disponibilizado, juntamente com seu endereço
de correio eletrônico. Se você não votar, o supervisor terá acesso a essa
informação.';
}

sub poll_has_been_announced_to_end { #election_end
    "Previsão de encerramento da votação: $_[1].";
}

sub To_view_the_results_at_the_end {
    "Para ver os resultados da votação após o encerramento, visite:</p> $_[1]";
}

sub For_more_information {
    'Para mais informação sobre o CIVS, veja:';
}

sub poll_email_subject { # title
    "Votação: $_[1]"
}

# close

sub CIVS_Ending_Poll {
    'CIVS: Encerrando a votação';
}

sub Ending_poll {
    'Encerrando a votação';
}
sub View_poll_results {
    'Veja os resultados da votação';
}
sub Poll_ended { #title
    "Votação encerrada: $_[1]";
}

sub The_poll_has_been_ended { #election_end
    "A votação foi encerrada. Encerramento anunciado: $_[1].";
}

sub poll_results_available_to_authorized_users {
    'Os resultados da votação estão disponíveis para os votantes autorizados.';
}

sub was_not_able_stop_the_poll {
    'Não foi possível encerrar a votação';
}


# results

sub CIVS_poll_result {
    "CIVS: Resultados da votação";
}
sub Poll_results { # title
    "Resultados da votação: $_[1]";
}

sub Writeins_currently_allowed {
    'A adição de novas opções é atualmente permitida.';
}

sub Writeins_allowed {
    'A adição de novas opções é permitida.';
}
sub Writeins_not_allowed {
    'A adição de novas opções não é permitida.';
}
sub Detailed_ballot_reporting_enabled {
    'Relatório detalhado dos votos está habilitado.';
}
sub Detailed_ballot_reporting_disabled {
    'Relatório detalhado dos votos está desabilitado.';
}
sub Voter_identities_will_be_kept_anonymous {
    'A identidade dos votantes não será revelada.';
}
sub Voter_identities_will_be_public {
    'A identidade dos votantes (email) será publicamente associada a seus votos.';
}
sub Condorcet_completion_rule {
    'Regra de término Condorcet:';
}
sub undefined_algorithm {
    'Erro: algoritmo indefinido.';
}
sub computing_results {
    'Calculando os resultados...';
}
sub Supervisor { #name, email
    "Supervisor: $_[1] ($_[2])";
}
sub Announced_end_of_poll {
    "Encerramento anunciado da votação: $_[1]";
}
sub Actual_time_poll_closed { # close time
    if ($_[1] == 0) {
	"Hora de encerramento da votação: $_[1]"
    } else {
	'Hora de encerramento da votação: <script>document.write(new Date(' .
	    $_[1] * 1000 . 
	    ').toLocaleString())</script>';
    }
}
sub Poll_not_ended {
    'Votação ainda não foi encerrada.';
}
sub This_is_a_test_poll {
    'Esta é uma votação de teste.';
}
sub This_is_a_private_poll { #num_auth
    "Votação privada ($_[1] votantes autorizados)";
}
sub This_is_a_public_poll {
    'Esta é uma votação pública.';
}

sub Actual_votes_cast { #num_votes
    "Número de votos registrados: $_[1]";
}
sub Number_of_winning_candidates {
    'Número de candidatos vencedores: ';

}
sub Poll_actually_has { #winmsg
    my $winmsg = '1 vencedor';
    if ($_[1] != 1) {
	$winmsg = $real_nwin.' vencedores';
    }
    "&nbsp;(Votação tem $winmsg)";
}
sub poll_description_hdr {
    'Descrição da votação';
}
sub Ranking_result {
    'Resultado';
}
sub x_beats_y { # x y w l 
    "$_[1] ganha de $_[2] por $_[3]&ndash;$_[4]";
}
sub x_ties_y { # x y w l 
    "$_[1] empata com $_[2] por $_[3]&ndash;$_[4]";
}
sub x_loses_to_y { # x y w l 
    "$_[1] perde para $_[2] por $_[3]&ndash;$_[4]";
}
sub some_result_details_not_shown {
    'Por simplicidade, alguns detalhes dos resultados não são mostrados. &nbsp;';
}
sub Show_details {
    'Mostrar detalhes';
}
sub Hide_details {
    'Ocultar detalhes';
}
sub Result_details {
    'Detalhes do resultado';
}
sub Ballot_report {
    'Relatório dos votos'
}
sub Ballots_are_shown_in_random_order {
    "Votos são apresentados em ordem aleatória.";
}
sub Download_ballots_as_a_CSV { # url
    "[<a href=\"$_[1]\">Votos em formato CSV</a>]";
}
sub No_ballots_were_cast {
    "Nenhum voto foi registrado nessa votação.";
}
sub Ballot_reporting_was_not_enabled {
    "O relatório de votos não foi habilitado nesta votação.";
}
sub Tied {
    "<i>Empatados</i>:";
}
sub loss_explanation { # loss_to, for, against
    ', perde para '. $_[1].' por '. $_[2] .'&ndash;'. $_[3];
}
sub loss_explanation2 {
    '&nbsp;&nbsp;perde para '.$_[1].' por '.$_[2].'&ndash;'.$_[3];
}
sub Condorcet_winner_explanation {
    '&nbsp;&nbsp;(vencedor Condorcet: vence disputas com todas as demais opções)';
}
sub undefeated_explanation {
    '&nbsp;&nbsp;(Não derrotado em em nenhuma disputa com outra opção)';
}
sub Choices_shown_in_red_have_tied {
    "As opções em vermelho estão empatadas.
	Talvez queira escolher entre elas aleatoriamente.";
}
sub Condorcet_winner {
    "Vencedor Condorcet";
}
sub Choices_in_individual_pref_order {
    'Opções (em ordem de preferência individual)';
}

sub What_is_this { # url
    '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>'. '(Que é isto?)</small></a>';
}

# rp

sub All_prefs_were_affirmed {
    'Todas as preferências foram confirmadas. Todos os
		  métodos Condorcet resultarão na mesma ordem.';
}

sub Presence_of_a_green_entry_etc {
    'A presença de uma entrada verde abaixo da diagonal
	(e de uma vermelha correspondente, acima)
        significa que a preferência foi ignorada porque
        conflitava com outras preferências mais fortes.';
}
sub Random_tie_breaking_used {
'Foi usado desempate aleatório para chegar a
este resultado, pelo algoritmo MAM. Isso pode
afetar a ordem das opções.';
}
sub No_random_tie_breaking_used {
    'Não foi necessário desempate aleatório para chegar a este resultado.';
}

# beatpath

sub beatpath_matrix_explanation {
    'A matriz abaixo mostra a força do caminho mais forte conectando
    cada par de opções. A opção 1 é escolhida sobre a opção 2 se houver
    pelo menos um caminho de 1 para 2 que é mais forte do que todos 
    os caminhos de 2 para 1.';
}

sub no_pref {
    'nenhum'
}

#rp

sub Some_voter_preferences_were_ignored {
    'Algumas preferências de votantes foram ignoradas, porque
     conflitam com outras preferências mais fortes:'
}

sub preference_description {
    "A preferência $_[1]&ndash;$_[2] para $_[3] sobre $_[4]."
}

1; # package succeeded!
