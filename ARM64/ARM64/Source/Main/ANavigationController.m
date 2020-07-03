//
//  ANavigationController.m
//  ARM64
//
//  Created by James Emrich (EvilPenguin) on 7/3/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

#import "ANavigationController.h"
#import "AMainViewController.h"

@interface ANavigationController ()
@property (nonatomic, weak) AInstructionLoader *loader;
@property (nonatomic, strong) AMainViewController *mainViewController;

@end

@implementation ANavigationController

#pragma mark - ANavigationController

- (instancetype) initWithLoader:(AInstructionLoader *)loader {
    if (self = [super init]) {
        self.loader                     = loader;
        self.navigationBar.tintColor    = [UIColor colorFromHex:0x8fa2b1];

        UINavigationBarAppearance *navigationBarAppearence = [[UINavigationBarAppearance alloc] init];
        navigationBarAppearence.shadowColor = UIColor.clearColor;
        navigationBarAppearence.backgroundColor = [UIColor colorFromHex:0x424C54];
        navigationBarAppearence.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.whiteColor, NSFontAttributeName: [UIFont systemFontOfSize:25.0f weight:UIFontWeightMedium]};
        self.navigationBar.standardAppearance = navigationBarAppearence;
        
        self.viewControllers = @[self.mainViewController];
    }
    
    return self;
}

#pragma mark - Setter

- (AMainViewController *) mainViewController {
    if (!_mainViewController) {
        _mainViewController = [[AMainViewController alloc] initWithLoader:self.loader];
    }
    
    return _mainViewController;
}

@end
