//
//  ANavigationController.m
//
//  Copyright (c) 2020 ARMRef (https://github.com/evilpenguin/ARMRef)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
