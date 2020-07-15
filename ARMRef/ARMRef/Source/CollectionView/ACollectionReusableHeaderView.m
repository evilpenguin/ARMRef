//
//  ACollectionReusableHeaderView.m
//  ARMRef
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

#import "ACollectionReusableHeaderView.h"

@interface ACollectionReusableHeaderView ()
@property (nonatomic, strong) UILabel *label;

@end

@implementation ACollectionReusableHeaderView

#pragma mark - ACollectionReusableHeaderView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorFromHex:0x5b646c];
        
        [self addSubview:self.label];
    }
    
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    // Label
    self.label.frame = CGRectMake(10.0f, 0.0f, self.bounds.size.width - 20.0f, self.bounds.size.height);
}

#pragma mark - Public class methods

+ (NSString *) identifier {
    return @"ACollectionReusableHeaderView";
}

#pragma mark - Lazy props

- (UILabel *) label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = UIColor.clearColor;
        _label.textColor = UIColor.whiteColor;
        _label.font = [UIFont systemFontOfSize:24.0f weight:UIFontWeightBold];
        _label.text = @"A";
    }
    
    return _label;
}

@end
