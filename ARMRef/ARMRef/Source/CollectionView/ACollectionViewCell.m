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
    
    CGFloat width = self.bounds.size.width - 20.0f;
    
    // Top label
    CGRect topFrame = [self.class _topLabelFrameForString:self.topLabel.text withWidth:width];
    self.topLabel.frame = CGRectMake(10.0f, 9.0f, topFrame.size.width, topFrame.size.height);

    // Bottom label
    CGRect bottomFrame = [self.class _bottomLabelFrameForString:self.bottomLabel.text withWidth:width];
    self.bottomLabel.frame = CGRectMake(10.0f, CGRectGetMaxY(self.topLabel.frame), bottomFrame.size.width, bottomFrame.size.height);
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

+ (CGFloat) heightForInstruction:(AInstruction *)instruction withWidth:(CGFloat)width {
    CGFloat padding = 18.0f;
    CGRect topFrame = [self _topLabelFrameForString:instruction.mnemonic withWidth:width];
    CGRect bottomFrame = [self _bottomLabelFrameForString:instruction.shortDesc withWidth:width];

    return topFrame.size.height + bottomFrame.size.height + padding;
}

#pragma mark - Private class

+ (CGRect) _topLabelFrameForString:(NSString *)string withWidth:(CGFloat)width {
    return  [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                              attributes:self._topLabelAttributes
                                 context:nil];
}

+ (NSDictionary *) _topLabelAttributes {
    return @{
        NSFontAttributeName: [UIFont systemFontOfSize:20.0f weight:UIFontWeightBold]
    };
}

+ (CGRect) _bottomLabelFrameForString:(NSString *)string withWidth:(CGFloat)width {
    return  [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                              attributes:self._bottomLabelAttributes
                                 context:nil];
}

+ (NSDictionary *) _bottomLabelAttributes {
    return @{
        NSFontAttributeName: [UIFont systemFontOfSize:14.0f weight:UIFontWeightRegular]
    };
}

#pragma mark - Setters

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [self setNeedsDisplay];
}

- (void) setInstruction:(AInstruction *)instruction {
    _instruction = instruction;
    
    self.topLabel.attributedText = [[NSAttributedString alloc] initWithString:instruction.mnemonic attributes:self.class._topLabelAttributes];
    self.bottomLabel.attributedText = [[NSAttributedString alloc] initWithString:instruction.shortDesc attributes:self.class._bottomLabelAttributes];
    
    [self setNeedsLayout];
}

#pragma mark - Lazy props

- (UILabel *) topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.backgroundColor = UIColor.clearColor;
        _topLabel.textColor = UIColor.blackColor;
        _topLabel.numberOfLines = 2;
    }
    
    return _topLabel;
}

- (UILabel *) bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.backgroundColor = UIColor.clearColor;
        _bottomLabel.textColor = UIColor.blackColor;
        _bottomLabel.numberOfLines = 0;
        _bottomLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _bottomLabel;
}

@end
