#include <sys/time.h>


int main(int argc, char **argv) {
    struct timeval tv;
    gettimeofday(&tv, 0);
    unsigned long retlo = (unsigned long) tv.tv_sec * 1000000 + tv.tv_usec;
    printf("%ld\n", retlo);
}
