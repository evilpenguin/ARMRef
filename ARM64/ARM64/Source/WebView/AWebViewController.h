//
//  AWebViewController.h
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWebViewController : UIViewController

- (void) loadHTMLString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
