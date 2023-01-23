package hindi;

use lib '@CGIBINDIR@';
use CGI qw(:standard -utf8);
use utf8;

use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

our $VERSION = 1.000;

sub lang { 'hi-IN' }

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
  'कोंडोरसेट इंटरनेट मतदान सेवा'
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited
  'कोंडोरसेट इंटरनेट मतदान सेवा'
}
sub CIVS_sender {
    my ($self) = @_;
    $self->Condorcet_Internet_Voting_Service_email_hdr
# UNTRANSLATED
}
sub about_civs {
  'सीआईवीएस के बारे में'
}
sub new_user {
  'उपयोगकर्ता को सक्रिय करें'
}
sub public_polls {
  'सार्वजनिक मतदान'
}
sub create_new_poll {
  'नया जनमत बनाएँ'
}
sub about_security_and_privacy {
  'सुरक्षा और गोपनीयता'
}
sub FAQ {
  'सामान्य प्रश्न'
}
sub CIVS_suggestion_box {
  'सीआईवीएस सुझाव बॉक्स'
}
sub unable_to_process {
  'एक आंतरिक त्रुटि के कारण CIVS आपके अनुरोध को संसाधित करने में असमर्थ है।'
}
sub CIVS_Error {
  'सीआईवीएस त्रुटि'
}
sub CIVS_server_busy {
  'सीआईवीएस सर्वर व्यस्त'
}
sub Sorry_the_server_is_busy {
  'क्षमा करें, CIVS वेब सर्वर अभी बहुत व्यस्त है और अधिक अनुरोधों को हैंडल नहीं कर सकता। कृपया थोड़ी देर बाद पुन: प्रयास करें।'
}

# civs_create

sub mail_has_been_sent {
  "मेल आपके दिए गए पते पर भेज दी गई है (<tt>$_[1]</tt>)।"
}

sub click_on_the_URL_to_start {
  "पोल â$_[1]â शुरू करने के लिए उस ईमेल के URL पर क्लिक करें।"
}

sub here_is_the_control_URL {
  'नए पोल को नियंत्रित करने के लिए यहां URL है। सामान्य संचालन में यह पर्यवेक्षक को ईमेल के माध्यम से भेजा जाएगा।'
}
sub the_poll_is_in_progress {
  'मतदान चल रहा है। इसे समाप्त करने के लिए इस बटन को दबाएँ:'
}

sub CIVS_Poll_Creation {
  "सीआईवीएस पोल निर्माण"
}
sub Poll_created {
  "जनमत बनाया गया: $_[1]"
}

sub Address_unacceptable { #addr
  "पता \"$_[1]\" स्वीकार्य नहीं है"
}
sub Poll_must_have_two_choices {
  'एक पोल में कम से कम दो विकल्प होने चाहिए।'
}
sub Poll_exceeds_max_choices {
    my ($self, $count) = @_;
  "एक पोल में ज़्यादा से ज़्यादा $count विकल्प हो सकते हैं।"
}
sub Poll_directory_not_writeable {
  "विन्यास त्रुटि? पोल निर्देशिका <tt>$_[1]</tt> बनाने में असमर्थ"
}
sub CIVS_poll_created {
  "सीआईवीएस पोल बनाया गया: $_[1]"
}
sub creation_email_info1 { # title, url
  "यह ईमेल एक नए पोल, $_[1] के निर्माण की स्वीकृति देता है। आपको इस पोल के पर्यवेक्षक के रूप में नामित किया गया है। मतदान शुरू करने और बंद करने के लिए, कृपया निम्न URL का उपयोग करें:
 <$_[2]>
इस ईमेल को सहेजें और इसे निजी रखें। यदि आप इसे खो देते हैं तो आप मतदान को नियंत्रित नहीं कर पाएंगे।
"
}
sub creation_email_public_link { # url
  "क्योंकि यह एक सार्वजनिक मतदान है, आप मतदाताओं को निम्न URL पर निर्देशित कर सकते हैं:
 <$_[1]>
"
}

sub opted_out { # addr
  "क्षमा करें, आप &lt;$_[1]&gt; सीआईवीएस के माध्यम से।"
}

sub Sending_result_key { # addr (escaped)
  "<p>परिणाम कुंजी <tt>$_[1]</tt> पर भेजी जा रही है। कृपया इसे पूरा होने दें...<br>"
}
sub Done_sending_result_key { # addr
  '...परिणाम कुंजी भेजना पूर्ण।</p>'
}
sub Results_of_CIVS_poll { # title
  "सीआईवीएस पोल के परिणाम: $_[1]"
}
sub Results_key_email_body { # title, url, civs_home
  "\"$_[1]\" नाम से एक नया सीआईवीएस पोल बनाया गया है। आपको एक ऐसे उपयोगकर्ता के रूप में नामित किया गया है जिसे इस पोल का परिणाम देखने की अनुमति है।
इस ईमेल को सेव करें। यदि आप इसे खो देते हैं तो आपके पास परिणामों तक पहुंच नहीं होगी। पोल बंद हो जाने के बाद, परिणाम निम्न URL पर उपलब्ध होंगे:
 <$_[2]>
यह यूआरएल निजी है। अनधिकृत उपयोगकर्ताओं को इस URL तक पहुंच की अनुमति देने से वे मतदान के परिणाम देख सकेंगे।
"
}

# start

sub poll_started {
  "मतदान <strong>$_[1]</strong> शुरू हो गया है।"
}

sub sending_keys_now {
  'मतदाता निमंत्रण अभी भेज रहे हैं। जब तक सभी निमंत्रण नहीं भेजे जाते, तब तक इस पृष्ठ से दूर न जाएं।'
}

# control

sub CIVS_Poll_Control {
  "सीआईवीएस मतदान नियंत्रण"
}
sub Poll_control {
  "मतदान नियंत्रण"
}
sub poll_has_not_yet_started {
  'मतदान अभी शुरू नहीं हुआ है। इसे शुरू करने के लिए इस बटन को दबाएं:'
}
sub Start_poll {
  'मतदान शुरू करें'
}
sub End_poll {
  'मतदान समाप्त करें'
}
sub Edit_button {
  'संपादन करना'
}
sub ResendLink_button {
  'लिंक पुनः भेजें'
}
sub ResendLinkAck {
  'भेजा'
}
sub Save_button {
  'बचाना'
}
sub Remove_button {
  'निकालना'
}
sub confirm_ending_poll_cannot_be_undone {
  'मतदान समाप्त करना एक ऐसा ऑपरेशन है जिसे पूर्ववत नहीं किया जा सकता है। यह पुष्टि करने के लिए कि आप मतदान बंद करना चाहते हैं, &#34;बंद करें&#34; और ओके दबाएं'
}
sub writeins_have_been_disabled {
  'राइट-इन विकल्प अक्षम कर दिए गए हैं'
}
sub disallow_further_writeins {
  'आगे लिखने की अनुमति न दें'
}
sub voting_disabled_during_writeins {
  'राइट-इन चरण के दौरान वोटिंग वर्तमान में अक्षम है।'
}
sub allow_voting_during_writeins {
  'राइट-इन चरण के दौरान मतदान की अनुमति दें'
}
sub this_is_a_test_poll {
  'यह एक परीक्षण सर्वेक्षण है।'
}
sub file_to_upload_from {
  'मतपत्र अपलोड करने के लिए फ़ाइल:'
}
sub Load_ballots {
  'मतपत्र लोड करें'
}
sub poll_supervisor { # name, email
  "मतदान पर्यवेक्षक: $_[1] <tt>&lt;$_[2]&gt;</tt>"
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
  "कुल अधिकृत मतदाता: $_[1]"
}
sub actual_votes_so_far { # num
  "वास्तव में अब तक डाले गए वोट: $_[1]"
}
sub poll_ends { # end
  "मतदान के अंत की घोषणा: $_[1]"
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
  'मतदान पूरा होने पर सभी मतदाताओं के लिए मतदान के परिणाम उपलब्ध होते हैं।'
}
sub Voters_can_choose_No_opinion {
  'मतदाता &ldquo;कोई राय नहीं&rdquo; चुन सकते हैं।'
}
sub Voting_is_disabled_during_writeins {
  'राइट-इन अवधि के दौरान मतदान अक्षम है।'
}
sub Poll_results_will_be_available_to_the_following_users {
  'मतदान के परिणाम केवल निम्नलिखित उपयोगकर्ताओं के लिए उपलब्ध होंगे:'
}
sub Poll_results_are_now_available_to_the_following_users {
  'मतदान के परिणाम अब केवल निम्नलिखित उपयोगकर्ताओं के लिए उपलब्ध हैं, जिन्हें पहले परिणाम देखने के लिए एक URL युक्त ईमेल भेजा गया था:'
}
sub results_available_to_the_following_users {
  'इस पोल के परिणाम केवल कुछ सीमित उपयोगकर्ताओं के लिए जारी किए गए हैं:'
}

sub Poll_results_are_available { #url
  "<a href=\"$_[1]\">[&nbsp;मतदान परिणाम देखें&nbsp;]</a>"
}
sub Description {
  'विवरण:'
}
sub Candidates {
  'उम्मीदवार:'
}
sub Add_voters {
  'मतदाताओं को जोड़ें'
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
  'मतदाताओं के ईमेल पते दर्ज करें, प्रति पंक्ति एक। ये नए मतदाता या मौजूदा मतदाता हो सकते हैं जिन्होंने अभी तक मतदान नहीं किया है। एक निजी मतदान में, पहले से मौजूद मतदाता का ईमेल पता देने से उस मतदाता को दो बार मतदान <strong>नहीं</strong> करने दिया जाएगा। यह केवल मतदाता को मतदान करने का निमंत्रण दोबारा भेजेगा। एक सार्वजनिक मतदान में, एकाधिक मतदान को रोकने के लिए केवल एक सांकेतिक प्रयास किया जाता है।'
}
sub resend_question {
  'उन मतदाताओं को भी आमंत्रित करें जो पहले ही मतदान कर चुके हैं?'
}
sub Upload_file {
  'दस्तावेज अपलोड करें:'
}
sub Load_ballot_data {
  'मतपत्र डेटा लोड करें'
}
sub File_to_upload_ballots_from {
  'मतपत्र अपलोड करने के लिए फ़ाइल:'
}
sub Upload_instructions {
  'प्रति पंक्ति एक मतपत्र के साथ स्वरूपित टेक्स्ट फ़ाइल अपलोड करें। प्रत्येक पंक्ति में N विकल्पों की श्रेणी होती है, जो 1 से N तक की संख्याएँ होती हैं, या बिना किसी राय का प्रतिनिधित्व करने के लिए एक डैश (<kbd>-</kbd>) होता है। रैंकों को व्हाइटस्पेस या अल्पविराम से अलग किया जाना चाहिए। लाइन को एलएफ या सीआर/एलएफ के साथ समाप्त किया जा सकता है। व्हॉट्सएप को नजरअंदाज किया जाता है; जिन पंक्तियों का पहला गैर-सफ़ेद वर्ण # है, उन्हें भी नज़रअंदाज़ कर दिया जाता है। एक पंक्ति <i>m</i><kbd>X</kbd> से शुरू हो सकती है, जहां <i>m</i> एक संख्या है, जो <i>m</i> समान मतपत्रों को दर्शाता है, जिन्हें बाकी मतपत्रों द्वारा वर्णित किया गया है। रेखा का।'
}
sub Examples_of_ballots {
  'मतपत्रों के उदाहरण:'
}
sub Ballot_examples {
  ' 1,4,3,2,5 <i>एक साधारण बैलट रैंकिंग पांच विकल्प।</i> 5 - 2 - 3 <i>पांच विकल्पों की एक और रैंकिंग। डैश अनरैंक किए गए विकल्पों को इंगित करते हैं।</i> 8X1 4 3 2 5 <i>आठ मतपत्र पहले उदाहरण के मतपत्र की तरह।</i>'
}
sub Or_paste_this_code {
  'या इस HTML कोड को अपने वेब पेज में पेस्ट करें:'
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
  'मतदान समाप्त हो गया है।'
}

# add voters

sub CIVS_Adding_Voters {
  'सीआईवीएस: मतदाताओं को जोड़ना'
}
sub Adding_voters {
  'मतदाताओं को जोड़ना'
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
  'क्षमा करें, मतदाताओं को केवल चल रहे मतदान में जोड़ा जा सकता है।'
}
sub Too_many_voters_added {
  'क्षमा करें, आप एक बार में केवल @MAX_VOTER_ADD@ मतदाता ही जोड़ सकते हैं।'
}
sub Too_much_email {
  'क्षमा करें, सीआईवीएस ने ईमेल उत्पन्न करने की संख्या को सीमित कर दिया है। कृपया बाद में और मतदाता जोड़ें।'
}
sub Out_of_upload_space {
  'सर्वर अपलोड के लिए डिस्क स्थान से बाहर हो सकता है।'
}
sub Uploaded_file_empty {
    my ($self, $desc) = @_;
  "अपलोड किया गया $desc खाली है।"
}
sub No_upload_file_provided {
    my ($self, $desc) = @_;
  "कोई $desc प्रदान नहीं किया गया। अपलोड विफल।"
}
sub Didnt_get_plain_text {
    my ($self, $type) = @_;
  "अपलोड किया गया इनपुट एक सादा पाठ फ़ाइल या CSV फ़ाइल (इसके बजाय <b>$type</b> प्राप्त) होना चाहिए"
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
  'मतदान नियंत्रण पर वापस जाएं'
}
sub Done {
  'किया हुआ।'
}

sub Email_voters_who_have_not_activated {
  'ईमेल मतदाता जिन्होंने सक्रिय नहीं किया है'
}

sub Activate_mail_subject {
  'कृपया सीआईवीएस पर अपना ईमेल पता सक्रिय करें'
}
sub Address {
  'पता'
}
sub Reason {
  'कारण'
}

sub Activate_mail_body {
    my ($self, $supervisor, $name, $title, $url) = @_;
  "$name <$supervisor> द्वारा आपको â$titleâ शीर्षक वाले पोल में वोट करने के लिए आमंत्रित किया गया है।
 मतदान करने के लिए, कृपया सीआईवीएस मतदान प्रणाली के साथ अपना ईमेल पता सक्रिय करें: <$url>"
}


# vote

sub page_header_CIVS_Vote { # election_title
  'सीआईवीएस वोट: '.$_[1]
}

sub ballot_reporting_is_enabled {
  'इस मतदान के लिए मतपत्र रिपोर्टिंग सक्षम है। मतदान समाप्त होने पर आपका मतपत्र (चुनावों के लिए आपके द्वारा निर्दिष्ट रैंकिंग) मतदान परिणामों में दिखाई देगा।'
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
  'कृपया अपना ईमेल पता या अन्य पहचानने योग्य पहचानकर्ता दें:'
}
sub Need_identifier {
  'क्षमा करें, मतदान करने के लिए आपको अपनी पहचान बतानी होगी।'
}

sub Rank {
  'पद'
}
sub Choice {
  'पसंद'
}
sub Weight {
  'वज़न'
}

# overridden in english.pm
sub ordinal_of {
  "$_[1]"
}

sub address_will_be_visible {
  'आपके मतपत्र के साथ <strong>आपका ईमेल पता दिखाई देगा</strong>।'
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
  ' हालांकि, आपका मतपत्र अभी भी गुमनाम रहेगा: कोई व्यक्तिगत पहचान वाली जानकारी दिखाई नहीं देगी।'
}

sub submit_ranking {
  'रैंकिंग सबमिट करें'
}

sub only_writeins_are_permitted {
  'इस पोल में अभी तक वोटिंग की अनुमति नहीं है। हालाँकि, आप उपलब्ध विकल्पों को देख सकते हैं और नए विकल्पों में लिख सकते हैं। नए विकल्पों में लिखने के लिए नीचे टेक्स्ट फ़ील्ड का उपयोग करें।'
}

sub Add_writein {
  'राइट-इन जोड़ें'
}

sub to_top {
  'ऊपर के लिए'
}
sub to_bottom {
  'नीचे करने के लिए'
}
sub move_up {
  'बढ़ाना'
}
sub move_down {
  'नीचे की ओर'
}
sub make_tie {
  'टाई बनाओ'
}
sub buttons_are_deactivated {
  'ये बटन निष्क्रिय हैं क्योंकि आपका ब्राउज़र जावास्क्रिप्ट का समर्थन नहीं करता है।'
}
sub ranking_instructions {
  '<p>चुनावों को तीन तरीकों में से एक में रैंक करें:</p> <ol> <li>पंक्तियों को खींचें</li> <li>रैंक कॉलम में पुलडाउन का उपयोग करें</li> <li>पंक्तियों का चयन करें और ऊपर बटन का उपयोग करें </ली> </ओल>'
}
sub write_in_a_choice {
  'एक नई पसंद में लिखें:'
}
sub show_qr_code {
  'इस पोल के लिए क्यूआर कोड दिखाएं।'
}
sub if_you_have_already_voted { #url
  "यदि आप पहले ही मतदान कर चुके हैं, तो आप <a href=\"$_[1]\">वर्तमान मतदान परिणाम</a> देख सकते हैं।"
}
sub thank_you_for_voting { #title, receipt
  "धन्यवाद। <strong>$_[1]</strong> के लिए आपका वोट सफलतापूर्वक डाल दिया गया है।<br> आपकी मतदाता रसीद <code>$_[2]</code> है। यदि आप बाद में अपना मतपत्र बदलना चाहते हैं तो आपको इस रसीद की आवश्यकता होगी।"
}
sub try_some_public_polls {
  "किसी और चीज़ पर मतदान करने का मन करता है? इनमें से किसी एक सार्वजनिक चुनाव का प्रयास करें:"
}
sub you_can_change_ballot_now {
  'इस पृष्ठ से, आप अपने द्वारा डाले गए मतपत्र को मिटा सकते हैं और फिर से मतदान कर सकते हैं।'
}
sub change_ballot {
  'रिवोट करें'
}
sub name_of_writein_is_empty {
  "राइट-इन पसंद का नाम खाली है"
}
sub writein_too_similar {
  "क्षमा करें, राइट-इन का नाम मौजूदा पसंद के समान है"
}
sub doublecheck_msg {
  'आपके मतपत्र का कोई प्रभाव नहीं पड़ेगा क्योंकि जिन उम्मीदवारों पर आपकी राय है वे सभी बंधे हुए हैं। क्या आप अभी भी सबमिट करना चाहते हैं?'
}

# election

sub No_poll_ID {
  "कोई मतदान पहचान पत्र प्रदान नहीं किया गया था। शायद कॉपी-पेस्ट त्रुटि?"
}
sub Ill_formed_poll_ID {
  "एक गलत तरीके से बनाया गया मतदान पहचानकर्ता प्रदान किया गया था। शायद कॉपी-पेस्ट त्रुटि? (" . $_[1] .")"
}
sub vote_has_already_been_cast {
  "आपकी मतदाता कुंजी का उपयोग करके एक वोट पहले ही डाला जा चुका है।"
}
#deprecated, use future_result_link
sub following_URL_will_report_results {
  'मतदान समाप्त होने के बाद निम्न URL मतदान परिणामों की रिपोर्ट करेगा:'
}
sub future_result_link {
    my ($self, $url) = @_;
  "मतदान समाप्त होने के बाद निम्न URL मतदान परिणामों की रिपोर्ट करेगा: <a href='$url'><code>$url</code></a>"
}
#deprecated
sub following_URL_reports_results {
  'निम्न URL वर्तमान मतदान परिणामों की रिपोर्ट करता है:'
}
sub if_you_want_to_change {
  'आप यहां अपनी मतदाता रसीद दर्ज करके अपना पिछला वोट हटा सकते हैं और फिर से वोट कर सकते हैं:'
}
sub invalid_release_key {
    my ($self, $receipt) = @_;
  'प्रदान की गई मतदाता रसीद ('.$receipt.') गलत है। यह '.code('E_2ad1ca99ac3cac7a/3a191bd9fb00ef73').' जैसा दिखना चाहिए।'
}
sub no_ballot_under_key {
    my ($self, $key) = @_;
  "रसीद $ key के लिए कोई पिछला मतपत्र नहीं मिला"
}
sub current_result_link {
    my ($self, $url) = @_;
  "<a href=\"$url\" class=result_link>वर्तमान मतदान परिणामों पर जाएं</a>"
}
sub Already_voted {
  'पहले ही वोट कर दिया है'
}
sub Error {
  'गलती'
}
sub Invalid_key {
  'अमान्य चाबी। आपको ईमेल द्वारा मतदान को नियंत्रित करने के लिए एक सही URL प्राप्त होना चाहिए था। यह त्रुटि दर्ज की गई है।'
}
sub Authorization_failure {
  'प्राधिकरण विफलता'
}

sub already_ended { # title
  "यह मतदान (<strong>$_[1]</strong>) पहले ही समाप्त हो चुका है।"
}
sub Poll_not_yet_ended {
  "मतदान अभी समाप्त नहीं हुआ है"
}
sub The_poll_has_not_yet_been_ended { #title, name, email
  "यह मतदान ($_[1]) अभी तक इसके पर्यवेक्षक, $_[2] ($_[3]) द्वारा समाप्त नहीं किया गया है।"
}

# deprecated
sub The_results_of_this_completed_poll_are_here {
  'इस पूर्ण मतदान के परिणाम यहां हैं:'
}
sub completed_results_link {
    my ($self, $url) = @_;
  "<a href=\"$url\" class=result_link>पूर्ण मतदान परिणामों पर जाएं</a>"
}

sub No_write_access_to_lock_poll {
  "मतदान को लॉक करने के लिए लिखने की आवश्यकता नहीं थी।"
}
sub This_poll_has_already_been_started { # title
  "यह मतदान ($_[1]) पहले ही शुरू हो चुका है।"
}
sub No_write_access_to_start_poll {
  'मतदान शुरू करने के लिए लिखने का अधिकार नहीं था।'
}
sub Poll_does_not_exist_or_not_started {
  'यह मतदान मौजूद नहीं है या शुरू नहीं किया गया है।'
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
  "अमान्य परिणाम कुंजी: \"$_[1]\"। ईमेल द्वारा मतदान के परिणाम देखने के लिए आपको एक सही URL प्राप्त होना चाहिए। यह त्रुटि दर्ज की गई है।"
}
sub Invalid_control_key { # key
  "अमान्य नियंत्रण कुंजी। आपको ईमेल द्वारा मतदान को नियंत्रित करने के लिए एक सही URL प्राप्त होना चाहिए था। यह त्रुटि दर्ज की गई है।"
}
sub Invalid_voting_key {
  "अमान्य मतदान कुंजी। आपको ईमेल द्वारा मतदान करने के लिए एक सही URL प्राप्त होना चाहिए। यह त्रुटि दर्ज की गई है।"
}
sub Invalid_poll_id {
  "अमान्य मतदान पहचानकर्ता"
}
sub Poll_id_not_valid { #id
  "मतदान पहचानकर्ता \"$_[1]\" मान्य नहीं है।"
}
sub Unable_to_append_to_poll_log {
  "मतदान लॉग में संलग्न करने में असमर्थ।"
}
sub Voter_v_already_authorized {
  "मतदाता &lt;$_[1]&gt; पहले से ही अधिकृत है। मतदाता कुंजी मतदाता को फिर से भेजी जाएगी।"
}
sub Skipping_already_voted {
  "छोड़ने वाला मतदाता &lt;$_[1]&gt;: पहले ही मतदान कर चुका है।"
}
sub Invalid_email_address_hdr { # addr
  "अमान्य ईमेल पता"
}
sub Invalid_email_address { # addr
  "अमान्य ईमेल पता: $_[1]"
}
sub Address_opted_out { # addr
  "यह पता सीआईवीएस ईमेल से बाहर हो गया है: $_[1]"
}
sub Sending_mail_to_voter_v {
  "मतदाता को मेल भेजना \"$_[1]\"..."
}
sub CIVS_poll_supervisor { # name
  "\"कोंडोरसेट इंटरनेट वोटिंग सेवा ($_[1] की ओर से)\""
}
sub From_poll_supervisor {
    my ($self, $name) = @_;
    $self->CIVS_poll_supervisor($name)
# UNTRANSLATED
}
sub voter_mail_intro { #title, name, email_addr
  "<b>$_[1]</b> नाम का एक कॉन्डोरसेट इंटरनेट वोटिंग सर्विस पोल बनाया गया है। आपको मतदान पर्यवेक्षक, $_[2] (<a href=\"mailto:$_[3] ($_[2])\"><code>$_[3]< द्वारा एक मतदाता के रूप में नामित किया गया है /code></a>).</p>"
}
sub Description_of_poll {
  'मतदान का विवरण:'
}
sub if_you_would_like_to_vote_please_visit {
  'यदि आप मतदान करना चाहते हैं, तो कृपया निम्नलिखित URL पर जाएँ:'
}
sub This_is_your_private_URL {
  'यह आपका निजी यूआरएल है। इसे किसी और को न दें, क्योंकि वे इसका इस्तेमाल आपको वोट देने के लिए कर सकते हैं।'
}
sub Your_privacy_will_not_be_violated {
  'वोट देने से आपकी निजता का हनन नहीं होगा। मतदान सेवा ने आपके ईमेल पते के रिकॉर्ड को पहले ही नष्ट कर दिया है और आपने मतदान किया है या नहीं, इस बारे में कोई जानकारी जारी नहीं करेगी।'
}
sub This_is_a_nonanonymous_poll {
  'मतदान पर्यवेक्षक ने इसे <strong>गैर-गुमनाम मतदान</strong> बनाने का निर्णय लिया है. यदि आप मतदान करते हैं, तो आपका ईमेल पता और आपने कैसे मतदान किया, वह किसी को भी दिखाई देगा, जिसे मतदान परिणामों तक पहुंच प्रदान की गई है।'
}


sub poll_has_been_announced_to_end { #election_end
  "मतदान $_[1] समाप्त होने की घोषणा की गई है।"
}

sub To_view_the_results_at_the_end {
  "मतदान समाप्त होने के बाद उसके परिणाम देखने के लिए, यहां जाएं:</p> $_[1]"
}

sub for_more_information_about_CIVS { # url
  "कोंडोरसेट इंटरनेट वोटिंग सेवा के बारे में अधिक जानकारी के लिए, देखें $_[1]"
}

sub For_more_information { # url, mail mgmt url
  ($self, $home, $mail_mgmt) = @_;
  "For more information about the Condorcet Internet Voting Service, see
   $home. To control future email sent from CIVS, see $mail_mgmt"
# UNTRANSLATED
}

sub poll_email_subject { # title
  "मतदान: $_[1]"
}

# close

sub CIVS_Ending_Poll {
  'सीआईवीएस: एंडिंग पोल'
}

sub Ending_poll {
  'मतदान समाप्त करना'
}
sub View_poll_results {
  'मतदान के परिणाम देखें'
}
sub Poll_ended { #title
  "मतदान समाप्त: $_[1]"
}

sub The_poll_has_been_ended { #election_end
  "मतदान समाप्त कर दिया गया है। $_[1] को समाप्त करने की घोषणा की गई थी।"
}

sub poll_results_available_to_authorized_users {
  'मतदान के परिणाम अब अधिकृत उपयोगकर्ताओं के लिए उपलब्ध हैं।'
}

sub was_not_able_stop_the_poll {
  'मतदान को रोक नहीं पाए'
}


# results

sub CIVS_poll_result {
  "सीआईवीएस चुनाव परिणाम"
}
sub Poll_results { # title
  "मतदान परिणाम: $_[1]"
}

sub Writeins_currently_allowed {
  'राइट-इन विकल्पों की वर्तमान में अनुमति है।'
}

sub Writeins_allowed {
  'राइट-इन विकल्पों की अनुमति है।'
}
sub Writeins_not_allowed {
  'राइट-इन विकल्पों की अनुमति नहीं है।'
}
sub Detailed_ballot_reporting_enabled {
  'विस्तृत मतपत्र रिपोर्टिंग सक्षम है।'
}
sub Detailed_ballot_reporting_disabled {
  'विस्तृत मतपत्र रिपोर्टिंग अक्षम है।'
}
sub Voter_identities_will_be_kept_anonymous {
  'मतदाता पहचान गुमनाम रखी जाएगी'
}
sub Voter_identities_will_be_public {
  'मतदान के परिणाम देखने के लिए अधिकृत लोगों को उनके मतपत्रों के साथ मतदाता पहचान (ईमेल) दिखाई देगी।'
}
sub Condorcet_completion_rule {
  'कॉन्डोर्सेट समापन नियम:'
}
sub undefined_algorithm {
  'त्रुटि: अपरिभाषित एल्गोरिथ्म।'
}
sub computing_results {
  'गणना परिणाम...'
}
sub Supervisor { #name, email
  "पर्यवेक्षक: $_[1] <tt>&lt;$_[2]&gt;</tt>"
}
sub Announced_end_of_poll {
  "मतदान के अंत की घोषणा: $_[1]"
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
  'मतदान अभी समाप्त नहीं हुआ है।'
}
sub This_is_a_test_poll {
  'यह एक परीक्षण सर्वेक्षण है।'
}
sub This_is_a_private_poll { #num_auth
  "निजी मतदान ($_[1] अधिकृत मतदाता)"
}
sub This_is_a_public_poll {
  'यह एक सार्वजनिक मतदान है।'
}

sub Actual_votes_cast { #num_votes
  "डाले गए वास्तविक मत: $_[1]"
}
sub Number_of_winning_candidates {
  'जीतने के विकल्पों की संख्या:'
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
  'जनमत विवरण'
}
sub Ranking_result {
  'परिणाम'
}
sub x_beats_y { # x y w l
  "$_[1] ने $_[2] $_[3]&ndash;$_[4] को मात दी"
}
sub x_ties_y { # x y w l
  "$_[1] संबंध $_[2] $_[3]&ndash;$_[4]"
}
sub x_loses_to_y { # x y w l
  "$_[1] $_[2] $_[3]&ndash;$_[4] से हार गया"
}
sub some_result_details_not_shown {
  'सरलता के लिए, चुनाव परिणाम के कुछ विवरण नहीं दिखाए जाते हैं।'
}
sub Show_details {
  'प्रदर्शन का विवरण'
}
sub Hide_details {
  'जानकारी छिपाएँ'
}
sub Result_details {
  'परिणाम विवरण'
}
sub Ballot_report {
  'बैलेट रिपोर्ट'
}
sub Ballots_are_shown_in_random_order {
  "मतपत्र बेतरतीब ढंग से उत्पन्न क्रम में दिखाए जाते हैं।"
}
sub Download_ballots_as_a_CSV { # url
  "[<a href=\"$_[1]\">CSV प्रारूप में मतपत्र डाउनलोड करें</a>]"
}
sub No_ballots_were_cast {
  "इस पोल में कोई मतपत्र नहीं डाला गया था।"
}
sub Ballot_reporting_was_not_enabled {
  'इस मतदान के लिए मतपत्र रिपोर्टिंग सक्षम नहीं की गई थी।'
}
sub Tied {
  '<i>बंधे</i>:'
}
sub loss_explanation { # loss_to, for, against
  ', हार जाता है। '.$_[1].' द्वारा ।'.$_[2].'&ndash;। '.$_[3]
}
sub loss_explanation2 {
  '&nbsp;&nbsp;'.$_[1].' से हारे। '.$_[2].'&ndash;'.$_[3].' द्वारा'
}
sub Condorcet_winner_explanation {
  '&nbsp;&nbsp;(कोंडोरसेट विजेता: अन्य सभी विकल्पों के साथ प्रतियोगिता जीतता है)'
}
sub undefeated_explanation {
  '&nbsp;&nbsp;(किसी भी प्रतियोगिता बनाम किसी अन्य विकल्प में पराजित नहीं)'
}
sub Choices_shown_in_red_have_tied {
  'लाल रंग में दिखाए गए विकल्प चुने जाने के लिए टाई हो गए हैं। आप उनमें से यादृच्छिक रूप से चयन करना चाह सकते हैं।'
}
sub Condorcet_winner {
  "कोंडोरसेट विजेता"
}
sub Choices_in_individual_pref_order {
  'विकल्प (व्यक्तिगत वरीयता क्रम में)'
}

sub Unknown_email {
  '(अनजान)'
}

sub What_is_this { # url
  '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>(यह क्या है?)</small></a>'
}

# rp

sub All_prefs_were_affirmed {
  'सभी प्राथमिकताओं की पुष्टि की गई।'
}

sub Presence_of_a_green_entry_etc {
  'विकर्ण के नीचे एक हरे रंग की प्रविष्टि (और ऊपर एक संबंधित लाल) की उपस्थिति का अर्थ है कि वरीयता को अनदेखा कर दिया गया क्योंकि यह अन्य, मजबूत प्राथमिकताओं के साथ विरोधाभासी थी।'
}
sub Random_tie_breaking_used {
  'एमएएम एल्गोरिथम के अनुसार, इस क्रम पर पहुंचने के लिए रैंडम टाई ब्रेकिंग का उपयोग किया गया था। इससे विकल्पों के क्रम पर असर पड़ सकता है।'
}
sub No_random_tie_breaking_used {
  'इस ऑर्डर पर पहुंचने के लिए किसी रैंडम टाई ब्रेकिंग की जरूरत नहीं थी।'
}

# beatpath

sub beatpath_matrix_explanation {
  'निम्नलिखित मैट्रिक्स प्रत्येक जोड़ी विकल्पों को जोड़ने वाले सबसे मजबूत बीटपाथ की ताकत दिखाता है। पसंद 1 को पसंद 2 से ऊपर स्थान दिया गया है यदि 2 से 1 तक किसी भी अग्रणी की तुलना में 1 से 2 तक एक मजबूत बीटपाथ है।'
}

sub no_pref {
  'कोई भी नहीं'
}

#rp

sub Some_voter_preferences_were_ignored {
  'कुछ मतदाता प्राथमिकताओं पर ध्यान नहीं दिया गया क्योंकि वे अन्य मजबूत प्राथमिकताओं के साथ संघर्ष करती हैं:'
}

sub preference_description {
  "$_[1]&ndash;$_[2] $_[3] के लिए $_[4] से अधिक वरीयता।"
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
  'मेल पता:'
}
sub deactivation_code {
  'निष्क्रियता कोड:'
}
sub filter_question {
  'फ़िल्टर पैटर्न <छोटा>(खाली छोड़ा जा सकता है; मदद के लिए होवर करें)</छोटा>'
}
sub filter_explanation {
  'यह निर्दिष्ट करने के लिए कि कौन से मतदान पर्यवेक्षकों को ईमेल से बचना है, आप यहां एक या अधिक पैटर्न दर्ज कर सकते हैं। पैटर्न पर्यवेक्षक का ईमेल पता या ईमेल पतों का वर्णन करने वाला पैटर्न हो सकता है। वर्णों के किसी भी अनुक्रम का प्रतिनिधित्व करने के लिए पैटर्न * का उपयोग कर सकता है। उदाहरण के लिए, पैटर्न *@inmano.com @inmano.com पते वाले पर्यवेक्षकों को आपको मतदान आमंत्रण भेजने से रोकेगा। यदि आप इस फ़ील्ड को खाली छोड़ देते हैं, तो सभी ईमेल पतों पर निष्क्रियता/पुनः सक्रियण लागू होगा।'
}
sub send_deactivation_code {
  'ईमेल द्वारा निष्क्रियता कोड भेजें'
}
sub cant_send_email {
  'आप सीआईवीएस का उपयोग कर इस उपयोगकर्ता को ईमेल नहीं भेज सकते। इस उपयोगकर्ता को भेजे गए ईमेल को पहले भेजे गए निष्क्रियकरण कोड का उपयोग करके पहले पुनः सक्रिय किया जाना चाहिए।'
}
sub submit_deact_react {
  'निष्क्रियता / पुनर्सक्रियन जमा करें'
}
sub codes_dont_match {
  "क्षमा करें, दिया गया कोड और ईमेल पता मेल नहीं खाते। यदि आपने पहले सीआईवीएस से ईमेल अवरुद्ध नहीं किया है तो आप दूसरे कोड का अनुरोध कर सकते हैं।"
}
sub deactivation_successful {
    my ($self, $pattern) = @_;
  "यदि सीआईवीएस इस पते पर कोई और मेल नहीं भेजेगा यदि इसका प्रेषक इस पैटर्न से मेल खाता है: \"$पैटर्न\"। आप केवल इस वेब पेज का उपयोग करके उसी कोड के साथ CIVS से मेल को पुनः सक्रिय कर सकते हैं जिसका आपने अभी उपयोग किया है।"
}
sub reactivation_successful {
  'आपने इस पते पर मेल को सफलतापूर्वक पुनः सक्रिय कर दिया है।'
}
sub someone_has_requested {
  "किसी ने सीआईवीएस को आपको ईमेल भेजने से रोकने के लिए एक कोड का अनुरोध किया है। यदि यह आप थे, तो आपको पता चल जाएगा कि इसके साथ क्या करना है। कोड है:
 $_[1]
यह ईमेल अपने पास रखें क्योंकि यदि आप भविष्य में सेवा का उपयोग करना चाहते हैं तो आपको इस कोड की आवश्यकता होगी।"
}
sub deactivation_code_subject {
  'CIVS मेल के लिए निष्क्रियता कोड'
}
sub mail_mgmt_title {
  'मेल प्रबंधन'
}

## User activation

sub user_activation {
  'उपयोगकर्ता को सक्रिय करें'
}
sub activation_code_subject {
  'सीआईवीएस का उपयोग करने के लिए सक्रियण कोड'
}
sub user_activation_instructions1 {
  'निजी सीआईवीएस चुनावों में मतदान करने के लिए, आपको सेवा से ईमेल संचार का विकल्प चुनना होगा। सीआईवीएस आपका ईमेल पता संग्रहीत नहीं करता है, और कोई स्वचालित मेलिंग नहीं है। आप केवल चुनाव पर्यवेक्षकों के स्पष्ट अनुरोध पर सेवा से ईमेल प्राप्त करते हैं, जिसमें निजी चुनावों में मतदान करने या मतदान के परिणाम देखने के लिए आवश्यक क्रेडेंशियल्स होते हैं।'
}
sub user_activation_instructions2 {
  "ऑप्ट इन करने के लिए, कृपया अपना ईमेल पता दर्ज करें और नीचे दिए गए बटन पर क्लिक करें। फिर आपको एक सक्रियण कोड वाला एक ईमेल प्राप्त होना चाहिए। ध्यान दें कि यदि आपने पहले ईमेल से ऑप्ट आउट किया है, तो आपको ईमेल को पुनः सक्रिय करने के लिए <a href=\"$_[1]\">मेल प्रबंधन पृष्ठ</a> का उपयोग करना होगा। यदि आप मेल ब्लॉकिंग सेवा का उपयोग करते हैं, तो आपको CIVS ईमेल पते को अधिकृत प्रेषक (".'@SUPERVISOR@'.") के रूप में श्वेतसूची में डालने की आवश्यकता हो सकती है।"
}
sub user_activation_instructions {
    my ($self, $mail_mgmt_url) = @_;
    p($self->user_activation_instructions1).
    p($self->user_activation_instructions2($mail_mgmt_url))
# UNTRANSLATED
}
sub opt_in_label {
  'सक्रियण कोड का अनुरोध करें'
}
sub activation_code {
  'एक्टिवेशन कोड:'
}
sub someone_has_requested_activation {
    my ($self, $address, $code, $mail_mgmt_url) = @_;
  "किसी ने अनुरोध किया है कि सीआईवीएस वोटिंग सिस्टम मतदान में मतदान के लिए ईमेल पता <$address> सक्रिय करें। इस पते को सक्रिय करने के लिए, आपको निम्नलिखित सक्रियण कोड की आवश्यकता होगी:
 $ कोड
यदि आपने यह अनुरोध नहीं किया है, तो आप इस ईमेल को अनदेखा कर सकते हैं।
इस लिंक का उपयोग करके CIVS से ईमेल नियंत्रित करें: $mail_mgmt_url."
}
sub already_activated {
  'यह ईमेल पता पहले से सक्रिय है।'
}
sub activation_successful
{
    'Email address successfully activated.'
}
sub pending_invites_hdr {
  'लंबित मतदान आमंत्रण:'
}
sub submit_activation_code {
  'पूर्ण सक्रियता'
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
  "क्षमा करें, किसी भी उपयोगकर्ता ने पता &lt;$पता&gt; ईमेल प्राप्त करने के लिए।"
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
  "<p>नीचे दी गई तालिका में सूचीबद्ध कारणों से CIVS के लिए कुछ मतदाताओं को मेल भेजना संभव नहीं था। मतदाता अपनी व्यक्तिगत कुंजी प्राप्त होने तक मतदान नहीं कर सकेंगे, इसलिए आपको उनसे सीधे संपर्क करना चाहिए। मतदाताओं को निम्नलिखित लिंक उपयोगी लगने की संभावना है:</p> <ul> <li>CIVS के साथ एक ईमेल पता सक्रिय करें: <a href='$active_url'>$active_url</a></li> <li>निष्क्रिय करें /एक ईमेल पता पुनः सक्रिय करें: <a href='$mail_mgmt_url'>$mail_mgmt_url</a></li> </ul> <p> ध्यान दें कि जब मतदाता अपने ईमेल पते को सक्रिय करते हैं, तो उन्हें मतदान के लिए किसी भी लंबित आमंत्रण के बारे में सूचित किया जाता है चुनावों में। </p>"
}
sub download_failures {
  'तालिका को CSV के रूप में डाउनलोड करें'
}

sub code_requested {
  'कोड का अनुरोध किया। अपने ईमेल की जाँच करें।'
}

sub code_requested_but_something_wrong {
  'कोड का अनुरोध किया गया लेकिन कुछ गलत हो गया।'
}

sub error_handling_code_request {
  "कोड अनुरोध को हैंडल करने में त्रुटि"
}
sub invalid_email_address {
  'अमान्य ईमेल पता'
}
sub unexpected_error {
  '<b>अप्रत्याशित त्रुटि:</b>'
}
sub optin_error {
  'गलती:'
}
sub submitted {
  'प्रस्तुत'
}

1; # package succeeded!
