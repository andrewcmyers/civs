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

# Export the package interface
BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.00;
    @ISA         = qw(Exporter);
    @EXPORT      = qw(&GetPrivateHostID &HTML_Header &CIVS_Header &Log
                      &SecureNonce &fisher_yates_shuffle $home $thishost
                      $civs_bin_path $civs_log $civs_url $civs_home $local_debug $cr
                      $lockfile $private_host_id &Fatal_CIVS_Error &CIVS_End
                      &unique_elements &civs_hash &system_load &CheckLoad
		      $remote_ip_address $languages $tx &FileTimestamp &BR &Filter
                      &TrySomePolls);
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
use CGI qw(:standard);
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
our $private_host_id = '';

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


sub SetIPAddress {
    if ($using_ISA) {
	$remote_ip_address = http('HTTP_IPREMOTEADDR');
	if (!defined($remote_ip_address)) {
	    $remote_ip_address = http('HTTP_REMOTE_ADDRESS');
	}
	if (!defined($remote_ip_address)) {
	    $remote_ip_address = remote_addr();
	}
    } else {
	$remote_ip_address = remote_addr();
    }
}

sub SetLanguage {
    $languages = http('Accept-Language');
    if (!defined($languages)) {
	$languages = 'en-us';
    }
    &languages::init($languages);
}


sub GetPrivateHostID {
    if (!open(HOSTID, $private_host_id_file)) {
	&HTML_Header("Configuration error");
        print h1($tx->Error),
	      p("Unable to access the server's private key"),
	      end_html();
	exit 0;
    }
    $private_host_id=<HOSTID>;
    chomp $private_host_id;
    close(HOSTID);
}

sub HTML_Header {
    (my $title, my $js) = @_;
    if (!$generated_header) {
      my $style = $tx->style_file;
      if (!defined($js) || $js eq '') {
	print header(-charset => 'utf-8', -content_language => $tx->lang),
	      start_html(-title => $title,
	                 -lang => $tx->lang,
			 -head => [ Link({ -rel => "shortcut icon",
			                    -href => "@PROTO@://www.cs.cornell.edu/w8/~andru/civs/images/check123b.png" }),
				    meta({-name => 'viewport', -content => 'width=device-width, initial-scale=1'}),
                                    meta({-name => 'referrer', -context => 'no-referrer'})
                                  ],
			 -encoding => 'utf-8',
			 -style => {'src' => "@CIVSURL@/$style"});
      } else {
        print header(-charset => 'utf-8', -content_language => $tx->lang),
              start_html(-title => $title,
                         -lang => $tx->lang,
			 -head => [ Link({ -rel => "shortcut icon",
			                    -href => "@PROTO@://www.cs.cornell.edu/w8/~andru/civs/images/check123b.png" }),
				    meta({-name => 'viewport', -content => 'width=device-width, initial-scale=1'}),
                                    meta({-name => 'referrer', -context => 'no-referrer'})
                                  ],
                         -encoding => 'utf-8',
                         -style => {'src' => "@CIVSURL@/$style"},
                         -script => [{'src' => "@CIVSURL@/$js"},
                                     {'src' => "@CIVSURL@/ezdom.js"},
                                     {'src' => "@PROTO@://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js"},
                                     {'src' => "@PROTO@://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js"}], 
                         -onLoad => "setup()");
      }
    }
    $html_header_printed = 1;
    $generated_header = 1;
}

sub BR {
    br() . $cr
}

sub CIVS_Header {
    &HTML_Header($_[0]);
    if ($civs_header_printed) { return; }
    my $suggestion_box = '@SUGGESTION_BOX@';
print 
 '<div class="banner">';
if ($local_debug) {
	print '<div style="text-align: center; background-color: yellow; width: 100%">',
	      'LOCAL DEBUG MODE</div>';
}	
print $cr,
 '<div class=bannerpart id=bannericon>
      <img src="@CIVSURL@/images/check-civs.png" style="border: none"/>
  </div>
  <div class=bannerpart>
    <h1>&nbsp;', $tx->Condorcet_Internet_Voting_Service, '</h1>
  </div>
  <div class=bannerpart id=bannermenu>',
	a({-href => $civs_home}, $tx->about_civs), BR,
	a({-href => "$civs_url/publicized_polls.html"}, $tx->public_polls), BR,
	a({-href => "$civs_url/civs_create.html"}, $tx->create_new_poll), BR,
	a({-href => "$civs_url/sec_priv.html"}, $tx->about_security_and_privacy), BR,
	a({-href => "$civs_url/faq.html"}, $tx->FAQ), BR,
	a({-href => $suggestion_box}, $tx->CIVS_suggestion_box), BR,
    '</div><br>
  <div class=bannerpart>
    <h2 align="center">', $_[0], '</h2>
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
    print CIVS_LOG $now.' '.$remote_ip_address.' '.$_[0].$cr;
    close(CIVS_LOG);
}

# SecureNonce() is an unpredictable nonce that cannot
# be predicted from the future state of the system (except
# for data derived from the nonce itself).
sub SecureNonce {
    GetPrivateHostID;
    open(LOCK, $lockfile) or die "Can't open global lock file $lockfile: $!\n";
    flock LOCK, &LOCK_EX;

    open(NONCEFILE, "<$nonce_seed_file") 
	    or die "Can't open nonce file for read: $!\n";
    my $seed = <NONCEFILE>;
    chomp $seed;
    close(NONCEFILE);
    my $ret = substr($seed, 0, 16);

    my $timeofday = `$home/gettimeofday`;
    $seed = md5_hex($private_host_id,$timeofday,$seed);

    open(NONCEFILE, ">$nonce_seed_file")
	or die "Can't open nonce file for write: $!\n";
    print NONCEFILE $seed.$cr;
    close(NONCEFILE);
    flock LOCK, &LOCK_UN;
    close(LOCK);
    return $ret;
}

# Generate a cryptographic hash of the arguments.
sub civs_hash {
    return substr(md5_hex(@_),0,16);
}

my $filter_tags = '@FILTER_TAGS@';

my $tf;
if ($filter_tags ne 'no') {
    $tf = new HTML::TagFilter(
      on_open_tag => sub {
          my ($self, $tag, $attributes, $sequence) = @_;
          if ($$tag eq 'img') {
            my $src = $attributes->{'src'};
            $attributes->{'src'} = '@CIVSURL@/images/check123b.png';
            my $http = HTTP::Tiny->new({verify_SSL => 1});
            my $response = $http->get($src);

            if ($response->{status} eq 200) {
                my $contenttype = $response->{headers}->{'content-type'};
                my $content = $response->{content};
                if (length $content < @MAX_IMAGE_SIZE@) {
                    my $enc = MIME::Base64::encode_base64($content,'');
                    my $newsrc = "data:$contenttype;base64,$enc";
                    $attributes->{'src'} = $newsrc;
                }
            }
          }
          return;
      }
    );
    $tf->xss_risky_attributes(qw(href background cite lowsrc));
    my $ok = {all => []};
    $tf->allow_tags({
	table => $ok,
	td => {colspan => [], rowspan => []},
	tr => $ok,
        s => $ok,
        strike => $ok,
        kbd => $ok,
	strong => $ok,
	b => $ok,
	dl => $ok, dt => $ok, dd => $ok,
        br => $ok,
        var => $ok,
        dfn => $ok,
        cite => $ok,
        samp => $ok,
	span => $ok, div => $ok,
	small => $ok,
	p => {align => ['left' | 'right' | 'center']},
	ol => {type => ['a', '1', 'A']}
    });
}

# Filter tags from a string, if $filter_tags is not 'no' (which is probably dangerous)
sub Filter {
    my $s = decode_entities($_[0]);
    my $result = ($filter_tags ne 'no'
               ? $tf->filter($s)
               : $s);
    # Log "Filtering: " . $_[0] . " to " . $result;
    return $result;
}

# From the Perl Cookbook, p. 121
# Generate a random permutation of @array in place.
sub fisher_yates_shuffle {
    my $array = shift;
    my $i;
    for ($i = @$array; --$i; ) {
	my $j = int rand ($i+1);
	next if $i == $j;
	@$array[$i,$j] = @$array[$j,$i];
    }
}

# From the Perl Cookbook, p. 102
# Return the unique elements from a list.
sub unique_elements {
	my %seen = ();
	my @uniq = ();
	foreach my $item (@_) {
		push(@uniq, $item) unless $seen{$item}++;
	}
	return @uniq;
}

sub system_load {
    open(LOADAVG, "</proc/loadavg");
    my $line = <LOADAVG>;
    close(LOADAVG);
    (my $one, my $five, my $fifteen) = ($line =~ m/^([^ ]+) ([^ ]+) ([^ ]+)/);
    return $one;
}

sub CheckLoad {
    my $load = system_load + 0;
    if ($load >= 10.0) {
	HTML_Header($tx->CIVS_server_busy);
	CIVS_Header($tx->CIVS_server_busy);
	print p($tx->Sorry_the_server_is_busy);
	exit 0;
    }
}

sub FileTimestamp {
    my $fname = $_[0];
    (my $dev, my $ino, my $mode, my $nlink, my $uid, my $gid, my $rdev, my $size,
	my $atime, my $mtime, my $ctime, my $blksize, my $blocks)
	    = stat($fname);
    if (!defined($mtime) || $mtime eq '') {
	return 0; # no cache file
    } else {
	return $mtime;
    }
}

1; # ok!
