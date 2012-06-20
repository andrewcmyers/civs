package hebrew;

use lib '@CGIBINDIR@';
use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

sub lang { 'he-IL' }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub style_file {
    'hebrew.css'
}

sub Condorcet_Internet_Voting_Service {
    'שירות הצבעה אינטרנטי קונדורסט'
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited 
    'שירות הצבעה אינטרנטי קונדורסט'
}
sub about_civs {
    'אודות CIVS'
}
sub public_polls {
    'הציבור בסקרים'
}
sub create_new_poll {
    'צור הצבעה חדשה'
}
sub about_security_and_privacy {
    'אודות אבטחה ופרטיות'
}
sub FAQ {
    'שאלות ותשובות נפוצות'
}
sub CIVS_suggestion_box {
    'תיבת הצעות ל-CIVS'
}
sub unable_to_process {
    'מערכת ה-CIVS אינה יכולה לעבד את בקשתך בשל שגיאה פנימית.'
}
sub CIVS_Error {
    'שגיאת CIVS'
}
sub CIVS_server_busy {
    'שרת ה-CIVS עסוק'
}
sub Sorry_the_server_is_busy {
'צר לנו, שרת הרשת של CIVS עסוק מאד כרגע, ואינו יכול לטפל בבקשות נוספות. אנא נסו שנית מעט מאוחר יותר. '
}

# civs_create

sub mail_has_been_sent {
    "הודעת דואל נשלחה לכתובת שציינת (<tt>$_[1]</tt>).";
}

sub click_on_the_URL_to_start {
    "הקליקו על כתובת ה-URL בהודעת הדואל על-מנת להתחיל את ההצבעה: <strong>$_[1]</strong>.";
}

sub here_is_the_control_URL {
'מצב כתובת ה-URL על-מנת לשלוט בהצבעה החדשה. בהפעלה רגילה, הכתובת תישלח למפקח באמצעות הדוא"ל. ';
}
sub the_poll_is_in_progress {
    'ההצבעה נמצאת בעיצומה. לחצו על כפתור זה כדי לסיים אותה: ';
}

sub CIVS_Poll_Creation {
    "יצירת הצבעה במערכת ה-CIVS ";
}
sub Poll_created {
    "ההצבעה שנוצרה: $_[1]"
}

sub Address_unacceptable { #addr
    "הכתובת \"$_[1]\" אינה מקובלת";
}
sub Poll_must_have_two_choices {
    'הצבעה חייבת לכלול לפחות שתי אפשרויות. ';
}
sub Poll_directory_not_writeable {
    "לא ניתן לכתוב אל הספרייה של ההצבעה";
}
sub CIVS_poll_created {
 "הצבעת CIVS שנוצרה:$_[1]";
}
sub creation_email_info1 { # title, url
"הודעת דוא\"ל זו מאשרת את יצירתה של הצבעה חדשה, $_[1]. אתה הוגדרת בתור המפקח של הצבעה זו. על-מנת להתחיל ולהפסיק את ההצבעה, אנא השתמש בכתובת ה-URL הבאה: 

  $_[2]

";
}
sub creation_email_public_link { # url
"מאחר שזו הצבעה פומבית, באפשרותך להכווין את המצביעים לכתובת ה-URL הבאה:

  $_[1]

";
}
sub for_more_information_about_CIVS { # url
"למידע נוסף אודות שירות ההצבעה האינטרנטי קונדורסט, ראה
  $_[1]";
}

sub Sending_result_key { # addr
    "שולח מפתח תוצאות עבור '$_[1]'";
}
sub Results_of_CIVS_poll { # title
    "תוצאות של הצבעת CIVS: $_[1]";
}
sub Results_key_email_body { # title, url, civs_home
"הצבעת CIVS חדשה נוצרה, בשם \"$_[1]\".
אתה הוגדרת בתור משתמש שרשאי לצפות בתוצאות הצבעה זו.

שמור הודעת דוא\"ל זו. אם תאבד אותה לא תהיה לך גישה לתוצאות. 
לאחר סגירת ההצבעה, התוצאות יהיו זמינות בכתובת ה-URL הבאה:

  $_[2]

כתובת URL זו היא פרטית. מתן אפשרות למשתמשים לא-מורשים לגשת לכתובת זו 
תאפשר להם לצפות בתוצאות ההצבעה.
למידע נוסף אודות שירות ההצבעה האינטרנטי קונדורסט, ראה
  $_[3]

";
}
  
# start

sub poll_started {
    'ההצבעה <strong>'.$_[1].'</strong> נפתחה.';
}

# control

sub CIVS_Poll_Control {
    "בקרת הצבעת CIVS";
}
sub Poll_control {
    "בקרת הצבעה";
}
sub poll_has_not_yet_started {
    'ההצבעה טרם החלה. לחץ על כפתור זה כדי להתחיל אותה: ';
}
sub Start_poll {
    'התחל הצבעה';
}
sub End_poll {
    'סיים הצבעה';
}
sub ending_poll_cannot_be_undone {
    'סיום הצבעה הוא פעולה שלא ניתן לבטל. האם להמשיך? ';
}
sub writeins_have_been_disabled {
    'מועמדים שאינם רשומים לא מאופשר';
}
sub disallow_further_writeins {
    'אל תאפשר מועמדים נוספים שאינם רשומים';
}
sub voting_disabled_during_writeins {
    'ההצבעה אינה מתאפשרת כרגע, במהלך שלב רישום מועמדים שלא היו רשומים.';
}
sub allow_voting_during_writeins {
    "אפשר הצבעה במהלך שלב רישום מועמדים נוספים";
}
sub this_is_a_test_poll {
    'זו הצבעת מבחן.';
}

sub poll_supervisor { # name, email
    "<tt>$_[2]&gt;</tt> $_[1]<tt>&gt;</tt>"
}
sub no_authorized_yet { #waiting
    "0 ($_[1] מצביעים יאושרו בעת פתיחת ההצבעה)"
}
sub total_authorized_voters { # num_auth_string
    "סך הכל מצביעים מורשים:$_[1]"
}
sub actual_votes_so_far { # num
    "הצבעות בפועל עד עתה: $_[1]"
}
sub poll_ends { # end
    "ההצבעה מסתיימת $_[1]."
}
sub Poll_results_available_to_all_voters_when_poll_completes {
    'תוצאות ההצבעה יהיו זמינות לכל המצביעים עם השלמת ההצבעה.';
}
sub Voters_can_choose_No_opinion {
    'המצביעים יכולים לבחור &ldquo;No opinion&rdquo;';
}
sub Voting_is_disabled_during_writeins {
    'ההצבעה לא מתאפשרת במהלך שלב רישום מועמדים נוספים.';
}
sub Poll_results_will_be_available_to_the_following_users {
    'תוצאות ההצבעה יהיו זמינות למשתמשים הבאים בלבד:';
}
sub Poll_results_are_now_available_to_the_following_users {
    'תוצאות ההצבעה זמינות כעת למשתמשים הבאים בלבד,
אליהם נשלחה קודם לכן הודעת דוא"ל המכילה כתובת URL לצפייה בתוצאות:';
}
sub results_available_to_the_following_users {
    'התוצאות של הצבעה זו שוחחרו לקבוצה מוגבלת של משתמשים בלבד:';
}

sub Poll_results_are_available { #url
    "<a href=\"$_[1]\">צפה בתוצאות ההצבעה</a>";
}
sub Description {
    'תיאור:';
}
sub Candidates {
    'מועמדים:';
}
sub Add_voters {
    'הוסף מצביעים';
}

sub the_top_n_will_win { # num_winners
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt = "מועמד";
    } else {
	$wintxt = "$_[1] מועמדים";
    }
    return "ה$wintxt יזכה.";
}

sub add_voter_instructions {
    "הזן כתובות דוא\"ל של מצביעים, אחת בכל שורה.
    אלו יכולים להיות מצביעים חדשים או מצביעים קיימים שעוד לא הצביעו.
    בהצבעה פרטית, מתן כתובת דוא\"ל של מצביע שכבר קיים <strong>לא</strong>
     תאפשר לאותו מצביע להצביע פעמיים.
    היא רק תשלח לאותו מצביע הזמנה נוספת להצביע.
    בהצבעה פומבית, נעשה נסיון סמלי בלבד למנוע הצבעה כפולה.";
}
sub Upload_file {
    'טען קובץ: ';
}
sub Load_ballot_data {
    'טען נתוני טופס הצבעה';
}
sub File_to_upload_ballots_from {
    'הקובץ ממנו יש לטעון טופסי הצבעה:';
}
sub This_is_a_public_poll_plus_link {
    my $url = $_[1];
    "זו הצבעה פומבית. שתף את המצביעים בקישור הבא בכדי לאפשר להם להצביע: 
    </p><p>&nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>";
}
sub The_poll_has_ended {
    'ההצבעה הסתיימה.';
}

# add voters

sub CIVS_Adding_Voters {
    'CIVS: מוסיף מצביעים';
}
sub Adding_voters {
    'מוסיף מצביעים';
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
    'צר לנו, ניתן להוסיף מצביעים רק להצבעה שכבר מתקיימת.';
}

sub Total_of_x_voters_authorized { # x
    if ($_[1] == 0) {
	'אף מצביע עוד לא קיבל הרשאה להצביע.';
    } elsif ($_[1] == 1) {
	'רק מצביע 1 הורשה להצביע עד עתה.';
    } else {
	"סה\"כ $_[1] מצביעים הורשו להצביע.";
    }
}

sub Go_back_to_poll_control {
    'חזור לבקרת ההצבעה';
}
sub Done {
    'בוצע.';
}

# vote

sub page_header_CIVS_Vote { # election_title
    'הצבעת CIVS: '.$_[1];
}

sub ballot_reporting_is_enabled {
    'דיווח טופסי הצבעה מאופשר בהצבעה זו.
     טופס ההצבעה שלך (הדירוגים שהקצית למועמדים)
     יהפוך פומבי עם סיום ההצבעה.';
}
sub instructions1 { # num_winners, end, name, email
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt="הבחירה המועדפת הבודדת";
    } else {
	$wintxt="$_[1] הבחירות המועדפות";
    }
    "רק $wintxt ינצח(ו) בהצבעה.<p>
	    ההצבעה מסתיימת <b>$_[2]</b>.
	    מפקח ההצבעה הוא <tt>$_[4]&gt;</tt> $_[3]<tt>&gt;</tt>.
	    צור קשר עם מפקח ההצבעה אם אתה זקוק לעזרה.";
}
sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
    my ($self, $no_opinion, $prop, $combined, $civs_url) = @_;
    my $ret;
    if (!$prop || !$combined) {
$ret = "תן דירוג לכל אחד מהבחירות הבאות, כאשר דירוג במספר נמוך יותר 
    משמעו שאתה מעדיף אפשרות זו יותר.
	    לדוגמה, תן לאפשרות העדיפה עליך את הדירוג 1.
	    תן לאפשרויות אחרות אותו דירוג אם אין לך העדפה ביניהן. 
   אינך חייב להשתמש בכל הדירוגים האפשריים.  
    כל האפשרויות קיבלו, מלכתחילה, את הדירוג הנמוך ביותר האפשרי.". $cr;
	if ($no_opinion) {
	    $ret .= '<b>Note:</b> &ldquo;No opinion&rdquo;
		    <i>לא</i> שווה לדירוג הנמוך ביותר האפשרי; 
    המשמעות היא שאתה בוחר שלא לדרג אפשרות זו ביחס לאפשרויות האחרות.</p>';
	}
	if ($prop) {
	    $ret .= '<p>הצבעה זו מוכרעת באמצעות שיטה נסיונית מבוססת-קונדורסט, 
   שתוכננה כך שתספק ייצוג יחסי. ההנחה של אלגוריתם ההצבעה היא, 
   שאתה רוצה שהדירוג של האפשרות המועדפת עליך ביותר <i>הזוכה</i> 
      יהיה הגבוה ביותר שניתן, וכי אם שתי סדרות של בחירות מנצחות 
   מסכימות על האפשרות המועדפת עליך, אתה תחליט ביניהן 
   תוך שימוש בדרגה השנייה הכי מועדפת עליך, וכן הלאה. ';
	}
    } else {
	$ret = '<p> הצבעה זו מוכרעת באמצעות שיטה נסיונית מבוססת-קונדורסט, 
          שתוכננה כך שתספק ייצוג יחסי.
	   אנא תן לכל אחת מהאפשרויות הבאות <b>משקל</b> שמבטא את המידה 
   בה אתה רוצה, שאותה אפשרות תהיה חלק מסדרת האפשרויות המנצחת.
   ההנחה של אלגוריתם ההצבעה היא, שאתה רוצה שסכום המשקלים 
   של אפשרויות מנצחות יהיה הגדול ביותר שניתן. 
   כל האפשרויות קיבלו כרגע משקל של אפס, 
   כלומר שאין לך כל עניין לראות אותן מנצחות.
   משקלים לא יכולים להיות שליליים או גדולים מ-999.
   זה לא יעזור לך לרשום משקלים גדולים יותר מאלו של מצביעים אחרים, 
   מאחר שהמשקלים שלך מושווים רק אחד למול השני. '.
	"<a href=\"$civs_url/proportional.html\">[See more information]</a>.</p>";
    }
    return $ret;
}
sub Rank {
    'דירוג';
}
sub Choice {
    'אפשרות';
}
sub Weight {
    'משקל';
}

sub address_will_be_visible {
    '<strong>כתובת הדוא"ל שלך תהיי גלויה</strong> יחד עם טופס ההצבעה שלך.';
}

sub ballot_will_be_anonymous {
    ' עם זאת, טופס ההצבעה שלך יישאר אנונימי:
      לא יופיע כל מידע שמאפשר זיהוי אישי.';
}

sub submit_ranking {
    'שלח דירוג';
}

sub only_writeins_are_permitted {
    'עדיין לא מתאפשרת הצבעה בבחירות אלו. 
עם זאת, באפשרותך לצפות באפשרויות הזמינות ולרשום אפשרויות חדשות. 
השתמש בשדה הטקסט שלהלן כדי לרשום אפשרויות חדשות. ';
}

sub Add_writein {
    'הוסף מועמד נוסף';
}

sub to_top {
    'לתחילת הרשימה';
}
sub to_bottom {
    'לתחתית הרשימה';
}
sub move_up {
    'הזז למעלה';
}
sub move_down {
    'הזז למטה';
}
sub make_tie {
    'צור שוויון';
}
sub buttons_are_deactivated {
    'כפתורים אלו בוטלו מאחר שהדפדפן שלך אינו תומך בג\'אווה.';
}
sub ranking_instructions {
       'דרג את האפשרויות באחת מבין שלוש דרכים:
	<ol>
	    <li>גרור את השורות
	    <li>השתמש בתפריטים הנפתחים בעמודת הדירוגים
	    <li>בחר בשורות והשתמש בכפתורים שמעל
	</ol>';
}

sub write_in_a_choice {
    'רשום אפשרות חדשה: ';
}
sub if_you_have_already_voted { #url
    "אם כבר הצבעת, באפשרותך לצפות 
	<a href=\"$_[1]\">בתוצאות ההצבעה הנוכחית</a>.";
}
sub thank_you_for_voting { #title, receipt
    "תודה לך. ההצבעה שלך עבור <strong>$_[1]</strong> נרשמה בהצלחה. 
	קבלת המצביע שלך היא <code>$_[2]</code>.";
}
sub name_of_writein_is_empty {
    "שם האפשרות להזנה ידנית ריק";
}
sub writein_too_similar {
    "צר לנו, השם של האפשרות להזנה ידנית דומה מדי לאפשרות קיימת";
}

# election

sub vote_has_already_been_cast {
    "הצבעה כבר התקבלה באמצעות מפתח המצביע שלך.";
}
sub following_URL_will_report_results {
    'כתובת ה-URL הבאה תדווח את תוצאות ההצבעה עם סגירת ההצבעה:';
}
sub following_URL_reports_results {
    'כתובת ה-URL הבאה מדווחת את תוצאות ההצבעה הנוכחית:';
}
sub Already_voted {
    'כבר הצביע';
}
sub Error {
    'שגיאה';
}
sub Invalid_key {
    'מפתח לא חוקי. היית אמור לקבל כתובת URL נכונה לבקרת ההצבעה באמצעות הדוא"ל. 
שגיאה זו נרשמה ביומן. ';
}
sub Authorization_failure {
    'שגיאת הרשאה';
}

sub already_ended { # title 
    "הצבעה זו (<strong>$_[1]</strong>) כבר הסתיימה.";
}
sub Poll_not_yet_ended {
    "ההצבעה עדיין לא הסתיימה";
}
sub The_poll_has_not_yet_been_ended { #title, name, email
    "הצבעה זו ($_[1]) עדיין לא הופסקה על-ידי המפקח עליה, $_[2] ($_[3]).";
}
sub The_results_of_this_completed_poll_are_here {
    'התוצאות של הצבעה זו, שהושלמה, נמצאות כאן:';
}

sub No_write_access_to_lock_poll {
    "לא התקיימה גישת כתיבה הדרושה לנעילת ההצבעה.";
}
sub This_poll_has_already_been_started { # title
    "הצבעה זו ($_[1]) כבר נפתחה.";
}
sub No_write_access_to_start_poll {
    'לא התקיימה גישת כתיבה לשם הפעלת הצבעה.';
}
sub Poll_does_not_exist_or_not_started {
    'הצבעה זו לא קיימת, או שעדיין לא נפתחה.';
}
sub Your_voter_key_is_invalid__check_mail { # voter
   my $voter = $_[1];
   if ($voter ne '') {
    "מפתח המצביע שלך אינו חוקי, $voter.
     היית אמור לקבל כתובת URL נכונה בדוא\"ל.";
   } else {
    "מפתח המצביע שלך אינו חוקי. היית אמור לקבל כתובת URL נכונה בדוא\"ל.";
   }
}
sub Invalid_result_key { # key
    "מפתח תוצאה לא חוקי: \"$_[1]\". היית אמור לקבל כתובת URL נכונה לשם צפייה בתוצאות ההצבעה בדוא\"ל. 
שגיאה זו נרשמה ביומן.";
}
sub Invalid_control_key { # key
    "מפתח בקרה לא חוקי. היית אמור לקבל כתובת URL נכונה לבקרת ההצבעה בדוא\"ל. שגיאה זו נרשמה ביומן.";
}
sub Invalid_voting_key {
    "מפתח הצבעה לא חוקי. היית אמור לקבל כתובת URL נכונה להצבעה באמצעות הדוא\"ל. 
שגיאה זו נרשמה ביומן.";
}
sub Invalid_poll_id {
    "מזהה הצבעה לא חוקי";
}
sub Poll_id_not_valid { #id
    "מזהה ההצבעה \"$_[1]\" אינו חוקי.";
}
sub Unable_to_append_to_poll_log {
    "לא יכול להיצמד ליומן ההצבעה.";
}
sub Voter_v_already_authorized {
    "המצביע \"$_[1]\" כבר קיבל הרשאה.
     המפתח של מצביע זה יישלח מחדש למצביע.";
}
sub Invalid_email_address_hdr { # addr
    "כתובת דוא\"ל לא חוקית";
}
sub Invalid_email_address { # addr
    "כתובת דוא\"ל לא חוקית:  $_[1]";
}
sub Sending_mail_to_voter_v {
    "שולח דוא\"ל למצביע \"$_[1]\"...";
}
sub CIVS_poll_supervisor { # name
    "\"$_[1], מפקח הצבעת CIVS\""
}
sub voter_mail_intro { #title, name, email_addr
"בחירות באמצעות שירות ההצבעה האינטרנטי קונדורסט בשם <b>$_[1]</b> נוצרו.
אתה הוגדרת כמצביע על-ידי מפקח הבחירות,
$_[2] (<a href=\"mailto:$_[3] ($_[2])\">$_[3]</a>).</p>";
}
sub Description_of_poll {
    'תיאור ההצבעה:';
}
sub if_you_would_like_to_vote_please_visit {
    'אם ברצונך להצביע, אנא בקר בכתובת ה-URL הבאה:';
}
sub This_is_your_private_URL {
'זו כתובת ה-URL הפרטית שלך. אל תיתן אותה לאף אדם אחר, מאחר שביכולתם להשתמש בה בכדי להצביע בשמך. ';
}
sub Your_privacy_will_not_be_violated {
'הפרטיות שלך לא תיפגע בשל הצבעתך. שירות ההצבעה כבר השמיד את רישומי כתובת הדוא"ל שלך, ולא ישחרר מידע כלשהו אודות השאלה האם הצבעת או למי.';
}
sub This_is_a_nonanonymous_poll {
'מפקח ההצבעה החליט להפוך בחירות אלו לבחירות <strong>שאינן אנונימיות</strong>אם תצביע, ההצבעה שלך תהיה גלויה לכל, יחד עם כתובת הדוא"ל שלך. 
אם לא תצביע, מפקח ההצבעה יוכל לזהות גם זאת.';
}

sub poll_has_been_announced_to_end { #election_end
    "הוכרז על סיום ההצבעה $_[1].";
}

sub To_view_the_results_at_the_end {
    "על-מנת לצפות בתוצאות ההצבעה עם סיומה, בקר ב:</p> $_[1]";
}

sub For_more_information {
    'למידע נוסף אודות שירות ההצבעה האינטרנ טי קונדורסט, ראה: ';
}

sub poll_email_subject { # title
    "הצבעה $_[1]"
}

# close

sub CIVS_Ending_Poll {
    'מערכת CIVS: מסיים הצבעה';
}

sub Ending_poll {
    'מסיים הצבעה';
}
sub View_poll_results {
    'צפה בתוצאות ההצבעה';
}
sub Poll_ended { #title
    "ההצבעה הסתיימה: $_[1]";
}

sub The_poll_has_been_ended { #election_end
    "ההצבעה הופסקה. הוכרז שהיה תסתיים ב- $_[1].";
}

sub poll_results_available_to_authorized_users {
    'תוצאות ההצבעה זמינות עתה למשתמשים מורשים.';
}

sub was_not_able_stop_the_poll {
    'לא ניתן היה לעצור את ההצבעה';
}


# results

sub CIVS_poll_result {
    "תוצאות הצבעת CIVS";
}
sub Poll_results { # title
    "תוצאות הצבעה: $_[1]";
}

sub Writeins_currently_allowed {
    'העדפות בהזנה ידנית מותרות כעת.';
}

sub Writeins_allowed {
    'מועמדים בהזנה ידנית מותרים.';
}
sub Writeins_not_allowed {
    'מועמדים בהזנה ידנית אינם מותרים.';
}
sub Detailed_ballot_reporting_enabled {
    'דיווח מפורט על טופסי הצבעה מאופשר.';
}
sub Detailed_ballot_reporting_disabled {
    'דיווח מפורט על טופסי הצבעה לא מאופשר.';
}
sub Voter_identities_will_be_kept_anonymous {
    'זהות המצביעים תישמר אנונימית';
}
sub Voter_identities_will_be_public {
    'זהות המצביעים (דוא"ל) תקושר באופן פומבי לטופסי ההצבעה שלהם.';
}
sub Condorcet_completion_rule {
    'כלל השלמה קונדורסט:';
}
sub undefined_algorithm {
    'שגיאה: אלגוריתם לא מוגדר';
}
sub computing_results {
    'מחשב תוצאות...';
}
sub Supervisor { #name, email
    "מפקח: <tt>$_[2]&gt;</tt> $_[1]<tt>&gt;</tt>"
}
sub Announced_end_of_poll {
    "הוכרז על סיום ההצבעה: $_[1]";
}
sub Actual_time_poll_closed { # close time
    if ($_[1] == 0) {
	"זמן סגירה בפועל של ההצבעה: $_[1]"
    } else {
	'זמן סגירה בפועל של ההצבעה: <script>document.write(new Date(' .
	    $_[1] * 1000 . 
	    ').toLocaleString())</script>';
    }
}
sub Poll_not_ended {
    'ההצבעה עדיין לא הסתיימה.';
}
sub This_is_a_test_poll {
    'אלו בחירות לבחינה.';
}
sub This_is_a_private_poll { #num_auth
    "הצבעה פרטית ($_[1] authorized voters)";
}
sub This_is_a_public_poll {
    'זו הצבעה פומבית.';
}

sub Actual_votes_cast { #num_votes
    "מספר ההצבעות בפועל: $_[1]";
}
sub Number_of_winning_candidates {
    'מספר המועמדים המנצחים: ';
}
sub Poll_actually_has { #winmsg
    my $winmsg = 'מנצח 1';
    if ($_[1] != 1) {
	$winmsg = $real_nwin.' מנצחים';
    }
    "&nbsp;(בהצבעה יש בפועל $winmsg)";
}
sub poll_description_hdr {
    'תיאור ההצבעה';
}
sub Ranking_result {
    'תוצאה';
}
sub x_beats_y { # x y w l 
    "$_[1] מנצח את $_[2] $_[3]&ndash;$_[4]";
}
sub x_ties_y { # x y w l 
    "$_[1] בשוויון עם $_[2] $_[3]&ndash;$_[4]";
}
sub x_loses_to_y { # x y w l 
    "$_[1] מפסיד ל$_[2] $_[3]&ndash;$_[4]";
}
sub some_result_details_not_shown {
    'לשם פשטות, חלק מהפרטים של תוצאות ההצבעה אינם מוצגים. &nbsp;';
}
sub Show_details {
    'הצג פרטים';
}
sub Hide_details {
    'הסתר פרטים';
}
sub Result_details {
    'פרטי התוצאות';
}
sub Ballot_report {
    'דוח טופסי הצבעה'
}
sub Ballots_are_shown_in_random_order {
    "טופסי ההצבעה מוצגים בסדר רנדומלי.";
}
sub Download_ballots_as_a_CSV { # url
    "[<a href=\"$_[1]\">הורד את טופסי ההצבעה בפורמט CSV</a>]";
}
sub No_ballots_were_cast {
    "לא נמסרו טופסי הצבעה בבחירות אלו.";
}
sub Ballot_reporting_was_not_enabled {
    "דיווח טופסי הצבעה לא אופשר עבור בחירות אלו.";
}
sub Tied {
    "<i>תיקו</i>:";
}
sub loss_explanation { # loss_to, for, against
    ', מפסיד ל'. $_[1].' ב-'. $_[2] .'&ndash;'. $_[3];
}
sub loss_explanation2 {
    '&nbsp;&nbsp;מפסיד ל'.$_[1].' ב-'.$_[2].'&ndash;'.$_[3];
}
sub Condorcet_winner_explanation {
    '&nbsp;&nbsp;(מנצח קונדורסט: מנצח בתחרויות מול כל יתר האפשרויות)';
}
sub undefeated_explanation {
    '&nbsp;&nbsp;(לא הובס בתחרות כלשהי מול אפשרות אחרת)';
}
sub Choices_shown_in_red_have_tied {
    "האפשרויות המוצגות באדום הגיעו לשוויון מתוך הבחירה בהן.
	ייתכן שתרצה לבחור מביניהן באופן רנדומלי.";
}
sub Condorcet_winner {
    "מנצח קונדורסט";
}
sub Choices_in_individual_pref_order {
    'האפשרויות (לפי סדר עדיפויות פרטי)';
}

sub What_is_this { # url
    '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>'. '(מה זה?)</small></a>';
}

# rp

sub All_prefs_were_affirmed {
    'כל ההעדפות אושרו. כל שיטות קונדורסט יתאימו לדירוג זה.';
}

sub Presence_of_a_green_entry_etc {
    'נוכחותה של רשומה ירוקה מתחת לאלכסון
	(ורשומה אדומה בהתאם מעליו) משמעה התעלמות מהעדפה 
משום שהיא התנגשה עם העדפות אחרות, חזקות יותר.';
}
sub Random_tie_breaking_used {
    'נעשה שימוש בשבירת שוויון רנדומלית
    בכדי להגיע לדירוג זה, בהתאם לאלגוריתם MAM.
    פעולה זו ייתכן שהשפיעה על דירוג האפשרויות.';
}
sub No_random_tie_breaking_used {
    'לא היה צורך בשבירת שוויון רנדומלית בכדי להגיע לדירוג זה.';
}

# beatpath

sub beatpath_matrix_explanation {
    'המטריצה הבאה מראה את עוצמת נתיב הנצחון החזק ביותר, המחבר כל זוג אפשרויות.
    אפשרות 1 מדורגת מעל אפשרות 2 אם קיים נתיב נצחון חזק יותר המוביל מ-1 ל-2 מאשר מ-2 ל-1.';
}

sub no_pref {
    'אף אחד'
}

#rp

sub Some_voter_preferences_were_ignored {
    'היתה התעלמות מחלק מהעדפות המצביעים משום שהן מתנגשות עם העדפות אחרות, חזקות יותר:'
}

sub preference_description {
    "ה$_[1]&ndash;$_[2] העדפה של $_[3] על-פני $_[4]."
}

1; # package succeeded!
