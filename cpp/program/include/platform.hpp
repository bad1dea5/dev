//
//
//

#ifndef _PLATFORM_HPP
#define _PLATFORM_HPP 1

//
//  architecture
//
#if defined(__aarch64__) || defined(_M_ARM64) || defined(__ARM64_ARCH_8__)
    #define PLATFORM_ARM64 1
#elif defined(__x86_64__) || defined(_x86_64) || defined(_M_X64) || defined(_M_AMD64)
    #define PLATFORM_AMD64 1
#else
    #error unsupported architecture
#endif

//
//  platform
//
#if defined(__linux__) || defined(LINUX)
    #define PLATFORM_LINUX 1
#elif defined(_WIN32) || defined(WINDOWS)
    #if !defined(_WIN64)
        #error unsupported platform
    #endif
    #define PLATFORM_WINDOWS 1
#else
    #error unsupported platform
#endif

//
//  build
//
#if defined(_DEBUG) || defined(DEBUG)
    #define PLATFORM_DEBUG 1
#else
    #define PLATFORM_RELEASE 1
#endif

#endif
