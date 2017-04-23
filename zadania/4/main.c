#include <stdio.h>
#include "not_exported.h"

int main()
{
    printf("And the answer is: %d\n", not_exported_function());   
    return 0;
}
