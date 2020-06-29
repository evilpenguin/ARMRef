//
//  ACollectionViewDataHandle.h
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AInstructionLoader, AInstruction;
@protocol ACollectionViewDataHandleTouch;
@interface ACollectionViewDataHandle : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) id<ACollectionViewDataHandleTouch> handleTouch;

- (instancetype) initWithLoader:(AInstructionLoader *)loader;

@end

@protocol ACollectionViewDataHandleTouch <NSObject>
@required
- (void) collectioinViewHandle:(ACollectionViewDataHandle *)handle didTouchInstruction:(AInstruction *)instruction;
@end

NS_ASSUME_NONNULL_END
