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
        _window.backgroundColor = UIColor.blackColor;
        _window.rootViewController = self.mainViewController;
    }
    
    return _window;
}

- (AMainViewController *) mainViewController {
    if (!_mainViewController) _mainViewController = [[AMainViewController alloc] initWithLoader:self.loader];
    
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
