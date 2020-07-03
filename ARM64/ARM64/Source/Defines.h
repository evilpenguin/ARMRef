//
//  Defines.h
//  ARM64
//
//  Created by evilpenguin on 7/3/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

// Weakify and Strongify
#define weakify(var) \
    __weak typeof(var) KPWeak_##var = var

#define strongify(var) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    __strong typeof(var) var = KPWeak_##var \
    _Pragma("clang diagnostic pop")

// Dispatch main
#define dispatch_async_main(block) \
    if (block) dispatch_async(dispatch_get_main_queue(), block)

#define dispatch_async_global(block) \
    if (block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#endif /* Defines_h */
