//
//  AppDelegate.m
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import "AAppDelegate.h"
#import "AMainViewController.h"
#import "AInstructionLoader.h"
#import "UIColor+A.h"

@implementation AAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
        
    return YES;
}

#pragma mark - Lazy props

- (UIWindow *) window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _window.backgroundColor = [UIColor colorFromHex:0x333e48];
        _window.rootViewController = self.mainViewController;
    }
    
    return _window;
}

- (UINavigationController *) mainViewController {
    if (!_mainViewController) {
        AMainViewController *mainViewController = [[AMainViewController alloc] initWithLoader:self.loader];
        
        _mainViewController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
        _mainViewController.navigationBar.tintColor = [UIColor colorFromHex:0x8fa2b1];

        UINavigationBarAppearance *navigationBarAppearence = [[UINavigationBarAppearance alloc] init];
        navigationBarAppearence.shadowColor = UIColor.clearColor;
        navigationBarAppearence.backgroundColor = [UIColor colorFromHex:0x424C54];
        navigationBarAppearence.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.whiteColor, NSFontAttributeName: [UIFont systemFontOfSize:25.0f weight:UIFontWeightMedium]};
        _mainViewController.navigationBar.standardAppearance = navigationBarAppearence;
    }
    
    return _mainViewController;
}

- (AInstructionLoader *) loader {
    if (!_loader) {
        _loader = [[AInstructionLoader alloc] init];
        [_loader load];
    }
    
    return _loader;
}

@end
