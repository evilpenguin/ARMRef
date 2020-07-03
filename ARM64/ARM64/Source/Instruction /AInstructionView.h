//
//  AInstructionView.h
//  ARM64
//
//  Created by evilpenguin on 7/3/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AInstruction;
@interface AInstructionView : UIView
@property (nonatomic, weak) AInstruction *instruction;

@end

NS_ASSUME_NONNULL_END
