package japanese;

use lib '@CGIBINDIR@';
use CGI qw(:standard -utf8);
use utf8;

use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

our $VERSION = 1.000;

sub lang { 'ja-JP' }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

### BEGIN TRANSLATIONS ###

# civs_common

sub style_file {
    return 'style.css'
# UNTRANSLATED
}
sub Condorcet_Internet_Voting_Service {
  'コンドルセ インターネット投票サービス'
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited
  'コンドルセ インターネット投票サービス'
}
sub CIVS_sender {
    my ($self) = @_;
    $self->Condorcet_Internet_Voting_Service_email_hdr
# UNTRANSLATED
}
sub about_civs {
  'CIVSについて'
}
sub new_user {
  'ユーザーをアクティブ化'
}
sub public_polls {
  '世論調査'
}
sub create_new_poll {
  '新しい投票を作成'
}
sub about_security_and_privacy {
  'セキュリティとプライバシー'
}
sub FAQ {
  'よくある質問'
}
sub CIVS_suggestion_box {
  'CIVS 提案ボックス'
}
sub unable_to_process {
  '内部エラーのため、CIVS はリクエストを処理できません。'
}
sub CIVS_Error {
  'CIVS エラー'
}
sub CIVS_server_busy {
  'CIVS サーバーがビジー状態'
}
sub Sorry_the_server_is_busy {
  '申し訳ありませんが、CIVS Web サーバーは現在非常にビジーで、これ以上のリクエストを処理できません。しばらくしてからもう一度お試しください。'
}

# civs_create

sub mail_has_been_sent {
  "入力したアドレス (<tt>$_[1]</tt>) にメールを送信しました。"
}

sub click_on_the_URL_to_start {
  "メールに記載されている URL をクリックしてアンケートを開始してください…$_[1]…。"
}

sub here_is_the_control_URL {
  '新しいポーリングを制御する URL は次のとおりです。通常の操作では、これは電子メールでスーパーバイザに送信されます。'
}
sub the_poll_is_in_progress {
  '投票が進行中です。このボタンを押して終了します。'
}

sub CIVS_Poll_Creation {
  "CIVS 投票の作成"
}
sub Poll_created {
  "投票が作成されました: $_[1]"
}

sub Address_unacceptable { #addr
  "アドレス \"$_[1]\" は受け入れられません"
}
sub Poll_must_have_two_choices {
  '投票には少なくとも 2 つの選択肢が必要です。'
}
sub Poll_exceeds_max_choices {
    my ($self, $count) = @_;
  "投票には、最大で $count の選択肢を含めることができます。"
}
sub Poll_directory_not_writeable {
  "設定ミス？ポーリング ディレクトリ <tt>$_[1]</tt> を作成できません"
}
sub CIVS_poll_created {
  "CIVS 投票が作成されました: $_[1]"
}
sub creation_email_info1 { # title, url
  "この電子メールは、新しい投票 $_[1] の作成を承認します。あなたはこの投票の監督者に指名されました。投票を開始および停止するには、次の URL を使用してください。
 <$_[2]>
このメールを保存して非公開にしてください。これを失うと、投票を制御できなくなります。
"
}
sub creation_email_public_link { # url
  "これは公開投票であるため、有権者を次の URL に誘導することができます。
 <$_[1]>
"
}

sub opted_out { # addr
  "&lt;$_[1]&gt; にメールを送信できません。 CIVS経由。"
}

sub Sending_result_key { # addr (escaped)
  "<p>結果キーを <tt>$_[1]</tt> に送信しています。完了するまでお待ちください...<br>"
}
sub Done_sending_result_key { # addr
  '...結果キーの送信が完了しました。</p>'
}
sub Results_of_CIVS_poll { # title
  "CIVS 投票の結果: $_[1]"
}
sub Results_key_email_body { # title, url, civs_home
  "\"$_[1]\" という名前の新しい CIVS 投票が作成されました。あなたは、この投票の結果を表示できるユーザーとして指定されました。
このメールを保存します。紛失すると、結果にアクセスできなくなります。投票が終了すると、次の URL で結果が表示されます。
 <$_[2]>
この URL は非公開です。許可されていないユーザーがこの URL にアクセスできるようにすると、そのユーザーは投票結果を見ることができます。
"
}

# start

sub poll_started {
  "投票 <strong>$_[1]</strong> が開始されました。"
}

sub sending_keys_now {
  '現在、有権者への招待状を送信しています。すべての招待状が送信されるまで、このページから移動しないでください。'
}

# control

sub CIVS_Poll_Control {
  "CIVS ポーリング制御"
}
sub Poll_control {
  "ポーリング制御"
}
sub poll_has_not_yet_started {
  '投票はまだ開始されていません。このボタンを押して開始します。'
}
sub Start_poll {
  '投票を開始'
}
sub End_poll {
  '投票終了'
}
sub Edit_button {
  '編集'
}
sub ResendLink_button {
  'リンクを再送信'
}
sub ResendLinkAck {
  '送信済'
}
sub Save_button {
  'セーブ'
}
sub Remove_button {
  '削除する'
}
sub confirm_ending_poll_cannot_be_undone {
  '投票の終了は元に戻せない操作です。投票を終了することを確認するには、「close」と入力します。 OKを押します'
}
sub writeins_have_been_disabled {
  '書き込みの選択肢が無効になっています'
}
sub disallow_further_writeins {
  'それ以上の書き込みを許可しない'
}
sub voting_disabled_during_writeins {
  '現在、書き込みフェーズ中の投票は無効になっています。'
}
sub allow_voting_during_writeins {
  '書き込み段階での投票を許可する'
}
sub this_is_a_test_poll {
  'これはテスト投票です。'
}
sub file_to_upload_from {
  '投票用紙をアップロードするファイル:'
}
sub Load_ballots {
  '投票用紙をロードする'
}
sub poll_supervisor { # name, email
  "投票監督者: $_[1] <tt>&lt;$_[2]&gt;</tt>"
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
  "承認された投票者の総数: $_[1]"
}
sub actual_votes_so_far { # num
  "これまでに実際に投じられた投票数: $_[1]"
}
sub poll_ends { # end
  "投票終了のお知らせ: $_[1]"
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
  '投票が完了すると、すべての有権者が投票結果を利用できます。'
}
sub Voters_can_choose_No_opinion {
  '有権者は「意見なし」を選択できます。'
}
sub Voting_is_disabled_during_writeins {
  '書き込み期間中は投票できません。'
}
sub Poll_results_will_be_available_to_the_following_users {
  '投票結果は、次のユーザーのみが利用できます。'
}
sub Poll_results_are_now_available_to_the_following_users {
  '投票結果は、結果を表示するための URL を含む電子メールが以前に送信された次のユーザーのみが利用できるようになりました。'
}
sub results_available_to_the_following_users {
  'この投票の結果は、限定された一連のユーザーにのみ公開されています。'
}

sub Poll_results_are_available { #url
  "<a href=\"$_[1]\">[&nbsp;投票結果を見る&nbsp;]</a>"
}
sub Description {
  '説明：'
}
sub Candidates {
  '候補者:'
}
sub Add_voters {
  '有権者を追加'
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
  '投票者の電子メール アドレスを 1 行に 1 つずつ入力します。これらは、新しい有権者またはまだ投票していない既存の有権者である可能性があります。非公開投票では、既存の有権者のメール アドレスを指定しても、その有権者は 2 回投票することは<strong>できません</strong>。投票者に投票への招待を再送信するだけです。公開投票では、複数の投票を防ぐためにトークンの試行のみが行われます。'
}
sub resend_question {
  'すでに投票した有権者も招待しますか?'
}
sub Upload_file {
  'ファイルをアップロードする：'
}
sub Load_ballot_data {
  '投票データの読み込み'
}
sub File_to_upload_ballots_from {
  '投票用紙をアップロードするファイル:'
}
sub Upload_instructions {
  '1 行に 1 つの投票用紙でフォーマットされたテキスト ファイルをアップロードします。各行には、1 から N までの数字、または意見がないことを表すダッシュ (<kbd>-</kbd>) である N 個の選択肢のランクが含まれています。ランクは、空白またはコンマで区切る必要があります。行は LF または CR/LF で終了できます。空白は無視されます。最初の非空白文字が # である行も無視されます。行は <i>m</i><kbd>X</kbd> で始まる場合があります。ここで、<i>m</i> は数字で、残りの部分で記述された <i>m</i> 個の同一の投票を意味します。行の。'
}
sub Examples_of_ballots {
  '投票用紙の例:'
}
sub Ballot_examples {
  ' 1,4,3,2,5 <i>5 つの選択肢をランク付けする単純な投票。</i> 5 - 2 - 3 <i>5 つの選択肢の別のランキング。ダッシュはランク付けされていない選択肢を示します。</i> 8X1 4 3 2 5 <i>最初の投票例のように 8 つの投票。</i>'
}
sub Or_paste_this_code {
  'または、この HTML コードを自分の Web ページに貼り付けます。'
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
  '投票は終了しました。'
}

# add voters

sub CIVS_Adding_Voters {
  'CIVS: 有権者の追加'
}
sub Adding_voters {
  '有権者の追加'
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
  '申し訳ありませんが、有権者は進行中の投票にのみ追加できます。'
}
sub Too_many_voters_added {
  '一度に追加できるのは @MAX_VOTER_ADD@ 人の投票者のみです。'
}
sub Too_much_email {
  '申し訳ありませんが、CIVS は生成される電子メールの量に制限を設けています。後で有権者を追加してください。'
}
sub Out_of_upload_space {
  'サーバーでアップロード用のディスク容量が不足している可能性があります。'
}
sub Uploaded_file_empty {
    my ($self, $desc) = @_;
  "アップロードされた $desc は空です。"
}
sub No_upload_file_provided {
    my ($self, $desc) = @_;
  "$desc が提供されていません。アップロードに失敗しました。"
}
sub Didnt_get_plain_text {
    my ($self, $type) = @_;
  "アップロードされた入力は、プレーン テキスト ファイルまたは CSV ファイルでなければなりません (代わりに <b>$type</b> を受け取りました)"
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
  '投票制御に戻る'
}
sub Done {
  '終わり。'
}

sub Email_voters_who_have_not_activated {
  'アクティブ化していない有権者に電子メールを送信する'
}

sub Activate_mail_subject {
  'CIVS でメールアドレスを有効にしてください'
}
sub Address {
  '住所'
}
sub Reason {
  '理由'
}

sub Activate_mail_body {
    my ($self, $supervisor, $name, $title, $url) = @_;
  "あなたは、$name <$supervisor> から、「$title」というタイトルの投票に招待されました。
 投票するには、次の CIVS 投票システムで電子メール アドレスを有効にしてください: <$url>"
}


# vote

sub page_header_CIVS_Vote { # election_title
  'CIVS 投票: '.$_[1]
}

sub ballot_reporting_is_enabled {
  'この投票では、投票レポートが有効になっています。あなたの投票 (選択肢に割り当てるランキング) は、投票が終了すると投票結果に表示されます。'
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
  'メールアドレスまたはその他の認識可能な識別子を入力してください:'
}
sub Need_identifier {
  '申し訳ありませんが、投票するには本人確認が必要です。'
}

sub Rank {
  'ランク'
}
sub Choice {
  '選択'
}
sub Weight {
  '重さ'
}

# overridden in english.pm
sub ordinal_of {
  "$_[1]"
}

sub address_will_be_visible {
  '<strong>あなたのメール アドレスは、投票用紙とともに表示されます</strong>。'
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
  ' ただし、投票は引き続き匿名で行われます。個人を特定する情報は表示されません。'
}

sub submit_ranking {
  'ランキングを送信'
}

sub only_writeins_are_permitted {
  'この投票では、投票はまだ許可されていません。ただし、利用可能な選択肢を表示して、新しい選択肢を書き込むことはできます。下のテキスト フィールドを使用して、新しい選択肢を入力します。'
}

sub Add_writein {
  '書き込みを追加'
}

sub to_top {
  'トップに'
}
sub to_bottom {
  '一番下まで'
}
sub move_up {
  '上に移動'
}
sub move_down {
  '下に移動'
}
sub make_tie {
  'ネクタイをする'
}
sub buttons_are_deactivated {
  'お使いのブラウザは Javascript をサポートしていないため、これらのボタンは無効になっています。'
}
sub ranking_instructions {
  '<p>次の 3 つの方法のいずれかで選択肢をランク付けします。</p> <ol> <li>行をドラッグします</li> <li>ランク列でプルダウンを使用します</li> <li>行を選択し、上のボタンを使用します</li> </ol>'
}
sub write_in_a_choice {
  '新しい選択肢を書きます:'
}
sub show_qr_code {
  'この投票の QR コードを表示します。'
}
sub if_you_have_already_voted { #url
  "すでに投票したことがある場合は、<a href=\"$_[1]\">現在の投票結果</a>が表示されることがあります。"
}
sub thank_you_for_voting { #title, receipt
  "ありがとう。 <strong>$_[1]</strong> への投票が完了しました。<br>投票者の領収書は <code>$_[2]</code> です。後で投票用紙を変更する場合は、この領収書が必要になります。"
}
sub try_some_public_polls {
  "他の何かに投票したいですか？次の公開投票のいずれかを試してください。"
}
sub you_can_change_ballot_now {
  'このページから、投じた投票を消去して、再度投票することができます。'
}
sub change_ballot {
  '取り消す'
}
sub name_of_writein_is_empty {
  "書き込み選択肢の名前が空です"
}
sub writein_too_similar {
  "申し訳ありませんが、書き込みの名前が既存の選択肢に似すぎています"
}
sub doublecheck_msg {
  'あなたが意見を持っているすべての候補者が引き分けであるため、あなたの投票は無効です。それでも提出しますか？'
}

# election

sub No_poll_ID {
  "投票 ID が指定されていません。もしかしてコピペミス？"
}
sub Ill_formed_poll_ID {
  "不適切な形式のポーリング ID が指定されました。もしかしてコピペミス？ (" . $_[1] . ")"
}
sub vote_has_already_been_cast {
  "投票者キーを使用して、すでに投票が行われています。"
}
#deprecated, use future_result_link
sub following_URL_will_report_results {
  '投票が終了すると、次の URL で投票結果が報告されます。'
}
sub future_result_link {
    my ($self, $url) = @_;
  "次の URL は、投票が終了すると投票結果を報告します: <a href='$url'><code>$url</code></a>"
}
#deprecated
sub following_URL_reports_results {
  '次の URL は、現在の投票結果を報告します。'
}
sub if_you_want_to_change {
  'ここに有権者の領収書を入力することで、以前の投票を削除して再度投票することができます。'
}
sub invalid_release_key {
    my ($self, $receipt) = @_;
  '提供された有権者領収書 ('.$receipt.') が正しくありません。 '.code('E_2ad1ca99ac3cac7a/3a191bd9fb00ef73').' のようになります。'
}
sub no_ballot_under_key {
    my ($self, $key) = @_;
  "レシート $key の以前の投票は見つかりませんでした"
}
sub current_result_link {
    my ($self, $url) = @_;
  "<a href=\"$url\" class=result_link>現在の投票結果に移動</a>"
}
sub Already_voted {
  'すでに投票済み'
}
sub Error {
  'エラー'
}
sub Invalid_key {
  '無効キー。メールで投票を制御するための正しい URL を受け取っているはずです。このエラーはログに記録されています。'
}
sub Authorization_failure {
  '認証失敗'
}

sub already_ended { # title
  "この投票 (<strong>$_[1]</strong>) は既に終了しています。"
}
sub Poll_not_yet_ended {
  "投票はまだ終了していません"
}
sub The_poll_has_not_yet_been_ended { #title, name, email
  "このポーリング ($_[1]) は、スーパーバイザ $_[2] ($_[3]) によってまだ終了されていません。"
}

# deprecated
sub The_results_of_this_completed_poll_are_here {
  'この完了した投票の結果は次のとおりです。'
}
sub completed_results_link {
    my ($self, $url) = @_;
  "<a href=\"$url\" class=result_link>完了した投票結果に移動</a>"
}

sub No_write_access_to_lock_poll {
  "ポーリングをロックするために必要な書き込みアクセスがありませんでした。"
}
sub This_poll_has_already_been_started { # title
  "この投票 ($_[1]) は既に開始されています。"
}
sub No_write_access_to_start_poll {
  'ポーリングを開始するための書き込みアクセス権がありませんでした。'
}
sub Poll_does_not_exist_or_not_started {
  'この投票は存在しないか、開始されていません。'
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
  "無効な結果キー: \"$_[1]\"。投票結果を表示するための正しい URL をメールで受け取っているはずです。このエラーはログに記録されています。"
}
sub Invalid_control_key { # key
  "コントロール キーが無効です。メールで投票を制御するための正しい URL を受け取っているはずです。このエラーはログに記録されています。"
}
sub Invalid_voting_key {
  "投票キーが無効です。メールで投票用の正しい URL を受け取っているはずです。このエラーはログに記録されています。"
}
sub Invalid_poll_id {
  "ポーリング ID が無効です"
}
sub Poll_id_not_valid { #id
  "ポーリング ID \"$_[1]\" は無効です。"
}
sub Unable_to_append_to_poll_log {
  "ポーリング ログに追加できません。"
}
sub Voter_v_already_authorized {
  "投票者 &lt;$_[1]&gt;すでに認可されています。投票者の鍵は投票者に再送信されます。"
}
sub Skipping_already_voted {
  "投票者をスキップ &lt;$_[1]&gt;: すでに投票済み。"
}
sub Invalid_email_address_hdr { # addr
  "無効なメールアドレス"
}
sub Invalid_email_address { # addr
  "無効な電子メール アドレス: $_[1]"
}
sub Address_opted_out { # addr
  "このアドレスは CIVS メールからオプトアウトしています: $_[1]"
}
sub Sending_mail_to_voter_v {
  "有権者 \"$_[1]\" にメールを送信しています..."
}
sub CIVS_poll_supervisor { # name
  "\"Condorcet インターネット投票サービス ($_[1] の代理)\""
}
sub From_poll_supervisor {
    my ($self, $name) = @_;
    $self->CIVS_poll_supervisor($name)
# UNTRANSLATED
}
sub voter_mail_intro { #title, name, email_addr
  "<b>$_[1]</b> という名前のコンドルセ インターネット投票サービスの投票が作成されました。投票監督者 $_[2] (<a href=\"mailto:$_[3] ($_[2])\"><code>$_[3]< /コード></a>).</p>"
}
sub Description_of_poll {
  '投票の説明:'
}
sub if_you_would_like_to_vote_please_visit {
  '投票したい場合は、次の URL にアクセスしてください。'
}
sub This_is_your_private_URL {
  'これはあなたのプライベート URL です。あなたに投票するために使用される可能性があるため、他の人には渡さないでください。'
}
sub Your_privacy_will_not_be_violated {
  '投票によってあなたのプライバシーが侵害されることはありません。投票サービスは、あなたの電子メールアドレスの記録をすでに破棄しており、あなたが投票したかどうか、またはどのように投票したかについての情報を公開することはありません.'
}
sub This_is_a_nonanonymous_poll {
  '投票監督者は、これを<strong>非匿名の投票</strong>にすることを決定しました。投票すると、あなたのメール アドレスと投票方法が、投票結果へのアクセスを許可されているすべてのユーザーに表示されます。'
}


sub poll_has_been_announced_to_end { #election_end
  "投票は $_[1] 終了することが発表されました。"
}

sub To_view_the_results_at_the_end {
  "終了後に投票結果を表示するには、次の URL にアクセスしてください:</p> $_[1]"
}

sub for_more_information_about_CIVS { # url
  "コンドルセ インターネット投票サービスの詳細については、$_[1] を参照してください。"
}

sub For_more_information { # url, mail mgmt url
  ($self, $home, $mail_mgmt) = @_;
  "For more information about the Condorcet Internet Voting Service, see
   $home. To control future email sent from CIVS, see $mail_mgmt"
# UNTRANSLATED
}

sub poll_email_subject { # title
  "投票: $_[1]"
}

# close

sub CIVS_Ending_Poll {
  'CIVS: 終了投票'
}

sub Ending_poll {
  '投票の終了'
}
sub View_poll_results {
  '投票結果を見る'
}
sub Poll_ended { #title
  "投票終了: $_[1]"
}

sub The_poll_has_been_ended { #election_end
  "投票は終了しました。 $_[1] を終了すると発表されました。"
}

sub poll_results_available_to_authorized_users {
  '承認されたユーザーが投票結果を利用できるようになりました。'
}

sub was_not_able_stop_the_poll {
  '投票を停止できませんでした'
}


# results

sub CIVS_poll_result {
  "CIVS 投票結果"
}
sub Poll_results { # title
  "投票結果: $_[1]"
}

sub Writeins_currently_allowed {
  '書き込みの選択肢は現在許可されています。'
}

sub Writeins_allowed {
  '書き込みの選択肢が許可されます。'
}
sub Writeins_not_allowed {
  '書き込みの選択肢は許可されていません。'
}
sub Detailed_ballot_reporting_enabled {
  '詳細な投票レポートが有効になっています。'
}
sub Detailed_ballot_reporting_disabled {
  '詳細な投票レポートは無効になっています。'
}
sub Voter_identities_will_be_kept_anonymous {
  '有権者の身元は匿名で保持されます'
}
sub Voter_identities_will_be_public {
  '有権者の身元 (電子メール) とその投票用紙は、投票結果を表示する権限のあるユーザーに表示されます。'
}
sub Condorcet_completion_rule {
  'コンドルセ完了規則:'
}
sub undefined_algorithm {
  'エラー: アルゴリズムが定義されていません。'
}
sub computing_results {
  '結果を計算しています...'
}
sub Supervisor { #name, email
  "スーパーバイザー: $_[1] <tt>&lt;$_[2]&gt;</tt>"
}
sub Announced_end_of_poll {
  "投票終了のお知らせ: $_[1]"
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
  '投票はまだ終了していません。'
}
sub This_is_a_test_poll {
  'これはテスト投票です。'
}
sub This_is_a_private_poll { #num_auth
  "非公開投票 ($_[1] 人の権限のある投票者)"
}
sub This_is_a_public_poll {
  'これは公開投票です。'
}

sub Actual_votes_cast { #num_votes
  "実際の投票: $_[1]"
}
sub Number_of_winning_candidates {
  '当選数：'
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
  '投票の説明'
}
sub Ranking_result {
  '結果'
}
sub x_beats_y { # x y w l
  "$_[1] が $_[2] $_[3] に勝った&ndash;$_[4]"
}
sub x_ties_y { # x y w l
  "$_[1] 同点 $_[2] $_[3]&ndash;$_[4]"
}
sub x_loses_to_y { # x y w l
  "$_[1] は $_[2] $_[3] に負けます&ndash;$_[4]"
}
sub some_result_details_not_shown {
  '簡単にするために、投票結果の一部の詳細は示していません。'
}
sub Show_details {
  '詳細を表示'
}
sub Hide_details {
  '詳細を非表示'
}
sub Result_details {
  '結果詳細'
}
sub Ballot_report {
  '投票レポート'
}
sub Ballots_are_shown_in_random_order {
  "投票はランダムに生成された順序で表示されます。"
}
sub Download_ballots_as_a_CSV { # url
  "[<a href=\"$_[1]\">投票用紙を CSV 形式でダウンロード</a>]"
}
sub No_ballots_were_cast {
  "この世論調査では投票は行われませんでした。"
}
sub Ballot_reporting_was_not_enabled {
  'この投票では、投票レポートが有効になっていませんでした。'
}
sub Tied {
  "<i>同点</i>:"
}
sub loss_explanation { # loss_to, for, against
  '、 に負けます。 ' . $_[1] . 'に'. $_[2] .'&ndash;'. $_[3]
}
sub loss_explanation2 {
  '&nbsp;&nbsp;は'.$_[1].'に負けます。 by '.$_[2].'&ndash;'.$_[3]
}
sub Condorcet_winner_explanation {
  '&nbsp;&nbsp;(コンドルセ勝者: 他のすべての選択肢でコンテストに勝つ)'
}
sub undefeated_explanation {
  '&nbsp;&nbsp;(どのコンテストでも負けていない vs. 別の選択肢)'
}
sub Choices_shown_in_red_have_tied {
  '赤で表示されている選択肢は、選択されたために引き分けです。それらの中からランダムに選択することもできます。'
}
sub Condorcet_winner {
  "コンドルセ勝者"
}
sub Choices_in_individual_pref_order {
  '選択肢（個人の好み順）'
}

sub Unknown_email {
  '（わからない）'
}

sub What_is_this { # url
  '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>(これは何?)</small></a>'
}

# rp

sub All_prefs_were_affirmed {
  'すべての好みが確認されました。'
}

sub Presence_of_a_green_entry_etc {
  '対角線の下にある緑色のエントリ (および対応する上の赤色のエントリ) は、優先度が他の強力な優先度と競合したために無視されたことを意味します。'
}
sub Random_tie_breaking_used {
  'この順序付けに到達するために、MAM アルゴリズムに従って、ランダム タイ ブレークが使用されました。これは、選択肢の順序に影響を与えた可能性があります。'
}
sub No_random_tie_breaking_used {
  'この順序にたどり着くのに、ランダムなタイブレークは必要ありませんでした。'
}

# beatpath

sub beatpath_matrix_explanation {
  '次のマトリックスは、選択肢の各ペアを結ぶ最強のビートパスの強さを示しています。 1 から 2 へのビートパスが 2 から 1 へのビートパスよりも強い場合、選択肢 1 は選択肢 2 より上にランク付けされます。'
}

sub no_pref {
  '無し'
}

#rp

sub Some_voter_preferences_were_ignored {
  '一部の有権者の設定は、他のより強力な設定と競合するため無視されました。'
}

sub preference_description {
  "$_[4] よりも $_[3] に対する $_[1]&ndash;$_[2] の優先度。"
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
  '電子メールアドレス：'
}
sub deactivation_code {
  '無効化コード:'
}
sub filter_question {
  'フィルター パターン <small> (空白のままにすることができます。ホバーするとヘルプが表示されます)</small>'
}
sub filter_explanation {
  'ここに 1 つ以上のパターンを入力して、電子メールを禁止するポーリング スーパーバイザを指定できます。パターンは、スーパーバイザーの電子メール アドレスまたは電子メール アドレスを説明するパターンです。パターンでは * を使用して任意の文字列を表すことができます。たとえば、パターン *@inmano.com は、@inmano.com アドレスを持つスーパーバイザーが投票の招待状を送信するのを防ぎます。このフィールドを空白のままにすると、無効化/再有効化がすべてのメール アドレスに適用されます。'
}
sub send_deactivation_code {
  '無効化コードをメールで送信'
}
sub cant_send_email {
  'CIVS を使用してこのユーザーに電子メールを送信することはできません。このユーザーへの電子メールは、以前に送信された無効化コードを使用して最初に再有効化する必要があります。'
}
sub submit_deact_react {
  '非アクティブ化/再アクティブ化を送信'
}
sub codes_dont_match {
  "入力されたコードとメールアドレスが一致しません。以前に CIVS からの電子メールをブロックしたことがない場合は、別のコードを要求できます。"
}
sub deactivation_successful {
    my ($self, $pattern) = @_;
  "送信者がこのパターン \"$pattern\" に一致する場合、CIVS はこのアドレスにこれ以上メールを送信しません。 CIVS からのメールを再アクティブ化するには、この Web ページを使用して、先ほど使用したのと同じコードを使用します。"
}
sub reactivation_successful {
  'このアドレスへのメールを正常に再開しました。'
}
sub someone_has_requested {
  "CIVS があなたに電子メールを送信しないようにするためのコードが要求されました。それがあなたなら、あなたはそれをどうするかを知っているでしょう。コードは次のとおりです。
 $_[1]
今後サービスを使用する場合にこのコードが必要になるため、このメールを保管しておいてください。"
}
sub deactivation_code_subject {
  'CIVS メールの無効化コード'
}
sub mail_mgmt_title {
  'メール管理'
}

## User activation

sub user_activation {
  'ユーザーをアクティブ化'
}
sub activation_code_subject {
  'CIVS を使用するためのアクティベーション コード'
}
sub user_activation_instructions1 {
  '非公開の CIVS 投票に投票するには、サービスからの電子メール通信にオプトインする必要があります。 CIVS はあなたの電子メール アドレスを保存せず、自動メールもありません。投票監督者の明示的な要求があった場合にのみ、サービスから電子メールを受け取ります。これには、プライベート投票で投票したり、投票結果を表示したりするために必要な資格情報が含まれています。'
}
sub user_activation_instructions2 {
  "オプトインするには、メールアドレスを入力して下のボタンをクリックしてください。その後、アクティベーション コードが記載されたメールが届きます。以前にメールをオプトアウトしたことがある場合は、<a href=\"$_[1]\">メール管理ページ</a>を使用してメールを再度有効にする必要があります。メール ブロッキング サービスを使用している場合は、CIVS の電子メール アドレスを許可された送信者 (".'@SUPERVISOR@'.") としてホワイトリストに登録する必要がある場合があります。"
}
sub user_activation_instructions {
    my ($self, $mail_mgmt_url) = @_;
    p($self->user_activation_instructions1).
    p($self->user_activation_instructions2($mail_mgmt_url))
# UNTRANSLATED
}
sub opt_in_label {
  'アクティベーション コードのリクエスト'
}
sub activation_code {
  'アクティベーション コード:'
}
sub someone_has_requested_activation {
    my ($self, $address, $code, $mail_mgmt_url) = @_;
  "投票で投票するために、CIVS 投票システムが電子メール アドレス <$address> を有効にするように誰かが要求しました。このアドレスを有効にするには、次の有効化コードが必要です。
 $コード
このリクエストを開始した覚えがない場合は、このメールを無視してかまいません。
このリンクを使用して、CIVS からの電子メールを制御します: $mail_mgmt_url。"
}
sub already_activated {
  'このメールアドレスはすでに有効になっています。'
}
sub activation_successful
{
    'Email address successfully activated.'
}
sub pending_invites_hdr {
  '保留中の投票への招待:'
}
sub submit_activation_code {
  'アクティベーションを完了する'
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
  "申し訳ありませんが、アドレス &lt;$address&gt; を有効にしたユーザーはいません。メールを受信します。"
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
  "<p>以下の表にリストされている理由により、CIVS は一部の有権者にメールを送信できませんでした。投票者は個人キーを受け取るまで投票できませんので、投票者に直接連絡してください。有権者は、次のリンクが役立つ可能性があります。</p> <ul> <li>CIVS でメール アドレスを有効にする: <a href='$activate_url'>$activate_url</a></li> <li>無効にする/電子メール アドレスを再有効化: <a href='$mail_mgmt_url'>$mail_mgmt_url</a></li> </ul> <p> 有権者が電子メール アドレスを有効にすると、保留中の投票への招待について通知されることに注意してください。世論調査で。 </p>"
}
sub download_failures {
  'テーブルを CSV としてダウンロード'
}

sub code_requested {
  'コードが要求されました。あなたのメールをチェック。'
}

sub code_requested_but_something_wrong {
  'コードが要求されましたが、問題が発生しました。'
}

sub error_handling_code_request {
  "エラー処理コード リクエスト"
}
sub invalid_email_address {
  '無効なメールアドレス'
}
sub unexpected_error {
  '<b>予期しないエラー:</b>'
}
sub optin_error {
  'エラー：'
}
sub submitted {
  '提出した'
}

1; # package succeeded!
