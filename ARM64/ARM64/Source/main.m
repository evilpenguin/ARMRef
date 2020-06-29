//
//  main.m
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString *appDelegateClassName;
    
    @autoreleasepool {
        appDelegateClassName = NSStringFromClass(AAppDelegate.class);
    }
    
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
