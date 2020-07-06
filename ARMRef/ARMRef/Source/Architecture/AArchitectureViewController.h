//
//  AArchitectureViewController.h
//  ARMRef
//
//  Created by evilpenguin on 7/5/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AArchitectureViewController : UITableViewController
 @property (nonatomic, copy, nullable) void (^pickCompletion)(NSString *arch);

- (instancetype) initWithLoader:(AInstructionLoader *)loader;

@end

NS_ASSUME_NONNULL_END
