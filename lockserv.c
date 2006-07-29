#include <netdb.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <ctype.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

#include <sys/un.h>

#ifndef UNIX_PATH_MAX
#define UNIX_PATH_MAX _POSIX_PATH_MAX
#endif

#define TRY(name,expr) if (0>(expr)) { perror(name); exit(EXIT_FAILURE); }

char buf[4096];

int lingerval = 1;

/* 
 * lockserv <file> <num> creates a process that acts like a lock that
 * can be held by up to <num> processes, but where acquires immediately
 * fail if <num> processes currently hold the lock.
 *
 * A client attempts to acquire the lock by reading from the specified file.
 * The server responds with the number of processes currently holding
 * the lock. If that number is at least <num>, the server immediately closes
 * the connection; the client has failed to acquire the lock. Otherwise,
 * the client has now acquired the lock. It releases the lock by closing
 * the connection itself.
 */
 
main(int argc, char **argv) {
    char *hostname;
    int num;
    int *clients;
    int num_held = 0;
    int sock;
    int input_closed = 0;
    struct sockaddr_in client;
    socklen_t client_size;
    int fd;
    int maxfd;
    struct hostent *h;
    struct sockaddr_un server;
    if (argc != 3 || 0 >= (num = atoi(argv[2]))) {
	fprintf(stderr, "Usage: %s <file> <num>\n", argv[0]);
	exit(-1);
    }
    TRY("socket", (sock = socket(PF_UNIX, SOCK_STREAM, 0)));
    
    server.sun_family = AF_UNIX;
    strncpy(server.sun_path, argv[1], UNIX_PATH_MAX);
    TRY(argv[1], bind(sock, (struct sockaddr *)&server, sizeof(server)));
    TRY("listen", listen(sock, 5));

    client_size = sizeof(client);

    clients = malloc(num * sizeof(int));
    maxfd = sock;
    num_held = 0;

    for(;;) {
	fd_set rds;
	int n, i;
	FD_ZERO(&rds);
	FD_SET(sock, &rds);
	for (i = 0; i < num_held; i++) FD_SET(clients[i], &rds);
	n = select(maxfd+1, &rds, 0, 0, 0);
	if (n>0) {
	    for (i = 0; i < num_held; i++) {
		int fd = clients[i];
		if (FD_ISSET(fd, &rds)) {
		    int ch = read(fd, buf, sizeof(buf));
		    if (ch == 0) {
			// fprintf(stderr, "Connection closed by remote host\n");
			close(fd);
			if (num_held > 1)
			    clients[i] = clients[num_held-1];
			num_held--;
		    }
		    break;
		}
	    }
	    if (FD_ISSET(sock, &rds)) {
		char buf[10];
		TRY("accept", fd = accept(sock, (struct sockaddr *)&client, &client_size));
		if (num_held >= num) {
		    // fprintf(stderr, "Rejected acquire attempt\n");
		    close(fd);
		} else {
		    clients[num_held++] = fd;
		    if (fd > maxfd) maxfd = fd;
		    sprintf(buf, "Acquired %d\n", num_held);
		    write(fd, buf, strlen(buf));
		}
	    }
	}
    }
}
