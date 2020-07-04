//
//  ACollectionViewCell.m
//  ARMRef
//
//  Created by James Emrich (EvilPenguin) on 6/28/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

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
