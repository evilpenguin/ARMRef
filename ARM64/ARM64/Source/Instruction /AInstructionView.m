//
//  AInstructionView.m
//  ARM64
//
//  Created by James Emrich (EvilPenguin) on 7/3/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

#import "AInstructionView.h"
#import "AInstruction.h"

@interface AInstructionView ()
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UILabel *syntaxSectionLabel;
@property (nonatomic, strong) NSPointerArray *syntaxLabels;

@property (nonatomic, strong) UILabel *symbolSectionLabel;
@property (nonatomic, strong) NSPointerArray *symbolLabels;

@property (nonatomic, strong) UILabel *decodeSectionLabel;
@property (nonatomic, strong) UILabel *decodeLabel;

@property (nonatomic, strong) UILabel *operationSectionLabel;
@property (nonatomic, strong) UILabel *operationLabel;

@end

@implementation AInstructionView

#pragma mark - AInstructionView

- (instancetype) init {
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        
        [self addSubview:self.scrollView];
        //[self.scrollView addSubview:self.titleLabel];
        [self.scrollView addSubview:self.descLabel];
        [self.scrollView addSubview:self.syntaxSectionLabel];
        [self.scrollView addSubview:self.symbolSectionLabel];
        [self.scrollView addSubview:self.decodeSectionLabel];
        [self.scrollView addSubview:self.decodeLabel];
        [self.scrollView addSubview:self.operationSectionLabel];
        [self.scrollView addSubview:self.operationLabel];
    }
    
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    // Scrollview
    CGFloat leftRightInset = self.safeAreaInsets.left + self.safeAreaInsets.right;
    self.scrollView.frame = CGRectMake(self.safeAreaInsets.left, 0.0f, self.bounds.size.width - leftRightInset, self.bounds.size.height);

    // Points
    CGFloat headerIndent = 8.0f;
    CGFloat headerMaxWidth = self.scrollView.bounds.size.width - (headerIndent * 2.0f);
    CGFloat contentIndent = headerIndent * 2.5f;
    CGFloat contextMaxWidth = self.scrollView.bounds.size.width - (contentIndent * 2.0f);

    // Title label
    //CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(headerMaxWidth, CGFLOAT_MAX)];
    //self.titleLabel.frame = CGRectMake(headerIndent, headerIndent, titleSize.width, titleSize.height);
    
    // Desc label
    CGSize descSize = [self.descLabel sizeThatFits:CGSizeMake(contextMaxWidth, CGFLOAT_MAX)];
    self.descLabel.frame = CGRectMake(contentIndent, contentIndent, descSize.width, descSize.height);
    
    // Syntax section label
    CGSize syntaxSectionSize = [self.syntaxSectionLabel sizeThatFits:CGSizeMake(headerMaxWidth, CGFLOAT_MAX)];
    self.syntaxSectionLabel.frame = CGRectMake(headerIndent, CGRectGetMaxY(self.descLabel.frame) + 10.0f, syntaxSectionSize.width, syntaxSectionSize.height);
    
    // Syntax labels
    CGFloat syntaxOffsetY = CGRectGetMaxY(self.syntaxSectionLabel.frame) + 5.0f;
    for (UILabel *syntaxLabel in self.syntaxLabels) {
        CGSize syntaxSize = [syntaxLabel sizeThatFits:CGSizeMake(contextMaxWidth, CGFLOAT_MAX)];
        syntaxLabel.frame = CGRectMake(contentIndent, syntaxOffsetY, contextMaxWidth, syntaxSize.height + 4.0f);
        
        syntaxOffsetY = CGRectGetMaxY(syntaxLabel.frame) + 5.0f;
    }
    
    // Symbol section label
    CGSize symbolSectionSize = [self.symbolSectionLabel sizeThatFits:CGSizeMake(headerMaxWidth, CGFLOAT_MAX)];
    self.symbolSectionLabel.frame = CGRectMake(headerIndent, syntaxOffsetY + 10.0f, symbolSectionSize.width, symbolSectionSize.height);
    
    // Syntax labels
    CGFloat symbolOffsetY = CGRectGetMaxY(self.symbolSectionLabel.frame) + 5.0f;
    for (UILabel *symbolLabel in self.symbolLabels) {
        CGSize syntaxSize = [symbolLabel sizeThatFits:CGSizeMake(contextMaxWidth, CGFLOAT_MAX)];
        symbolLabel.frame = CGRectMake(contentIndent, symbolOffsetY, syntaxSize.width, syntaxSize.height + 4.0f);
        
        symbolOffsetY = CGRectGetMaxY(symbolLabel.frame) + 10.0f;
    }
    
    // Decode section label
    CGSize decodeSectionSize = [self.decodeSectionLabel sizeThatFits:CGSizeMake(headerMaxWidth, CGFLOAT_MAX)];
    self.decodeSectionLabel.frame = CGRectMake(headerIndent, symbolOffsetY + 10.0f, decodeSectionSize.width, decodeSectionSize.height);

    // Decode label
    CGSize decodeSize = [self.decodeLabel sizeThatFits:CGSizeMake(contextMaxWidth, CGFLOAT_MAX)];
    self.decodeLabel.frame = CGRectMake(contentIndent, CGRectGetMaxY(self.decodeSectionLabel.frame) + 10.0f, contextMaxWidth, decodeSize.height + 4.0f);

    // Operation section label
    CGSize operationSectionSize = [self.operationSectionLabel sizeThatFits:CGSizeMake(headerMaxWidth, CGFLOAT_MAX)];
    self.operationSectionLabel.frame = CGRectMake(headerIndent, CGRectGetMaxY(self.decodeLabel.frame) + 10.0f, operationSectionSize.width, operationSectionSize.height);

    // Operation label
    CGSize operationSize = [self.operationLabel sizeThatFits:CGSizeMake(contextMaxWidth, CGFLOAT_MAX)];
    self.operationLabel.frame = CGRectMake(contentIndent, CGRectGetMaxY(self.operationSectionLabel.frame) + 10.0f, contextMaxWidth, operationSize.height + 4.0f);

    // Scroll content size
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, CGRectGetMaxY(self.operationLabel.frame) + 10.0f);
}

#pragma mark - Setter

- (void) setInstruction:(AInstruction *)instruction {
    _instruction = instruction;
    
    // Mnemonic
    //self.titleLabel.text = instruction.mnemonic;
    
    // Desc
    self.descLabel.text = instruction.fullDesc;
    
    // Syntax
    for (NSString *symbol in instruction.syntax) {
        UILabel *label = [self _syntaxLabelWithString:symbol];
        [self.syntaxLabels addPointer:(__bridge void *)label];
    }
    
    // Symbols
    for (NSString *symbol in instruction.symbols) {
        UILabel *label = [self _symbolLabelWithString:symbol];
        [self.symbolLabels addPointer:(__bridge void *)label];
    }
    
    // Decode
    self.decodeLabel.text = instruction.decode;
    
    // Operation
    self.operationLabel.text = instruction.operation;
}

#pragma mark - Private

- (UILabel *) _syntaxLabelWithString:(NSString *)string {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightSemibold];
    label.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
    label.textColor = [UIColor colorFromHex:0x333e48];
    label.numberOfLines = 0;
    label.text = string;
    [self.scrollView addSubview:label];

    return label;
}

- (UILabel *) _symbolLabelWithString:(NSString *)string {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{
        NSForegroundColorAttributeName: [UIColor colorFromHex:0x333e48],
        NSFontAttributeName: [UIFont systemFontOfSize:16.0f weight:UIFontWeightSemibold],
        NSBackgroundColorAttributeName: [UIColor colorFromHex:0xe6e6e6]
    }];
    
    NSRange newLine = [string rangeOfString:@"\n"];
    NSDictionary *afterSymbolAttributes = @{
        NSForegroundColorAttributeName: [UIColor colorFromHex:0x333e48],
        NSFontAttributeName: [UIFont systemFontOfSize:16.0f weight:UIFontWeightRegular],
        NSBackgroundColorAttributeName: UIColor.clearColor
    };
    [attributedString setAttributes:afterSymbolAttributes range:NSMakeRange(newLine.location, string.length - newLine.location)];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = UIColor.clearColor;
    label.numberOfLines = 0;
    label.attributedText = attributedString;
    [self.scrollView addSubview:label];

    return label;
}

#pragma mark - Lazy

- (UIScrollView *) scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = UIColor.clearColor;
    }
    
    return _scrollView;
}

- (UILabel *) titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:35.0f weight:UIFontWeightSemibold];
        _titleLabel.backgroundColor = UIColor.clearColor;
        _titleLabel.textColor = [UIColor colorFromHex:0x333e48];
    }
    
    return _titleLabel;
}

- (UILabel *) descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightRegular];
        _descLabel.backgroundColor = UIColor.clearColor;
        _descLabel.textColor = [UIColor colorFromHex:0x333e48];
        _descLabel.numberOfLines = 0;
    }
    
    return _descLabel;
}

- (UILabel *) syntaxSectionLabel {
    if (!_syntaxSectionLabel) {
        _syntaxSectionLabel = [[UILabel alloc] init];
        _syntaxSectionLabel.font = [UIFont systemFontOfSize:22.0f weight:UIFontWeightMedium];
        _syntaxSectionLabel.backgroundColor = UIColor.clearColor;
        _syntaxSectionLabel.textColor = [UIColor colorFromHex:0x333e48];
        _syntaxSectionLabel.text = @"Syntax";
    }
    
    return _syntaxSectionLabel;
}

- (NSPointerArray *) syntaxLabels {
    if (!_syntaxLabels) _syntaxLabels = [NSPointerArray pointerArrayWithOptions:NSPointerFunctionsWeakMemory];

    return _syntaxLabels;
}

- (UILabel *) symbolSectionLabel {
    if (!_symbolSectionLabel) {
        _symbolSectionLabel = [[UILabel alloc] init];
        _symbolSectionLabel.font = [UIFont systemFontOfSize:22.0f weight:UIFontWeightMedium];
        _symbolSectionLabel.backgroundColor = UIColor.clearColor;
        _symbolSectionLabel.textColor = [UIColor colorFromHex:0x333e48];
        _symbolSectionLabel.text = @"Symbols";
    }
    
    return _symbolSectionLabel;
}

- (NSPointerArray *) symbolLabels {
    if (!_symbolLabels) _symbolLabels = [NSPointerArray pointerArrayWithOptions:NSPointerFunctionsWeakMemory];

    return _symbolLabels;
}

- (UILabel *) decodeSectionLabel {
    if (!_decodeSectionLabel) {
        _decodeSectionLabel = [[UILabel alloc] init];
        _decodeSectionLabel.font = [UIFont systemFontOfSize:22.0f weight:UIFontWeightMedium];
        _decodeSectionLabel.backgroundColor = UIColor.clearColor;
        _decodeSectionLabel.textColor = [UIColor colorFromHex:0x333e48];
        _decodeSectionLabel.text = @"Decode";
    }
    
    return _decodeSectionLabel;
}

- (UILabel *) decodeLabel {
    if (!_decodeLabel) {
        _decodeLabel = [[UILabel alloc] init];
        _decodeLabel.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightSemibold];
        _decodeLabel.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        _decodeLabel.textColor = [UIColor colorFromHex:0x333e48];
        _decodeLabel.numberOfLines = 0;
    }
    
    return _decodeLabel;
}

- (UILabel *) operationSectionLabel {
    if (!_operationSectionLabel) {
        _operationSectionLabel = [[UILabel alloc] init];
        _operationSectionLabel.font = [UIFont systemFontOfSize:22.0f weight:UIFontWeightMedium];
        _operationSectionLabel.backgroundColor = UIColor.clearColor;
        _operationSectionLabel.textColor = [UIColor colorFromHex:0x333e48];
        _operationSectionLabel.text = @"Operation";
    }
    
    return _operationSectionLabel;
}

- (UILabel *) operationLabel {
    if (!_operationLabel) {
        _operationLabel = [[UILabel alloc] init];
        _operationLabel.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightSemibold];
        _operationLabel.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        _operationLabel.textColor = [UIColor colorFromHex:0x333e48];
        _operationLabel.numberOfLines = 0;
    }
    
    return _operationLabel;
}

@end
