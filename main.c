#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

int64_t timeDelta(struct timespec finish, struct timespec start)
{
    int64_t nsecStart, nsecFinish;

    nsecStart = start.tv_sec;
    nsecStart *= 1000000000;
    nsecStart += start.tv_nsec;


    nsecFinish = finish.tv_sec;
    nsecFinish *= 1000000000;
    nsecFinish += finish.tv_nsec;

    return nsecFinish - nsecStart;
}

extern double calc(double x);

int main(int argc, char** argv) {
    int count;
    double x;
    int i;
    double result;
    struct timespec start;
    struct timespec finish;
    int64_t time_delta;
    FILE *input, *output;

    if (argc < 3) {
        printf("Incorrect input\n");
        return 0;
    }
    count = atoi(argv[1]);
    if (atoi(argv[2]) == 0) {
        if (argc < 4 || access(argv[3], F_OK) != 0) {
            printf("Incorrect input\n");
            return 0;
        }
        input = fopen(argv[3], "r");
        output = fopen(argv[4], "w");
        fscanf(input, "%lf", &x);
    } else {
        input = fopen("input", "w");
        output = fopen("output", "w");
        x = rand() % 128;
        fprintf(input, "%f", x);
    }

    clock_gettime(CLOCK_MONOTONIC, &start);

    for(i = 0; i < count; i++) {
        result = calc(x);
    }

    clock_gettime(CLOCK_MONOTONIC, &finish);

    time_delta = timeDelta(finish, start);
    printf("Time delta: %ld ns\n", time_delta);
    fprintf(output, "%f", result);
    return 0;
}

