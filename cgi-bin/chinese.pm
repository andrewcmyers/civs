package chinese;

our $VERSION = 1.00;

use lib '@CGIBINDIR@';

use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

sub lang { 'zh-CN'; }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub style_file {
    'style.css';
}
sub Condorcet_Internet_Voting_Service {
    'CIVS在线投票服务（Condorcet Internet Voting Service）';
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited 
    'CIVS在线投票服务（Condorcet Internet Voting Service）';
}
sub about_civs {
    '关于CIVS';
}
sub create_new_poll {
    '创建新投票';
}
sub about_security_and_privacy {
    '关于安全和隐私';
}
sub FAQ {
    '常见问题';
}
sub CIVS_suggestion_box {
    'CIVS建议箱';
}
sub unable_to_process {
    '因为系统错误，CIVS当前无法处理你的请求。';
}
sub CIVS_Error {
    'CIVS错误';
}
sub CIVS_server_busy {
    'CIVS系统忙碌';
}
sub Sorry_the_server_is_busy {
    '抱歉，当前CIVS网络服务器正忙。请稍后再试。';
}

# civs_create

sub mail_has_been_sent {
    "邮件已发送到您提供的地址 (<tt>$_[1]</tt>)。";
}

sub click_on_the_URL_to_start {
    "请点击电子邮件中的链接来开始投票: <strong>$_[1]</strong>。";
}

sub here_is_the_control_URL {
    '这里是控制新投票的链接。通常这将会通过电子邮件的方式发送给投票创建者。';
}
sub the_poll_is_in_progress {
    '投票正在进行中。点击此键结束此次投票: ';
}

sub CIVS_Poll_Creation {
    "创建CIVS投票";
}
sub Poll_created {
    "投票已经创建: $_[1]"
}

sub Address_unacceptable { #addr
    "无法接受地址 \"$_[1]\"";
}
sub Poll_must_have_two_choices {
    '投票至少需要两个选项。';
}
sub Poll_directory_not_writeable {
    "无法写入投票目录";
}
sub CIVS_poll_created {
 "CIVS投票已经创建: $_[1]";
}
sub creation_email_info1 { # title, url
"此电子邮件确认您已创建了一个新的投票,
$_[1]. 您是此次投票的创建者。使用下面的链接来开始或者结束此次投票:

  $_[2]

";
}
sub creation_email_public_link { # url
"因为这是一次实名投票，请让参与者使用下面的链接:

  $_[1]

";
}
sub for_more_information_about_CIVS { # url
"参考
  $_[1] 来获得更多关于CIVS在线投票服务的信息";
}

sub Sending_result_key { # addr
    "正在向 '$_[1]'发送结果";
}
sub Results_of_CIVS_poll { # title
    "CIVS投票结果: $_[1]";
}
sub Results_key_email_body { # title, url, civs_home
"一个名为 \"$_[1]\"的新CIVS投票已经创建。作为此次投票的参与者，您可以
查看此次投票的结果。

请保存此封邮件。如果流失了此封邮件您将无法再访问此次投票的结果。一旦投票
结束，您可以通过下面的链接获得投票结果:

  $_[2]

此链接是私有的。让未经授权用户获得该链接将使其能查看此次投票的结果。
请查看
  $_[3]
来获得更多关于CIVS网络投票服务的信息
";
}
  
# start

sub poll_started {
    '投票 <strong>'.$_[1].'</strong> 已经开始。';
}

# control

sub CIVS_Poll_Control {
    "CIVS投票控制";
}
sub Poll_control {
    "投票控制";
}
sub poll_has_not_yet_started {
    '该投票尚未开始。点击下面的按钮来开始此次投票: ';
}
sub Start_poll {
    '开始投票';
}
sub End_poll {
    '结束投票';
}
sub ending_poll_cannot_be_undone {
    '一旦结束投票将无法再继续此次投票。确定继续？';
}
sub writeins_have_been_disabled {
    '无法写入新的投票选项';
}
sub disallow_further_writeins {
    '截止添加新投票选项';
}
sub voting_disabled_during_writeins {
    '在添加新的投票选项阶段无法投票。';
}
sub allow_voting_during_writeins {
    "允许在添加投票选项阶段投票";
}
sub this_is_a_test_poll {
    '这是一个投票测试。';
}

sub poll_supervisor { # name, email
    "投票创建者: $_[1] (<tt>$_[2]</tt>)";
}
sub no_authorized_yet { #waiting
    "投票开始时，0 ($_[1] 个参与者将被授权)";
}
sub total_authorized_voters { # num_auth_string
    "授权参与者总数: $_[1]";
}
sub actual_votes_so_far { # num
    "实际参加投票人数: $_[1]";
}
sub poll_ends { # end
    "投票结束 $_[1]。";
}
sub Poll_results_available_to_all_voters_when_poll_completes {
    '投票结果在投票结束之后将对所有参与者均可见。';
}
sub Voters_can_choose_No_opinion {
    '投票者可以选择 &ldquo;没有选项&rdquo;';
}
sub Voting_is_disabled_during_writeins {
    '添加投票选项时无法投票。';
}
sub Poll_results_will_be_available_to_the_following_users {
    '投票结果仅对以下用户可见:';
}
sub Poll_results_are_now_available_to_the_following_users {
    '投票结果当前仅对以下这些收到过查看结果的链接的用户可见:';
}
sub results_available_to_the_following_users {
    '投票结果仅对一部分用户可见:';
}

sub Poll_results_are_available { #url
    "<a href=\"$_[1]\">查看投票结果</a>";
}
sub Description {
    '描述:';
}
sub Candidates {
    '选项:';
}
sub Add_voters {
    '添加参与者';
}

sub the_top_n_will_win { # num_winners
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt = "个参与者";
    } else {
	$wintxt = "$_[1] 个参与者";
    }
    return "最靠前的 $wintxt 将获胜。";
}

sub add_voter_instructions {
    "输入投票参与者的电子邮件地址，每行一个地址。可以是新的参与者，或者
    是还未投票的当前参与者。
    在匿名投票中，输入当前参与者的电子邮件地址 <strong>不会</strong> 让该
    参与者投票两次。
    这只会给参与者再次发送投票邀请。
    在实名投票中，为了防止多次投票请仅输入一次参与者的电子邮箱。";
}
sub Upload_file {
    '上传文件: ';
}
sub Load_ballot_data {
    '载入 投票数据';
}
sub File_to_upload_ballots_from {
    '将从下面这个文件载入投票数据:';
}
sub This_is_a_public_poll_plus_link {
    my $url = $_[1];
    "这是一个实名投票。分享下面的链接给投票参与者:</p><p>
	&nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>";
}
sub The_poll_has_ended {
    '投票已经结束。';
}

# add voters

sub CIVS_Adding_Voters {
    'CIVS: 添加参与者';
}
sub Adding_voters {
    '正在添加参与者';
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
    '抱歉，只能向正在进行中的投票添加参与者。';
}

sub Total_of_x_voters_authorized { # x
    if ($_[1] == 0) {
	'目前尚无投票参与者。';
    } elsif ($_[1] == 1) {
	'目前只有一个投票参与者。';
    } else {
	"目前总共有 $_[1] 个投票参与者。";
    }
}

sub Go_back_to_poll_control {
    '返回投票控制';
}
sub Done {
    '完成。';
}

# vote

sub page_header_CIVS_Vote { # election_title
    'CIVS投票: '.$_[1];
}

sub ballot_reporting_is_enabled {
    '当前投票使用了选票报告功能。
     您的选票 (您给每个选项的权重)
     将在投票结束的时候被公开。';
}
sub instructions1 { # num_winners, end, name, email
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt="单选";
    } else {
	$wintxt="$_[1] 多选";
    }
    "只有 $wintxt 会赢得此次投票。<p>
	    投票结束 <b>$_[2]</b>.
	    投票创建者 $_[3] (<tt>$_[4]</tt>).
	    如果需要帮助请联系投票创建者。";
}
sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
    my ($self, $no_opinion, $prop, $combined, $civs_url) = @_;
    my $ret;
    if (!$prop || !$combined) {
	$ret = "给下面每一个选项相应的排名，排名越小优先级越高。
	    例如，给你的第一选择排名1。如果对于几个选项没有特别的偏好
	    可以给他们同样的排名。你无须使用所有可用的排名，。所有的
	    选项一开始都有相同的排名。 ". $cr;
	if ($no_opinion) {
	    $ret .= '<b>注意:</b> &ldquo;无所谓&rdquo;
		    并 <i>不是</i> 最低的排名；该选项代表你并无法将此选项
		    和其他选项做出比较</p>';
	}
	if ($prop) {
	    $ret .= '<p>投票结果的计算基于Condorcet算法。该算法假定你会给<i>最优</i>
	    选项最高的排名。如果两个投票结果在你的最优选项上一致，则您将会通过第二偏好来
	    选择更优的排序。以此类推。';
	}
    } else {
	$ret = '<p>此投票使用 试验性的基于Condorcet算法使用正比来计算结果。 designed to provide proportional
	representation.
	请给予下列选项一个<b>权限</b>，以表示在多大程度上您希望该选项上出现在获胜结果
	中。投票算法假定您将给偏好选项尽可能高的权重。当前所有的权重都是零，表示您不
	希望这些选项获胜。权重不能为负数，也不能超过999。
	使用比其他投票者更大的权重并不会使您的偏好具有更高的权重，因为选项只和您的投票
	中的其他权重相比。'.
	"<a href=\"$civs_url/proportional.html\">[查看更多信息]</a>.</p>";
    }
    return $ret;
}
sub Rank {
    '排名';
}
sub Choice {
    '选项';
}
sub Weight {
    '权重';
}

sub address_will_be_visible {
    '<strong>你的电子邮箱将对其他人可见。</strong>';
}

sub ballot_will_be_anonymous {
    ' 不过，您的选票还是匿名的:
      所有个人信息都不会公开。';
}

sub submit_ranking {
    '提交排名';
}

sub only_writeins_are_permitted {
    '投票尚未开始。不过，您可以查看所有选项，并且添加新的选项。
    在下面的文本框中输入新的选项。';
}

sub Add_writein {
    '添加选项';
}

sub to_top {
    '返回顶部';
}
sub to_bottom {
    '返回底部';
}
sub move_up {
    '上移';
}
sub move_down {
    '下移';
}
sub make_tie {
    '平局';
}
sub buttons_are_deactivated {
    '因为您的浏览器不支持Javascript，无法使用这些按钮';
}
sub ranking_instructions {
       '使用下面三种方法之一排序:
	<ol>
	    <li>拖拉一行
	    <li>使用排名一列的下拉框
	    <li>选择若干行并使用上面的按钮
	</ol>';
}

sub write_in_a_choice {
    '写入一个新的选项: ';
}
sub if_you_have_already_voted { #url
    "如果您已经投票，您可以
	<a href=\"$_[1]\">查看当前的投票结果</a>。";
}
sub thank_you_for_voting { #title, receipt
    "感谢您的投票。您对<strong>$_[1]</strong>的投票已经生效。
    您的 投票确认是<code>$_[2]</code>.";
}
sub name_of_writein_is_empty {
    "投票选项没有名字";
}
sub writein_too_similar {
    "抱歉，投票选项的名字和已有选项过于相像";
}

# election

sub vote_has_already_been_cast {
    "一个投票已经生效。";
}
sub following_URL_will_report_results {
    '一旦投票结束，下面的链接将显示投票结果:';
}
sub following_URL_reports_results {
    '下面的链接显示当前的投票结果:';
}
sub Already_voted {
    '已投票过';
}
sub Error {
    '错误';
}
sub Invalid_key {
    '链接错误。您应该通过电子邮箱收到过正确的投票链接。该错误已被记录。';
}
sub Authorization_failure {
    '验证错误';
}

sub already_ended { # title 
    "这个投票 (<strong>$_[1]</strong>) 已经结束。";
}
sub Poll_not_yet_ended {
    "投票尚未结束";
}
sub The_poll_has_not_yet_been_ended { #title, name, email
    "投票 ($_[1]) 还尚未结束，投票创建者 
    $_[2] ($_[3]).";
}
sub The_results_of_this_completed_poll_are_here {
    '此次完成的投票结果为:';
}

sub No_write_access_to_lock_poll {
    "没有锁住当前投票的权限。";
}
sub This_poll_has_already_been_started { # title
    "投票 ($_[1]) 已经开始。";
}
sub No_write_access_to_start_poll {
    '没有开始投票的权限。';
}
sub Poll_does_not_exist_or_not_started {
    '该投票不存在，或者尚未开始。';
}
sub Your_voter_key_is_invalid__check_mail { # voter
   my $voter = $_[1];
   if ($voter ne '') {
    "您的投票链接不正确, $voter。
     您应该通过电子邮件已经收到过正确的链接。";
   } else {
    "您的投票链接不正确。您应该通过电子邮件已经收到过正确的链接。";
   }
}
sub Invalid_result_key { # key
    "您查看结果的链接不正确: \"$_[1]\". 您应该通过电子邮件已经收到过正确的链接。
    该错误已经被记录";
}
sub Invalid_control_key { # key
    "无效控制链接。您应该通过电子邮件已经收到过正确的链接。该错误已经被记录。";
}
sub Invalid_voting_key {
    "无效投票链接。您应该通过电子邮件已经收到过正确的链接。该错误已经被记录。";
}
sub Invalid_poll_id {
    "无效投票ID";
}
sub Poll_id_not_valid { #id
    "投票ID \"$_[1]\" 是无效的。";
}
sub Unable_to_append_to_poll_log {
    "无法写入投票记录。";
}
sub Voter_v_already_authorized {
    "投票者 \"$_[1]\" 已经被授权。其投票链接将再次被发送给投票者。";
}
sub Invalid_email_address_hdr { # addr
    "无效电子邮箱地址";
}
sub Invalid_email_address { # addr
    "无效电子邮箱地址: $_[1]";
}
sub Sending_mail_to_voter_v {
    "发送电子邮件给投票者 \"$_[1]\"...";
}
sub CIVS_poll_supervisor { # name
    "\"$_[1], CIVS投票创建者\""
}
sub voter_mail_intro { #title, name, email_addr
"一个名为<b>$_[1]</b>的CIVS在线投票已经创建。
该投票的创建者，
$_[2] (<a href=\"mailto:$_[3] ($_[2])\">$_[3]</a>).</p>，给予了您投票的权利";
}
sub Description_of_poll {
    '投票描述:';
}
sub if_you_would_like_to_vote_please_visit {
    '如果您想参与此次投票，请访问以下链接:';
}
sub This_is_your_private_URL {
'这是您的私人链接，请不要与其他人分享。否则他人将可以使用该链接替您投票。';
}
sub Your_privacy_will_not_be_violated {
'投票将不会侵犯您的隐私。投票系统已经销毁了您的电子邮箱地址，并且不会泄露任何您是否
投票，或者投票内容的信息。';
}
sub This_is_a_nonanonymous_poll {
'投票创建者将此次投票设置成了<strong>实名投票</strong>。如果您参与了此次投票，您的
投票内容以及电子邮箱地址将被公开。如果您不参与此次投票，投票创建者可以知道您尚未参
与此次投票。';
}

sub poll_has_been_announced_to_end { #election_end
    "投票即将结束 $_[1].";
}

sub To_view_the_results_at_the_end {
    "访问:</p> $_[1] 来查看投票结束后的投票结果。";
}

sub For_more_information {
    '查看以下内容来获得更多关于CIVS在线投票服务的信息:';
}

sub poll_email_subject { # title
    "投票: $_[1]"
}

# close

sub CIVS_Ending_Poll {
    'CIVS: 结束投票';
}

sub Ending_poll {
    '结束投票';
}
sub View_poll_results {
    '查看投票结果';
}
sub Poll_ended { #title
    "投票结束: $_[1]";
}

sub The_poll_has_been_ended { #election_end
    "投票已经结束。该投票结束于 $_[1].";
}

sub poll_results_available_to_authorized_users {
    '授权用户已经可以查看该投票结果';
}

sub was_not_able_stop_the_poll {
    '无法终止投票';
}


# results

sub CIVS_poll_result {
    "CIVS投票结果";
}
sub Poll_results { # title
    "投票结果: $_[1]";
}

sub Writeins_currently_allowed {
    '当前允许添加新的投票选项。';
}

sub Writeins_allowed {
    '可以添加新的投票选项。';
}
sub Writeins_not_allowed {
    '不可以添加新的投票选项。';
}
sub Detailed_ballot_reporting_enabled {
    '支持详细的投票结果。';
}
sub Detailed_ballot_reporting_disabled {
    '不支持详细的投票结果。';
}
sub Voter_identities_will_be_kept_anonymous {
    '这是一次匿名投票';
}
sub Voter_identities_will_be_public {
    '投票者的ID（电子邮箱地址）将和选票一起被公开。';
}
sub Condorcet_completion_rule {
    'Condorcet规则:';
}
sub undefined_algorithm {
    '错误：未定义的算法';
}
sub computing_results {
    '计算结果中...';
}
sub Supervisor { #name, email
    "创建者: $_[1] ($_[2])";
}
sub Announced_end_of_poll {
    "投票结束于: $_[1]";
}
sub Actual_time_poll_closed { # close time
    if ($_[1] == 0) {
	"投票实际结束于: $_[1]"
    } else {
	'A投票实际结束于: <script>document.write(new Date(' .
	    $_[1] * 1000 . 
	    ').toLocaleString())</script>';
    }
}
sub Poll_not_ended {
    '投票尚未结束';
}
sub This_is_a_test_poll {
    '这是测试投票。';
}
sub This_is_a_private_poll { #num_auth
    "匿名投票 ($_[1] 授权投票者)";
}
sub This_is_a_public_poll {
    '这是实名投票。';
}

sub Actual_votes_cast { #num_votes
    "实际有效投票: $_[1]";
}
sub Number_of_winning_candidates {
    '获胜投票选项总数: ';
}
sub Poll_actually_has { #winmsg
    my $winmsg = '一个获胜者';
    if ($_[1] != 1) {
	$winmsg = $real_nwin.' 个获胜者';
    }
    "&nbsp;(此次投票有 $winmsg)";
}
sub poll_description_hdr {
    '投票描述';
}
sub Ranking_result {
    '结果';
}
sub x_beats_y { # x y w l 
    "$_[1] 胜出 $_[2] $_[3]&ndash;$_[4]";
}
sub x_ties_y { # x y w l 
    "$_[1] 平局 $_[2] $_[3]&ndash;$_[4]";
}
sub x_loses_to_y { # x y w l 
    "$_[1] 负于 $_[2] $_[3]&ndash;$_[4]";
}
sub some_result_details_not_shown {
    '为简洁起见，部分投票结果的细节并未显示。 &nbsp;';
}
sub Show_details {
    '显示结果';
}
sub Hide_details {
    '隐藏结果';
}
sub Result_details {
    '详细结果';
}
sub Ballot_report {
    '选票报告'
}
sub Ballots_are_shown_in_random_order {
    "选票按照随机生成的顺序排列。";
}
sub Download_ballots_as_a_CSV { # url
    "[<a href=\"$_[1]\">以CSV的格式下载选票</a>]";
}
sub No_ballots_were_cast {
    "该投票尚无有效选票。";
}
sub Ballot_reporting_was_not_enabled {
    "当前投票无法使用选票报告功能";
}
sub Tied {
    "<i>平局</i>:";
}
sub loss_explanation { # loss_to, for, against
    ', 负于 '. $_[1].'，差距为 '. $_[2] .'&ndash;'. $_[3];
}
sub loss_explanation2 {
    '&nbsp;&nbsp;负于 '.$_[1].'，差距为 '.$_[2].'&ndash;'.$_[3];
}
sub Condorcet_winner_explanation {
    '&nbsp;&nbsp;(Condorcet方法优胜者: 胜出所有其他投票选项)';
}
sub undefeated_explanation {
    '&nbsp;&nbsp;(未被任何其他投票选项击败)';
}
sub Choices_shown_in_red_have_tied {
    "红色显示的选项出现了平局。您可能想要随机的选择一个作为获胜者。";
}
sub Condorcet_winner {
    "Condorcet方法优胜者";
}
sub Choices_in_individual_pref_order {
    '选项 (按照个人偏好排序)';
}

sub What_is_this { # url
    '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>'. '(这是什么?)</small></a>';
}

# rp

sub All_prefs_were_affirmed {
    '所有偏好已经确认。所有Condorcet方法都将遵循该排序。';
}

sub Presence_of_a_green_entry_etc {
    '下面矩阵中对角线以下的绿色方块（和相应的对角线以上的红色方块）表示该
    结果已被忽略，因为它和一个更强的偏好选择相冲突。';
}
sub Random_tie_breaking_used {
'该排序在出现平局的情况下随机的选择了优胜者。该选择可能影响到选项的顺序。';
}
sub No_random_tie_breaking_used {
    '无需在平局的情况下随机选择获胜者来获得该排序结果。';
}

# beatpath

sub beatpath_matrix_explanation {
    '下面的矩阵显示了各个投票选项的比较结果。选项1排在选项2之前仅当
    选项1有一条更长的获胜序列。';
}

sub no_pref {
    '无'
}

#rp

sub Some_voter_preferences_were_ignored {
    '部分投票参与者的偏好被忽略，因为其余其他更强的偏好冲突:'
}

sub preference_description {
    "$_[1]&ndash;$_[2] 对 $_[3] 的偏好对比 $_[4]."
}

1; # package succeeded!
