#include <math.h>

double calc(double x){
    int i = 1;
    double el = 1;
    double s = 1;
    double answer = exp(x);
    while(fabs(answer - s) >= 0.001) {
        el = el * x / i;
        i++;
        s = s + el;
    }
    return s;
}