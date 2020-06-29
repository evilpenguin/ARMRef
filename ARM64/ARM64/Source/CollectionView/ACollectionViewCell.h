//
//  ACollectionViewCell.h
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AInstruction;
@interface ACollectionViewCell : UICollectionViewCell
@property (nonatomic, readonly, class) NSString *identifier;
@property (nonatomic, weak) AInstruction *instruction;

- (CGFloat) maxSizeForInstruction:(AInstruction *)instruction withWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
