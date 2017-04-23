#include <stdio.h>
#include <stdint.h>

extern "C" {
int64_t funZion(void);
int64_t f00nzion(void);
int64_t funzi0n(void);
}

int main()
{
    if (funZion() == 0x33333333)
    {
        printf("First level unlocked\n");
        if (funzi0n() == 0x12340987)
        {
            printf("Second level unlocked\n");
            if (f00nzion() == 0x54323333)
                printf("~ You win!!!11! ~\n");
        }
    }
}
