//
//  AInstructionLoader.h
//  ARMRef
//
//  Created by James Emrich (EvilPenguin) on 6/28/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AInstruction.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString *const AInstructionLoaderFinishedNotificaton;

@interface AInstructionLoader : NSObject
@property (nonatomic, strong, nullable) NSString *armVersion;
@property (nonatomic, strong, nullable) NSString *filerString;

- (NSArray<AInstruction *> *) instructions;

@end

NS_ASSUME_NONNULL_END
