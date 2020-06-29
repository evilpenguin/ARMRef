//
//  ViewController.h
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AInstructionLoader;
@interface AMainViewController : UIViewController

- (instancetype) initWithLoader:(AInstructionLoader *)loader;

@end

