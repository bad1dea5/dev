//
//
//

#include "platform.hpp"

//
//
//
[[noreturn]] void exit(int status)
{
    while(true)
    {
#if PLATFORM_LINUX && PLATFORM_AMD64
        asm(
            "movl   %[status], %%edi\n"
            "movl   $231, %%eax\n"
            "syscall\n"
            "hlt"
            :
            : [status] "g" (status)
            : "eax", "edi"
        );
#endif
    }
}

//
//
//
extern "C" void _start()
{
    exit(0);
}
