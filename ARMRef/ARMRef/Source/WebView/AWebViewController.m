//
//  AWebViewController.m
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import "AWebViewController.h"

@interface AWebViewController () <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation AWebViewController

#pragma mark - AWebViewController

- (instancetype) init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationPageSheet;
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.webView];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.webView.frame = self.view.bounds;
}

#pragma mark - Public

- (void) loadHTMLString:(NSString *)string {
    self.webView.alpha = 0.0f;
    [self.webView loadHTMLString:string baseURL:NSBundle.mainBundle.bundleURL];
}

#pragma mark - Lazy

- (WKWebView *) webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:WKWebViewConfiguration.new];
        _webView.contentMode = UIViewContentModeScaleAspectFit;
        _webView.navigationDelegate = self;
    }
    
    return _webView;
}

#pragma mark - WKNavigationDelegate

- (void) webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [UIView animateWithDuration:0.35f animations:^{
        self.webView.alpha = 1.0f;
    }];
}

@end
