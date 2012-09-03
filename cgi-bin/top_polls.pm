#!@PERL@
package top_polls;

use strict;
use warnings;
use CGI qw(:standard);
use Fcntl qw(:DEFAULT);

use lib '@CGIBINDIR@';

my $days_per_decay = 4.0;
my $decay = 1.0/86400.0/$days_per_decay;
my $usage_bottom = 1.0e-12;

my %elections; # map to [(last_time_stamp, usage_level)]
my %titles;

sub find_top_polls {
    my ($max_publicized, $max_full, $min_usage) = @_;
    my $home = '@CIVSDATADIR@';
    my $public_vote_log = $home. "/elections/public_vote.log"; # must be consistent with 'vote'.
    my $top_polls_temp = $home. "/elections/top_polls.$$";
    my $top_polls_full_temp = $home. "/elections/top_polls_full.$$";
    my $top_polls_out = $home. "/elections/top_polls.html";
    my $top_polls_full = $home. "/elections/top_polls_full.html";
    my $reduced_log = $home. "/elections/public_vote.log.temp";

    open(IN, $public_vote_log);
    if (!sysopen NEWLOG, $reduced_log, O_WRONLY|O_CREAT|O_TRUNC) {
	&Log("Could not open public vote log temp output file $reduced_log");
	return;
    }

    while (<IN>) {
      if ($_ =~ m/^= /) {
	my ($sum, $time, $eid, $usage, $title) = split /\s+/, $_, 5;
	$elections{$eid} = [($time, $usage)];
	$title =~ s/\s+$//;
	$titles{$eid} = $title;
      } else {
	my ($time, $eid, $title) = split /\s+/, $_, 3;
	if (defined($title)) {
	    $title =~ s/\s+$//;
	    $titles{$eid} = $title;
	}
	my $r = $elections{$eid};
	if (!defined($r)) {
	    # print STDERR "Creating record for $eid\n";
	    $elections{$eid} = [($time, 1.0)];
	} else {
	    my ($prevtime, $prevu) = @{$r};
	    my $usage = 1.0;
	    my $kt = ($prevtime - $time) * $decay;
	    if ($kt > -30.0) { $usage += $prevu * exp($kt); }
	    $elections{$eid} = [($time, $usage)];
	    # print "Updated $eid to $usage\n";
	}
      }
    }
    my @eids;
    my $now = time();
    foreach my $eid (keys %elections) {
	my ($t, $u) = @{$elections{$eid}};
	my $kt = ($t - $now) * $decay;
	if ($kt > -30.0) { $u *= exp($kt); } else { $u = 0; }
	$elections{$eid} = $u;
	push @eids, $eid;

	if ($u > $usage_bottom) {
	    print NEWLOG "= $now $eid $u $titles{$eid}\r\n";
	}
    }

    sub cmp {
	return $elections{$a} <=> $elections{$b}
    }
    @eids = sort {$elections{$b} <=> $elections{$a}} @eids;

    # foreach my $id (@eids) {
	# print $id, '(', $titles{$id}, ') : ',$elections{$id}, "\r\n";
    #}

    close(IN);

    if (!sysopen OUT, $top_polls_temp, O_WRONLY|O_CREAT|O_TRUNC) {
	&Log("Could not open top polls temp output file $top_polls_temp");
	return;
    }
    if (!sysopen FULL, $top_polls_full_temp, O_WRONLY|O_CREAT|O_TRUNC) {
	&Log("Could not open top polls temp output file $top_polls_full_temp");
	return;
    }
    print OUT '<ul>';
    print FULL '<ul>';
    my $count = 0;
    foreach my $id (@eids) {
	if ($elections{$id} < $min_usage || $count >= $max_full) { last; }
	my @line = ('<li>',
			'<a href="http://@THISHOST@@CIVSBINURL@',
			    '/vote@PERLEXT@?id=' , $id , '">' , escapeHTML($titles{$id}),
			'</a>',
		    '</li>', "\r\n");
	if ($count++ < $max_publicized) {
	    print OUT @line;
	}
	print FULL @line;
    }
    print OUT "</ul>\r\n";
    close(OUT);
    close(FULL);
    close(NEWLOG);
    rename($top_polls_temp, $top_polls_out);
    rename($top_polls_full_temp, $top_polls_full);
    rename($reduced_log, $public_vote_log);
}

sub standard_refresh {
    find_top_polls(10, 1000, 0.00001);
}

1; # ok!
