int find(int n, int size, char *str){
    int flag;
    int i;
    int j;
    for (i = size - n; i >= 0; i--)
    {
        flag = 1;
        for (j = 0; j < n - 1; j++)
        {
            if (str[i+j] <= str[i+j+1]) {
                flag = 0;
                break;
            }
        }
        if (flag == 1) {
            return i;
        }
    }
    return -1;
}