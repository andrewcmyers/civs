#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/types.h>

void ignore() {}

void usage() {
    fprintf(stderr, "Usage: timeout <seconds> [ <pid> ] [ -- command]\n");
    exit(EXIT_FAILURE);
}

int main(int argc, char **argv)
{
    int sec;
    pid_t pid;
    if (argc < 3) usage();
    sec = atoi(argv[1]);
    signal(SIGCHLD, exit);
    if (strcmp(argv[2], "--") != 0) {
	pid = atoi(argv[2]);
    } else {
	pid = fork();
	if (pid == 0) {
	    if (execvp(argv[3], &argv[3]) < 0) {
		perror(argv[3]);
		exit(1);
	    }
	}
	close(0); // let child take over normal I/O
	close(1);
    }
    if (sec == 0 || pid == 0) usage();
    sleep(sec);
    if (0 > kill(pid, SIGTERM)) {
	fprintf(stderr, "timeout: killed pid %d\n", pid);
    }
    return EXIT_SUCCESS;
}
