//
//  ACollectionViewCell.m
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


#import "ACollectionViewCell.h"
#import "AInstruction.h"

@interface ACollectionViewCell ()
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation ACollectionViewCell
@dynamic identifier;

#pragma mark - ACollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor        = UIColor.whiteColor;
        self.layer.masksToBounds    = YES;
        self.layer.cornerRadius     = 10.0f;
        self.layer.maskedCorners    = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;

        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.bottomLabel];
    }
    
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    // Top label
    CGSize topSize = [self.topLabel sizeThatFits:CGSizeMake(self.bounds.size.width - 10.0f, CGFLOAT_MAX)];
    self.topLabel.frame = CGRectMake(10.0f, 9.0f, topSize.width, topSize.height);

    // Bottom label
    CGSize bottomSize = [self.bottomLabel sizeThatFits:CGSizeMake(self.bounds.size.width - 10.0f, CGFLOAT_MAX)];
    self.bottomLabel.frame = CGRectMake(10.0f, CGRectGetMaxY(self.topLabel.frame), bottomSize.width, bottomSize.height);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    if (self.highlighted) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 1, 0, 0, 1);
        CGContextFillRect(context, self.bounds);
    }
}

#pragma mark - Public class methods

+ (NSString *) identifier {
    return @"ACollectionViewCell";
}

#pragma mark - Public methods

- (CGFloat) maxSizeForInstruction:(AInstruction *)instruction withWidth:(CGFloat)width {
    self.topLabel.text = instruction.mnemonic;
    self.bottomLabel.text = instruction.shortDesc;

    CGFloat finalWidth = width - 10.0f;
    CGSize topSize = [self.topLabel sizeThatFits:CGSizeMake(finalWidth, CGFLOAT_MAX)];
    CGSize bottomSize = [self.bottomLabel sizeThatFits:CGSizeMake(finalWidth, CGFLOAT_MAX)];

    return topSize.height + bottomSize.height + 18.0f;
}

#pragma mark - Setters

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [self setNeedsDisplay];
}

- (void) setInstruction:(AInstruction *)instruction {
    _instruction = instruction;
    
    self.topLabel.text = instruction.mnemonic;
    self.bottomLabel.text = instruction.shortDesc;
    
    [self setNeedsLayout];
}

#pragma mark - Lazy props

- (UILabel *) topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.backgroundColor = UIColor.clearColor;
        _topLabel.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightBold];
        _topLabel.textColor = UIColor.blackColor;
        _topLabel.numberOfLines = 2;
    }
    
    return _topLabel;
}

- (UILabel *) bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.backgroundColor = UIColor.clearColor;
        _bottomLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightRegular];
        _bottomLabel.textColor = UIColor.blackColor;
        _bottomLabel.numberOfLines = 0;
        _bottomLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _bottomLabel;
}

@end
