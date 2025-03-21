package korean;

use lib '@CGIBINDIR@';
use CGI qw(:standard -utf8);
use utf8;

use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

our $VERSION = 1.000;

sub lang { 'ko-KR' }

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
  '콩도르세 인터넷 투표 서비스'
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited
  '콩도르세 인터넷 투표 서비스'
}
sub CIVS_sender {
    my ($self) = @_;
    $self->Condorcet_Internet_Voting_Service_email_hdr
# UNTRANSLATED
}
sub about_civs {
  'CIVS 소개'
}
sub new_user {
  '사용자 활성화'
}
sub public_polls {
  '공개 여론 조사'
}
sub create_new_poll {
  '새 투표 만들기'
}
sub about_security_and_privacy {
  '보안 및 개인정보 보호'
}
sub FAQ {
  '자주하는 질문'
}
sub CIVS_suggestion_box {
  'CIVS 제안 상자'
}
sub unable_to_process {
  '내부 오류로 인해 CIVS에서 요청을 처리할 수 없습니다.'
}
sub CIVS_Error {
  'CIVS 오류'
}
sub CIVS_server_busy {
  'CIVS 서버 사용 중'
}
sub Sorry_the_server_is_busy {
  '죄송합니다. 현재 CIVS 웹 서버가 매우 바빠서 추가 요청을 처리할 수 없습니다. 잠시 후 다시 시도해 주세요.'
}

# civs_create

sub mail_has_been_sent {
  "귀하가 제공한 주소(<tt>$_[1]</tt>)로 메일이 발송되었습니다."
}

sub click_on_the_URL_to_start {
  "해당 이메일의 URL을 클릭하여 설문 조사를 시작하세요 $_[1]â."
}

sub here_is_the_control_URL {
  '다음은 새 투표를 제어하는 URL입니다. 정상적인 작업에서 이것은 이메일을 통해 감독자에게 전송됩니다.'
}
sub the_poll_is_in_progress {
  '설문조사가 진행 중입니다. 종료하려면 이 버튼을 누르세요.'
}

sub CIVS_Poll_Creation {
  "CIVS 투표 생성"
}
sub Poll_created {
  "설문 생성: $_[1]"
}

sub Address_unacceptable { #addr
  "\"$_[1]\" 주소는 허용되지 않습니다."
}
sub Poll_must_have_two_choices {
  '투표에는 적어도 두 가지 선택 항목이 있어야 합니다.'
}
sub Poll_exceeds_max_choices {
    my ($self, $count) = @_;
  "투표는 최대 $count 선택 항목을 가질 수 있습니다."
}
sub Poll_directory_not_writeable {
  "구성 오류? 폴링 디렉터리 <tt>$_[1]</tt>를 만들 수 없습니다."
}
sub CIVS_poll_created {
  "생성된 CIVS 투표: $_[1]"
}
sub creation_email_info1 { # title, url
  "이 이메일은 새 투표 $_[1]의 생성을 확인합니다. 귀하는 이 투표의 감독관으로 지정되었습니다. 설문 조사를 시작하고 중지하려면 다음 URL을 사용하십시오.
 <$_[2]>
이 이메일을 저장하고 비공개로 유지하세요. 당신이 그것을 잃으면 당신은 투표를 제어할 수 없습니다.
"
}
sub creation_email_public_link { # url
  "이것은 공개 투표이므로 유권자를 다음 URL로 안내할 수 있습니다.
 <$_[1]>
"
}

sub opted_out { # addr
  "죄송합니다. &lt;$_[1]&gt;에 이메일을 보낼 수 없습니다. CIVS를 통해"
}

sub Sending_result_key { # addr (escaped)
  "<p>결과 키를 <tt>$_[1]</tt>에 보내는 중입니다. 이 작업이 완료될 때까지 기다리십시오...<br>"
}
sub Done_sending_result_key { # addr
  '...결과 키 전송을 완료했습니다.</p>'
}
sub Results_of_CIVS_poll { # title
  "CIVS 투표 결과: $_[1]"
}
sub Results_key_email_body { # title, url, civs_home
  "\"$_[1]\"라는 새 CIVS 투표가 생성되었습니다. 귀하는 이 투표 결과를 볼 수 있는 사용자로 지정되었습니다.
이 이메일을 저장하세요. 잃어버리면 결과에 액세스할 수 없습니다. 투표가 종료되면 다음 URL에서 결과를 확인할 수 있습니다.
 <$_[2]>
이 URL은 비공개입니다. 승인되지 않은 사용자가 이 URL에 액세스하도록 허용하면 투표 결과를 볼 수 있습니다.
"
}

# start

sub poll_started {
  "설문 <strong>$_[1]</strong>이(가) 시작되었습니다."
}

sub sending_keys_now {
  '지금 유권자 초대장을 보냅니다. 모든 초대장이 전송될 때까지 이 페이지에서 벗어나지 마십시오.'
}

# control

sub CIVS_Poll_Control {
  "CIVS 투표 제어"
}
sub Poll_control {
  "투표 제어"
}
sub poll_has_not_yet_started {
  '아직 설문조사가 시작되지 않았습니다. 시작하려면 이 버튼을 누르세요.'
}
sub Start_poll {
  '설문조사 시작'
}
sub End_poll {
  '설문조사 종료'
}
sub Edit_button {
  '편집하다'
}
sub ResendLink_button {
  '링크 재전송'
}
sub ResendLinkAck {
  '전송된'
}
sub Save_button {
  '저장'
}
sub Remove_button {
  '제거하다'
}
sub confirm_ending_poll_cannot_be_undone {
  '투표 종료는 취소할 수 없는 작업입니다. 투표 종료를 확인하려면 &#34;close&#34;를 입력하십시오. 확인을 누릅니다.'
}
sub writeins_have_been_disabled {
  '쓰기 선택이 비활성화되었습니다.'
}
sub disallow_further_writeins {
  '추가 기입 금지'
}
sub voting_disabled_during_writeins {
  '현재 쓰기 단계에서는 투표가 비활성화되어 있습니다.'
}
sub allow_voting_during_writeins {
  '기명 단계에서 투표 허용'
}
sub this_is_a_test_poll {
  '테스트 투표입니다.'
}
sub file_to_upload_from {
  '투표 용지를 업로드할 파일:'
}
sub Load_ballots {
  '투표 용지 로드'
}
sub poll_supervisor { # name, email
  "투표 감독자: $_[1] <tt>&lt;$_[2]&gt;</tt>"
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
  "승인된 총 투표자 수: $_[1]"
}
sub actual_votes_so_far { # num
  "지금까지 실제로 투표한 투표: $_[1]"
}
sub poll_ends { # end
  "투표 종료 발표: $_[1]"
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
  '투표가 완료되면 모든 유권자가 투표 결과를 볼 수 있습니다.'
}
sub Voters_can_choose_No_opinion {
  '유권자는 &ldquo;의견 없음&rdquo;을 선택할 수 있습니다.'
}
sub Voting_is_disabled_during_writeins {
  '기명 기간 동안 투표가 비활성화됩니다.'
}
sub Poll_results_will_be_available_to_the_following_users {
  '투표 결과는 다음 사용자에게만 제공됩니다.'
}
sub Poll_results_are_now_available_to_the_following_users {
  '투표 결과는 이전에 결과를 볼 수 있는 URL이 포함된 이메일을 보낸 다음 사용자만 사용할 수 있습니다.'
}
sub results_available_to_the_following_users {
  '이 설문 조사의 결과는 제한된 사용자에게만 공개되었습니다.'
}

sub Poll_results_are_available { #url
  "<a href=\"$_[1]\">[&nbsp;설문 조사 결과 보기&nbsp;]</a>"
}
sub Description {
  '설명:'
}
sub Candidates {
  '후보자:'
}
sub Add_voters {
  '유권자 추가'
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
  '유권자의 이메일 주소를 한 줄에 하나씩 입력하십시오. 신규 유권자이거나 아직 투표하지 않은 기존 유권자일 수 있습니다. 비공개 투표에서 기존 유권자의 이메일 주소를 제공하면 해당 유권자가 두 번 투표할 수 <strong>없습니다</strong>. 유권자에게 투표 초대를 다시 보낼 뿐입니다. 공개 투표에서는 다중 투표를 방지하기 위해 토큰 시도만 수행됩니다.'
}
sub resend_question {
  '이미 투표한 유권자도 초대하시겠습니까?'
}
sub Upload_file {
  '파일 업로드:'
}
sub Load_ballot_data {
  '투표 데이터 로드'
}
sub File_to_upload_ballots_from {
  '투표 용지를 업로드할 파일:'
}
sub Upload_instructions {
  '한 줄에 하나의 투표용지 형식의 텍스트 파일을 업로드하십시오. 각 행에는 N 선택 항목의 순위가 포함되며, 이는 1에서 N까지의 숫자 또는 의견이 없음을 나타내는 대시(<kbd>-</kbd>)입니다. 순위는 공백이나 쉼표로 구분해야 합니다. 라인은 LF 또는 CR/LF로 종료될 수 있습니다. 공백은 무시됩니다. 공백이 아닌 첫 번째 문자가 #인 행도 무시됩니다. 줄은 <i>m</i><kbd>X</kbd>로 시작할 수 있습니다. 여기서 <i>m</i>은 숫자이며, 이는 <i>m</i> 나머지에 의해 설명된 동일한 투표용지를 나타냅니다. 라인의.'
}
sub Examples_of_ballots {
  '투표용지의 예:'
}
sub Ballot_examples {
  ' 1,4,3,2,5 <i>5개의 선택 항목에 대한 간단한 투표.</i> 5 - 2 - 3 <i>5개의 선택 항목에 대한 또 다른 순위. 대시는 순위가 매겨지지 않은 선택을 나타냅니다.</i> 8X1 4 3 2 5 <i>첫 번째 예시 투표지와 같은 8개의 투표지.</i>'
}
sub Or_paste_this_code {
  '또는 이 HTML 코드를 자신의 웹 페이지에 붙여넣으십시오.'
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
  '설문조사가 종료되었습니다.'
}

# add voters

sub CIVS_Adding_Voters {
  'CIVS: 유권자 추가'
}
sub Adding_voters {
  '유권자 추가'
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
  '죄송합니다. 유권자는 진행 중인 설문조사에만 추가할 수 있습니다.'
}
sub Too_many_voters_added {
  '죄송합니다. 한 번에 @MAX_VOTER_ADD@ 유권자만 추가할 수 있습니다.'
}
sub Too_much_email {
  '죄송합니다. CIVS는 생성되는 이메일의 양을 제한합니다. 나중에 유권자를 더 추가하십시오.'
}
sub Out_of_upload_space {
  '서버에 업로드할 디스크 공간이 부족할 수 있습니다.'
}
sub Uploaded_file_empty {
    my ($self, $desc) = @_;
  "업로드된 $desc가 비어 있습니다."
}
sub No_upload_file_provided {
    my ($self, $desc) = @_;
  "$desc가 제공되지 않았습니다. 업로드에 실패했습니다."
}
sub Didnt_get_plain_text {
    my ($self, $type) = @_;
  "업로드된 입력은 일반 텍스트 파일 또는 CSV 파일이어야 합니다(대신 <b>$type</b> 수신됨)."
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
  '투표 관리로 돌아가기'
}
sub Done {
  '완료.'
}

sub Email_voters_who_have_not_activated {
  '활성화하지 않은 유권자에게 이메일 보내기'
}

sub Activate_mail_subject {
  'CIVS에서 이메일 주소를 활성화하십시오.'
}
sub Address {
  '주소'
}
sub Reason {
  '이유'
}

sub Activate_mail_body {
    my ($self, $supervisor, $name, $title, $url) = @_;
  "$name <$supervisor>님이 $titleâ 제목의 투표에 초대하셨습니다.
 투표하려면 <$url>에서 CIVS 투표 시스템으로 이메일 주소를 활성화하십시오."
}


# vote

sub page_header_CIVS_Vote { # election_title
  'CIVS 투표: '.$_[1]
}

sub ballot_reporting_is_enabled {
  '이 투표에 대해 투표 보고가 사용 설정되었습니다. 귀하의 투표(선택 항목에 할당한 순위)는 투표가 종료되면 투표 결과에 표시됩니다.'
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
  '귀하의 이메일 주소 또는 기타 식별 가능한 식별자를 제공하십시오.'
}
sub Need_identifier {
  '죄송합니다. 투표하려면 신분을 밝혀야 합니다.'
}

sub Rank {
  '계급'
}
sub Choice {
  '선택'
}
sub Weight {
  '무게'
}

# overridden in english.pm
sub ordinal_of {
  "$_[1]"
}

sub address_will_be_visible {
  '투표용지와 함께 <strong>이메일 주소가 표시</strong>됩니다.'
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
  ' 그러나 귀하의 투표용지는 여전히 익명으로 처리됩니다. 개인 식별 정보는 표시되지 않습니다.'
}

sub submit_ranking {
  '순위 제출'
}

sub only_writeins_are_permitted {
  '이 투표에서는 아직 투표가 허용되지 않습니다. 그러나 사용 가능한 선택 항목을 보고 새 선택 항목을 작성할 수 있습니다. 아래의 텍스트 필드를 사용하여 새로운 선택 항목을 작성하십시오.'
}

sub Add_writein {
  '기명 추가'
}

sub to_top {
  '상단으로'
}
sub to_bottom {
  '바닥으로'
}
sub move_up {
  '이동'
}
sub move_down {
  '아래로 이동'
}
sub make_tie {
  '넥타이를 매다'
}
sub buttons_are_deactivated {
  '브라우저가 Javascript를 지원하지 않기 때문에 이 버튼은 비활성화되어 있습니다.'
}
sub ranking_instructions {
  '<p>세 가지 방법 중 하나로 선택 순위 지정:</p> <ol> <li>행 드래그</li> <li>순위 열에서 풀다운 사용</li> <li>행 선택 및 위의 버튼 사용 </리> </올>'
}
sub write_in_a_choice {
  '새로운 선택을 작성하십시오.'
}
sub show_qr_code {
  '이 설문조사의 QR 코드를 보여주세요.'
}
sub if_you_have_already_voted { #url
  "이미 투표했다면 <a href=\"$_[1]\">현재 투표 결과</a>를 볼 수 있습니다."
}
sub thank_you_for_voting { #title, receipt
  "고맙습니다. <strong>$_[1]</strong>에 대한 귀하의 투표가 성공적으로 이루어졌습니다.<br> 귀하의 유권자 영수증은 <code>$_[2]</code>입니다. 나중에 투표 용지를 변경하려면 이 영수증이 필요합니다."
}
sub try_some_public_polls {
  "다른 것에 투표하고 싶습니까? 다음 공개 설문 조사 중 하나를 시도하십시오."
}
sub you_can_change_ballot_now {
  '이 페이지에서 투표한 투표지를 지우고 다시 투표할 수 있습니다.'
}
sub change_ballot {
  '철회하다'
}
sub name_of_writein_is_empty {
  "기명 선택 항목의 이름이 비어 있습니다."
}
sub writein_too_similar {
  "죄송합니다. 작성 이름이 기존 선택 항목과 너무 유사합니다."
}
sub doublecheck_msg {
  '귀하의 의견이 있는 모든 후보가 동률이기 때문에 귀하의 투표는 아무런 효력이 없습니다. 그래도 제출하시겠습니까?'
}

# election

sub No_poll_ID {
  "설문 ID가 제공되지 않았습니다. 아마도 복사-붙여넣기 오류일까요?"
}
sub Ill_formed_poll_ID {
  "형식이 잘못된 설문 식별자가 제공되었습니다. 아마도 복사-붙여넣기 오류일까요? (" . $_[1] . ")"
}
sub vote_has_already_been_cast {
  "유권자 키를 사용하여 투표가 이미 이루어졌습니다."
}
#deprecated, use future_result_link
sub following_URL_will_report_results {
  '투표가 끝나면 다음 URL에서 투표 결과를 보고합니다.'
}
sub future_result_link {
    my ($self, $url) = @_;
  "투표가 끝나면 다음 URL에서 투표 결과를 보고합니다. <a href='$url'><code>$url</code></a>"
}
#deprecated
sub following_URL_reports_results {
  '다음 URL은 현재 투표 결과를 보고합니다.'
}
sub if_you_want_to_change {
  '여기에 유권자 영수증을 입력하여 이전 투표를 제거하고 다시 투표할 수 있습니다.'
}
sub invalid_release_key {
    my ($self, $receipt) = @_;
  '제공된 유권자 영수증('.$receipt.')이 올바르지 않습니다. '.code('E_2ad1ca99ac3cac7a/3a191bd9fb00ef73').'와 유사해야 합니다.'
}
sub no_ballot_under_key {
    my ($self, $key) = @_;
  "영수증 $key에 대한 이전 투표지를 찾을 수 없습니다."
}
sub current_result_link {
    my ($self, $url) = @_;
  "<a href=\"$url\" class=result_link>현재 투표 결과로 이동</a>"
}
sub Already_voted {
  '이미 투표함'
}
sub Error {
  '오류'
}
sub Invalid_key {
  '유효하지 않은 키. 이메일로 투표를 제어하기 위한 올바른 URL을 받았어야 합니다. 이 오류가 기록되었습니다.'
}
sub Authorization_failure {
  '승인 실패'
}

sub already_ended { # title
  "이 투표(<strong>$_[1]</strong>)는 이미 종료되었습니다."
}
sub Poll_not_yet_ended {
  "아직 끝나지 않은 설문조사"
}
sub The_poll_has_not_yet_been_ended { #title, name, email
  "이 투표($_[1])는 아직 감독자 $_[2]($_[3])에 의해 종료되지 않았습니다."
}

# deprecated
sub The_results_of_this_completed_poll_are_here {
  '이 완료된 투표의 결과는 다음과 같습니다.'
}
sub completed_results_link {
    my ($self, $url) = @_;
  "<a href=\"$url\" class=result_link>완료된 투표 결과로 이동</a>"
}

sub No_write_access_to_lock_poll {
  "설문 조사를 잠그는 데 필요한 쓰기 권한이 없습니다."
}
sub This_poll_has_already_been_started { # title
  "이 투표($_[1])는 이미 시작되었습니다."
}
sub No_write_access_to_start_poll {
  '투표를 시작할 수 있는 쓰기 액세스 권한이 없습니다.'
}
sub Poll_does_not_exist_or_not_started {
  '이 투표는 존재하지 않거나 시작되지 않았습니다.'
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
  "유효하지 않은 결과 키: \"$_[1]\". 투표 결과를 이메일로 보려면 올바른 URL을 받았어야 합니다. 이 오류가 기록되었습니다."
}
sub Invalid_control_key { # key
  "제어 키가 잘못되었습니다. 이메일로 투표를 제어하기 위한 올바른 URL을 받았어야 합니다. 이 오류가 기록되었습니다."
}
sub Invalid_voting_key {
  "투표 키가 잘못되었습니다. 이메일로 투표하기 위한 올바른 URL을 받으셨을 것입니다. 이 오류가 기록되었습니다."
}
sub Invalid_poll_id {
  "잘못된 투표 식별자"
}
sub Poll_id_not_valid { #id
  "설문 식별자 \"$_[1]\"이(가) 유효하지 않습니다."
}
sub Unable_to_append_to_poll_log {
  "폴링 로그에 추가할 수 없습니다."
}
sub Voter_v_already_authorized {
  "유권자 &lt;$_[1]&gt; 이미 승인되었습니다. 유권자의 키는 유권자에게 재전송됩니다."
}
sub Skipping_already_voted {
  "건너뛰는 유권자 &lt;$_[1]&gt;: 이미 투표했습니다."
}
sub Invalid_email_address_hdr { # addr
  "잘못된 이메일 주소"
}
sub Invalid_email_address { # addr
  "잘못된 이메일 주소: $_[1]"
}
sub Address_opted_out { # addr
  "이 주소는 CIVS 이메일에서 제외되었습니다: $_[1]"
}
sub Sending_mail_to_voter_v {
  "유권자 \"$_[1]\"에게 메일을 보내는 중..."
}
sub CIVS_poll_supervisor { # name
  "\"Condorce 인터넷 투표 서비스($_[1]를 대신하여)\""
}
sub From_poll_supervisor {
    my ($self, $name) = @_;
    $self->CIVS_poll_supervisor($name)
# UNTRANSLATED
}
sub voter_mail_intro { #title, name, email_addr
  "이름이 <b>$_[1]</b>인 Condorcet Internet Voting Service 투표가 생성되었습니다. 투표 관리자 $_[2] (<a href=\"mailto:$_[3] ($_[2])\"><code>$_[3]<)에 의해 투표자로 지정되었습니다. /코드></a>).</p>"
}
sub Description_of_poll {
  '설문조사 설명:'
}
sub if_you_would_like_to_vote_please_visit {
  '투표를 원하시면 다음 URL을 방문하십시오.'
}
sub This_is_your_private_URL {
  '이것은 귀하의 비공개 URL입니다. 다른 사람에게 주지 마십시오. 그들이 귀하에게 투표하는 데 사용할 수 있기 때문입니다.'
}
sub Your_privacy_will_not_be_violated {
  '귀하의 개인 정보는 투표로 침해되지 않습니다. 투표 서비스는 이미 귀하의 이메일 주소 기록을 파기했으며 귀하의 투표 여부 또는 방법에 대한 어떠한 정보도 공개하지 않을 것입니다.'
}
sub This_is_a_nonanonymous_poll {
  '설문조사 감독자는 이 설문조사를 <strong>비익명 설문조사</strong>로 만들기로 결정했습니다. 투표하면 투표 결과에 대한 액세스 권한이 있는 모든 사람이 귀하의 이메일 주소와 투표 방법을 볼 수 있습니다.'
}


sub poll_has_been_announced_to_end { #election_end
  "설문 조사가 $_[1] 종료한다고 발표되었습니다."
}

sub To_view_the_results_at_the_end {
  "투표가 끝난 후 투표 결과를 보려면 다음을 방문하세요.</p> $_[1]"
}

sub for_more_information_about_CIVS { # url
  "Condorcet 인터넷 투표 서비스에 대한 자세한 내용은 $_[1]을 참조하십시오."
}

sub For_more_information { # url, mail mgmt url
  ($self, $home, $mail_mgmt) = @_;
  "For more information about the Condorcet Internet Voting Service, see
   $home. To control future email sent from CIVS, see $mail_mgmt"
# UNTRANSLATED
}

sub poll_email_subject { # title
  "설문조사: $_[1]"
}

# close

sub CIVS_Ending_Poll {
  'CIVS: 설문 조사 종료'
}

sub Ending_poll {
  '설문 조사 종료'
}
sub View_poll_results {
  '투표 결과 보기'
}
sub Poll_ended { #title
  "설문조사 종료: $_[1]"
}

sub The_poll_has_been_ended { #election_end
  "설문조사가 종료되었습니다. $_[1] 종료한다고 발표되었습니다."
}

sub poll_results_available_to_authorized_users {
  '이제 인증된 사용자가 투표 결과를 사용할 수 있습니다.'
}

sub was_not_able_stop_the_poll {
  '투표를 중지할 수 없습니다.'
}


# results

sub CIVS_poll_result {
  "CIVS 투표 결과"
}
sub Poll_results { # title
  "투표 결과: $_[1]"
}

sub Writeins_currently_allowed {
  '현재 쓰기 선택이 허용됩니다.'
}

sub Writeins_allowed {
  '쓰기 선택이 허용됩니다.'
}
sub Writeins_not_allowed {
  '기입 선택은 허용되지 않습니다.'
}
sub Detailed_ballot_reporting_enabled {
  '자세한 투표 보고가 활성화됩니다.'
}
sub Detailed_ballot_reporting_disabled {
  '자세한 투표 보고가 비활성화됩니다.'
}
sub Voter_identities_will_be_kept_anonymous {
  '유권자 신원은 익명으로 유지됩니다.'
}
sub Voter_identities_will_be_public {
  '투표용지와 함께 유권자 신원(이메일)은 투표 결과를 볼 권한이 있는 사람들에게 표시됩니다.'
}
sub Condorcet_completion_rule {
  '콩도르세 완료 규칙:'
}
sub undefined_algorithm {
  '오류: 정의되지 않은 알고리즘.'
}
sub computing_results {
  '계산 결과...'
}
sub Supervisor { #name, email
  "감독자: $_[1] <tt>&lt;$_[2]&gt;</tt>"
}
sub Announced_end_of_poll {
  "투표 종료 발표: $_[1]"
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
  '아직 설문조사가 끝나지 않았습니다.'
}
sub This_is_a_test_poll {
  '테스트 투표입니다.'
}
sub This_is_a_private_poll { #num_auth
  "비공개 투표($_[1] 승인된 유권자)"
}
sub This_is_a_public_poll {
  '이것은 공개 여론 조사입니다.'
}

sub Actual_votes_cast { #num_votes
  "실제 투표: $_[1]"
}
sub Number_of_winning_candidates {
  '우승 선택 수:'
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
  '설문조사 설명'
}
sub Ranking_result {
  '결과'
}
sub x_beats_y { # x y w l
  "$_[1]이 $_[2] $_[3]&ndash;$_[4]를 이겼습니다."
}
sub x_ties_y { # x y w l
  "$_[1] 넥타이 $_[2] $_[3]&ndash;$_[4]"
}
sub x_loses_to_y { # x y w l
  "$_[1]이 $_[2]에게 패함 $_[3]&ndash;$_[4]"
}
sub some_result_details_not_shown {
  '단순화를 위해 설문 조사 결과의 일부 세부 정보는 표시되지 않습니다.'
}
sub Show_details {
  '세부정보 표시'
}
sub Hide_details {
  '세부정보 숨기기'
}
sub Result_details {
  '결과 세부정보'
}
sub Ballot_report {
  '투표 보고서'
}
sub Ballots_are_shown_in_random_order {
  "투표 용지는 무작위로 생성된 순서로 표시됩니다."
}
sub Download_ballots_as_a_CSV { # url
  "[<a href=\"$_[1]\">CSV 형식으로 투표용지 다운로드</a>]"
}
sub No_ballots_were_cast {
  "이 투표에는 투표용지가 없습니다."
}
sub Ballot_reporting_was_not_enabled {
  '이 투표에 대한 투표 보고가 활성화되지 않았습니다.'
}
sub Tied {
  "<i>동점</i>:"
}
sub loss_explanation { # loss_to, for, against
  ', 에게 졌다'. $_[1].' 에 의해 '. $_[2] .'&ndash;'. $_[3]
}
sub loss_explanation2 {
  '&nbsp;&nbsp;'.$_[1].'에게 졌습니다. '.$_[2].'&ndash;'.$_[3].'에 의해'
}
sub Condorcet_winner_explanation {
  '&nbsp;&nbsp;(Condorcet 우승자: 다른 모든 선택과 함께 대회 우승)'
}
sub undefeated_explanation {
  '&nbsp;&nbsp;(어떤 콘테스트와 다른 선택에서도 패배하지 않음)'
}
sub Choices_shown_in_red_have_tied {
  '빨간색으로 표시된 항목은 공동으로 선택되었습니다. 그 중에서 무작위로 선택하고 싶을 수도 있습니다.'
}
sub Condorcet_winner {
  "콩도르세 우승자"
}
sub Choices_in_individual_pref_order {
  '선택 사항(개인 선호도 순서)'
}

sub Unknown_email {
  '(알려지지 않은)'
}

sub What_is_this { # url
  '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>(이게 뭐죠?)</small></a>'
}

# rp

sub All_prefs_were_affirmed {
  '모든 기본 설정이 확인되었습니다.'
}

sub Presence_of_a_green_entry_etc {
  '대각선 아래에 녹색 항목(및 위의 해당 빨간색 항목)이 있다는 것은 기본 설정이 다른 더 강력한 기본 설정과 충돌했기 때문에 무시되었음을 의미합니다.'
}
sub Random_tie_breaking_used {
  'MAM 알고리즘에 따라 이 순서에 도달하기 위해 임의 타이 브레이킹이 사용되었습니다. 이것은 선택 순서에 영향을 미쳤을 수 있습니다.'
}
sub No_random_tie_breaking_used {
  '이 주문에 도달하기 위해 임의의 타이 브레이킹이 필요하지 않았습니다.'
}

# beatpath

sub beatpath_matrix_explanation {
  '다음 매트릭스는 각 선택 쌍을 연결하는 가장 강한 비트 경로의 강도를 보여줍니다. 2에서 1로 이어지는 것보다 1에서 2로 이어지는 더 강한 비트 경로가 있는 경우 선택 1이 선택 2 위에 순위가 매겨집니다.'
}

sub no_pref {
  '없음'
}

#rp

sub Some_voter_preferences_were_ignored {
  '일부 유권자 선호도는 다른 강력한 선호도와 충돌하기 때문에 무시되었습니다.'
}

sub preference_description {
  "$_[4]보다 $_[3]에 대한 $_[1]&ndash;$_[2] 선호도."
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
  '이메일 주소:'
}
sub deactivation_code {
  '비활성화 코드:'
}
sub filter_question {
  '필터 패턴 <small>(비워 둘 수 있음, 도움말을 보려면 마우스를 가져가세요)</small>'
}
sub filter_explanation {
  '여기에 하나 이상의 패턴을 입력하여 이메일을 차단할 투표 감독자를 지정할 수 있습니다. 패턴은 감독자의 이메일 주소이거나 이메일 주소를 설명하는 패턴일 수 있습니다. 패턴은 *를 사용하여 임의의 문자 시퀀스를 나타낼 수 있습니다. 예를 들어 *@inmano.com 패턴은 @inmano.com 주소를 가진 감독자가 귀하에게 투표 초대를 보내는 것을 방지합니다. 이 필드를 공백으로 두면 비활성화/재활성화가 모든 이메일 주소에 적용됩니다.'
}
sub send_deactivation_code {
  '이메일로 비활성화 코드 보내기'
}
sub cant_send_email {
  'CIVS를 사용하여 이 사용자에게 이메일을 보낼 수 없습니다. 이 사용자에게 보내는 이메일은 먼저 이전에 보낸 비활성화 코드를 사용하여 재활성화해야 합니다.'
}
sub submit_deact_react {
  '비활성화/재활성화 제출'
}
sub codes_dont_match {
  "죄송합니다. 제공된 코드와 이메일 주소가 일치하지 않습니다. 이전에 CIVS의 이메일을 차단하지 않은 경우 다른 코드를 요청할 수 있습니다."
}
sub deactivation_successful {
    my ($self, $pattern) = @_;
  "발신자가 \"$pattern\" 패턴과 일치하는 경우 CIVS는 더 이상 이 주소로 메일을 보내지 않습니다. 방금 사용한 것과 동일한 코드로 이 웹 페이지를 사용해야만 CIVS에서 메일을 재활성화할 수 있습니다."
}
sub reactivation_successful {
  '이 주소로 보내는 메일을 성공적으로 재활성화했습니다.'
}
sub someone_has_requested {
  "누군가 CIVS에서 귀하에게 이메일을 보내지 못하도록 코드를 요청했습니다. 그것이 당신이라면 그것으로 무엇을 해야할지 알게 될 것입니다. 코드는 다음과 같습니다.
 $_[1]
나중에 서비스를 사용하려면 이 코드가 필요하므로 이 이메일을 보관하십시오."
}
sub deactivation_code_subject {
  'CIVS 메일 비활성화 코드'
}
sub mail_mgmt_title {
  '메일 관리'
}

## User activation

sub user_activation {
  '사용자 활성화'
}
sub activation_code_subject {
  'CIVS 사용을 위한 활성화 코드'
}
sub user_activation_instructions1 {
  '비공개 CIVS 투표에 투표하려면 서비스에서 이메일 통신을 선택해야 합니다. CIVS는 귀하의 이메일 주소를 저장하지 않으며 자동 메일링이 없습니다. 귀하는 비공개 투표에 투표하거나 투표 결과를 보는 데 필요한 자격 증명이 포함된 투표 감독자의 명시적인 요청이 있는 경우에만 서비스로부터 이메일을 받습니다.'
}
sub user_activation_instructions2 {
  "옵트인하려면 이메일 주소를 입력하고 아래 버튼을 클릭하십시오. 그러면 활성화 코드가 포함된 이메일을 받게 됩니다. 이전에 이메일 수신을 거부한 경우 <a href=\"$_[1]\">메일 관리 페이지</a>를 사용하여 이메일을 다시 활성화해야 합니다. 메일 차단 서비스를 사용하는 경우 CIVS 이메일 주소를 승인된 발신자(".'@SUPERVISOR@'.")로 화이트리스트에 추가해야 할 수 있습니다."
}
sub user_activation_instructions {
    my ($self, $mail_mgmt_url) = @_;
    p($self->user_activation_instructions1).
    p($self->user_activation_instructions2($mail_mgmt_url))
# UNTRANSLATED
}
sub opt_in_label {
  '활성화 코드 요청'
}
sub activation_code {
  '활성화 코드:'
}
sub someone_has_requested_activation {
    my ($self, $address, $code, $mail_mgmt_url) = @_;
  "누군가가 CIVS 투표 시스템이 투표에서 투표하기 위해 이메일 주소 <$address>를 활성화하도록 요청했습니다. 이 주소를 활성화하려면 다음 활성화 코드가 필요합니다.
 $code
이 요청을 시작하지 않은 경우 이 이메일을 무시해도 됩니다.
$mail_mgmt_url 링크를 사용하여 CIVS에서 이메일을 제어합니다."
}
sub already_activated {
  '이 이메일 주소는 이미 활성화되어 있습니다.'
}
sub activation_successful
{
    'Email address successfully activated.'
}
sub pending_invites_hdr {
  '대기 중인 투표 초대:'
}
sub submit_activation_code {
  '활성화 완료'
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
  "죄송합니다. &lt;$address&gt; 주소를 활성화한 사용자가 없습니다. 이메일을 받으려면."
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
  "<p>아래 표에 나열된 이유로 인해 CIVS가 일부 유권자에게 메일을 보낼 수 없었습니다. 유권자는 개인 키를 받을 때까지 투표할 수 없으므로 직접 연락해야 합니다. 유권자는 다음 링크를 유용하게 사용할 수 있습니다.</p> <ul> <li>CIVS로 이메일 주소 활성화: <a href='$activate_url'>$activate_url</a></li> <li>비활성화 /reactivate an email address: <a href='$mail_mgmt_url'>$mail_mgmt_url</a></li> </ul> <p> 유권자가 이메일 주소를 활성화하면 대기 중인 투표 초대에 대한 알림을 받게 됩니다. 여론 조사에서. </p>"
}
sub download_failures {
  '테이블을 CSV로 다운로드'
}

sub code_requested {
  '코드가 요청되었습니다. 이메일을 확인.'
}

sub code_requested_but_something_wrong {
  '코드가 요청되었지만 문제가 발생했습니다.'
}

sub error_handling_code_request {
  "오류 처리 코드 요청"
}
sub invalid_email_address {
  '잘못된 이메일 주소'
}
sub unexpected_error {
  '<b>예기치 않은 오류:</b>'
}
sub optin_error {
  '오류:'
}
sub submitted {
  '제출된'
}

1; # package succeeded!
