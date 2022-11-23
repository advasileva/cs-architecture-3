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

extern int find(int n, int size, char *str);

int main(int argc, char** argv) {
    int count;
    int n;
    int size;
    int result;
    int i;
    char ch;
    int max = 1000000;
    char str[max + 1];
    struct timespec start;
    struct timespec finish;
    int64_t time_delta;
    FILE *input, *output;

    if (argc < 4) {
        printf("Incorrect input\n");
        return 0;
    }
    count = atoi(argv[1]);
    n = atoi(argv[2]);
    if (atoi(argv[3]) == 0) {
        if (argc < 5 || access(argv[4], F_OK) != 0) {
            printf("Incorrect input\n");
            return 0;
        }
        input = fopen(argv[4], "r");
        output = fopen(argv[5], "w");
        size = 0;
        do {
            if (size > max) {
                printf("Incorrect input\n");
                return 0;
            }
            ch = fgetc(input);
            str[size++] = ch;
        } while(ch != -1);
        size--;
        str[size] = '\0';
    } else {
        input = fopen("input", "w");
        output = fopen("output", "w");
        size = atoi(argv[4]);
        if (size > max) {
            printf("Incorrect input\n");
            return 0;
        }
        for(i = 0; i < size; i++) {
            str[i] = rand() % 128;
            fprintf(input, "%c", str[i]);
        }
    }

    clock_gettime(CLOCK_MONOTONIC, &start);

    for(i = 0; i < count; i++) {
        result = find(n, size, str);
    }

    clock_gettime(CLOCK_MONOTONIC, &finish);

    time_delta = timeDelta(finish, start);
    printf("Time delta: %ld ns\n", time_delta);
    if (result != -1) {
        for(i = 0; i < n; i++) {
            fprintf(output, "%c", str[result+i]);
        } 
    }
    return 0;
}

