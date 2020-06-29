//
//  ACollectionViewCell.m
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
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
        self.backgroundColor = UIColor.whiteColor;

        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.bottomLabel];
    }
    
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGSize topSize = [self.topLabel sizeThatFits:CGSizeMake(self.bounds.size.width - 10.0f, CGFLOAT_MAX)];
    self.topLabel.frame = CGRectMake(10.0f, 9.0f, topSize.width, topSize.height);

    CGSize bottomSize = [self.bottomLabel sizeThatFits:CGSizeMake(self.bounds.size.width - 10.0f, CGFLOAT_MAX)];
    self.bottomLabel.frame = CGRectMake(10.0f, CGRectGetMaxY(self.topLabel.frame), bottomSize.width, bottomSize.height);
}

#pragma mark - Public class

+ (NSString *) identifier {
    return @"ACollectionViewCell";
}

#pragma mark - Public methods

- (CGFloat) maxSizeForInstruction:(AInstruction *)instruction withWidth:(CGFloat)width {
    self.topLabel.text = instruction.mnemonic;
    self.bottomLabel.text = instruction.desc;

    CGSize topSize = [self.topLabel sizeThatFits:CGSizeMake(width - 10.0f, CGFLOAT_MAX)];
    CGSize bottomSize = [self.bottomLabel sizeThatFits:CGSizeMake(width - 10.0f, CGFLOAT_MAX)];

    return topSize.height + bottomSize.height + 18.0f;
}

#pragma mark - Setters

- (void) setInstruction:(AInstruction *)instruction {
    _instruction = instruction;
    
    self.topLabel.text = instruction.mnemonic;
    self.bottomLabel.text = instruction.desc;
    
    [self setNeedsLayout];
}

#pragma mark - Lazy props

- (UILabel *) topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.backgroundColor = UIColor.whiteColor;
        _topLabel.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightBold];
        _topLabel.textColor = UIColor.blackColor;
    }
    
    return _topLabel;
}

- (UILabel *) bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.backgroundColor = UIColor.whiteColor;
        _bottomLabel.font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightRegular];
        _bottomLabel.textColor = UIColor.blackColor;
        _bottomLabel.numberOfLines = 0;
        _bottomLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    
    return _bottomLabel;
}

@end
