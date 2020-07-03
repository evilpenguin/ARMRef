//
//  ACollectionView.m
//  ARM64
//
//  Created by James Emrich (EvilPenguin) on 6/28/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

#import "ACollectionView.h"
#import "ACollectionViewCell.h"

@implementation ACollectionView

#pragma mark - ACollectionView

- (instancetype) init {
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:UICollectionViewFlowLayout.new]) {
        self.backgroundColor                            = [UIColor colorFromHex:0x333e48];
        self.contentInset                               = UIEdgeInsetsMake(10.0f, 0.0f, 0.0f, 0.0f);
        self.alwaysBounceVertical                       = YES;
        self.translatesAutoresizingMaskIntoConstraints  = NO;
        
        [self registerClass:ACollectionViewCell.class forCellWithReuseIdentifier:ACollectionViewCell.identifier];
    }
    
    return self;
}

@end
