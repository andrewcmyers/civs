package tamil;

use lib '@CGIBINDIR@';
use CGI qw(:standard -utf8);
use utf8;

use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

our $VERSION = 1.000;

sub lang { 'ta-IN' }

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
  'Condorcet இணைய வாக்களிப்பு சேவை'
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited
  'Condorcet இணைய வாக்களிப்பு சேவை'
}
sub CIVS_sender {
    my ($self) = @_;
    $self->Condorcet_Internet_Voting_Service_email_hdr
# UNTRANSLATED
}
sub about_civs {
  'CIVS பற்றி'
}
sub new_user {
  'பயனரை இயக்கவும்'
}
sub public_polls {
  'பொது வாக்கெடுப்பு'
}
sub create_new_poll {
  'புதிய வாக்கெடுப்பை உருவாக்கவும்'
}
sub about_security_and_privacy {
  'பாதுகாப்பு மற்றும் தனியுரிமை'
}
sub FAQ {
  'அடிக்கடி கேட்கப்படும் கேள்விகள்'
}
sub CIVS_suggestion_box {
  'CIVS பரிந்துரை பெட்டி'
}
sub unable_to_process {
  'அகப் பிழையின் காரணமாக CIVS ஆல் உங்கள் கோரிக்கையைச் செயல்படுத்த முடியவில்லை.'
}
sub CIVS_Error {
  'CIVS பிழை'
}
sub CIVS_server_busy {
  'CIVS சர்வர் பிஸியாக உள்ளது'
}
sub Sorry_the_server_is_busy {
  'மன்னிக்கவும், CIVS இணைய சேவையகம் தற்போது மிகவும் பிஸியாக உள்ளது மேலும் கோரிக்கைகளை கையாள முடியாது. சிறிது நேரம் கழித்து மீண்டும் முயற்சிக்கவும்.'
}

# civs_create

sub mail_has_been_sent {
  "நீங்கள் வழங்கிய முகவரிக்கு அஞ்சல் அனுப்பப்பட்டது (<tt>$_[1]</tt>)."
}

sub click_on_the_URL_to_start {
  "வாக்கெடுப்பைத் தொடங்க அந்த மின்னஞ்சலில் உள்ள URL ஐக் கிளிக் செய்யவும் â$_[1]â."
}

sub here_is_the_control_URL {
  'புதிய வாக்கெடுப்பைக் கட்டுப்படுத்துவதற்கான URL இதோ. சாதாரண செயல்பாட்டில் இது மின்னஞ்சல் மூலம் மேற்பார்வையாளருக்கு அனுப்பப்படும்.'
}
sub the_poll_is_in_progress {
  'வாக்கெடுப்பு நடந்து வருகிறது. அதை முடிக்க இந்த பொத்தானை அழுத்தவும்:'
}

sub CIVS_Poll_Creation {
  "CIVS கருத்துக்கணிப்பு உருவாக்கம்"
}
sub Poll_created {
  "கருத்துக்கணிப்பு உருவாக்கப்பட்டது: $_[1]"
}

sub Address_unacceptable { #addr
  "\"$_[1]\" என்ற முகவரி ஏற்கத்தக்கதல்ல"
}
sub Poll_must_have_two_choices {
  'ஒரு வாக்கெடுப்பில் குறைந்தது இரண்டு தேர்வுகள் இருக்க வேண்டும்.'
}
sub Poll_exceeds_max_choices {
    my ($self, $count) = @_;
  "ஒரு வாக்கெடுப்பில் அதிகபட்சம் $count தேர்வுகள் இருக்கலாம்."
}
sub Poll_directory_not_writeable {
  "கட்டமைப்பு பிழையா? <tt>$_[1]</tt> வாக்கெடுப்பு கோப்பகத்தை உருவாக்க முடியவில்லை"
}
sub CIVS_poll_created {
  "CIVS வாக்கெடுப்பு உருவாக்கப்பட்டது: $_[1]"
}
sub creation_email_info1 { # title, url
  "$_[1] என்ற புதிய வாக்கெடுப்பின் உருவாக்கத்தை இந்த மின்னஞ்சல் அங்கீகரிக்கிறது. இந்த வாக்கெடுப்பின் மேற்பார்வையாளராக நீங்கள் நியமிக்கப்பட்டுள்ளீர்கள். வாக்கெடுப்பைத் தொடங்கவும் நிறுத்தவும், பின்வரும் URL ஐப் பயன்படுத்தவும்:
 <$_[2]>
இந்த மின்னஞ்சலைச் சேமித்து, தனிப்பட்டதாக வைத்துக் கொள்ளுங்கள். அதை இழந்தால் வாக்கெடுப்பை உங்களால் கட்டுப்படுத்த முடியாது.
"
}
sub creation_email_public_link { # url
  "இது ஒரு பொது வாக்கெடுப்பு என்பதால், பின்வரும் URL க்கு நீங்கள் வாக்காளர்களை வழிநடத்தலாம்:
 <$_[1]>
"
}

sub opted_out { # addr
  "மன்னிக்கவும், நீங்கள் எந்த மின்னஞ்சலையும் &lt;$_[1]&gt; CIVS வழியாக."
}

sub Sending_result_key { # addr (escaped)
  "<p>முடிவு விசையை <tt>$_[1]</tt>க்கு அனுப்புகிறது. இதை முடிக்க அனுமதிக்கவும்...<br>"
}
sub Done_sending_result_key { # addr
  '...முடிவு விசையை அனுப்புவது முடிந்தது.</p>'
}
sub Results_of_CIVS_poll { # title
  "CIVS வாக்கெடுப்பின் முடிவுகள்: $_[1]"
}
sub Results_key_email_body { # title, url, civs_home
  "\"$_[1]\" என்ற பெயரில் புதிய CIVS வாக்கெடுப்பு உருவாக்கப்பட்டது. இந்த வாக்கெடுப்பின் முடிவைப் பார்க்க அனுமதிக்கப்பட்ட பயனராக நீங்கள் நியமிக்கப்பட்டுள்ளீர்கள்.
இந்த மின்னஞ்சலைச் சேமிக்கவும். நீங்கள் அதை இழந்தால், முடிவுகளை அணுக முடியாது. கருத்துக்கணிப்பு முடிந்ததும், பின்வரும் URL இல் முடிவுகள் கிடைக்கும்:
 <$_[2]>
இந்த URL தனிப்பட்டது. அங்கீகரிக்கப்படாத பயனர்களை இந்த URL ஐ அணுக அனுமதிப்பது, அவர்கள் வாக்கெடுப்பு முடிவுகளைப் பார்க்க அனுமதிக்கும்.
"
}

# start

sub poll_started {
  "<strong>$_[1]</strong> வாக்கெடுப்பு தொடங்கப்பட்டது."
}

sub sending_keys_now {
  'இப்போது வாக்காளர் அழைப்பிதழ்களை அனுப்புகிறது. அனைத்து அழைப்புகளும் அனுப்பப்படும் வரை இந்தப் பக்கத்திலிருந்து செல்ல வேண்டாம்.'
}

# control

sub CIVS_Poll_Control {
  "CIVS கருத்துக்கணிப்பு கட்டுப்பாடு"
}
sub Poll_control {
  "கருத்துக்கணிப்பு கட்டுப்பாடு"
}
sub poll_has_not_yet_started {
  'வாக்கெடுப்பு இன்னும் தொடங்கவில்லை. இதைத் தொடங்க இந்த பொத்தானை அழுத்தவும்:'
}
sub Start_poll {
  'வாக்கெடுப்பைத் தொடங்கவும்'
}
sub End_poll {
  'முடிவு வாக்கெடுப்பு'
}
sub Edit_button {
  'தொகு'
}
sub ResendLink_button {
  'இணைப்பை மீண்டும் அனுப்பவும்'
}
sub ResendLinkAck {
  'அனுப்பப்பட்டது'
}
sub Save_button {
  'சேமிக்க'
}
sub Remove_button {
  'அகற்று'
}
sub confirm_ending_poll_cannot_be_undone {
  'வாக்கெடுப்பை முடிப்பது என்பது செயல்தவிர்க்க முடியாத செயலாகும். நீங்கள் வாக்கெடுப்பை மூட விரும்புகிறீர்கள் என்பதை உறுதிப்படுத்த, &#34;மூடு&#34; சரி என்பதை அழுத்தவும்'
}
sub writeins_have_been_disabled {
  'எழுதும் தேர்வுகள் முடக்கப்பட்டுள்ளன'
}
sub disallow_further_writeins {
  'மேலும் எழுதுவதை அனுமதிக்க வேண்டாம்'
}
sub voting_disabled_during_writeins {
  'எழுதும் கட்டத்தில் தற்போது வாக்குப்பதிவு முடக்கப்பட்டுள்ளது.'
}
sub allow_voting_during_writeins {
  'எழுதும் கட்டத்தில் வாக்களிக்க அனுமதிக்கவும்'
}
sub this_is_a_test_poll {
  'இது ஒரு சோதனை வாக்கெடுப்பு.'
}
sub file_to_upload_from {
  'வாக்குச் சீட்டுகளைப் பதிவேற்றுவதற்கான கோப்பு:'
}
sub Load_ballots {
  'வாக்குச் சீட்டுகளை ஏற்றவும்'
}
sub poll_supervisor { # name, email
  "வாக்கெடுப்பு மேற்பார்வையாளர்: $_[1] <tt>&lt;$_[2]&gt;</tt>"
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
  "அங்கீகரிக்கப்பட்ட மொத்த வாக்காளர்கள்: $_[1]"
}
sub actual_votes_so_far { # num
  "உண்மையில் இதுவரை அளிக்கப்பட்ட வாக்குகள்: $_[1]"
}
sub poll_ends { # end
  "வாக்கெடுப்பின் முடிவு அறிவிக்கப்பட்டது: $_[1]"
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
  'வாக்கெடுப்பு முடிந்ததும் அனைத்து வாக்காளர்களுக்கும் வாக்கெடுப்பு முடிவுகள் கிடைக்கும்.'
}
sub Voters_can_choose_No_opinion {
  '&ldquo;கருத்து இல்லை&rdquo; என்பதை வாக்காளர்கள் தேர்வு செய்யலாம்.'
}
sub Voting_is_disabled_during_writeins {
  'எழுதும் காலத்தில் வாக்களிப்பது முடக்கப்பட்டுள்ளது.'
}
sub Poll_results_will_be_available_to_the_following_users {
  'கருத்துக்கணிப்பு முடிவுகள் பின்வரும் பயனர்களுக்கு மட்டுமே கிடைக்கும்:'
}
sub Poll_results_are_now_available_to_the_following_users {
  'முடிவுகளைப் பார்ப்பதற்காக URL அடங்கிய மின்னஞ்சலை அனுப்பிய பின்வரும் பயனர்களுக்கு மட்டுமே கருத்துக்கணிப்பு முடிவுகள் இப்போது கிடைக்கும்:'
}
sub results_available_to_the_following_users {
  'இந்த வாக்கெடுப்பின் முடிவுகள் குறிப்பிட்ட சில பயனர்களுக்கு மட்டுமே வெளியிடப்பட்டுள்ளன:'
}

sub Poll_results_are_available { #url
  "<a href=\"$_[1]\">[&nbsp;வாக்கெடுப்பு முடிவுகளைப் பார்க்கவும்&nbsp;]</a>"
}
sub Description {
  'விளக்கம்:'
}
sub Candidates {
  'வேட்பாளர்கள்:'
}
sub Add_voters {
  'வாக்காளர்களைச் சேர்க்கவும்'
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
  'ஒரு வரிக்கு ஒன்று என வாக்காளர்களின் மின்னஞ்சல் முகவரியை உள்ளிடவும். இவர்கள் புதிய வாக்காளர்களாகவோ அல்லது இதுவரை வாக்களிக்காத தற்போதைய வாக்காளர்களாகவோ இருக்கலாம். ஒரு தனிப்பட்ட வாக்கெடுப்பில், ஏற்கனவே இருக்கும் வாக்காளரின் மின்னஞ்சல் முகவரியைக் கொடுத்தால், அந்த வாக்காளரை இரண்டு முறை வாக்களிக்க அனுமதிக்க முடியாது. இது வாக்களிக்க வாக்காளருக்கு மீண்டும் அழைப்பு அனுப்பும். ஒரு பொது வாக்கெடுப்பில், பல வாக்குகளை தடுக்க ஒரு டோக்கன் முயற்சி மட்டுமே செய்யப்படுகிறது.'
}
sub resend_question {
  'ஏற்கனவே வாக்களித்த வாக்காளர்களைக் கூட அழைக்கவா?'
}
sub Upload_file {
  'கோப்பை பதிவேற்றவும்:'
}
sub Load_ballot_data {
  'வாக்குச் சீட்டுத் தரவை ஏற்றவும்'
}
sub File_to_upload_ballots_from {
  'வாக்குச் சீட்டுகளைப் பதிவேற்றுவதற்கான கோப்பு:'
}
sub Upload_instructions {
  'ஒரு வரிக்கு ஒரு வாக்குச்சீட்டுடன் வடிவமைக்கப்பட்ட உரைக் கோப்பைப் பதிவேற்றவும். ஒவ்வொரு வரியிலும் N தேர்வுகளின் ரேங்க்கள் உள்ளன, அவை 1 முதல் N வரையிலான எண்கள் அல்லது ஒரு கோடு (<kbd>-</kbd>) எந்தக் கருத்தையும் குறிக்கவில்லை. ரேங்க்கள் இடைவெளி அல்லது கமாவால் பிரிக்கப்பட வேண்டும். வரிகள் LF அல்லது CR/LF உடன் நிறுத்தப்படலாம். வெண்வெளி புறக்கணிக்கப்படுகிறது; வெள்ளைவெளி அல்லாத முதல் எழுத்து # என்ற வரிகளும் புறக்கணிக்கப்படுகின்றன. ஒரு வரியானது <i>m</i><kbd>X</kbd> உடன் தொடங்கலாம், அங்கு <i>m</i> என்பது ஒரு எண்ணாகும், இது மற்றவற்றால் விவரிக்கப்பட்டுள்ள <i>m</i> ஒத்த வாக்குச்சீட்டுகளைக் குறிக்கிறது. வரியின்.'
}
sub Examples_of_ballots {
  'வாக்குச்சீட்டுகளின் எடுத்துக்காட்டுகள்:'
}
sub Ballot_examples {
  ' 1,4,3,2,5 <i>ஐந்து தேர்வுகளை தரவரிசைப்படுத்தும் எளிய வாக்குச்சீட்டு.</i> 5 - 2 - 3 <i>ஐந்து தேர்வுகளின் மற்றொரு தரவரிசை. கோடுகள் தரவரிசைப்படுத்தப்படாத தேர்வுகளைக் குறிக்கின்றன.</i> 8X1 4 3 2 5 <i>முதல் எடுத்துக்காட்டு வாக்குச்சீட்டைப் போன்ற எட்டு வாக்குச்சீட்டுகள்.</i>'
}
sub Or_paste_this_code {
  'அல்லது இந்த HTML குறியீட்டை உங்கள் சொந்த வலைப்பக்கத்தில் ஒட்டவும்:'
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
  'கருத்துக்கணிப்பு முடிந்தது.'
}

# add voters

sub CIVS_Adding_Voters {
  'CIVS: வாக்காளர்களைச் சேர்த்தல்'
}
sub Adding_voters {
  'வாக்காளர்களைச் சேர்த்தல்'
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
  'மன்னிக்கவும், நடந்துகொண்டிருக்கும் வாக்கெடுப்பில் மட்டுமே வாக்காளர்களைச் சேர்க்க முடியும்.'
}
sub Too_many_voters_added {
  'மன்னிக்கவும், நீங்கள் ஒரு நேரத்தில் @MAX_VOTER_ADD@ வாக்காளர்களை மட்டுமே சேர்க்க முடியும்.'
}
sub Too_much_email {
  'மன்னிக்கவும், எவ்வளவு மின்னஞ்சல் உருவாக்கப்படுகிறது என்பதற்கு CIVS வரம்புகளை விதிக்கிறது. பின்னர் மேலும் வாக்காளர்களைச் சேர்க்கவும்.'
}
sub Out_of_upload_space {
  'பதிவேற்றங்களுக்கு சேவையகத்தில் வட்டு இடம் இல்லாமல் இருக்கலாம்.'
}
sub Uploaded_file_empty {
    my ($self, $desc) = @_;
  "பதிவேற்றிய $desc காலியாக உள்ளது."
}
sub No_upload_file_provided {
    my ($self, $desc) = @_;
  "$desc வழங்கப்படவில்லை. பதிவேற்றம் தோல்வியுற்றது."
}
sub Didnt_get_plain_text {
    my ($self, $type) = @_;
  "பதிவேற்றப்பட்ட உள்ளீடு ஒரு எளிய உரைக் கோப்பு அல்லது CSV கோப்பாக இருக்க வேண்டும் (அதற்குப் பதிலாக <b>$type</b> பெறப்பட்டது)"
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
  'வாக்கெடுப்பு கட்டுப்பாட்டுக்கு திரும்பவும்'
}
sub Done {
  'முடிந்தது.'
}

sub Email_voters_who_have_not_activated {
  'செயல்படுத்தப்படாத வாக்காளர்களுக்கு மின்னஞ்சல் அனுப்பவும்'
}

sub Activate_mail_subject {
  'CIVS இல் உங்கள் மின்னஞ்சல் முகவரியைச் செயல்படுத்தவும்'
}
sub Address {
  'முகவரி'
}
sub Reason {
  'காரணம்'
}

sub Activate_mail_body {
    my ($self, $supervisor, $name, $title, $url) = @_;
  "â$titleâ என்ற வாக்கெடுப்பில் வாக்களிக்க $name <$supervisor> ஆல் அழைக்கப்பட்டுள்ளீர்கள்.
 வாக்களிக்க, CIVS வாக்களிக்கும் முறையுடன் உங்கள் மின்னஞ்சல் முகவரியைச் செயல்படுத்தவும்: <$url>"
}


# vote

sub page_header_CIVS_Vote { # election_title
  'CIVS வாக்கு: '.$_[1]
}

sub ballot_reporting_is_enabled {
  'இந்த வாக்கெடுப்புக்கு வாக்குச் சீட்டு அறிக்கையிடல் இயக்கப்பட்டுள்ளது. வாக்கெடுப்பு முடியும்போது உங்கள் வாக்குச்சீட்டு (தேர்வுகளுக்கு நீங்கள் ஒதுக்கும் தரவரிசை) வாக்கெடுப்பு முடிவுகளில் தெரியும்.'
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
  'தயவுசெய்து உங்கள் மின்னஞ்சல் முகவரி அல்லது வேறு அடையாளம் காணக்கூடிய அடையாளங்காட்டியைக் கொடுங்கள்:'
}
sub Need_identifier {
  'மன்னிக்கவும், வாக்களிக்க நீங்கள் உங்களை அடையாளப்படுத்த வேண்டும்.'
}

sub Rank {
  'தரவரிசை'
}
sub Choice {
  'தேர்வு'
}
sub Weight {
  'எடை'
}

# overridden in english.pm
sub ordinal_of {
  "$_[1]"
}

sub address_will_be_visible {
  'உங்கள் வாக்குச்சீட்டுடன் <strong>உங்கள் மின்னஞ்சல் முகவரி தெரியும்</strong>.'
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
  ' இருப்பினும், உங்கள் வாக்குச் சீட்டு அநாமதேயமாகவே இருக்கும்: தனிப்பட்ட முறையில் அடையாளம் காணும் தகவல்கள் எதுவும் தோன்றாது.'
}

sub submit_ranking {
  'தரவரிசையை சமர்ப்பிக்கவும்'
}

sub only_writeins_are_permitted {
  'இந்த வாக்கெடுப்பில் வாக்களிக்க இன்னும் அனுமதிக்கப்படவில்லை. இருப்பினும், நீங்கள் கிடைக்கக்கூடிய தேர்வுகளைப் பார்க்கலாம் மற்றும் புதிய தேர்வுகளில் எழுதலாம். புதிய தேர்வுகளில் எழுத கீழே உள்ள உரை புலத்தைப் பயன்படுத்தவும்.'
}

sub Add_writein {
  'எழுத்தைச் சேர்க்கவும்'
}

sub to_top {
  'மேல் நோக்கி'
}
sub to_bottom {
  'கீழே'
}
sub move_up {
  'மேலே நகர்த்து'
}
sub move_down {
  'கீழே இறங்கு'
}
sub make_tie {
  'டை செய்ய'
}
sub buttons_are_deactivated {
  'உங்கள் உலாவி Javascript ஐ ஆதரிக்காததால், இந்த பொத்தான்கள் செயலிழக்கப்பட்டுள்ளன.'
}
sub ranking_instructions {
  '<p>மூன்று வழிகளில் ஒன்றில் தேர்வுகளை வரிசைப்படுத்தவும்:</p> <ol> <li>வரிசைகளை இழுக்கவும்</li> <li>தரவரிசை நெடுவரிசையில் புல் டவுன்களைப் பயன்படுத்தவும்</li> <li>வரிசைகளைத் தேர்ந்தெடுத்து மேலே உள்ள பொத்தான்களைப் பயன்படுத்தவும் </li> </ol>'
}
sub write_in_a_choice {
  'புதிய தேர்வில் எழுதவும்:'
}
sub show_qr_code {
  'இந்த வாக்கெடுப்புக்கான QR குறியீட்டைக் காட்டு.'
}
sub if_you_have_already_voted { #url
  "நீங்கள் ஏற்கனவே வாக்களித்திருந்தால், <a href=\"$_[1]\">தற்போதைய வாக்கெடுப்பு முடிவுகளைப்</a> பார்க்கலாம்."
}
sub thank_you_for_voting { #title, receipt
  "நன்றி. <strong>$_[1]</strong> க்கான உங்கள் வாக்கு வெற்றிகரமாக அளிக்கப்பட்டது.<br> உங்கள் வாக்காளர் ரசீது <code>$_[2]</code> ஆகும். உங்கள் வாக்குச்சீட்டை பின்னர் மாற்ற விரும்பினால் இந்த ரசீது உங்களுக்குத் தேவைப்படும்."
}
sub try_some_public_polls {
  "வேறு எதிலாவது வாக்களிப்பது போல் உள்ளதா? இந்த பொது வாக்கெடுப்புகளில் ஒன்றை முயற்சிக்கவும்:"
}
sub you_can_change_ballot_now {
  'இந்தப் பக்கத்திலிருந்து, நீங்கள் போட்ட வாக்கை அழித்துவிட்டு மீண்டும் வாக்களிக்கலாம்.'
}
sub change_ballot {
  'வாக்களியுங்கள்'
}
sub name_of_writein_is_empty {
  "எழுதும் தேர்வின் பெயர் காலியாக உள்ளது"
}
sub writein_too_similar {
  "மன்னிக்கவும், ரைட்-இன் பெயர் ஏற்கனவே உள்ள தேர்வைப் போலவே உள்ளது"
}
sub doublecheck_msg {
  'உங்களின் வாக்குச் சீட்டு எந்த விளைவையும் ஏற்படுத்தாது, ஏனெனில் நீங்கள் கருத்துள்ள அனைத்து வேட்பாளர்களும் சமமாக உள்ளனர். நீங்கள் இன்னும் சமர்ப்பிக்க விரும்புகிறீர்களா?'
}

# election

sub No_poll_ID {
  "வாக்கெடுப்பு ஐடி எதுவும் வழங்கப்படவில்லை. ஒருவேளை காப்பி பேஸ்ட் பிழையா?"
}
sub Ill_formed_poll_ID {
  "தவறாக உருவாக்கப்பட்ட வாக்கெடுப்பு அடையாளங்காட்டி வழங்கப்பட்டது. ஒருவேளை காப்பி பேஸ்ட் பிழையா? (". $_[1] . ")"
}
sub vote_has_already_been_cast {
  "உங்கள் வாக்காளர் சாவியைப் பயன்படுத்தி ஏற்கனவே ஒரு வாக்கு பதிவு செய்யப்பட்டுள்ளது."
}
#deprecated, use future_result_link
sub following_URL_will_report_results {
  'வாக்கெடுப்பு முடிந்ததும் பின்வரும் URL வாக்கெடுப்பு முடிவுகளை அறிவிக்கும்:'
}
sub future_result_link {
    my ($self, $url) = @_;
  "வாக்கெடுப்பு முடிந்ததும் பின்வரும் URL வாக்கெடுப்பு முடிவுகளை அறிவிக்கும்: <a href='$url'><code>$url</code></a>"
}
#deprecated
sub following_URL_reports_results {
  'பின்வரும் URL தற்போதைய வாக்கெடுப்பு முடிவுகளைப் புகாரளிக்கிறது:'
}
sub if_you_want_to_change {
  'உங்களின் முந்தைய வாக்கை நீக்கிவிட்டு, உங்கள் வாக்காளர் ரசீதை இங்கே உள்ளிடுவதன் மூலம் மீண்டும் வாக்களிக்கலாம்:'
}
sub invalid_release_key {
    my ($self, $receipt) = @_;
  'வழங்கப்பட்ட வாக்காளர் ரசீது ('.$receipt.') தவறானது. இது '.code('E_2ad1ca99ac3cac7a/3a191bd9fb00ef73').' போல இருக்க வேண்டும்.'
}
sub no_ballot_under_key {
    my ($self, $key) = @_;
  "ரசீது $கீக்கு முந்தைய வாக்குச் சீட்டு எதுவும் கிடைக்கவில்லை"
}
sub current_result_link {
    my ($self, $url) = @_;
  "<a href=\"$url\" class=result_link>தற்போதைய வாக்கெடுப்பு முடிவுகளுக்கு செல்க</a>"
}
sub Already_voted {
  'ஏற்கனவே வாக்களித்துள்ளது'
}
sub Error {
  'பிழை'
}
sub Invalid_key {
  'தவறான விசை. மின்னஞ்சல் மூலம் வாக்கெடுப்பைக் கட்டுப்படுத்த சரியான URLஐப் பெற்றிருக்க வேண்டும். இந்த பிழை பதிவு செய்யப்பட்டுள்ளது.'
}
sub Authorization_failure {
  'அங்கீகார தோல்வி'
}

sub already_ended { # title
  "இந்த வாக்கெடுப்பு (<strong>$_[1]</strong>) ஏற்கனவே முடிந்துவிட்டது."
}
sub Poll_not_yet_ended {
  "வாக்கெடுப்பு இன்னும் முடிவடையவில்லை"
}
sub The_poll_has_not_yet_been_ended { #title, name, email
  "இந்த வாக்கெடுப்பு ($_[1]) இன்னும் அதன் மேற்பார்வையாளரால் முடிக்கப்படவில்லை, $_[2] ($_[3])."
}

# deprecated
sub The_results_of_this_completed_poll_are_here {
  'முடிக்கப்பட்ட இந்த வாக்கெடுப்பின் முடிவுகள் இங்கே:'
}
sub completed_results_link {
    my ($self, $url) = @_;
  "<a href=\"$url\" class=result_link>முடிந்த வாக்கெடுப்பு முடிவுகளுக்கு செல்க</a>"
}

sub No_write_access_to_lock_poll {
  "வாக்கெடுப்பை பூட்டுவதற்கு தேவையான எழுத்து அணுகல் இல்லை."
}
sub This_poll_has_already_been_started { # title
  "இந்த வாக்கெடுப்பு ($_[1]) ஏற்கனவே தொடங்கப்பட்டது."
}
sub No_write_access_to_start_poll {
  'வாக்கெடுப்பைத் தொடங்க எழுத்து அணுகல் இல்லை.'
}
sub Poll_does_not_exist_or_not_started {
  'இந்த வாக்கெடுப்பு இல்லை அல்லது தொடங்கப்படவில்லை.'
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
  "தவறான முடிவு விசை: \"$_[1]\". மின்னஞ்சல் மூலம் வாக்கெடுப்பு முடிவுகளைப் பார்ப்பதற்கு நீங்கள் சரியான URL ஐப் பெற்றிருக்க வேண்டும். இந்த பிழை பதிவு செய்யப்பட்டுள்ளது."
}
sub Invalid_control_key { # key
  "தவறான கட்டுப்பாட்டு விசை. மின்னஞ்சல் மூலம் வாக்கெடுப்பைக் கட்டுப்படுத்த சரியான URLஐப் பெற்றிருக்க வேண்டும். இந்த பிழை பதிவு செய்யப்பட்டுள்ளது."
}
sub Invalid_voting_key {
  "தவறான வாக்குச் சாவி. மின்னஞ்சல் மூலம் வாக்களிக்க சரியான URLஐப் பெற்றிருக்க வேண்டும். இந்த பிழை பதிவு செய்யப்பட்டுள்ளது."
}
sub Invalid_poll_id {
  "தவறான வாக்கெடுப்பு அடையாளங்காட்டி"
}
sub Poll_id_not_valid { #id
  "வாக்கெடுப்பு அடையாளங்காட்டி \"$_[1]\" தவறானது."
}
sub Unable_to_append_to_poll_log {
  "வாக்கெடுப்பு பதிவில் இணைக்க முடியவில்லை."
}
sub Voter_v_already_authorized {
  "வாக்காளர் &lt;$_[1]&gt; ஏற்கனவே அங்கீகரிக்கப்பட்டுள்ளது. வாக்காளரின் திறவுகோல் வாக்காளருக்கு அனுப்பப்படும்."
}
sub Skipping_already_voted {
  "வாக்காளரைத் தவிர்த்தல் &lt;$_[1]&gt;: ஏற்கனவே வாக்களிக்கப்பட்டது."
}
sub Invalid_email_address_hdr { # addr
  "தவறான மின்னஞ்சல் முகவரி"
}
sub Invalid_email_address { # addr
  "தவறான மின்னஞ்சல் முகவரி: $_[1]"
}
sub Address_opted_out { # addr
  "இந்த முகவரி CIVS மின்னஞ்சலில் இருந்து விலகியுள்ளது: $_[1]"
}
sub Sending_mail_to_voter_v {
  "வாக்காளருக்கு அஞ்சல் அனுப்புகிறது \"$_[1]\"..."
}
sub CIVS_poll_supervisor { # name
  "\"கன்டோர்செட் இணைய வாக்களிப்பு சேவை ($_[1] சார்பாக)\""
}
sub From_poll_supervisor {
    my ($self, $name) = @_;
    $self->CIVS_poll_supervisor($name)
# UNTRANSLATED
}
sub voter_mail_intro { #title, name, email_addr
  "<b>$_[1]</b> என்ற பெயரில் Condorcet Internet Voting Service கருத்துக்கணிப்பு உருவாக்கப்பட்டது. நீங்கள் வாக்கெடுப்பு மேற்பார்வையாளரால் வாக்காளராக நியமிக்கப்பட்டுள்ளீர்கள், $_[2] (<a href=\"mailto:$_[3] ($_[2])\"><code>$_[3]< /code></a>).</p>"
}
sub Description_of_poll {
  'கருத்துக்கணிப்பின் விளக்கம்:'
}
sub if_you_would_like_to_vote_please_visit {
  'நீங்கள் வாக்களிக்க விரும்பினால், பின்வரும் URL ஐப் பார்வையிடவும்:'
}
sub This_is_your_private_URL {
  'இது உங்களின் தனிப்பட்ட URL. அதை வேறு யாருக்கும் கொடுக்க வேண்டாம், ஏனென்றால் அவர்கள் அதை உங்களுக்கு வாக்களிக்க பயன்படுத்தலாம்.'
}
sub Your_privacy_will_not_be_violated {
  'வாக்களிப்பதன் மூலம் உங்கள் தனியுரிமை மீறப்படாது. வாக்களிக்கும் சேவை ஏற்கனவே உங்கள் மின்னஞ்சல் முகவரியின் பதிவை அழித்துவிட்டதால் நீங்கள் வாக்களித்தீர்களா அல்லது எப்படி வாக்களித்தீர்கள் என்பது பற்றிய எந்த தகவலையும் வெளியிடாது.'
}
sub This_is_a_nonanonymous_poll {
  'இதை <strong>அநாமதேய வாக்கெடுப்பாக</strong> மாற்ற தேர்தல் கண்காணிப்பாளர் முடிவு செய்துள்ளார். நீங்கள் வாக்களித்தால், உங்கள் மின்னஞ்சல் முகவரி மற்றும் நீங்கள் எப்படி வாக்களித்தீர்கள் என்பது வாக்கெடுப்பு முடிவுகளுக்கான அணுகல் வழங்கப்பட்ட அனைவருக்கும் தெரியும்.'
}


sub poll_has_been_announced_to_end { #election_end
  "வாக்கெடுப்பு $_[1] முடிவடைவதாக அறிவிக்கப்பட்டுள்ளது."
}

sub To_view_the_results_at_the_end {
  "வாக்கெடுப்பு முடிவடைந்தவுடன் அதன் முடிவுகளைப் பார்க்க, இங்கு செல்க:</p> $_[1]"
}

sub for_more_information_about_CIVS { # url
  "Condorcet இணைய வாக்களிப்பு சேவை பற்றிய கூடுதல் தகவலுக்கு, பார்க்கவும் $_[1]"
}

sub For_more_information { # url, mail mgmt url
  ($self, $home, $mail_mgmt) = @_;
  "For more information about the Condorcet Internet Voting Service, see
   $home. To control future email sent from CIVS, see $mail_mgmt"
# UNTRANSLATED
}

sub poll_email_subject { # title
  "கருத்துக்கணிப்பு: $_[1]"
}

# close

sub CIVS_Ending_Poll {
  'CIVS: முடிவு வாக்கெடுப்பு'
}

sub Ending_poll {
  'ஒரு வாக்கெடுப்பை முடிக்கிறது'
}
sub View_poll_results {
  'வாக்கெடுப்பு முடிவுகளைப் பார்க்கவும்'
}
sub Poll_ended { #title
  "வாக்கெடுப்பு முடிந்தது: $_[1]"
}

sub The_poll_has_been_ended { #election_end
  "வாக்கெடுப்பு முடிவடைந்தது. $_[1] முடிவடைவதாக அறிவிக்கப்பட்டது."
}

sub poll_results_available_to_authorized_users {
  'வாக்கெடுப்பு முடிவுகள் இப்போது அங்கீகரிக்கப்பட்ட பயனர்களுக்குக் கிடைக்கும்.'
}

sub was_not_able_stop_the_poll {
  'வாக்கெடுப்பை நிறுத்த முடியவில்லை'
}


# results

sub CIVS_poll_result {
  "CIVS வாக்கெடுப்பு முடிவு"
}
sub Poll_results { # title
  "வாக்கெடுப்பு முடிவுகள்: $_[1]"
}

sub Writeins_currently_allowed {
  'எழுதும் தேர்வுகள் தற்போது அனுமதிக்கப்படுகின்றன.'
}

sub Writeins_allowed {
  'எழுதும் தேர்வுகள் அனுமதிக்கப்படுகின்றன.'
}
sub Writeins_not_allowed {
  'எழுதும் தேர்வுகள் அனுமதிக்கப்படாது.'
}
sub Detailed_ballot_reporting_enabled {
  'விரிவான வாக்குச் சீட்டு அறிக்கை இயக்கப்பட்டது.'
}
sub Detailed_ballot_reporting_disabled {
  'விரிவான வாக்குச் சீட்டு அறிக்கை முடக்கப்பட்டுள்ளது.'
}
sub Voter_identities_will_be_kept_anonymous {
  'வாக்காளர் அடையாளங்கள் அநாமதேயமாக வைக்கப்படும்'
}
sub Voter_identities_will_be_public {
  'வாக்கெடுப்பு முடிவுகளைக் காண அங்கீகரிக்கப்பட்டவர்களுக்கு வாக்காளர் அடையாளங்களும் (மின்னஞ்சல்) அவர்களின் வாக்குச்சீட்டுகளும் தெரியும்.'
}
sub Condorcet_completion_rule {
  'Condorcet நிறைவு விதி:'
}
sub undefined_algorithm {
  'பிழை: வரையறுக்கப்படாத அல்காரிதம்.'
}
sub computing_results {
  'முடிவுகளை கணக்கிடுகிறது...'
}
sub Supervisor { #name, email
  "மேற்பார்வையாளர்: $_[1] <tt>&lt;$_[2]&gt;</tt>"
}
sub Announced_end_of_poll {
  "வாக்கெடுப்பின் முடிவு அறிவிக்கப்பட்டது: $_[1]"
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
  'வாக்கெடுப்பு இன்னும் முடிவடையவில்லை.'
}
sub This_is_a_test_poll {
  'இது ஒரு சோதனை வாக்கெடுப்பு.'
}
sub This_is_a_private_poll { #num_auth
  "தனிப்பட்ட வாக்கெடுப்பு ($_[1] அங்கீகரிக்கப்பட்ட வாக்காளர்கள்)"
}
sub This_is_a_public_poll {
  'இது ஒரு பொது வாக்கெடுப்பு.'
}

sub Actual_votes_cast { #num_votes
  "உண்மையான வாக்குகள்: $_[1]"
}
sub Number_of_winning_candidates {
  'வெற்றி பெற்ற தேர்வுகளின் எண்ணிக்கை:'
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
  'கருத்துக்கணிப்பு விளக்கம்'
}
sub Ranking_result {
  'விளைவாக'
}
sub x_beats_y { # x y w l
  "$_[1] $_[2] $_[3]&ndash;$_[4] ஐ வென்றது"
}
sub x_ties_y { # x y w l
  "$_[1] உறவுகள் $_[2] $_[3]&ndash;$_[4]"
}
sub x_loses_to_y { # x y w l
  "$_[1] $_[2] $_[3]&ndash;$_[4] க்கு இழக்கிறார்"
}
sub some_result_details_not_shown {
  'எளிமைக்காக, வாக்கெடுப்பு முடிவின் சில விவரங்கள் காட்டப்படவில்லை.'
}
sub Show_details {
  'விவரங்களை காட்டு'
}
sub Hide_details {
  'விவரங்களை மறை'
}
sub Result_details {
  'முடிவு விவரங்கள்'
}
sub Ballot_report {
  'வாக்குச்சீட்டு அறிக்கை'
}
sub Ballots_are_shown_in_random_order {
  "வாக்குச்சீட்டுகள் தோராயமாக உருவாக்கப்பட்ட வரிசையில் காட்டப்படுகின்றன."
}
sub Download_ballots_as_a_CSV { # url
  "[<a href=\"$_[1]\">CSV வடிவத்தில் வாக்குச்சீட்டுகளைப் பதிவிறக்கு</a>]"
}
sub No_ballots_were_cast {
  "இந்த வாக்கெடுப்பில் எந்த வாக்குகளும் பதிவாகவில்லை."
}
sub Ballot_reporting_was_not_enabled {
  'இந்த வாக்கெடுப்புக்கு வாக்குச் சீட்டு அறிக்கையிடல் இயக்கப்படவில்லை.'
}
sub Tied {
  "<i>டைட்</i>:"
}
sub loss_explanation { # loss_to, for, against
  ', இழக்கிறது '. $_[1].' மூலம் '. $_[2] .'&ndash;'. $_[3]
}
sub loss_explanation2 {
  '&nbsp;&nbsp;'.$_[1].' மூலம் '.$_[2].'&ndash;'.$_[3]
}
sub Condorcet_winner_explanation {
  '&nbsp;'
}
sub undefeated_explanation {
  '&nbsp;&nbsp;(எந்தப் போட்டியிலும் தோற்கவில்லை. மற்றொரு தேர்வு)'
}
sub Choices_shown_in_red_have_tied {
  'சிவப்பு நிறத்தில் காட்டப்பட்டுள்ள தேர்வுகள் தேர்ந்தெடுக்கப்படுவதற்கு இணைக்கப்பட்டுள்ளன. அவர்களில் நீங்கள் தோராயமாக தேர்ந்தெடுக்க விரும்பலாம்.'
}
sub Condorcet_winner {
  "காண்டோர்செட் வெற்றியாளர்"
}
sub Choices_in_individual_pref_order {
  'தேர்வுகள் (தனிப்பட்ட விருப்ப வரிசையில்)'
}

sub Unknown_email {
  '(தெரியாது)'
}

sub What_is_this { # url
  '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>(இது என்ன?)</small></a>'
}

# rp

sub All_prefs_were_affirmed {
  'அனைத்து விருப்பங்களும் உறுதிப்படுத்தப்பட்டன.'
}

sub Presence_of_a_green_entry_etc {
  'மூலைவிட்டத்திற்கு கீழே பச்சை உள்ளீடு இருப்பது (மேலே தொடர்புடைய சிவப்பு) என்பது மற்ற வலுவான விருப்பங்களுடன் முரண்பட்டதால் ஒரு விருப்பம் புறக்கணிக்கப்பட்டது என்று அர்த்தம்.'
}
sub Random_tie_breaking_used {
  'MAM அல்காரிதம் படி, இந்த வரிசையை வருவதற்கு ரேண்டம் டை பிரேக்கிங் பயன்படுத்தப்பட்டது. இது தேர்வுகளின் வரிசையை பாதித்திருக்கலாம்.'
}
sub No_random_tie_breaking_used {
  'இந்த ஆர்டரை வருவதற்கு சீரற்ற டை பிரேக்கிங் தேவையில்லை.'
}

# beatpath

sub beatpath_matrix_explanation {
  'ஒவ்வொரு ஜோடி தேர்வுகளையும் இணைக்கும் வலிமையான பீட்பாத்தின் வலிமையை பின்வரும் மேட்ரிக்ஸ் காட்டுகிறது. 2 முதல் 1 வரையிலான எந்த முன்னணியையும் விட 1 முதல் 2 வரை செல்லும் வலுவான பீட்பாத் இருந்தால், சாய்ஸ் 1 தேர்வு 2க்கு மேலே தரப்படுத்தப்படும்.'
}

sub no_pref {
  'எதுவும் இல்லை'
}

#rp

sub Some_voter_preferences_were_ignored {
  'சில வாக்காளர் விருப்பத்தேர்வுகள் புறக்கணிக்கப்பட்டன, ஏனெனில் அவை மற்ற வலுவான விருப்பங்களுடன் முரண்படுகின்றன:'
}

sub preference_description {
  "$_[4] ஐ விட $_[3]க்கான $_[1]&ndash;$_[2] விருப்பம்."
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
  'மின்னஞ்சல் முகவரி:'
}
sub deactivation_code {
  'செயலிழக்க குறியீடு:'
}
sub filter_question {
  'வடிகட்டி வடிவத்தை <small>(வெறுமையாக விடலாம்; உதவிக்கு வட்டமிடவும்)</small>'
}
sub filter_explanation {
  'மின்னஞ்சலைத் தடுக்கும் வாக்கெடுப்பு மேற்பார்வையாளர்களைக் குறிப்பிட, ஒன்று அல்லது அதற்கு மேற்பட்ட வடிவங்களை இங்கே உள்ளிடலாம். பேட்டர்ன் என்பது மேற்பார்வையாளரின் மின்னஞ்சல் முகவரி அல்லது மின்னஞ்சல் முகவரிகளை விவரிக்கும் வடிவமாக இருக்கலாம். எழுத்துகளின் எந்த வரிசையையும் குறிக்க பேட்டர்ன் * ஐப் பயன்படுத்தலாம். எடுத்துக்காட்டாக, @inmano.com முகவரியைக் கொண்ட மேற்பார்வையாளர்கள் உங்களுக்கு வாக்கெடுப்பு அழைப்பிதழ்களை அனுப்புவதிலிருந்து *@inmano.com பேட்டர்ன் தடுக்கும். இந்தப் புலத்தை காலியாக விட்டால், செயலிழக்கச் செய்தல்/மீண்டும் செயல்படுத்துவது எல்லா மின்னஞ்சல் முகவரிகளுக்கும் பொருந்தும்.'
}
sub send_deactivation_code {
  'செயலிழக்கக் குறியீட்டை மின்னஞ்சல் மூலம் அனுப்பவும்'
}
sub cant_send_email {
  'CIVSஐப் பயன்படுத்தி இந்தப் பயனருக்கு மின்னஞ்சல் அனுப்ப முடியாது. இந்தப் பயனருக்கான மின்னஞ்சலை முன்பு அனுப்பிய செயலிழக்கக் குறியீட்டைப் பயன்படுத்தி முதலில் மீண்டும் செயல்படுத்த வேண்டும்.'
}
sub submit_deact_react {
  'செயலிழக்கச் செய்தல்/மீண்டும் செயல்படுத்துதல்'
}
sub codes_dont_match {
  "மன்னிக்கவும், வழங்கப்பட்ட குறியீடும் மின்னஞ்சல் முகவரியும் பொருந்தவில்லை. CIVS இலிருந்து மின்னஞ்சலை நீங்கள் முன்பு தடுக்கவில்லை என்றால், நீங்கள் மற்றொரு குறியீட்டைக் கோரலாம்."
}
sub deactivation_successful {
    my ($self, $pattern) = @_;
  "CIVS இந்த முகவரிக்கு அனுப்பியவர் இந்த வடிவத்துடன் பொருந்தினால், இந்த முகவரிக்கு எந்த மின்னஞ்சலையும் அனுப்பாது: \"$pattern\". நீங்கள் பயன்படுத்திய அதே குறியீட்டைக் கொண்டு இந்த இணையப் பக்கத்தைப் பயன்படுத்துவதன் மூலம் மட்டுமே CIVS இலிருந்து மின்னஞ்சலை மீண்டும் செயல்படுத்த முடியும்."
}
sub reactivation_successful {
  'இந்த முகவரிக்கான மின்னஞ்சலை வெற்றிகரமாக மீண்டும் இயக்கியுள்ளீர்கள்.'
}
sub someone_has_requested {
  "CIVS உங்களுக்கு மின்னஞ்சல் அனுப்புவதைத் தடுப்பதற்கான குறியீட்டை ஒருவர் கோரியுள்ளார். அது நீங்களாக இருந்தால், அதை என்ன செய்வது என்று உங்களுக்குத் தெரியும். குறியீடு:
 $_[1]
இந்த மின்னஞ்சலை வைத்திருங்கள், ஏனெனில் நீங்கள் எதிர்காலத்தில் சேவையைப் பயன்படுத்த விரும்பினால் இந்தக் குறியீடு உங்களுக்குத் தேவைப்படும்."
}
sub deactivation_code_subject {
  'CIVS அஞ்சல் செயலிழக்க குறியீடு'
}
sub mail_mgmt_title {
  'அஞ்சல் மேலாண்மை'
}

## User activation

sub user_activation {
  'பயனரை இயக்கவும்'
}
sub activation_code_subject {
  'CIVS ஐப் பயன்படுத்துவதற்கான செயல்படுத்தல் குறியீடு'
}
sub user_activation_instructions {
    my ($self, $mail_mgmt_url) = @_;
    p('தனியார் CIVS வாக்கெடுப்புகளில் வாக்களிக்க, நீங்கள் சேவையில் இருந்து மின்னஞ்சல் தொடர்பு கொள்ள வேண்டும். CIVS உங்கள் மின்னஞ்சல் முகவரியைச் சேமிக்காது, தானியங்கு அஞ்சல்கள் எதுவும் இல்லை. தனிப்பட்ட வாக்கெடுப்புகளில் வாக்களிக்க அல்லது வாக்கெடுப்புகளின் முடிவுகளைப் பார்க்கத் தேவையான நற்சான்றிதழ்களைக் கொண்ட, வாக்கெடுப்புக் கண்காணிப்பாளர்களின் வெளிப்படையான கோரிக்கையின் பேரில் மட்டுமே சேவையிலிருந்து மின்னஞ்சலைப் பெறுவீர்கள்.').
    p("தேர்வு செய்ய, உங்கள் மின்னஞ்சல் முகவரியை உள்ளிட்டு கீழே உள்ள பொத்தானைக் கிளிக் செய்யவும். அப்போது நீங்கள் வேண்டும்
செயல்படுத்தும் குறியீடு அடங்கிய மின்னஞ்சலைப் பெறவும். மின்னஞ்சலில் இருந்து நீங்கள் முன்பு விலகியிருந்தால், மின்னஞ்சலை மீண்டும் செயல்படுத்த <a href=\"$mail_mgmt_url\">அஞ்சல் மேலாண்மைப் பக்கத்தைப்</a> பயன்படுத்த வேண்டும். நீங்கள் அஞ்சல் தடுக்கும் சேவையைப் பயன்படுத்தினால், CIVS மின்னஞ்சல் முகவரியை அங்கீகரிக்கப்பட்ட அனுப்புநராக (".'@SUPERVISOR@'.") ஏற்புப் பட்டியலில் சேர்க்க வேண்டியிருக்கும்.")
# UNTRANSLATED
}
sub opt_in_label {
  'செயல்படுத்தும் குறியீட்டைக் கோரவும்'
}
sub activation_code {
  'செயல்படுத்தும் குறியீடு:'
}
sub someone_has_requested_activation {
    my ($self, $address, $code, $mail_mgmt_url) = @_;
  "வாக்கெடுப்புகளில் வாக்களிக்க <$address> என்ற மின்னஞ்சல் முகவரியை CIVS வாக்களிப்பு முறை செயல்படுத்துமாறு ஒருவர் கோரியுள்ளார். இந்த முகவரியைச் செயல்படுத்த, பின்வரும் செயல்படுத்தல் குறியீடு உங்களுக்குத் தேவைப்படும்:
 $குறியீடு
இந்தக் கோரிக்கையை நீங்கள் தொடங்கவில்லை என்றால், இந்த மின்னஞ்சலைப் புறக்கணிக்கலாம்.
இந்த இணைப்பைப் பயன்படுத்தி CIVS இலிருந்து மின்னஞ்சலைக் கட்டுப்படுத்தவும்: $mail_mgmt_url."
}
sub already_activated {
  'இந்த மின்னஞ்சல் முகவரி ஏற்கனவே செயல்படுத்தப்பட்டுள்ளது.'
}
sub activation_successful
{
    'Email address successfully activated.'
}
sub pending_invites_hdr {
  'நிலுவையில் உள்ள வாக்கெடுப்பு அழைப்புகள்:'
}
sub submit_activation_code {
  'முழுமையான செயல்படுத்தல்'
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
  "மன்னிக்கவும், எந்த பயனரும் &lt;$address&gt; மின்னஞ்சல் பெற."
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
  "<p>கீழே உள்ள அட்டவணையில் பட்டியலிடப்பட்டுள்ள காரணங்களுக்காக CIVS ஆல் சில வாக்காளர்களுக்கு அஞ்சல் அனுப்ப முடியவில்லை. வாக்காளர்கள் தங்கள் தனிப்பட்ட சாவியைப் பெறும் வரை வாக்களிக்க முடியாது, எனவே நீங்கள் அவர்களை நேரடியாக தொடர்பு கொள்ள வேண்டும். வாக்காளர்களுக்கு பின்வரும் இணைப்புகள் பயனுள்ளதாக இருக்கும்:</p> <ul> <li>CIVS உடன் மின்னஞ்சல் முகவரியைச் செயல்படுத்தவும்: <a href='$activate_url'>$activate_url</a></li> <li>முடக்கு ஒரு மின்னஞ்சல் முகவரியை மீண்டும் செயல்படுத்தவும்: <a href='$mail_mgmt_url'>$mail_mgmt_url</a></li> </ul> <p> வாக்காளர்கள் தங்கள் மின்னஞ்சல் முகவரிகளைச் செயல்படுத்தும்போது, வாக்களிக்க நிலுவையில் உள்ள அழைப்புகள் குறித்து அவர்களுக்குத் தெரிவிக்கப்படும் என்பதை நினைவில் கொள்ளவும் வாக்கெடுப்புகளில். </p>"
}
sub download_failures {
  'அட்டவணையை CSV ஆகப் பதிவிறக்கவும்'
}

sub code_requested {
  'குறியீடு கோரப்பட்டது. உங்கள் மின்னஞ்சல் பார்க்க.'
}

sub code_requested_but_something_wrong {
  'குறியீடு கோரப்பட்டது ஆனால் ஏதோ தவறாகிவிட்டது.'
}

sub error_handling_code_request {
  "குறியீடு கோரிக்கையை கையாள்வதில் பிழை"
}
sub invalid_email_address {
  'தவறான மின்னஞ்சல் முகவரி'
}
sub unexpected_error {
  '<b>எதிர்பாராத பிழை:</b>'
}
sub optin_error {
  'பிழை:'
}
sub submitted {
  'சமர்ப்பிக்கப்பட்டது'
}

1; # package succeeded!
