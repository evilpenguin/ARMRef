//
//  AppDelegate.m
//  ARMRef
//
//  Created by James Emrich (EvilPenguin) on 6/28/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

#import "AAppDelegate.h"
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
        _window.backgroundColor = [UIColor colorFromHex:0x333e48];
        _window.rootViewController = self.navController;
    }
    
    return _window;
}

- (ANavigationController *) navController {
    if (!_navController) _navController = [[ANavigationController alloc] initWithLoader:self.loader];

    return _navController;
}

- (AInstructionLoader *) loader {
    if (!_loader) _loader = [[AInstructionLoader alloc] init];
    
    return _loader;
}

@end
