package russian;

use CGI qw(:standard -utf8);
use utf8;

our $VERSION = 1.0;

use lib '@CGIBINDIR@';

use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

sub lang { 'ru-RU' }

sub init {
    my $self = {}; 
    bless $self; 
    return $self; 
}

sub style_file {
    'style.css'; # probably what is wanted except for right-to-left languages
}

sub Condorcet_Internet_Voting_Service {
    'Кондорсе Интернет Голосование Сервис (CIVS)'
}

sub Condorcet_Internet_Voting_Service_email_hdr { # Note: charset may be limited 
    'Кондорсе Интернет Голосование Сервис (CIVS)'
}

sub about_civs {
    'О CIVS'
}
sub public_polls {
    'опросы общественного'
}
sub create_new_poll {
     'Создать новый опрос'
}
sub about_security_and_privacy {
    'Безопасность и конфиденциальность'
}
sub FAQ {
    'ЧАВО'
}
sub CIVS_suggestion_box {
    'CIVS ящик для предложений'
}
sub unable_to_process {
    'CIVS не может обработать ваш запрос из внутренней ошибки.'
}
sub CIVS_Error {
    'CIVS Ошибка'
}
sub CIVS_server_busy {
    'Сервер CIVS занят'
}
sub Sorry_the_server_is_busy {
     'К сожалению, веб-сервер CIVS очень занят сейчас и не может обрабатывать
     больше запросов. Пожалуйста, попробуйте еще раз чуть позже.'
}

# civs_create

sub mail_has_been_sent {
    "Почта был отправлен на указанный вами адрес. (<tt>$_[1]</tt>)."
}

sub click_on_the_URL_to_start {
     "Нажмите на URL в этом сообщении, чтобы начать опрос &ldquo;$_[1]&rdquo;."
}

sub here_is_the_control_URL {
    'Вот URL контролировать новый опрос. В обычной работе это будет направлено
    руководителю по электронной почте.'
}
sub the_poll_is_in_progress {
    'Опрос продолжается. Нажмите эту кнопку для завершения его:'
}

sub CIVS_Poll_Creation {
     "CIVS Создание опросе"
}
sub Poll_created {
     "Опрос был создан: $_[1]"
}

sub Address_unacceptable { #addr
    "Адрес \"$_[1] \" не является приемлемым"
}
sub Poll_must_have_two_choices {
    'Опрос должен иметь как минимум два варианта.'
}
sub Poll_directory_not_writeable {
    "Каталог опрос не может быть записан."
}
sub CIVS_poll_created {
  "CIVS опрос создан: $_[1]"
}

sub creation_email_info1 { # title, url
"Этот адрес электронной признает создание нового опроса,
$_[1]. Вы были назначены в качестве руководителя этого
голосование. Для запуска и остановки опрос, пожалуйста, используйте следующий адрес:

  $_[2]
"
}

sub creation_email_public_link { # url
"Потому что это открытый опрос, вы можете направить избирателей по следующему адресу:

  $_[1]

"
}

sub for_more_information_about_CIVS { # url
"Для получения дополнительной информации о Кондорсе интернет-голосование услуг, см:
    $_[1]"
}

sub Sending_result_key { # addr
"<р>Отправка результата ключ <tt>$_[1]</tt>. Пожалуйста, позвольте это, чтобы завершить ... <br>"
}
sub Done_sending_result_key { # addr
"... сделано отправки результата ключ.</p>"
}
sub Results_of_CIVS_poll { # title
    "Результаты опроса: $_[1]"
}
sub Results_key_email_body { # title, url, civs_home
"Новый опрос цивилизациям была создана по имени \"$_[1]\".
Вы были назначены в качестве пользователя, который допускается, чтобы увидеть
Результат этого опроса.

Сохранить эту электронную почту. Если вы его потеряете, вы не будете иметь
доступ к результаты. После того, как опрос был закрыт, результаты будут
Доступны по следующему адресу:

  $_[2]

Этот URL-адрес является частным. Разрешение несанкционированные пользователи доступ к thisURL позволит им увидеть результаты опроса. Для получения более подробной информации о Кондорсе интернет-голосование услуг, см
    $_[3]
"
}

# start

sub poll_started {
     "Опрос $_[1] был запущен"
}

sub sending_keys_now {
     'Отправка приглашений избирателей в настоящее время. Не уйдете с этой страницы, пока все приглашения не отправляются.'
}

# # control

# sub CIVS_Poll_Control {
#     "CIVS Poll Control"
# }
# sub Poll_control {
#     "Poll Control"
# }
# sub poll_has_not_yet_started {
#     'The poll has not yet started. Press this button to start it: '
# }
# sub Start_poll {
#     'Start poll'
# }
# sub End_poll {
#     'End poll'
# }
# sub Edit_button {
#     'edit'
# }
# sub Save_button {
#     'save'
# }
# sub Remove_button {
#     'remove'
# }
# sub ending_poll_cannot_be_undone {
#     'Ending a poll is an operation that cannot be undone. Continue?'
# }
# sub writeins_have_been_disabled {
#     'Write-in choices have been disabled'
# }
sub disallow_further_writeins {
    'Запретить добавление дополнительных вариантов'
}
# sub voting_disabled_during_writeins {
#     'Voting is currently disabled during the write-in phase.'
# }
# sub allow_voting_during_writeins {
#     'Allow voting during write-in phase'
# }
# sub this_is_a_test_poll {
#     'This is a test poll.'
# }
# sub file_to_upload_from {
#     'File to upload ballots from:'
# }
# sub Load_ballots {
#     'Load ballots'
# }
# sub poll_supervisor { # name, email
#     "Poll supervisor: $_[1] <tt>&lt;$_[2]&gt;</tt>"
# }
# sub no_authorized_yet { #waiting
#     "0 ($_[1] voters will be authorized when the poll is started)"
# }
# sub total_authorized_voters { # num_auth_string
#     "Total authorized voters: $_[1]"
# }
# sub actual_votes_so_far { # num
#     "Actual votes cast thus far: $_[1]"
# }
# sub poll_ends { # end
#     "Poll ends $_[1]."
# }
# sub Poll_results_available_to_all_voters_when_poll_completes {
#     'Poll results available to all voters when poll completes.'
# }
# sub Voters_can_choose_No_opinion {
#     'Voters can choose &ldquo;No opinion&rdquo;.'
# }
# sub Voting_is_disabled_during_writeins {
#     'Voting is disabled during the write-in period.'
# }
# sub Poll_results_will_be_available_to_the_following_users {
#     'Poll results will be available only to the following users:'
# }
# sub Poll_results_are_now_available_to_the_following_users {
#     'Poll results are now available only to the following users,
# 	    who were earlier sent an email containing a URL for
# 	     viewing results:'
# }
sub results_available_to_the_following_users {
     'Результаты этого опроса были опубликованы только для ограниченного круга пользователей:'
}

# sub Poll_results_are_available { #url
#     "<a href=\"$_[1]\">See poll results</a>"
# }
# sub Description {
#     'Description:'
# }
# sub Candidates {
#     'Candidates:'
# }
# sub Add_voters {
#     'Add voters'
# }

# sub the_top_n_will_win { # num_winners
#     my $wintxt;
#     if ($_[1] == 1) {
# 	$wintxt = "choice";
#     } else {
# 	$wintxt = "$_[1] choices";
#     }
#     return "The top $wintxt will win.";
# }

# sub add_voter_instructions {
#     "Enter e-mail addresses of voters, one per line. These
#     may be new voters or existing voters who have not voted yet.
#     In a private poll, giving the e-mail address of an already 
#     existing voter <strong>will not</strong> let that voter vote twice.
#     It will only resend the voter an invitation to vote.
#     In a public poll, only a token attempt is made to prevent
#     multiple voting."
# }
# sub Upload_file {
#     'Upload file: '
# }
# sub Load_ballot_data {
#     'Load ballot data'
# }
# sub File_to_upload_ballots_from {
#     'File to upload ballots from:'
# }
# sub Upload_instructions {
#     'Upload a text file formatted with one ballot per line. Each
#       line contains the ranks of the N choices, which are numbers from 1
#       to N, or a dash (<kbd>-</kbd>) to represent no opinion. Ranks should be
#       separated by whitespace or a comma. Lines may be terminated
#       with LF or CR/LF. Whitespace is ignored; lines whose first
#       non-whitespace character is # are also ignored. A line may begin
#       with <i>m</i><kbd>X</kbd> where <i>m</i> is a number, which
#       signifies <i>m</i> identical ballots described by the rest of
#       the line.'
# }
# sub Examples_of_ballots {
#     'Examples of ballots:'
# }
# sub Ballot_examples {
#     '1,4,3,2,5        <i>A simple ballot ranking five choices.</i>
#     5 - 2 - 3        <i>Another ranking of five choices. Dashes indicate unranked choices.</i>
#     8X1 4 3 2 5      <i>Eight ballots like the first example ballot.</i>'
# }
# sub Or_paste_this_code {
#     'Or paste this HTML code into your own web page:'
# }
# sub This_is_a_public_poll_plus_link {
#     my ($self, $url, $pub) = @_;
#     if ($pub) {
# 	return "This is a public poll. Share the following link
# 	    with voters to allow them to vote:</p><p>
# 	    &nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>. This
# 	    poll will also be publicized by CIVS.";
#     } else {
# 	return "This is a public poll. Share the following link
# 	    with voters to allow them to vote:</p><p>
# 	    &nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>";
#     }
# }
sub The_poll_has_ended {
    'Опрос закончился.'
}

# # add voters

# sub CIVS_Adding_Voters {
#     'CIVS: Adding Voters'
# }
# sub Adding_voters {
#     'Adding voters'
# }

# sub Sorry_voters_can_only_be_added_to_poll_in_progress {
#     'Sorry, voters can only be added to an poll in progress.'
# }

# sub Total_of_x_voters_authorized { # x
#     if ($_[1] == 0) {
# 	'No voters authorized to vote yet.'
#     } elsif ($_[1] == 1) {
# 	'Only 1 voter authorized to vote so far.'
#     } else {
# 	"Total of $_[1] voters authorized to vote."
#     }
# }

# sub Go_back_to_poll_control {
#     'Go back to poll control'
# }
# sub Done {
#     'Done.'
# }

# # vote

sub page_header_CIVS_Vote { # election_title
     'Голосование CIVS: '.$_[1]
}
sub ballot_reporting_is_enabled {
    'Отчетность по бюллетеням включена для этого опроса. Ваш бюллетень
    (рейтинг, который вы присваиваете вариантам) будет обнародован по окончании
    голосования.'
}
 sub instructions1 { # num_winners, end, name, email
     my $wintxt;
     if ($_[1] == 1) {
 	$wintxt="единственный любимый выбор";
     } else {
       $wintxt = $_[1]."любимых выборы"
     }
 	"Только $wintxt выиграет опрос.<br />
 	    Опрос заканчивается <b>$_[2]</b>.
 	    Руководитель опроса $_[3] (<tt>$_[4]</tt>).
            Обратитесь к руководителю опроса, если вам нужна помощь."
 }
 sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
     my ($self, $no_opinion, $prop, $combined, $civs_url) = @_;
     my $ret;
     if (!$prop || !$combined) {
        $ret = 'Дайте каждому из следующих вариантов в ранге, где меньше
        номером ранг означает, что вы кластеризацию Этот выбор станет ежевика.
        Например, дайте ваш лучший выбор в ранг 1. Указать выбор один и тот же
        ранг, если у вас нет предпочтения между ними. Вы не должны использовать
        все возможные ряды. Все выборы изначально имеют самый низкий возможный
        ранг.'. $cr;
 	if ($no_opinion) {
            $ret .= '<b>Примечания</b>: «Нет мнение» <i>не</i> так же, как
            самого низкого ранга возможно; Это означает, что Вы выбираете не
            ранжировать этот выбор относительно других вариантов выбора. </p>';
 	}
 	if ($prop) {
            $ret .= '<p>Этот опрос проводится с использованием
            экспериментального метода Кондорсе, разработанного для обеспечения
            пропорционального представительства. Алгоритм голосования
            предполагает, что вы хотите, чтобы рейтинг вашего наиболее
            предпочтительного <i>выигрышного</i> варианта был как можно более
            высоким, и если два набора выигрышных вариантов совпадают с
            выбором, который вы предпочитаете больше всего, то вы бы выбрать
            между ними, используя второй наиболее предпочтительный вариант, и
            так далее.';
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

sub Identifier_request {
     "<p>Укажите свой адрес электронной почты или другой узнаваемый идентификатор:\r\n".
     '<input type="text" name="email_address" size="50"></p>'.
     "\r\n"
}

sub Rank { 'Ранг' }
sub Choice { 'Выбор' }
sub Weight { 'Вес' }

sub ordinal_of {
    "$_[1]"
}

sub address_will_be_visible {
  '<strong>Ваш адрес электронной почты будет виден</strong> вместе с бюллетенем'
}

sub however_results_restricted {
   my @users = @{$_[1]};
   my $r = 'Однако результаты будут доступны только ограниченному кругу пользователей:';
   my $first=1;
   foreach my $u (@users) {
      if (!$first) { $r .= ', '; $first=0; }
      $r .= "<tt>$u</tt>";
   }
   $r .= '.';
   return $r;
}

sub ballot_will_be_anonymous {
    'Однако ваш бюллетень по-прежнему будет анонимным: персональная идентификационная информация не появится.'
}

sub submit_ranking {
    'Добавить рейтинг'
}

sub only_writeins_are_permitted {
    'Голосование еще не разрешено в этом опросе. Тем не менее, вы можете
    просмотреть список доступных вариантов и писать новые выборы. Используйте
    текстовое поле ниже, чтобы писать новые выборы.'
}

sub Add_writein {
    'Добавить запись в выбор.'
}

sub to_top {
    'Перейти к началу'
}
sub to_bottom {
    'двигаться вниз'
}
sub move_up {
    'Переместить вверх'
}
sub move_down {
    'Переместить вниз'
}
sub make_tie {
    'Сделать равными'
}
# sub buttons_are_deactivated {
#     'These buttons are deactivated because
# 	your browser does not support Javascript.'
# }
 sub ranking_instructions {
    'Ранжируйте выбор в одном из трех способов:
 	<ol>
 	    <li>перетащите строки
 	    <li>Используйте отжимания в колонке "ранга"
 	    <li>Выберите строки и используйте кнопки выше.
 	</ol>'
 }

sub write_in_a_choice {
    'Написать в новый выбор:'
}
sub if_you_have_already_voted { #url
    "Если вы уже голосовали, вы можете увидеть <a href=\"$_[1]\">текущие
    результаты опроса</a>."
}
sub thank_you_for_voting { #title, receipt
    "Спасибо. Ваш голос за <strong>$_[1]</strong> был успешно брошен. Квитанция избиратель <code>$_[2]</code>."
}
sub try_some_public_polls {
    'Хотите проголосовать по другому поводу? Попробуйте один из этих общественных опросов:'
}
sub name_of_writein_is_empty {
    'Название приказная в выборе пуст.'
}
sub writein_too_similar {
    'К сожалению, название вписанный слишком похож на существующий выбор'
}

# election

sub No_poll_ID {
    'Нет идентификатора опроса. Возможно, ошибка копирования-вставки?'
}

sub Ill_formed_poll_ID {
    'Был предоставлен неверно сформированный идентификатор опроса. Возможно, ошибка копирования-вставки?'
}

sub vote_has_already_been_cast {
  "Голосование уже подано с использованием вашего ключа избирателя."
}
sub following_URL_will_report_results {
  'Следующий URL сообщит о результатах опроса после его завершения:'
}
sub following_URL_reports_results {
  'Следующий URL сообщает о текущих результатах опроса:'
}
sub Already_voted {
    'Уже проголосовали.'
}
sub Error {
    'Ошибка.'
}
# sub Invalid_key {
#     'Invalid key. You should have received a correct URL for
#         controlling the poll by email. This error has been logged.'
# }
# sub Authorization_failure {
#     'Authorization failure'
# }

# sub already_ended { # title 
#     "This poll (<strong>$_[1]</strong>) has already been ended."
# }
sub Poll_not_yet_ended {
    'Опрос еще не закончился.'
}
# sub The_poll_has_not_yet_been_ended { #title, name, email
#     "This poll ($_[1]) has not yet been ended by its supervisor,
#     $_[2] ($_[3])."
# }
# sub The_results_of_this_completed_poll_are_here {
#     'The results of this completed poll are here:'
# }

# sub No_write_access_to_lock_poll {
#     "Did not have the write access needed to lock the poll."
# }
# sub This_poll_has_already_been_started { # title
#     "This poll ($_[1]) has already been started."
# }
# sub No_write_access_to_start_poll {
#     'Did not have write access to start a poll.'
# }
# sub Poll_does_not_exist_or_not_started {
#     'This poll does not exist or has not been started.'
# }
# sub Your_voter_key_is_invalid__check_mail { # voter
#    my $voter = $_[1];
#    if ($voter ne '') {
#     "Your voter key is invalid, $voter.
#      You should have received a correct URL by email."
#    } else {
#     "Your voter key is invalid. You should have received a correct URL by email."
#    }
# }
# sub Invalid_result_key { # key
#     "Invalid result key: \"$_[1]\". You should have received a correct URL for
#         viewing poll results by email. This error has been logged."
# }
# sub Invalid_control_key { # key
#     "Invalid control key. You should have received a correct URL for controlling the poll by email. This error has been logged."
# }
# sub Invalid_voting_key {
#     "Invalid voting key. You should have received a correct URL for voting by email. This error has been logged."
# }
# sub Invalid_poll_id {
#     "Invalid poll identifier"
# }
# sub Poll_id_not_valid { #id
#     "The poll identifier \"$_[1]\" is not valid."
# }
# sub Unable_to_append_to_poll_log {
#     "Unable to append to the poll log."
# }
# sub Voter_v_already_authorized {
#     "Voter \"$_[1]\" is already authorized.
#      The voter's key will be resent to the voter."
# }
# sub Invalid_email_address_hdr { # addr
#     "Invalid email address"
# }
# sub Invalid_email_address { # addr
#     "Invalid email address: $_[1]"
# }
# sub Sending_mail_to_voter_v {
#     "Sending mail to voter \"$_[1]\"..."
# }
# sub CIVS_poll_supervisor { # name
#     "\"$_[1], CIVS poll supervisor\""
# }
# sub voter_mail_intro { #title, name, email_addr
# "A Condorcet Internet Voting Service poll named <b>$_[1]</b> has been created.
# You have been designated as a voter by the poll supervisor,
# $_[2] (<a href=\"mailto:$_[3] ($_[2])\">$_[3]</a>).</p>"
# }
# sub Description_of_poll {
#     'Description of poll:'
# }
# sub if_you_would_like_to_vote_please_visit {
#     'If you would like to vote, please visit the following URL:'
# }
# sub This_is_your_private_URL {
# 'This is your private URL. Do not give it to anyone else, because they could use
# it to vote for you.'
# }
# sub Your_privacy_will_not_be_violated {
# 'Your privacy will not be violated by voting.  The voting service has already
# destroyed the record of your email address and will not release any information
# about whether or how you have voted.'
# }
# sub This_is_a_nonanonymous_poll {
# 'The poll supervisor has decided to make this a <strong>non-anonymous poll</strong>.  If
# you vote, how you voted will be publicly visible along with your
# email address. If you do not vote, the poll supervisor will also be able
# to determine this.'
# }

sub poll_has_been_announced_to_end { #election_end
    "Объявлено, что голосование закончится $_[1]."
}

sub To_view_the_results_at_the_end {
  "Чтобы просмотреть результаты опроса после его завершения, посетите:</p> $_[1]"
}

sub For_more_information {
  "Для получения дополнительной информации о CIVS см.: \r\n$_[1]"
}

sub poll_email_subject { # title
  "Опрос: $_[1]"
}

# # close

# sub CIVS_Ending_Poll {
#     'CIVS: Ending Poll'
# }

# sub Ending_poll {
#     'Ending a poll'
# }
sub View_poll_results {
  'Просмотреть результаты опроса'
}
sub Poll_ended { #title
  "Опрос закончился: $_[1]"
}

sub The_poll_has_been_ended { #election_end
  "Голосование завершено. Объявлено о завершении $_[1]."
}

sub poll_results_available_to_authorized_users {
  'Результаты опроса теперь доступны авторизованным пользователям.'
}

sub was_not_able_stop_the_poll {
    'Не удалось остановить опрос'
}

# results

sub CIVS_poll_result {
 'Результат опроса CIVS'
}
sub Poll_results { # title
  "Результаты опроса: $_[1]"
}
sub Writeins_currently_allowed {
  'Варианты записи в настоящее время разрешены.'
}
sub Writeins_allowed {
  'Варианты записи разрешены.'
}
sub Writeins_not_allowed {
  'Варианты записи не разрешены.'
}
# sub Detailed_ballot_reporting_enabled {
#     'Detailed ballot reporting is enabled.'
# }
# sub Detailed_ballot_reporting_disabled {
#     'Detailed ballot reporting is disabled.'
# }
# sub Voter_identities_will_be_kept_anonymous {
#     'Voter identities will be kept anonymous'
# }
# sub Voter_identities_will_be_public {
#     'Voter identities (email) will be publicly associated with their ballots.'
# }
sub Condorcet_completion_rule {
  #'Condorcet completion rule:'
  'Правило завершения Кондорсе:'
}
# sub undefined_algorithm {
#     'Error: undefined algorithm.'
# }
# sub computing_results {
#     'Computing results...'
# }
sub Supervisor { #name, email
     "Супервизор: $_[1] <tt>&lt;$_[2]&gt;</tt>"
}
sub Announced_end_of_poll {
  "Объявлено об окончании опроса: $_[1]"
}
sub Actual_time_poll_closed { # close time
    if ($_[1] == 0) {
       "Фактическое время окончания опроса: $_[1]"
    } else {
       'Фактическое время окончания опроса: <script>document.write(new Date(' .
 	    $_[1] * 1000 . 
 	    ').toLocaleString())</script>'
    }
}
sub Poll_not_ended {
  'Опрос еще не закончился.'
}
sub This_is_a_test_poll {
  'Это тестовый опрос.'
}
sub This_is_a_private_poll { #num_auth
  "Частный опрос ($_[1] авторизованных избирателей)"
}
sub This_is_a_public_poll {
  'Это открытый опрос.'
}

sub Actual_votes_cast { #num_votes
  "Фактическое количество голосов: $_[1]"
}
sub Number_of_winning_candidates {
  'Количество выигрышных вариантов:'
}
# sub Poll_actually_has { #winmsg
#     my $winmsg = '1 winner'
#     if ($_[1] != 1) {
# 	$winmsg = $real_nwin.' winners'
#     }
#     "&nbsp;(Poll actually has $winmsg)"
# }
sub poll_description_hdr {
    'Описание опроса'
}
sub Ranking_result {
     'Результат'
}
# sub x_beats_y { # x y w l 
#     "$_[1] beats $_[2] $_[3]&ndash;$_[4]"
# }
# sub x_ties_y { # x y w l 
#     "$_[1] ties $_[2] $_[3]&ndash;$_[4]"
# }
# sub x_loses_to_y { # x y w l 
#     "$_[1] loses to $_[2] $_[3]&ndash;$_[4]"
# }
sub some_result_details_not_shown {
  'Для простоты некоторые детали результатов опроса не показаны.'
}
sub Show_details {
  'Показать детали'
}
sub Hide_details {
  'Скрыть детали'
}
sub Result_details {
  'Детали результата'
}
# sub Ballot_report {
#     'Ballot report'
# }
# sub Ballots_are_shown_in_random_order {
#     "Ballots are shown in a randomly generated order."
# }
# sub Download_ballots_as_a_CSV { # url
#     "[<a href=\"$_[1]\">Download ballots in CSV format</a>]"
# }
# sub No_ballots_were_cast {
#     "No ballots were cast in this poll."
# }
sub Ballot_reporting_was_not_enabled {
     'Отчетность по бюллетеням не была включена для этого опроса'
}
sub Tied {
     '<i>ничейный результат</i>:'
}
# sub loss_explanation { # loss_to, for, against
#     ', loses to '. $_[1].' by '. $_[2] .'&ndash;'. $_[3]
# }
# sub loss_explanation2 {
#     '&nbsp;&nbsp;loses to '.$_[1].' by '.$_[2].'&ndash;'.$_[3]
# }
sub Condorcet_winner_explanation {
    '  (Не побежден ни в одном состязании против другого выбора)'
}
sub undefeated_explanation {
     '  (Не побежден ни в одном состязании против другого выбора)'
}
sub Choices_shown_in_red_have_tied {
  'Варианты, показанные красным, связаны с их выбором.
   Вы можете выбрать среди них случайным образом.'
}
sub Condorcet_winner {
  "Победитель Кондорсе"
}
sub Choices_in_individual_pref_order {
  'Выбор (в индивидуальном порядке предпочтений)'
}

sub What_is_this { # url
     '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>'. '(что это?)</small></a>'
}

# rp

# sub All_prefs_were_affirmed {
#     'All preferences were affirmed. All
# 		  Condorcet methods will agree with this ranking.'
# }

# sub Presence_of_a_green_entry_etc {
#     'The presence of a green entry below
# 	the diagonal (and a corresponding red one above)
# 	means that a preference was ignored because
# 	it conflicted with other, stronger preferences.'
# }
# sub Random_tie_breaking_used {
# 'Random tie breaking was used to
# arrive at this ordering, as per the MAM
# algorithm. This may have affected the ordering
# of the choices.'
# }
# sub No_random_tie_breaking_used {
#     'No random tie breaking was needed to arrive at this ordering.'
# }

# # beatpath

# sub beatpath_matrix_explanation {
#     'The following matrix shows the strength of the strongest
#     beatpath connecting each pair of choices. Choice 1 is ranked above
#     choice 2 if there is a stronger beatpath leading from 1 to 2
#     than any leading from 2 to 1.'
# }

# sub no_pref {
#     'none'
# }

# #rp

# sub Some_voter_preferences_were_ignored {
#     'Some voter preferences were ignored because they
#      conflict with other, stronger preferences:'
# }

# sub preference_description {
#     "The $_[1]&ndash;$_[2] preference for $_[3] over $_[4]."
# }

# User activation

sub new_user {
    'Активировать пользователя'
}
sub user_activation {
    'Активировать пользователя'
}
sub activation_code_subject {
    'Код активации для использования CIVS'
}
sub user_activation_instructions {
    my ($self, $mail_mgmt_url) = @_;
    p('Чтобы проголосовать в частных опросах CIVS, вы должны включить рассылку сообщений по электронной почте от службы. CIVS не хранит ваш адрес электронной почты, и автоматические рассылки отсутствуют. Вы получаете электронное письмо от службы только по явному запросу руководителей опросов, содержащее учетные данные, необходимые для голосования в частных опросах или для просмотра результатов опросов.').
    p("Чтобы принять участие, введите свой адрес электронной почты и нажмите кнопку ниже. Затем вы должны получить электронное письмо с кодом активации. Обратите внимание, что если вы ранее отказались от электронной почты, вы должны использовать страницу управления электронной почтой, чтобы повторно активировать электронную почту. Если вы используете службу блокировки почты, вам может потребоваться внести адрес электронной почты CIVS в белый список в качестве авторизованного отправителя (".'@SUPERVISOR@'.").")
}
sub opt_in_label {
    'Запросить код активации'
}
sub activation_code {
    'Код активации: '
}
sub someone_has_requested_activation {
    my ($self, $address, $code, $mail_mgmt_url) = @_;
"Кто-то попросил, чтобы система голосования CIVS активировала адрес электронной почты <$address>
для голосования в опросах. Для активации этого адреса вам понадобится следующий код активации:

     $code

Если вы не отправляли этот запрос, вы можете проигнорировать это письмо.

Управляйте электронной почтой от CIVS по этой ссылке: $mail_mgmt_url."
}
sub already_activated {
    "Этот адрес электронной почты уже активирован."
}
sub activation_successful
{
    'Адрес электронной почты успешно активирован.'
}
sub pending_invites_hdr {
    'Эти приглашения ожидают рассмотрения:'
}
sub submit_activation_code {
    'Завершите активацию'
}
sub mail_address {
    'Адрес электронной почты: '
}
1; # package succeeded!
