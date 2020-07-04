//
//  ANavigationController.h
//  ARMRef
//
//  Created by James Emrich (EvilPenguin) on 7/3/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AInstructionLoader;
@interface ANavigationController : UINavigationController

- (instancetype) initWithLoader:(AInstructionLoader *)loader;

@end

NS_ASSUME_NONNULL_END
