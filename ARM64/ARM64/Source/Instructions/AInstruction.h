//
//  AInstruction.h
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AInstruction : NSObject
@property (nonatomic, strong) NSString *mnemonic;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *html;

@end

NS_ASSUME_NONNULL_END
