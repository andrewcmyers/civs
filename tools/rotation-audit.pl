#!/usr/bin/perl
# Read-only audit: which polls would be affected by changing private_host_id?
#
#   perl rotation-audit.pl /path/to/civs/data
#
# Reports only counts and poll ids -- no titles, addresses or ballots.
use strict; use warnings;
use DB_File; use Fcntl;

my $data = shift @ARGV or die "usage: rotation-audit.pl <CIVSDATADIR>\n";
my $dir = "$data/elections";
opendir(my $dh, $dir) or die "$dir: $!\n";

my ($total, $legacy_auth) = (0, 0);
my (@legacy_control, @open_polls);
while (my $e = readdir $dh) {
    next unless $e =~ /^E_[0-9a-f]+$/;
    my $d = "$dir/$e";
    next unless -f "$d/election_data";
    $total++;
    my %ed;
    unless (tie %ed, 'DB_File', "$d/election_data", O_RDONLY, 0666, $DB_HASH) {
        print "  ?? could not read $e\n"; next;
    }
    # Pre-2004 polls: the control key is derived from private_host_id, so
    # rotating permanently invalidates the supervisor's control URL.
    push @legacy_control, $e unless defined $ed{'hash_control_key'};
    # Pre-2004 private polls: voter keys were civs_hash(email, '', host_id),
    # i.e. derivable from the host id alone. Rotation does NOT fix these,
    # because the keys already issued stay valid.
    $legacy_auth++ if !defined($ed{'hash_authorization_key'})
                   && ($ed{'public'} // '') ne 'yes';
    untie %ed;
    # Polls still open: outstanding ballot receipts stop working, and adding
    # or resending to a voter mints a second key for them.
    push @open_polls, $e if -e "$d/started" && !-e "$d/stopped";
}
closedir $dh;

printf "polls examined:                                  %d\n", $total;
printf "\n[BREAKS] pre-2004 polls, control URL is derived: %d\n", scalar @legacy_control;
print  "         ", join(" ", @legacy_control), "\n" if @legacy_control;
printf "\n[BREAKS] polls still open (receipts / resends):   %d\n", scalar @open_polls;
print  "         ", join(" ", @open_polls), "\n" if @open_polls && @open_polls < 40;
printf "\n[NOT FIXED BY ROTATION] legacy private polls with\n".
       "         host-id-derived voter keys:             %d\n", $legacy_auth;
