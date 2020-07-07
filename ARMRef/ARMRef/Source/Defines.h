//
//  Defines.h
//
//  Copyright (c) 2020 ARMRef (https://github.com/evilpenguin/ARMRef)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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

// Block
#define BlockSafetyCall(block) \
    if (block) block()

#define BlockSafetyCallWithArgs(block, ...) \
    if (block) block(__VA_ARGS__)

// Array
#define safetyObjectAtIndex(array, index) \
    (array.count > index ? array[index] : nil)

#define safetyPointerObjectAtIndex(array, index) \
    (array.count > index ? [array pointerAtIndex:index] : nil)


#endif /* Defines_h */
