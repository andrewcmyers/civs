use CGI qw(:standard);
use POSIX qw(strftime);
use Digest::MD5 qw(md5_hex);
# use Time::HiRes qw(gettimeofday);

$home = "@CIVSDATADIR@";
$thishost = "@THISHOST@";
$civs_bin_path = "@CIVSBINURL@";
$civs_log = $home.'/log';
$civs_url = "@CIVSURL@";
$nonce_seed_file = $home.'/nonce_seed';
$private_host_id_file = $home.'/private_host_id';
$lockfile = $home.'/global_lock';
$local_debug = 0;
$cr = "\r\n";
$generated_header = 0;

sub GetPrivateHostID {
    if (!open(HOSTID, $private_host_id_file)) {
	&HTML_Header("Configuration error");
        print h1("Error"),
	      p("Unable to access the server's private key"),
	      end_html();
	exit 0;
    }
    $private_host_id=<HOSTID>;
    chomp $private_host_id;
    close(HOSTID);
}

sub HTML_Header {
    my $title = $_[0];
    if (!$generated_header) {
	print header(), start_html(-title => $title,
				   -style => {'src' => "@CIVSURL@/style.css"});
    }
}

sub CIVS_Header {
print "
<table border=0 width=100% cellspacing=0 cellpadding=7 class=\"banner\">
  <tr>
    <td width=100% valign=top nowrap>
    <h1>&nbsp;Condorcet Internet Voting Service</h1>
    </td>
    <td width=0% nowrap valign=top align=right><a href=\"$civs_url\">CIVS Home</a><br>
    <a href=\"$civs_url/civs_create.html\">Create new election</a><br>
    <a href=\"$civs_url/sec_priv.html\">About security and privacy</a>
    </td>
  </tr>
  <tr>
    <td width=100% valign=top nowrap colspan=2>
    <h2 align=center>$_[0]</h2>
    </td>
  </tr>
</table>
";
}

# Log the string provided
sub Log {
    $now = strftime "%a %b %e %H:%M:%S %Y", localtime;
    open(CIVS_LOG, ">>$civs_log");
    print CIVS_LOG $now.' '.remote_addr().' '.$_[0].$cr;
    close(CIVS_LOG);
}

# SecureNonce() is an unpredictable nonce that cannot
# be predicted from the future state of the system (except
# for data derived from the nonce itself).
sub SecureNonce {
    GetPrivateHostID;
    open(LOCK, $lockfile);
    flock LOCK, LOCK_EX;

    open(NONCEFILE, "<$nonce_seed_file");
    my $seed = <NONCEFILE>;
    chomp $seed;
    close(NONCEFILE);
    my $ret = substr($seed, 0, 16);

    $timeofday = `$home/gettimeofday`;
    $seed = md5_hex($private_host_id,$timeofday,$seed);

    open(NONCEFILE, ">$nonce_seed_file");
    print NONCEFILE $seed.$cr;
    close(NONCEFILE);
    flock LOCK, LOCK_UN;
    close(LOCK);
    return $ret;
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

1; # ok!
