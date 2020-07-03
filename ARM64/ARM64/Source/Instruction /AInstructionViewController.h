//
//  AInstructionViewController.h
//  ARM64
//
//  Created by evilpenguin on 7/3/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AInstruction;
@interface AInstructionViewController : UIViewController
@property (nonatomic, weak) AInstruction *instruction;

- (instancetype) init;

@end

NS_ASSUME_NONNULL_END
