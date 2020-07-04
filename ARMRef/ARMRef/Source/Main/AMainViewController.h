//
//  ViewController.h
//  ARMRef
//
//  Created by James Emrich (EvilPenguin) on 6/28/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

#import <UIKit/UIKit.h>

@class AInstructionLoader;
@interface AMainViewController : UIViewController

- (instancetype) initWithLoader:(AInstructionLoader *)loader;

@end

