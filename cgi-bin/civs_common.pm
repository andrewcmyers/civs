use POSIX qw(strftime);

$home = "@CIVSDATADIR@";
$thishost = "@THISHOST@";
$civs_bin_path = "@CIVSBINURL@";
$civs_log = $home."/log";
$civs_url = "@CIVSURL@";
$last_election_id_file = $home."/last_election_id";
$private_host_id_file = $home."/private_host_id";
$lockfile = $home."/global_lock";
$local_debug = 1;
$cr = "\r\n";

sub GetPrivateHostID {
    open(HOSTID, $private_host_id_file);
    $private_host_id=<HOSTID>;
    chomp $private_host_id;
    close(HOSTID);
}

sub HTML_Header {
    local $title = $_[0];
    print header(), start_html(-title => $title,
			       -style => {'src' => "@CIVSURL@/style.css"});
}

sub CIVS_Header {
print "
<table border=0 width=100% cellspacing=0 cellpadding=7 class=\"banner\">
  <tr>
    <td width=100% valign=top nowrap>
    <h1>&nbsp;Condorcet Internet Voting Service</h1>
    </td>
    <td width=0% nowrap valign=top><a href=$civs_url>CIVS Home</a></td>
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
    print CIVS_LOG $now." ".remote_addr()." ".$_[0]."\n";
    close(CIVS_LOG);
}

1; # ok!
