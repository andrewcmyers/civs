extern int setpgrp(int pid, int pgrp);
extern int getpid();
extern int getdtablesize();
extern int getopt(int argc, char **argv, char *opts);
extern int optind;
#if 0 
extern int open(char *, int, ...);
#endif
extern int dup2(int, int);

#include <stdio.h>
#include <assert.h>
#include <fcntl.h>

void usage(char **argv)
{
    fprintf(stderr, "Usage: %s [-n] <command>\n", argv[0]);
    exit(-1);
}

int main(int argc, char **argv)
{
    int devnull = 0;
    int c, pid;
    while (-1 != (c = getopt(argc, argv, "n"))) {
	switch(c) {
	    case 'n': devnull = 1; break;
	    default: usage(argv);
	}
    }
    if (optind == argc) usage(argv);
    pid = fork();
    if (pid) {
	if (0 > setpgrp(pid, pid)) { perror("setpgrp"); }
    } else {
	int i;
	int maxfd = getdtablesize();
	for (i=0; i< maxfd; i++) close(i);
	if (devnull) {
	    int fd = open("/dev/null", O_RDWR);
	    assert(fd == 0);
	    dup2(fd, 1);
	    dup2(fd, 2);
	}
	if (0 > execvp(argv[optind], argv + optind)) { perror("exec"); }
    }
}
