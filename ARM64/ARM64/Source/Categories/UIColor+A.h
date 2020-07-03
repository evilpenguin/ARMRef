//
//  UIColor+A.h
//  ARM64
//
//  Created by evilpenguin on 7/3/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (A)

+ (instancetype) colorFromHex:(int64_t)hex;
+ (CGColorRef) cgColorFromhex:(int64_t)hex;

@end

NS_ASSUME_NONNULL_END
