//
//  UIColor+A.m
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

#import "UIColor+A.h"

@implementation UIColor (A)

#pragma mark - Public methods

+ (instancetype) colorFromHex:(int64_t)hex {
    return [UIColor colorWithRed:((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0f
                           green:((CGFloat)((hex & 0x00FF00) >>  8)) / 255.0f
                            blue:((CGFloat)((hex & 0x0000FF) >>  0)) / 255.0f
                           alpha:1.0];
}

+ (CGColorRef) cgColorFromhex:(int64_t)hex {
    return [[self colorFromHex:hex] CGColor];
}

@end
