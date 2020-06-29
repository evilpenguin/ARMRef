//
//  ACollectionView.m
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import "ACollectionView.h"
#import "ACollectionViewCell.h"

@implementation ACollectionView

#pragma mark - ACollectionView

- (instancetype) init {
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:UICollectionViewFlowLayout.new]) {
        self.backgroundColor = UIColor.blackColor;
        self.contentInset = UIEdgeInsetsZero;
        self.alwaysBounceVertical = YES;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self registerClass:ACollectionViewCell.class forCellWithReuseIdentifier:ACollectionViewCell.identifier];
    }
    
    return self;
}

@end
