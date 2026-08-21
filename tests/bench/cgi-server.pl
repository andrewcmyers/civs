#!/usr/bin/perl
#
# A small CGI web server, enough of one to put the CIVS scripts under load.
#
# Apache is not something a benchmark run can assume is installed, still
# less one configured for CIVS, and the cost being measured is mostly the
# cost of CGI itself: a process forked and a perl interpreter started for
# every request. So this serves that much of CGI/1.1 and no more.
#
# It is not fit to face a network. It runs whatever is in the directory it
# is pointed at, for whoever connects, and believes the address headers it
# is handed. Bind it to the loopback interface, which is the default.
#
#   cgi-server.pl --cgi-dir DIR [options]
#
#     --port N        port to listen on; 0 (the default) asks for a free one
#     --host ADDR     interface to bind (default 127.0.0.1)
#     --workers N     how many requests may be served at once (default 8)
#     --backlog N     how many may wait to be served (default 1024)
#     --timeout SECS  give up on a script that takes this long (default 60)
#     --log FILE      where to report requests that went wrong
#
# The port is announced on stdout as "listening PORT" before anything is
# accepted, so a script that starts the server can wait for that line and
# learn where to aim.
#
# The worker count and the backlog are the server's shape, not the
# workload's: together they are the c and the queue of an M/G/c station.
# Raising them lets more of the machine be used and lets more requests
# wait; neither makes a vote take less time to record.

use strict;
use warnings;

use IO::Socket::INET;
use POSIX qw(:sys_wait_h);
use Socket qw(SOL_SOCKET SO_REUSEADDR);

my %opt = (port => 0, host => '127.0.0.1', workers => 8, backlog => 1024,
           timeout => 60, log => '', 'cgi-dir' => '');
while (@ARGV) {
    my $arg = shift @ARGV;
    $arg =~ s/\A--// or die "cgi-server.pl: unexpected argument $arg\n";
    exists $opt{$arg} or die "cgi-server.pl: unknown option --$arg\n";
    $opt{$arg} = shift @ARGV;
}
my $cgi_dir = $opt{'cgi-dir'};
$cgi_dir ne '' && -d $cgi_dir or die "cgi-server.pl: --cgi-dir must name a directory\n";

my $logfh;
if ($opt{log} ne '') {
    open($logfh, '>>', $opt{log}) or die "cgi-server.pl: cannot write $opt{log}: $!\n";
    $logfh->autoflush(1);
}
sub logmsg {
    return unless $logfh;
    print $logfh scalar(localtime), " [$$] ", @_, "\n";
}

my $listener = IO::Socket::INET->new(
    LocalAddr => $opt{host},
    LocalPort => $opt{port},
    Proto     => 'tcp',
    Listen    => $opt{backlog},
    ReuseAddr => 1,
) or die "cgi-server.pl: cannot listen on $opt{host}:$opt{port}: $!\n";

$| = 1;
print "listening ", $listener->sockport, "\n";

# A worker that dies mid-response leaves the client waiting on a socket
# nobody will write to, so the load generator counts it. Nothing here
# should die, but say so in the log if something does.
$SIG{PIPE} = 'IGNORE';

my @workers;
for (1 .. $opt{workers}) {
    my $pid = fork();
    defined($pid) or die "cgi-server.pl: cannot fork: $!\n";
    if (!$pid) { worker(); exit 0 }
    push @workers, $pid;
}

my $stopping = 0;
$SIG{INT} = $SIG{TERM} = sub { $stopping = 1 };
# Perl asks the system to restart interrupted calls, and runs a handler
# only once the call it interrupted has returned. A parent blocked in
# waitpid would therefore never see the signal that was meant to stop it,
# so it looks in now and then instead of waiting there.
while (!$stopping) {
    my $pid = waitpid(-1, WNOHANG);
    if ($pid > 0) {
        # A worker should outlive the run; replace one that did not,
        # rather than quietly serving the rest of the benchmark with fewer.
        logmsg("worker $pid died (status $?); replacing it");
        @workers = grep { $_ != $pid } @workers;
        my $new = fork();
        if (defined($new) && !$new) { worker(); exit 0 }
        push @workers, $new if $new;
        next;
    }
    select(undef, undef, undef, 0.2);
}
kill 'TERM', @workers;
select(undef, undef, undef, 0.2);
kill 'KILL', @workers;
exit 0;

# One request at a time, forever: this is the "c" of the c servers.
sub worker {
    $SIG{INT} = $SIG{TERM} = sub { exit 0 };
    while (1) {
        my $conn = $listener->accept() or next;
        eval { serve($conn); 1 } or logmsg("request failed: $@");
        close($conn);
    }
}

sub serve {
    my ($conn) = @_;
    $conn->autoflush(1);
    setsockopt($conn, Socket::IPPROTO_TCP(), Socket::TCP_NODELAY(), 1);

    my ($head, $rest) = read_head($conn);
    return reply($conn, 400, "malformed request") unless defined $head;

    my @lines = split /\r?\n/, $head;
    my ($method, $target) = (shift(@lines) // '') =~ m{\A(\S+)\s+(\S+)\s+HTTP/}
        or return reply($conn, 400, "malformed request line");

    my %header;
    for my $line (@lines) {
        my ($name, $value) = $line =~ m/\A([^:]+):\s*(.*)\z/ or next;
        $name = uc $name;
        $name =~ tr/-/_/;
        # Repeated headers join with commas, as CGI/1.1 asks.
        $header{$name} = defined($header{$name}) ? "$header{$name}, $value" : $value;
    }

    my ($path, $query) = split /\?/, $target, 2;
    $query = '' unless defined $query;
    my ($script) = $path =~ m{([^/]+)\z};
    # Only a plain name, and only one that is already here: this server has
    # no business reaching anywhere but the directory it was pointed at.
    return reply($conn, 403, "not a script name")
        unless defined($script) && $script =~ m{\A[A-Za-z0-9._-]+\z} && $script !~ m{\A\.};
    my $prog = "$cgi_dir/$script";
    return reply($conn, 404, "no such script: $script") unless -f $prog && -x _;

    my $length = $header{CONTENT_LENGTH} || 0;
    $length = 0 unless $length =~ m/\A[0-9]+\z/;
    return reply($conn, 413, "body too large") if $length > 1_000_000;
    my $body = read_body($conn, $rest, $length);
    return reply($conn, 400, "short body") unless defined $body;

    my %env = (
        PATH              => $ENV{PATH} || '/usr/bin:/bin',
        GATEWAY_INTERFACE => 'CGI/1.1',
        SERVER_PROTOCOL   => 'HTTP/1.1',
        SERVER_SOFTWARE   => 'civs-bench-cgi/1',
        SERVER_NAME       => $opt{host},
        SERVER_PORT       => $listener->sockport,
        REQUEST_METHOD    => $method,
        REQUEST_URI       => $target,
        SCRIPT_NAME       => $path,
        SCRIPT_FILENAME   => $prog,
        QUERY_STRING      => $query,
        REMOTE_ADDR       => $conn->peerhost // '127.0.0.1',
        REMOTE_PORT       => $conn->peerport // 0,
        CONTENT_LENGTH    => $length,
        CONTENT_TYPE      => $header{CONTENT_TYPE} // '',
    );
    # Everything else the client sent, as CGI names it.
    for my $name (keys %header) {
        next if $name eq 'CONTENT_TYPE' || $name eq 'CONTENT_LENGTH';
        next unless $name =~ m{\A[A-Z0-9_]+\z};
        $env{"HTTP_$name"} = $header{$name};
    }

    my ($out, $status) = run_cgi($prog, \%env, $body);
    if (!defined $out) {
        return reply($conn, 504, "script timed out");
    }
    if ($status != 0) {
        logmsg("$script exited with status $status");
    }

    # Split what the script wrote into its headers and its body. A script
    # that died before printing any (CGI::Carp catches most of that, but
    # not everything) gets that reported as a 500 rather than sent on as a
    # body the load generator would have to guess about.
    my ($chead, $cbody) = split /\r?\n\r?\n/, $out, 2;
    if (!defined $cbody) {
        logmsg("$script produced no complete header");
        return reply($conn, 500, "script produced no header");
    }
    my $code = 200;
    my @out;
    for my $line (split /\r?\n/, $chead) {
        if ($line =~ m/\AStatus:\s*([0-9]{3})/i) { $code = $1; next }
        push @out, $line;
    }
    print $conn "HTTP/1.1 $code ", reason($code), "\r\n";
    print $conn "Connection: close\r\n";
    print $conn "Content-Length: ", length($cbody), "\r\n";
    print $conn join("\r\n", @out), "\r\n\r\n", $cbody;
}

# Run the script with the request on its standard input, and give back
# everything it wrote. Returns an undefined body if it had to be killed.
sub run_cgi {
    my ($prog, $env, $body) = @_;

    pipe(my $in_r, my $in_w) or die "pipe: $!\n";
    pipe(my $out_r, my $out_w) or die "pipe: $!\n";

    my $pid = fork();
    defined($pid) or die "fork: $!\n";
    if (!$pid) {
        close($in_w); close($out_r);
        open(STDIN, '<&', $in_r) or exit 1;
        open(STDOUT, '>&', $out_w) or exit 1;
        open(STDERR, '>&', $out_w) or exit 1;
        %ENV = %$env;
        chdir $cgi_dir;
        exec($prog);
        exit 1;
    }
    close($in_r); close($out_w);

    # The body is a form submission, far short of a pipe buffer, so this
    # cannot block long enough to deadlock against the read below.
    print $in_w $body;
    close($in_w);

    my $out = '';
    my $killed = 0;
    eval {
        local $SIG{ALRM} = sub { die "timeout\n" };
        alarm($opt{timeout});
        local $/;
        $out = <$out_r>;
        alarm(0);
        1;
    } or do {
        alarm(0);
        kill 'KILL', $pid;
        $killed = 1;
    };
    close($out_r);
    waitpid($pid, 0);
    my $status = $?;
    return (undef, $status) if $killed;
    return (defined($out) ? $out : '', $status);
}

sub read_head {
    my ($conn) = @_;
    my $buf = '';
    while ($buf !~ m/\r?\n\r?\n/) {
        my $n = sysread($conn, my $chunk, 8192);
        return (undef, '') unless $n;
        $buf .= $chunk;
        return (undef, '') if length($buf) > 65536;
    }
    return split(/\r?\n\r?\n/, $buf, 2);
}

sub read_body {
    my ($conn, $have, $length) = @_;
    while (length($have) < $length) {
        my $n = sysread($conn, my $chunk, $length - length($have));
        return undef unless $n;
        $have .= $chunk;
    }
    return substr($have, 0, $length);
}

sub reply {
    my ($conn, $code, $text) = @_;
    logmsg("$code $text");
    print $conn "HTTP/1.1 $code ", reason($code), "\r\n",
                "Connection: close\r\n",
                "Content-Type: text/plain\r\n",
                "Content-Length: ", length($text) + 1, "\r\n\r\n",
                "$text\n";
}

sub reason {
    my ($code) = @_;
    return { 200 => 'OK', 302 => 'Found', 400 => 'Bad Request',
             403 => 'Forbidden', 404 => 'Not Found', 413 => 'Payload Too Large',
             500 => 'Internal Server Error', 504 => 'Gateway Timeout',
           }->{$code} || 'Status';
}
