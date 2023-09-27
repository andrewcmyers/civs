package ukrainian;

use lib '@CGIBINDIR@';
use CGI qw(:standard -utf8);
use utf8;

use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

our $VERSION = 1.000;

sub lang { 'uk-UA' }

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
  'Служба Інтернет-голосування Condorcet'
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited
  'Служба Інтернет-голосування Condorcet'
}
sub CIVS_sender {
    my ($self) = @_;
    $self->Condorcet_Internet_Voting_Service_email_hdr
# UNTRANSLATED
}
sub about_civs {
  'Про CIVS'
}
sub new_user {
  'Активувати користувача'
}
sub public_polls {
  'Громадські опитування'
}
sub create_new_poll {
  'Створити нове опитування'
}
sub about_security_and_privacy {
  'Безпека та конфіденційність'
}
sub FAQ {
  'FAQ'
}
sub CIVS_suggestion_box {
  'Скринька пропозицій CIVS'
}
sub unable_to_process {
  'CIVS не може обробити ваш запит через внутрішню помилку.'
}
sub CIVS_Error {
  'Помилка CIVS'
}
sub CIVS_server_busy {
  'Сервер CIVS зайнятий'
}
sub Sorry_the_server_is_busy {
  'На жаль, веб-сервер CIVS зараз дуже зайнятий і не може обробляти додаткові запити. Спробуйте ще раз трохи пізніше.'
}

# civs_create

sub mail_has_been_sent {
  "Пошту надіслано на вказану вами адресу (<tt>$_[1]</tt>)."
}

sub click_on_the_URL_to_start {
  "Натисніть URL-адресу в цьому електронному листі, щоб розпочати опитування â$_[1]â."
}

sub here_is_the_control_URL {
  'Ось URL-адреса для керування новим опитуванням. У звичайній роботі це буде надіслано керівнику електронною поштою.'
}
sub the_poll_is_in_progress {
  'Опитування триває. Натисніть цю кнопку, щоб завершити:'
}

sub CIVS_Poll_Creation {
  "Створення опитування CIVS"
}
sub Poll_created {
  "Опитування створено: $_[1]"
}

sub Address_unacceptable { #addr
  "Адреса \"$_[1]\" неприйнятна"
}
sub Poll_must_have_two_choices {
  'В опитуванні має бути принаймні два варіанти.'
}
sub Poll_exceeds_max_choices {
    my ($self, $count) = @_;
  "Опитування може містити щонайбільше $count варіантів."
}
sub Poll_directory_not_writeable {
  "Помилка конфігурації? Не вдалося створити каталог опитувань <tt>$_[1]</tt>"
}
sub CIVS_poll_created {
  "Створено опитування CIVS: $_[1]"
}
sub creation_email_info1 { # title, url
  "Цей електронний лист підтверджує створення нового опитування $_[1]. Вас призначили наглядачем цього опитування. Щоб розпочати та зупинити опитування, скористайтеся такою URL-адресою:
 <$_[2]>
Збережіть цей електронний лист і збережіть його приватним. Якщо ви його втратите, ви не зможете контролювати опитування.
"
}
sub creation_email_public_link { # url
  "Оскільки це публічне опитування, ви можете направити виборців за такою URL-адресою:
 <$_[1]>
"
}

sub opted_out { # addr
  "На жаль, ви не можете надсилати електронні листи на &lt;$_[1]&gt; через CIVS."
}

sub Sending_result_key { # addr (escaped)
  "<p>Надсилання ключа результату до <tt>$_[1]</tt>. Дозвольте завершити...<br>"
}
sub Done_sending_result_key { # addr
  '...надсилання ключа результату завершено.</p>'
}
sub Results_of_CIVS_poll { # title
  "Результати опитування CIVS: $_[1]"
}
sub Results_key_email_body { # title, url, civs_home
  "Було створено нове опитування CIVS під назвою \"$_[1]\". Вас призначено користувачем, якому дозволено переглядати результати цього опитування.
Збережіть цей електронний лист. Якщо ви його втратите, ви не матимете доступу до результатів. Після закриття опитування результати будуть доступні за такою URL-адресою:
 <$_[2]>
Ця URL-адреса приватна. Якщо дозволити неавторизованим користувачам доступ до цієї URL-адреси, вони зможуть побачити результати опитування.
"
}

# start

sub poll_started {
  "Опитування <strong>$_[1]</strong> розпочато."
}

sub sending_keys_now {
  'Розсилаю запрошення виборцям. Не виходьте з цієї сторінки, доки не буде надіслано всі запрошення.'
}

# control

sub CIVS_Poll_Control {
  "CIVS Poll Control"
}
sub Poll_control {
  "Контроль опитувань"
}
sub poll_has_not_yet_started {
  'Опитування ще не розпочато. Натисніть цю кнопку, щоб запустити:'
}
sub Start_poll {
  'Розпочати опитування'
}
sub End_poll {
  'Завершити опитування'
}
sub Edit_button {
  'редагувати'
}
sub ResendLink_button {
  'повторно надіслати посилання'
}
sub ResendLinkAck {
  'надісланий'
}
sub Save_button {
  'зберегти'
}
sub Remove_button {
  'видалити'
}
sub confirm_ending_poll_cannot_be_undone {
  'Завершення опитування – це операція, яку не можна скасувати. Щоб підтвердити, що ви хочете закрити опитування, введіть &#34;close&#34; і натисніть OK'
}
sub writeins_have_been_disabled {
  'Варіанти запису вимкнено'
}
sub disallow_further_writeins {
  'Заборонити подальші записи'
}
sub voting_disabled_during_writeins {
  'Наразі голосування вимкнено на етапі запису.'
}
sub allow_voting_during_writeins {
  'Дозволити голосування під час запису'
}
sub this_is_a_test_poll {
  'Це тестове опитування.'
}
sub file_to_upload_from {
  'Файл для завантаження бюлетенів з:'
}
sub Load_ballots {
  'Завантажте бюлетені'
}
sub poll_supervisor { # name, email
  "Керівник опитування: $_[1] <tt>&lt;$_[2]&gt;</tt>"
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
  "Загальна кількість авторизованих виборців: $_[1]"
}
sub actual_votes_so_far { # num
  "Фактично подано голосів: $_[1]"
}
sub poll_ends { # end
  "Оголошено кінець опитування: $_[1]"
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
  'Результати опитування доступні всім виборцям після завершення голосування.'
}
sub Voters_can_choose_No_opinion {
  'Виборці можуть вибрати &ldquo;Без думки&rdquo;.'
}
sub Voting_is_disabled_during_writeins {
  'Під час запису голосування вимкнено.'
}
sub Poll_results_will_be_available_to_the_following_users {
  'Результати опитування будуть доступні лише для наступних користувачів:'
}
sub Poll_results_are_now_available_to_the_following_users {
  'Результати опитування тепер доступні лише для наступних користувачів, яким раніше було надіслано електронний лист із URL-адресою для перегляду результатів:'
}
sub results_available_to_the_following_users {
  'Результати цього опитування були оприлюднені лише для обмеженого кола користувачів:'
}

sub Poll_results_are_available { #url
  "<a href=\"$_[1]\">[&nbsp;Переглянути результати опитування&nbsp;]</a>"
}
sub Description {
  'опис:'
}
sub Candidates {
  'Кандидати:'
}
sub Add_voters {
  'Додайте виборців'
}

sub the_top_n_will_win { # num_winners
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt = "choice";
    } else {
	$wintxt = "$_[1] choices";
    }
    "The top $wintxt will win."
# UNTRANSLATED
}

sub add_voter_instructions {
  "Введіть електронні адреси виборців, по одній на рядок. Це можуть бути нові виборці або існуючі виборці, які ще не голосували. У приватному опитуванні введення адреси електронної пошти вже існуючого виборця <strong>не</strong> дозволить цьому виборцю проголосувати двічі. Він лише повторно надішле виборцю запрошення проголосувати. Під час публічного опитування робиться лише символічна спроба запобігти багаторазовому голосуванню."
}
sub resend_question {
  'Запрошувати навіть виборців, які вже проголосували?'
}
sub Upload_file {
  'Завантажити файл:'
}
sub Load_ballot_data {
  'Завантажити дані бюлетеня'
}
sub File_to_upload_ballots_from {
  'Файл для завантаження бюлетенів з:'
}
sub Upload_instructions {
  'Завантажте текстовий файл у форматі з одним бюлетенем на рядок. Кожен рядок містить ранги N варіантів, які є числами від 1 до N, або тире (<kbd>-</kbd>), щоб не позначати думку. Ранги повинні бути розділені пробілом або комою. Лінії можуть закінчуватися LF або CR/LF. Пробіли ігноруються; рядки, першим непробілним символом яких є #, також ігноруються. Рядок може починатися з <i>m</i><kbd>X</kbd>, де <i>m</i> є числом, яке означає <i>m</i> ідентичних бюлетенів, описаних іншими лінії.'
}
sub Examples_of_ballots {
  'Приклади бюлетенів:'
}
sub Ballot_examples {
'    1,4,3,2,5 <i>Простий бюлетень для голосування з п\'ятьма варіантами.</i>
    5 - 2 - 3 <i>Інший рейтинг із п\'яти варіантів. Прочерки позначають варіанти без рейтингу.</i>
    8X1 4 3 2 5 <i>Вісім бюлетенів, як у першому прикладі.</i>'
}

sub Or_paste_this_code {
  'Або вставте цей HTML-код на свою веб-сторінку:'
}

sub This_is_a_public_poll_plus_link {
    my ($self, $url, $pub) = @_;
    if ($pub) {
	return 'This is a public poll. Share the following link with voters to allow them to vote:<br> &nbsp;&nbsp;' .  $self->CopyableURL('poll_link', $url) .  '</p><p>This poll will also be publicized by CIVS.'
    } else {
	'This is a public poll. Share the following link
	    with voters to allow them to vote:<br>
	    &nbsp;&nbsp;'
        . $self->CopyableURL('poll_link', $url)
        . '</p>';
    }
}
sub The_poll_has_ended {
  'Опитування закінчено.'
}

# add voters

sub CIVS_Adding_Voters {
  'CIVS: додавання виборців'
}
sub Adding_voters {
  'Додавання виборців'
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
  'Вибачте, виборців можна додавати лише до опитування, яке триває.'
}
sub Too_many_voters_added {
  'На жаль, одночасно можна додавати лише @MAX_VOTER_ADD@ виборців.'
}
sub Too_much_email {
  'На жаль, CIVS накладає обмеження на кількість створених електронних листів. Будь ласка, додайте більше виборців пізніше.'
}
sub Out_of_upload_space {
  'Можливо, на сервері бракує місця на диску для завантажень.'
}
sub Uploaded_file_empty {
    my ($self, $desc) = @_;
  "Завантажений $desc порожній."
}
sub No_upload_file_provided {
    my ($self, $desc) = @_;
  "$desc не надано. Помилка завантаження."
}
sub Didnt_get_plain_text {
    my ($self, $type) = @_;
  "Завантажений вхід має бути простим текстовим файлом або файлом CSV (натомість отримано <b>$type</b>)"
}

sub Total_of_x_voters_authorized { # x
    if ($_[1] == 0) {
	'No voters authorized to vote yet.';
    } elsif ($_[1] == 1) {
	'Only 1 voter authorized to vote so far.';
    } else {
	"A total of $_[1] voters are authorized to vote.";
    }
# UNTRANSLATED
}

sub Go_back_to_poll_control {
  'Повернутися до контролю опитувань'
}
sub Done {
  'Готово.'
}

sub Email_voters_who_have_not_activated {
  'Надішліть електронний лист виборцям, які не активувалися'
}

sub Activate_mail_subject {
  'Активуйте свою електронну адресу на CIVS'
}
sub Address {
  'Адреса'
}
sub Reason {
  'Причина'
}

sub Activate_mail_body {
    my ($self, $supervisor, $name, $title, $url) = @_;
  "$name <$supervisor> запросив вас проголосувати в опитуванні під назвою â$titleâ.
 Щоб проголосувати, будь ласка, активуйте свою електронну адресу в системі голосування CIVS за адресою: <$url>"
}


# vote

sub page_header_CIVS_Vote { # election_title
  'Голосування CIVS: '.$_[1]
}

sub ballot_reporting_is_enabled {
  'Для цього опитування ввімкнено звіт про голосування. Ваш бюлетень (рейтинг, який ви призначаєте варіантам) буде видно в результатах опитування, коли опитування закінчиться.'
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
  'Укажіть свою адресу електронної пошти або інший ідентифікатор, який можна розпізнати:'
}
sub Need_identifier {
  'Вибачте, щоб проголосувати, вам потрібно ідентифікувати себе.'
}

sub Rank {
  'ранг'
}
sub Choice {
  'Вибір'
}
sub Weight {
  'вага'
}

# overridden in english.pm
sub ordinal_of {
  "$_[1]"
}

sub address_will_be_visible {
  '<strong>Ваша адреса електронної пошти відображатиметься</strong> разом із вашим голосуванням.'
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
  ' Однак ваш бюлетень все одно буде анонімним: у ньому не буде жодної ідентифікаційної інформації.'
}

sub submit_ranking {
  'Надіслати рейтинг'
}

sub only_writeins_are_permitted {
  'Голосування в цьому опитуванні ще не дозволено. Однак ви можете переглянути доступні варіанти та вписати нові. Використовуйте текстове поле нижче, щоб ввести нові варіанти.'
}

sub Add_writein {
  'Додайте запис'
}

sub to_top {
  'до вершини'
}
sub to_bottom {
  'до низу'
}
sub move_up {
  'рухатися вгору'
}
sub move_down {
  'рухатися вниз'
}
sub make_tie {
  'зробити краватку'
}
sub buttons_are_deactivated {
  'Ці кнопки дезактивовано, оскільки ваш браузер не підтримує Javascript.'
}
sub ranking_instructions {
  '<p>Ранжуйте варіанти одним із трьох способів:</p> <ol> <li>перетягуйте рядки</li> <li>використовуйте розкривні меню в стовпці «Ранжування»</li> <li>вибирайте рядки та використовуйте кнопки вище </li> </ol>'
}
sub write_in_a_choice {
  'Напишіть у новому варіанті:'
}
sub show_qr_code {
  'Показати QR-код для цього опитування.'
}
sub if_you_have_already_voted { #url
  "Якщо ви вже проголосували, ви можете побачити <a href=\"$_[1]\">поточні результати опитування</a>."
}
sub thank_you_for_voting { #title, receipt
  "Дякую. Ваш голос за <strong>$_[1]</strong> успішно віддано.<br> Ваша квитанція для голосування: <code>$_[2]</code>. Вам знадобиться ця квитанція, якщо ви захочете змінити свій бюлетень пізніше."
}
sub try_some_public_polls {
  "Хочете проголосувати за щось інше? Спробуйте одне з цих публічних опитувань:"
}
sub you_can_change_ballot_now {
  'На цій сторінці ви можете стерти поданий вами бюлетень і проголосувати знову.'
}
sub change_ballot {
  'Повторне голосування'
}
sub name_of_writein_is_empty {
  "Ім'я вибору для запису порожнє"
}
sub writein_too_similar {
  "Вибачте, назва надто схожа на наявну назву"
}
sub doublecheck_msg {
  'Ваше голосування не матиме ефекту, оскільки всі кандидати, щодо яких ви маєте свою думку, мають однакову кількість голосів. Ви все ще хочете подати?'
}

# election

sub No_poll_ID {
  "Ідентифікатор опитування не надано. Можливо, помилка копіювання-вставки?"
}
sub Ill_formed_poll_ID {
  "Надано неправильно сформований ідентифікатор опитування. Можливо, помилка копіювання та вставлення? (" . $_[1] . ")"
}
sub vote_has_already_been_cast {
  "Голосування вже віддано за допомогою ключа виборця."
}
#deprecated, use future_result_link
sub following_URL_will_report_results {
  'Після завершення опитування за такою URL-адресою буде повідомлено результати опитування:'
}
sub future_result_link {
    my ($self, $url) = @_;
  "За наступною URL-адресою буде повідомлено результати опитування, коли опитування завершиться: <a href='$url'><code>$url</code></a>"
}
#deprecated
sub following_URL_reports_results {
  'Наступна URL-адреса повідомляє поточні результати опитування:'
}
sub if_you_want_to_change {
  'Ви можете видалити свій попередній голос і проголосувати знову, ввівши свою квитанцію тут:'
}
sub invalid_release_key {
    my ($self, $receipt) = @_;
  'Надана виборча квитанція ('.$receipt.') є неправильною. Він має виглядати подібно до '.code('E_2ad1ca99ac3cac7a/3a191bd9fb00ef73').'.'
}
sub no_ballot_under_key {
    my ($self, $key) = @_;
  "Для квитанції $key не знайдено жодного попереднього голосування"
}
sub current_result_link {
    my ($self, $url) = @_;
  "<a href=\"$url\" class=result_link>Перейти до поточних результатів опитування</a>"
}
sub Already_voted {
  'Вже проголосували'
}
sub Error {
  'Помилка'
}
sub Invalid_key {
  'Недійсний ключ. Ви мали отримати правильну URL-адресу для керування опитуванням електронною поштою. Ця помилка була зареєстрована.'
}
sub Authorization_failure {
  'Помилка авторизації'
}

sub already_ended { # title
  "Це опитування (<strong>$_[1]</strong>) уже завершено."
}
sub Poll_not_yet_ended {
  "Опитування ще не закінчено"
}
sub The_poll_has_not_yet_been_ended { #title, name, email
  "Це опитування ($_[1]) ще не завершено його керівником, $_[2] ($_[3])."
}

# deprecated
sub The_results_of_this_completed_poll_are_here {
  'Результати цього завершеного опитування тут:'
}
sub completed_results_link {
    my ($self, $url) = @_;
  "<a href=\"$url\" class=result_link>Перейти до завершених результатів опитування</a>"
}

sub No_write_access_to_lock_poll {
  "Немає доступу для запису, необхідного для блокування опитування."
}
sub This_poll_has_already_been_started { # title
  "Це опитування ($_[1]) уже розпочато."
}
sub No_write_access_to_start_poll {
  'Немає доступу для запису, щоб почати опитування.'
}
sub Poll_does_not_exist_or_not_started {
  'Це опитування не існує або не розпочато.'
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
  "Недійсний ключ результату: \"$_[1]\". Ви мали отримати правильну URL-адресу для перегляду результатів опитування електронною поштою. Ця помилка була зареєстрована."
}
sub Invalid_control_key { # key
  "Недійсний ключ керування. Ви мали отримати правильну URL-адресу для керування опитуванням електронною поштою. Ця помилка була зареєстрована."
}
sub Invalid_voting_key {
  "Недійсний ключ голосування. Ви мали отримати правильну URL-адресу для голосування електронною поштою. Ця помилка була зареєстрована."
}
sub Invalid_poll_id {
  "Недійсний ідентифікатор опитування"
}
sub Poll_id_not_valid { #id
  "Ідентифікатор опитування \"$_[1]\" недійсний."
}
sub Unable_to_append_to_poll_log {
  "Не вдалося додати до журналу опитувань."
}
sub Voter_v_already_authorized {
  "Виборець &lt;$_[1]&gt; вже авторизовано. Ключ виборця буде надіслано виборцю повторно."
}
sub Skipping_already_voted {
  "Пропуск голосуючого &lt;$_[1]&gt;: уже проголосував."
}
sub Invalid_email_address_hdr { # addr
  "невірна адреса електронної пошти"
}
sub Invalid_email_address { # addr
  "Недійсна електронна адреса: $_[1]"
}
sub Address_opted_out { # addr
  "Ця адреса відмовилася від електронної пошти CIVS: $_[1]"
}
sub Sending_mail_to_voter_v {
  "Надсилання листа виборцю \"$_[1]\"..."
}
sub CIVS_poll_supervisor { # name
  "\"Сервіс Інтернет-голосування Condorcet (від імені $_[1])\""
}
sub From_poll_supervisor {
    my ($self, $name) = @_;
    $self->CIVS_poll_supervisor($name)
# UNTRANSLATED
}
sub voter_mail_intro { #title, name, email_addr
  "Створено опитування служби Інтернет-голосування Condorcet під назвою <b>$_[1]</b>. Наглядач $_[2] призначив вас виборцем (<a href=\"mailto:$_[3] ($_[2])\"><code>$_[3]< /код></a>).</p>"
}
sub Description_of_poll {
  'Опис опитування:'
}
sub if_you_would_like_to_vote_please_visit {
  'Якщо ви бажаєте проголосувати, перейдіть за такою URL-адресою:'
}
sub This_is_your_private_URL {
  'Це ваша приватна URL-адреса. Не віддавайте його нікому, тому що вони можуть використати його, щоб проголосувати за вас.'
}
sub Your_privacy_will_not_be_violated {
  'Ваша конфіденційність не буде порушена голосуванням. Служба голосування вже знищила запис вашої адреси електронної пошти та не розголошує жодної інформації про те, чи голосували ви і як.'
}
sub This_is_a_nonanonymous_poll {
  'Керівник опитування вирішив зробити це <strong>неанонімним опитуванням</strong>. Якщо ви проголосуєте, вашу електронну адресу та те, як ви проголосували, бачитимуть усі, хто отримав доступ до результатів опитування.'
}


sub poll_has_been_announced_to_end { #election_end
  "Оголошено, що опитування закінчується $_[1]."
}

sub To_view_the_results_at_the_end {
  "Щоб переглянути результати опитування після його завершення, відвідайте:</p> $_[1]"
}

sub for_more_information_about_CIVS { # url
  "Для отримання додаткової інформації про службу голосування в Інтернеті Condorcet див. $_[1]"
}

sub For_more_information { # url, mail mgmt url
  ($self, $home, $mail_mgmt) = @_;
  "Додаткову інформацію про службу голосування в Інтернеті Condorcet див
    $home. Щоб контролювати майбутні електронні листи, надіслані з CIVS, перегляньте $mail_mgmt"
}

sub poll_email_subject { # title
  "Опитування: $_[1]"
}

# close

sub CIVS_Ending_Poll {
  'CIVS: завершення опитування'
}

sub Ending_poll {
  'Завершення опитування'
}
sub View_poll_results {
  'Переглянути результати опитування'
}
sub Poll_ended { #title
  "Опитування завершено: $_[1]"
}

sub The_poll_has_been_ended { #election_end
  "Опитування завершено. Було оголошено про завершення $_[1]."
}

sub poll_results_available_to_authorized_users {
  'Результати опитування тепер доступні авторизованим користувачам.'
}

sub was_not_able_stop_the_poll {
  'Не вдалося зупинити опитування'
}


# results

sub CIVS_poll_result {
  "Результат опитування CIVS"
}
sub Poll_results { # title
  "Результати опитування: $_[1]"
}

sub Writeins_currently_allowed {
  'Наразі доступні варіанти запису.'
}

sub Writeins_allowed {
  'Допускаються варіанти запису.'
}
sub Writeins_not_allowed {
  'Вибір запису не дозволяється.'
}
sub Detailed_ballot_reporting_enabled {
  'Увімкнено детальну звітність про голосування.'
}
sub Detailed_ballot_reporting_disabled {
  'Деталізований звіт про голосування вимкнено.'
}
sub Voter_identities_will_be_kept_anonymous {
  'Особи виборців залишатимуться анонімними'
}
sub Voter_identities_will_be_public {
  'Особи виборців (електронна адреса) разом із їхніми бюлетенями будуть видимі для тих, хто має право переглядати результати голосування.'
}
sub Condorcet_completion_rule {
  'Правило завершення Condorcet:'
}
sub undefined_algorithm {
  'Помилка: невизначений алгоритм.'
}
sub computing_results {
  'Обчислення результатів...'
}
sub Supervisor { #name, email
  "Керівник: $_[1] <tt>&lt;$_[2]&gt;</tt>"
}
sub Announced_end_of_poll {
  "Оголошено кінець опитування: $_[1]"
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
  'Опитування ще не закінчено.'
}
sub This_is_a_test_poll {
  'Це тестове опитування.'
}
sub This_is_a_private_poll { #num_auth
  "Приватне опитування ($_[1] авторизованих виборців)"
}
sub This_is_a_public_poll {
  'Це публічне опитування.'
}

sub Actual_votes_cast { #num_votes
  "Фактичні подані голоси: $_[1]"
}
sub Number_of_winning_candidates {
  'Кількість виграшних варіантів:'
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
  'Опис опитування'
}
sub Ranking_result {
  'Результат'
}
sub x_beats_y { # x y w l
  "$_[1] перемагає $_[2] $_[3]&ndash;$_[4]"
}
sub x_ties_y { # x y w l
  "$_[1] нічия $_[2] $_[3]&ndash;$_[4]"
}
sub x_loses_to_y { # x y w l
  "$_[1] програє $_[2] $_[3]&ndash;$_[4]"
}
sub some_result_details_not_shown {
  'Для простоти деякі деталі результатів опитування не показано.'
}
sub Show_details {
  'Показати деталі'
}
sub Hide_details {
  'Приховати деталі'
}
sub Result_details {
  'Деталі результату'
}
sub Ballot_report {
  'Звіт про голосування'
}
sub Ballots_are_shown_in_random_order {
  "Бюлетені відображаються у довільному порядку."
}
sub Download_ballots_as_a_CSV { # url
  "[<a href=\"$_[1]\">Завантажити бюлетені у форматі CSV</a>]"
}
sub No_ballots_were_cast {
  "У цьому голосуванні не було вдано жодного голосування."
}
sub Ballot_reporting_was_not_enabled {
  'Для цього опитування не було ввімкнено звіт про голосування.'
}
sub Tied {
  "<i>Ничья</i>:"
}
sub loss_explanation { # loss_to, for, against
  ', програє '. $_[1].' від '. $_[2] .'&ndash;'. $_[3]
}
sub loss_explanation2 {
  '&nbsp;&nbsp;програє '.$_[1].' by '.$_[2].'&ndash;'.$_[3]
}
sub Condorcet_winner_explanation {
  '&nbsp;&nbsp;(Переможець Кондорсе: виграє змагання з усіма іншими варіантами)'
}
sub undefeated_explanation {
  '&nbsp;&nbsp;(Не програв у жодному змаганні проти іншого вибору)'
}
sub Choices_shown_in_red_have_tied {
  'Варіанти, виділені червоним кольором, вибрані однаково. Ви можете вибрати з них випадковим чином.'
}
sub Condorcet_winner {
  "Лауреат Кондорсе"
}
sub Choices_in_individual_pref_order {
  'Вибір (в індивідуальному порядку)'
}

sub Unknown_email {
  '(невідомо)'
}

sub What_is_this { # url
  '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>'. '(Що це?)</small></a>'
}

# rp

sub All_prefs_were_affirmed {
  'Всі преференції були підтверджені.'
}

sub Presence_of_a_green_entry_etc {
  'Наявність зеленого запису під діагоналлю (і відповідного червоного вгорі) означає, що перевагу було проігноровано, оскільки вона суперечила іншим, сильнішим перевагам.'
}
sub Random_tie_breaking_used {
  'Для досягнення цього порядку використовувався випадковий зв’язок згідно з алгоритмом MAM. Це могло вплинути на порядок вибору.'
}
sub No_random_tie_breaking_used {
  'Щоб досягти цього замовлення, не потрібно було випадково розривати зв’язки.'
}

# beatpath

sub beatpath_matrix_explanation {
  'Наступна матриця показує силу найсильнішого шляху, що з’єднує кожну пару варіантів. Варіант 1 ранжується вище варіанту 2, якщо існує сильніший шлях від 1 до 2, ніж будь-який вихід від 2 до 1.'
}

sub no_pref {
  'немає'
}

#rp

sub Some_voter_preferences_were_ignored {
  'Деякі переваги виборців були проігноровані, оскільки вони суперечать іншим, сильнішим перевагам:'
}

sub preference_description {
  "Перевага $_[1]&ndash;$_[2] для $_[3] над $_[4]."
}

sub mail_management_instructions {
    p("CIVS не зберігає електронні адреси виборців і надсилає пошту лише тоді, коли
        керівник опитування, який уже знає вашу адресу, просить надіслати лист.
        Ви можете заборонити CIVS надсилати вам пошту, ввівши свою електронну адресу нижче.").
    p("Натисніть кнопку праворуч, щоб отримати код деактивації електронною поштою. Ця аутентифікація
        крок необхідний, щоб запобігти блокуванню електронної пошти інших користувачів.").
    p(b("УВАГА:"), "Якщо ви заблокуєте пошту від CIVS, її буде важко повторно ввімкнути, оскільки CIVS
       виконує автентифікацію користувачів за допомогою адрес електронної пошти. Ви не зможете голосувати в опитуваннях CIVS
       і ви не зможете створювати опитування CIVS.")
}

sub mail_address {
  'Електронна адреса:'
}
sub deactivation_code {
  'Код деактивації:'
}
sub filter_question {
  'Шаблон фільтра <small>(можна залишити порожнім; наведіть курсор, щоб отримати довідку)</small>'
}
sub filter_explanation {
  'Ви можете ввести тут один або кілька шаблонів, щоб указати, від яких супервізорів опитування забороняти надсилання електронної пошти. Шаблоном може бути адреса електронної пошти керівника або шаблон, що описує адреси електронної пошти. Шаблон може використовувати * для представлення будь-якої послідовності символів. Наприклад, шаблон *@inmano.com не дозволить керівникам із адресою @inmano.com надсилати вам запрошення на опитування. Якщо залишити це поле порожнім, деактивація/повторна активація застосовуватиметься до всіх електронних адрес.'
}
sub send_deactivation_code {
  'Надішліть код деактивації електронною поштою'
}
sub cant_send_email {
  'Ви не можете надіслати електронну пошту цьому користувачеві за допомогою CIVS. Електронну пошту для цього користувача потрібно спочатку повторно активувати, використовуючи попередньо надісланий код деактивації.'
}
sub submit_deact_react {
  'Надіслати деактивацію/повторну активацію'
}
sub codes_dont_match {
  "На жаль, наданий код і електронна адреса не збігаються. Ви можете подати запит на інший код, якщо ви раніше не блокували електронну пошту від CIVS."
}
sub deactivation_successful {
    my ($self, $pattern) = @_;
  "CIVS більше не надсилатиме пошту на цю адресу, якщо її відправник відповідає цьому шаблону: \"$pattern\". Ви можете повторно активувати пошту від CIVS, лише використовуючи цю веб-сторінку з тим самим кодом, який ви щойно використали."
}
sub reactivation_successful {
  'Ви успішно повторно активували пошту на цю адресу.'
}
sub someone_has_requested {
  "Хтось попросив код, щоб заборонити CIVS надсилати вам електронні листи. Якщо це були ви, ви будете знати, що з цим робити. Код:
 $_[1]
Збережіть цей електронний лист, оскільки цей код вам знадобиться, якщо ви захочете скористатися послугою в майбутньому."
}
sub deactivation_code_subject {
  'Код деактивації пошти CIVS'
}
sub mail_mgmt_title {
  'Управління поштою'
}

## User activation

sub user_activation {
  'Активувати користувача'
}
sub activation_code_subject {
  'Код активації для використання CIVS'
}
sub user_activation_instructions {
    my ($self, $mail_mgmt_url) = @_;
    p('Щоб проголосувати в приватних опитуваннях CIVS, ви повинні ввімкнути електронний лист від служби. CIVS не зберігає вашу адресу електронної пошти, і немає автоматичних розсилок. Ви отримуєте електронну пошту від служби лише за чітким запитом керівників опитувань, що містить облікові дані, необхідні для голосування в приватних опитуваннях або перегляду результатів опитувань.').
    p("Щоб прийняти участь, введіть адресу електронної пошти та натисніть кнопку нижче. Потім ви повинні отримати електронний лист із кодом активації. Зауважте, що якщо ви раніше відмовилися від електронної пошти, ви повинні скористатися <a href=\"$mail_mgmt_url\">сторінкою керування електронною поштою</a>, щоб повторно активувати електронну пошту. Якщо ви користуєтеся службою блокування пошти, вам може знадобитися додати адресу електронної пошти CIVS до білого списку авторизованих відправників (".'@SUPERVISOR@'.").")
}
sub opt_in_label {
  'Запит коду активації'
}
sub activation_code {
  'Код активації:'
}
sub someone_has_requested_activation {
    my ($self, $address, $code, $mail_mgmt_url) = @_;
  "Хтось попросив систему голосування CIVS активувати електронну адресу <$address> для голосування в опитуваннях. Щоб активувати цю адресу, вам знадобиться наступний код активації:
 $код
Якщо ви не надсилали цей запит, ви можете проігнорувати цей електронний лист.
Керуйте електронною поштою від CIVS за цим посиланням: $mail_mgmt_url."
}
sub already_activated {
  'Ця електронна адреса вже активована.'
}
sub activation_successful
{
    'Email address successfully activated.'
}
sub pending_invites_hdr {
  'Очікують запрошення на опитування:'
}
sub submit_activation_code {
  'Повна активація'
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
  "На жаль, жоден користувач не активував адресу &lt;$address&gt; щоб отримати електронну пошту."
}
sub mail_failure_reason {
    my ($self, $reason) = @_;
    if ($reason eq 'not activated') {
        'Ця адреса електронної пошти не була активована одержувачем.'
    } elsif ($reason eq 'opted out') {
        'Цей користувач відмовився від електронної пошти CIVS.'
    } else {
        'Невідома причина'
    }
# UNTRANSLATED
}
sub see_the_failure_table {
    my ($self, $activate_url, $mail_mgmt_url) = @_;
  "<p>CIVS не міг надіслати пошту деяким виборцям з причин, наведених у таблиці нижче. Виборці не зможуть проголосувати, доки не отримають особистий ключ, тому вам слід зв’язатися з ними напряму. Виборці, ймовірно, знайдуть такі посилання корисними:</p> <ul> <li>Активувати електронну адресу за допомогою CIVS: <a href='$activate_url'>$activate_url</a></li> <li>Деактивувати /повторно активуйте адресу електронної пошти: <a href='$mail_mgmt_url'>$mail_mgmt_url</a></li> </ul> <p> Зауважте, що коли виборці активують свої адреси електронної пошти, вони отримують сповіщення про будь-які незавершені запрошення проголосувати в опитуваннях. </p>"
}
sub download_failures {
  'Завантажити таблицю у форматі CSV'
}

sub code_requested {
  'Запит на код. Перевірити свою електронну пошту.'
}

sub code_requested_but_something_wrong {
  'Запитано код, але щось пішло не так.'
}

sub error_handling_code_request {
  "Помилка обробки запиту коду"
}
sub invalid_email_address {
  'невірна адреса електронної пошти'
}
sub unexpected_error {
  '<b>Неочікувана помилка:</b>'
}
sub optin_error {
  'Помилка:'
}
sub submitted {
  'подано'
}

1; # package succeeded!
