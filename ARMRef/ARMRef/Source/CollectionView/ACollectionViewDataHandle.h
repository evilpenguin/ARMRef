//
//  ACollectionViewDataHandle.h
//  ARMRef
//
//  Created by James Emrich (EvilPenguin) on 6/28/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AInstructionLoader, AInstruction;
@protocol ACollectionViewDelegatesTouchHandle;
@interface ACollectionViewDataHandle : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) id<ACollectionViewDelegatesTouchHandle> handleTouch;
@property (nonatomic, strong) NSArray<AInstruction *> *instructions;

@end

@protocol ACollectionViewDelegatesTouchHandle <NSObject>
@required
- (void) collectioinViewHandle:(ACollectionViewDataHandle *)handle didTouchInstruction:(AInstruction *)instruction;
@end

NS_ASSUME_NONNULL_END
