//
//  UIColor+A.m
//  ARM64
//
//  Created by evilpenguin on 7/3/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

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
