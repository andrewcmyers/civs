use POSIX qw(strftime);

$home = "/www5/andru/icvs";
$thishost = "www5.cs.cornell.edu";
$civs_bin_path = "/cgi-bin/andru/icvs";
$icvs_log = $home."/log";
$icvs_url = "http://www5.cs.cornell.edu/~andru/icvs";
$last_election_id_file = $home."/last_election_id";
$private_host_id_file = $home."/private_host_id";
$lockfile = $home."/global_lock";

sub GetPrivateHostID {
    open(HOSTID, $private_host_id_file);
    $private_host_id=<HOSTID>;
    chomp $private_host_id;
    close(HOSTID);
}

sub ICVS_Header {
print "
<table border=0 width=100% cellspacing=0 cellpadding=7>
  <tr>
    <td width=100% bgcolor=#000080 valign=top nowrap>
    <h1><font color=white face=sans-serif>&nbsp;Condorcet Internet Voting Service</font></h1>
    </td>
    <td bgcolor=#000080 width=0% nowrap><a href=$icvs_url><font color=white face=sans-serif>CIVS Home</font></a></td>
  </tr>
  <tr>
    <td width=100% bgcolor=#000080 valign=top nowrap colspan=2>
    <h2 align=center><font color=white face=sans-serif>$_[0]</font></h2>
    </td>
  </tr>
</table>
";
}

# Log the string provided
sub Log {
    $now = strftime "%a %b %e %H:%M:%S %Y", localtime;
    open(ICVS_LOG, ">>$icvs_log");
    print ICVS_LOG $now." ".$_[0]."\n";
    close(ICVS_LOG);
}

1; # ok!
