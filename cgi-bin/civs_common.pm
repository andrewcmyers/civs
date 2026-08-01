package civs_common;  # should be CIVS, or perhaps CIVS::Common

use strict;
no strict 'refs';
use warnings;
use POSIX ":sys_wait_h";
use Socket;
use HTML::TagFilter;
use HTML::Entities;
use HTTP::Tiny;
use MIME::Base64;
use CGI qw(:standard -utf8);
use Encode qw(encode);
use algorithms;

binmode STDOUT, ':encoding(UTF-8)';
binmode STDERR, ':encoding(UTF-8)';

# Export the package interface
BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.00;
    @ISA         = qw(Exporter);
    @EXPORT      = qw(&GetPrivateHostID &HTML_Header &CIVS_Header &Log &TrimAddr
                      &SecureNonce $home $thishost
                      $civs_bin_path $civs_log $civs_url $civs_home $local_debug $cr
                      $lockfile $private_host_id &Fatal_CIVS_Error &CIVS_End
                      &civs_hash &system_load &CheckLoad
                      &CheckPostRequest &CheckConfirmation
                      $remote_ip_address $peer_ip_address &LogIPAddress
                      $languages $tx &FileTimestamp &BR &Filter
                      &TrySomePolls &AcquireGlobalLock &ReleaseGlobalLock
                      &VerifyUpload &hexdump &toNatural &natParam &toBoolean
                      &boolParam &bytesParam &fixUTF);
    $ENV{'PATH'} = $ENV{'PATH'}.'@ADDTOPATH@';
}

# The local_debug flag must be declared before the call to set_message (in
# the package constructor, below), since the message handler uses
# local_debug.  The declaration has to be outside of the constructor block,
# however, so that the flag has the correct (package-global) scope.  The
# initialization of the flag, on the other hand, has to be inside
# the constructor, so that it is executed before any errors are encountered
# in parsing the rest of the file.  Complicated enough?
# The same holds for the other variables involved in printing fatal
# errors to the browser.
our $local_debug;
our $using_ISA = '@USING_ISA@';
our $remote_ip_address;
our $peer_ip_address;
our $languages;

# Package constructor
BEGIN {
        # This code is in a BEGIN block so that even compiler errors, as long
        # as they occur after this block, are caught.  They are recorded
        # in the CGILOG file.  Compile-time errors aren't timestamped,
        # unfortunately, but run-time ones are.  These are the errors
        # that used to be put in the global Apache error log.
        # It makes sense for every CGI script in CIVS to
        # "use civs_common;" as its first action.
        use IO::Handle;
        use CGI::Carp qw(carpout set_message fatalsToBrowser);
        open(CGILOG, ">>@CIVSDATADIR@/cgi-log") or
                die "Unable to open @CIVSDATADIR@/cgi-log: $!\n".(`id`);
        autoflush CGILOG;
        carpout(\*CGILOG);
        # set_message(\&Fatal_CIVS_Error);
        $local_debug = "@LOCALDEBUG@";
}

END {
        close CGILOG;
}

# Package imports
use CGI qw(:standard -utf8);
use POSIX qw(strftime);
use Digest::MD5 qw(md5_hex);
use Fcntl qw(:flock);
use languages;

# use Time::HiRes qw(gettimeofday);

# Exported package globals
our $home = "@CIVSDATADIR@";
our $thishost = "@THISHOST@";
our $civs_bin_path = "@CIVSBINURL@";
our $civs_log = $home.'/log';
our $civs_url = "@CIVSURL@";
our $civs_home = '@CIVSHOME@';
our $lockfile = $home.'/global_lock';
our $cr = "\r\n";
our $private_host_id;

# Non-exported package globals
our $generated_header = 0;
our $private_host_id_file = $home.'/private_host_id';
our $nonce_seed_file = $home.'/nonce_seed';
our $civs_header_printed = 0;
our $html_header_printed = 0;

&init;

sub init {
 &GetPrivateHostID;
 &SetIPAddress;
 &SetLanguage;
}

# Extract a single email address from a string, converting
# an undefined value to an empty string. Result is always
# lowercase.
sub TrimAddr {
    (my $addr) = @_;
    if (!$addr) { return '' }
    $addr = lc $addr;
    (my $inbrackets) = ($addr =~ m/\A.*<(.*)>.*\Z/);
    $addr = $inbrackets if ($inbrackets);
    $addr =~ s/^(\s)+//;
    $addr =~ s/(\s)+$//;
    $addr =~ s/\s+/ /;
    return $addr;
}

sub SetIPAddress {
    # The address the connection actually came from. Unlike the headers below,
    # this cannot be chosen by the sender -- though behind a proxy it is the
    # proxy's address rather than the client's, which is why the headers are
    # consulted at all.
    $peer_ip_address = remote_addr();
    $remote_ip_address = http('HTTP_X_REAL_IP')
                      || http('HTTP_X_FORWARDED_FOR')
                      || http('HTTP_IPREMOTEADDR')
                      || http('HTTP_REMOTE_ADDRESS')
                      || $peer_ip_address;
    # These headers are whatever the sender chose to send, and the value ends
    # up in log messages. Remove control characters here rather than at each
    # log call, so that an embedded newline cannot append forged log lines.
    $remote_ip_address =~ s/[\x00-\x1F\x7F]/ /g;
}

# The address to record in a log entry. Whoever sent the request can set the
# forwarding headers, so when one of them has overridden the peer address the
# entry records both: the address claimed, and the address the connection came
# from. Otherwise a request could be logged against an uninvolved third party.
sub LogIPAddress {
    my $claimed = $remote_ip_address;
    $claimed = '' unless defined($claimed);
    return $claimed if !defined($peer_ip_address)
                    || $claimed eq $peer_ip_address;
    return $claimed . '(peer=' . $peer_ip_address . ')';
}

sub SetLanguage {
    $languages = http('Accept-Language');
    if (!defined($languages)) {
        $languages = 'en-us';
    }
    if (param('language')) {
# allow language to be overridden by URL parameter
        $languages = param('language');
    }
    &languages::init($languages);
}

sub GetPrivateHostID {
    if (defined($private_host_id)) { return; }
    if (!open(HOSTID, $private_host_id_file)) {
        &HTML_Header("Configuration error");
        print h1($tx->Error),
              p("Unable to access the server's private key"),
              end_html();
        exit 0;
    }
    $private_host_id = <HOSTID>;
    $private_host_id =~ s/(\s)+$//;  # remove trailing whitespace
    close(HOSTID);
}

sub HTML_Header {
    my $title = shift;
    my @js = @_;
    if (!$generated_header) {
      my $style = $tx->style_file;
      if ($#js < 0) {
        print header(-charset => 'utf-8', -content_language => $tx->lang),
              start_html(
                -title => $title,
                -lang => $tx->lang,
                -head => [
                   Link({
                     -rel => "shortcut icon",
                     -href => "@CIVSURL@/images/check123b.png"
                   }),
                   meta({-name => 'viewport',
                         -content => 'width=device-width, initial-scale=1'}),
                   meta({-name => 'referrer',
                         -context => 'no-referrer'})
                ],
                -encoding => 'utf-8',
                -style => {'src' => "@CIVSURL@/$style"}
              );
      } else {
        my $ajaxlibs = "@PROTO@://ajax.googleapis.com/ajax/libs";
        my @scripts = (
            {'src' => "@CIVSURL@/ezdom.js"},
            {'src' => "$ajaxlibs/jquery/3.6.0/jquery.min.js"},
            {'src' => "$ajaxlibs/jqueryui/1.12.1/jquery-ui.min.js"},
            {'src' => "@CIVSURL@/jquery.ui.touch-punch.js"}
        );
        foreach my $script (@js) {
            push @scripts, { 'src' => ('@CIVSURL@/' . $script) };
        }
        print header(-charset => 'utf-8', -content_language => $tx->lang),
              start_html(
                -title => $title,
                -lang => $tx->lang,
                -head => [
                  Link({
                    -rel => "shortcut icon",
                    -href => "@CIVSURL@/images/check123b.png"
                  }),
                  meta({
                    -name => 'viewport',
                    -content => 'width=device-width, initial-scale=1'
                  }),
                  meta({
                    -name => 'referrer',
                    -context => 'no-referrer'
                  })
                ],
                -encoding => 'utf-8',
                -style => {'src' => "@CIVSURL@/$style"},
                -script => \@scripts,
                -onLoad => "setup()"
              );
      }
    }
    $html_header_printed = 1;
    $generated_header = 1;
}

sub BR {
    br() . $cr
}

sub CIVS_Header {
    my $heading = $_[0];
    if (!$heading) {
        $heading = "CIVS";
    }
    &HTML_Header($heading);
    if ($civs_header_printed) { return; }
    my $suggestion_box = '@SUGGESTION_BOX@';
print
 '<div class=banner role=banner>';
if ($local_debug) {
    print '<div style="text-align: center; background-color: yellow; width: 100%">',
          'LOCAL DEBUG MODE</div>';
}
print $cr,
 '  <div class=bannerpart id=bannericon>
      <img src="@CIVSURL@/images/check-civs.png" style="border: none" alt="CIVS logo"/>
  </div>
  <div class=bannerpart>
    <h1>', $tx->Condorcet_Internet_Voting_Service, '</h1>
  </div>
  <div class=bannerpart id=bannermenu><nav>',
        a({-href => $civs_home}, $tx->about_civs), BR,
        a({-href => "$civs_url/publicized_polls.html"}, $tx->public_polls), BR,
        a({-href => "@CIVSBINURL@/opt_in@PERLEXT@"}, $tx->new_user), BR,
        a({-href => "$civs_url/civs_create.html"}, $tx->create_new_poll), BR,
        a({-href => "$civs_url/sec_priv.html"}, $tx->about_security_and_privacy), BR,
        a({-href => "$civs_url/faq.html"}, $tx->FAQ), BR,
        a({-href => $suggestion_box}, $tx->CIVS_suggestion_box), BR,
    '</nav></div><br>
  <div class=pagetitle>
    <h2>', $heading, '</h2>
  </div>
</div>

<div class="contents">
';
    $civs_header_printed = 1;
}

sub CIVS_End {
    if ($civs_header_printed) {
        print '</div>', $cr; # contents
    }
    print end_html();
    exit 0;
}

sub Fatal_CIVS_Error {
    &HTML_Header($tx->CIVS_Error) unless $html_header_printed;
    &CIVS_Header($tx->Error) unless $civs_header_printed;

    print h2($tx->Error),
          p($tx->unable_to_process);
    print pre(@_);
    print pre(@_) if $local_debug;
    print end_html();
    exit 0;
}

sub TrySomePolls {
    return $cr
        . p($tx->try_some_public_polls)
        . '<script type="text/javascript" src="@CIVSURL@/ajax.js"></script>'
        . div({id=>"top_polls", class=>"small_list"}, "Loading...")
        . '<script type="text/javascript">fetch_content("top_polls", '
        . '"@PROTO@://@THISHOST@@CIVSBINURL@/get_top_polls@PERLEXT@")</script>';
}

# Log the string provided
sub Log {
    my $now = strftime "%a %b %e %H:%M:%S %Y", localtime;
    open(CIVS_LOG, ">>$civs_log");
    binmode CIVS_LOG, ':utf8';
    print CIVS_LOG $now.' '.&LogIPAddress.' '.$_[0].$cr;
    close(CIVS_LOG);
}

sub AcquireGlobalLock {
    open(LOCK, $lockfile) or die "Can't open global lock file $lockfile: $!\n";
    flock LOCK, &LOCK_EX;
}

sub ReleaseGlobalLock {
    flock LOCK, &LOCK_UN;
    close(LOCK);
}

# SecureNonce() is an unpredictable nonce that cannot
# be predicted from the future state of the system (except
# for data derived from the nonce itself).
sub SecureNonce {
    &GetPrivateHostID;
    &AcquireGlobalLock;

    open(NONCEFILE, "<$nonce_seed_file")
        or die "Can't open nonce file for read: $!\n";
    my $seed = <NONCEFILE>;
    $seed =~ s/(\s)+$//;
    close(NONCEFILE);
    my $ret = substr($seed, 0, 16);

    my $timeofday = `$home/gettimeofday`;
    $seed = md5_hex($private_host_id,$timeofday,$seed);

    open(NONCEFILE, ">$nonce_seed_file")
        or die "Can't open nonce file for write: $!\n";
    print NONCEFILE $seed.$cr;
    close(NONCEFILE);
    &ReleaseGlobalLock;
    return $ret;
}

# Generate a cryptographic hash of the argument(s), which
# must be strings of bytes (0-255).
sub civs_hash {
    substr(md5_hex(@_), 0, 16)
}

my $filter_tags = '@FILTER_TAGS@';

my $tf;

my $ok = {all => []};
my $allowed_tags = {
    table => $ok,
    td => {colspan => [], rowspan => []},
    tr => $ok,
    s => $ok,
    strike => $ok,
    kbd => $ok,
    code => $ok,
    strong => $ok,
    dl => $ok, dt => $ok, dd => $ok,
    br => $ok,
    var => $ok,
    dfn => $ok,
    cite => $ok,
    samp => $ok,
    span => $ok, div => $ok,
    small => $ok,
    time => {datetime => []},
    p => {align => ['left' | 'right' | 'center']},
    ol => {type => ['a', '1', 'A']}
};

my $max_image_size = @MAX_IMAGE_SIZE@;

# The image formats we are willing to inline, identified by the leading bytes
# of the data rather than by the content type the remote server claims. The
# type recorded in the generated data: URI comes from this table, so a hostile
# server cannot choose it. SVG is deliberately absent, since it can carry
# script.
my @image_magic = (
    ["\x89PNG\r\n\x1a\n" => 'image/png'],
    ["\xff\xd8\xff"      => 'image/jpeg'],
    ['GIF87a'            => 'image/gif'],
    ['GIF89a'            => 'image/gif'],
    ['BM'                => 'image/bmp'],
    ["\x00\x00\x01\x00"  => 'image/x-icon'],   # icon; \x02 would be a cursor
);

# Return the content type for image data, or undef if it is not one of the
# formats above.
sub ImageContentType {
    my ($content) = @_;
    return undef unless defined($content);
    foreach my $entry (@image_magic) {
        my ($magic, $type) = @$entry;
        return $type if length($content) >= length($magic)
                     && substr($content, 0, length($magic)) eq $magic;
    }
    # WebP is RIFF with a WEBP tag four bytes after the length.
    if (length($content) >= 12 && substr($content, 0, 4) eq 'RIFF'
                               && substr($content, 8, 4) eq 'WEBP') {
        return 'image/webp';
    }
    return undef;
}

# Report whether a packed address is one CIVS must not fetch from: loopback,
# link-local (which is where cloud instance metadata lives), private and other
# special-purpose ranges.
sub BlockedAddress {
    my ($family, $packed) = @_;
    if ($family == AF_INET) {
        my @o = unpack('C4', $packed);
        return 1 if $o[0] == 0;                            # 0.0.0.0/8
        return 1 if $o[0] == 10;                           # private
        return 1 if $o[0] == 127;                          # loopback
        return 1 if $o[0] == 169 && $o[1] == 254;          # link-local
        return 1 if $o[0] == 172 && $o[1] >= 16 && $o[1] <= 31;
        return 1 if $o[0] == 192 && $o[1] == 168;
        return 1 if $o[0] == 192 && $o[1] == 0 && $o[2] == 0;
        return 1 if $o[0] == 100 && $o[1] >= 64 && $o[1] <= 127;   # CGNAT
        return 1 if $o[0] == 198 && ($o[1] == 18 || $o[1] == 19);  # benchmarks
        return 1 if $o[0] >= 224;                          # multicast/reserved
        return 0;
    }
    if ($family == AF_INET6) {
        my @b = unpack('C16', $packed);
        my $top_zero = 1;
        foreach my $i (0..9) { $top_zero = 0 if $b[$i] != 0 }
        # IPv4-mapped and IPv4-compatible addresses: judge the embedded address,
        # so ::ffff:127.0.0.1 cannot be used to sidestep the checks above.
        if ($top_zero && (($b[10] == 0xff && $b[11] == 0xff)
                       || ($b[10] == 0 && $b[11] == 0))) {
            return BlockedAddress(AF_INET, pack('C4', @b[12..15]));
        }
        return 1 if ($b[0] & 0xfe) == 0xfc;                # fc00::/7
        return 1 if $b[0] == 0xfe && ($b[1] & 0xc0) == 0x80;  # fe80::/10
        return 1 if $b[0] == 0xff;                         # multicast
        return 0;
    }
    return 1;   # unrecognized family: refuse
}

# Fetch an image to inline into poll text. Returns (content type, bytes), or
# an empty list if the URL is one we decline to fetch or the reply is not an
# image of an accepted format.
#
# This request is issued by the server, from inside whatever network it sits
# in, and the bytes come back embedded in a page shown to whoever supplied the
# URL. Without the checks below, a poll description could use it to read the
# server's own internal HTTP endpoints.
sub FetchImage {
    my ($src) = @_;
    return () unless defined($src);
    $src =~ s/\A\s+//;
    $src =~ s/\s+\z//;
    my ($scheme, $hostport) = $src =~ m{\A(https?)://([^/?\#]*)}i;
    if (!defined($scheme)) {
        &Log("Image fetch refused: not an http or https URL");
        return ();
    }
    if ($hostport =~ m/\@/) {   # credentials obscure which host is addressed
        &Log("Image fetch refused: credentials in URL");
        return ();
    }
    my ($host) = $hostport =~ m/\A\[([^\]]*)\]/;   # bracketed IPv6 literal
    if (!defined($host)) { ($host) = $hostport =~ m/\A([^:]*)/ }
    if (!defined($host) || $host eq '') {
        &Log("Image fetch refused: no host in URL");
        return ();
    }
    my ($err, @addrs) =
        Socket::getaddrinfo($host, '', {socktype => SOCK_STREAM});
    if ($err || !@addrs) {
        &Log("Image fetch refused: cannot resolve host");
        return ();
    }
    foreach my $a (@addrs) {
        my $packed;
        if ($a->{family} == AF_INET) {
            (undef, $packed) = Socket::unpack_sockaddr_in($a->{addr});
        } elsif ($a->{family} == AF_INET6) {
            (undef, $packed) = Socket::unpack_sockaddr_in6($a->{addr});
        }
        if (!defined($packed) || &BlockedAddress($a->{family}, $packed)) {
            &Log("Image fetch refused: address not permitted");
            return ();
        }
    }
    # Do not follow redirects: a redirect is a second request to a target that
    # was never checked above.
    #
    # max_size aborts the read once the body passes the limit, instead of
    # letting the whole thing into memory and rejecting it afterwards. It
    # applies whatever the status is, so an oversized error body is capped
    # too, and a server that lies about (or omits) Content-Length gains
    # nothing. Exceeding it comes back as status 599, which is rejected below.
    my $http = HTTP::Tiny->new(verify_SSL => 0, timeout => 10,
                               max_redirect => 0,
                               max_size => $max_image_size);
    my $response = $http->get($src);
    if (!$response->{success} || $response->{status} != 200) {
        &Log("Image fetch failed with status " . $response->{status});
        return ();
    }
    my $content = $response->{content};
    if (!defined($content) || $content eq '') { return () }
    if (length($content) >= $max_image_size) {
        &Log("Image too large: " . length($content));
        return ();
    }
    my $type = &ImageContentType($content);
    if (!defined($type)) {
        &Log("Image fetch refused: content is not a recognized image format");
        return ();
    }
    return ($type, $content);
}

if ($filter_tags ne 'no') {
    $tf = new HTML::TagFilter(
      on_open_tag => sub {
          my ($self, $tag, $attributes, $sequence) = @_;
          if ($$tag eq 'img') {
            my $src = $attributes->{src};
            # Replace the source unconditionally: when the fetch is refused or
            # fails, the poll shows the placeholder rather than leaving a URL
            # that every viewer's browser would request.
            $attributes->{src} = '@CIVSURL@/images/check123b.png';
            my ($type, $content) = &FetchImage($src);
            if (defined($type)) {
                $attributes->{src} = "data:$type;base64,"
                          . MIME::Base64::encode_base64($content, '');
            }
          }
          return;
      }
    );
    $tf->xss_risky_attributes(qw(href background cite lowsrc));
    $tf->allow_tags($allowed_tags);
}

# Filter tags from a string, if $filter_tags is not 'no' (which is probably
# dangerous)
sub Filter {
    my $s = decode_entities($_[0]);
    my $result = ($filter_tags ne 'no'
               ? $tf->filter($s)
               : $s);
    # Log "Filtering: " . $_[0] . " to " . $result;
    return $result || "";
}

# Turn a string into a hex representation of each of its characters. For
# debugging.
sub hexdump {
    (my $s) = @_;
    my $result = $s . " = ";
    for (my $i = 0; $i < length($s); $i++) {
        $result .= sprintf("%04X ", ord(substr($s, $i, 1)));
        if ($i % 16 == 0) {
            $result .= "\r\n";
        }
    }
    return $result;
}

# Convert a broken UTF-8 encoding (if FIXUTF8 option turned on). The argument
# and result are both strings of bytes representing a UTF-8 encoded string, but
# the argument may have embedded bytes not following the encoding; these are
# treated as Latin-1 characters and encoded into UTF-8 in the result.
sub fixUTF {
    my ($a) = @_;
    return $a unless @FIXUTF8@ && ($a =~ m/[\200-\377]/);
    my $result = '';
    my $n = length($a);
    for (my $i = 0; $i < $n; $i++) {
        my $c = ord(substr($a, $i, 1));
        my $extra = $n - $i - 1;
        if ($c < 0x80 || $c > 0xFF) {
            $result .= chr($c);
        } else {
            my $needed = 0;
            my $ok = 1;
            if ($c >= 0xF0) {
                $needed = 3;
            } elsif ($c >= 0xE0) {
                $needed = 2;
            } elsif ($c >= 0xC0) {
                $needed = 1;
            } else {
                $ok = 0;
            }
            $ok = 0 if ($extra < $needed);
            if ($ok) {
                for (my $j = $i + 1; $ok && $j < $n && $j - $i <= $needed; $j++) {
                    my $e = ord(substr($a, $j, 1));
                    $ok = 0 if (($e & 0xC0) != 0x80);
                }
            }
            if ($ok) {
                $result .= substr($a, $i, $needed + 1);
                $i += $needed;
            } else {
                $result .= chr(0xC0 | ($c>>6)) . chr(0x80 | ($c & 077));
            }
        }
    }
    return $result;
}

# Return a numeric value for the argument. Return
# 0 if the argument is undefined or not a natural number.
sub toNatural {
    my $n = shift;
    return 0 unless defined($n) && $n =~ /\A(0|[1-9][0-9]*)\z/;
    return $n;
}

# A natural number value for the named parameter, which is
# 0 if the value of the parameter is absent or non-numeric.
sub natParam {
    toNatural(scalar param($_[0]))
}

# Return 0 or 1 for the argument, which is expected to be a boolean
# represented as 0 or 1. Anything else, including an undefined value,
# yields the default provided as the second argument (itself defaulting
# to 0).
sub toBoolean {
    my ($b, $default) = @_;
    $default = 0 unless defined($default);
    return $default unless defined($b) && $b =~ /\A[01]\z/;
    return $b + 0;
}

# A 0 or 1 value for the named parameter. If the parameter is absent or
# is not 0 or 1, the default provided as the second argument is used.
sub boolParam {
    toBoolean(scalar param($_[0]), $_[1])
}

# Convert the named param to a string of bytes. An undefined param becomes
# an empty string.
sub bytesParam {
    encode('utf-8', scalar param($_[0])) || ''
}

sub CheckPostRequest {
    if ((lc request_method()) ne 'post') {
	print h1("Invalid request type: ", request_method());
        print end_html();
        exit 0;
    }
}

sub CheckConfirmation {
    my $code = param('confirmation');
    my $req = shift;
    if ($code ne $req) {
        print end_html();
        exit 0;
    }
}

sub system_load {
    open(LOADAVG, "</proc/loadavg");
    my $line = <LOADAVG>;
    close(LOADAVG);
    (my $one, my $five, my $fifteen) = ($line =~ m/^([^ ]+) ([^ ]+) ([^ ]+)/);
    return $one;
}

sub CheckLoad {
    my $load = &toNatural(system_load);
    if ($load >= 10.0) {
        HTML_Header($tx->CIVS_server_busy);
        CIVS_Header($tx->CIVS_server_busy);
        print p($tx->Sorry_the_server_is_busy);
        exit 0;
    }
}

sub FileTimestamp {
    my $fname = $_[0];
    (my $dev, my $ino, my $mode, my $nlink, my $uid, my $gid, my $rdev,
     my $size, my $atime, my $mtime, my $ctime, my $blksize, my $blocks)
        = stat($fname);
    if (!defined($mtime) || $mtime eq '') {
        return 0; # no cache file
    } else {
        return $mtime;
    }
}

my %legal_upload_type = map { $_ => 1 } ('text/csv', 'text/plain');

sub VerifyUpload {
    my ($fh, $errors, $input_desc) = @_;
    if (!$fh) {
        push @{$errors}, li($tx->No_upload_file_provided);
        return 0;
    }
    my $type = uploadInfo($fh)->{'Content-Type'};
    if (!$legal_upload_type{$type}) {
        push @{$errors}, li($tx->Didnt_get_plain_text($type));
    } elsif ($fh->handle->eof) {
        my $size = uploadInfo($fh)->{'Content-Length'};
        if ($size > 0) {
            push @{$errors}, li($tx->Out_of_upload_space);
        } else {
            push @{$errors}, li($tx->Uploaded_file_empty($input_desc));
        }
    }
    return ($#{$errors} == -1);
}

1; # ok!
