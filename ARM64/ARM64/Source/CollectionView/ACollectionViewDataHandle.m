//
//  ACollectionViewDataHandle.m
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import "ACollectionViewDataHandle.h"
#import "AInstructionLoader.h"
#import "ACollectionViewCell.h"

@interface ACollectionViewDataHandle ()
@property (nonatomic, weak) AInstructionLoader *loader;

@end

@implementation ACollectionViewDataHandle

#pragma mark - ACollectionViewDataHandle

- (instancetype) initWithLoader:(AInstructionLoader *)loader {
    if (self = [super init]) {
        self.loader = loader;
    }
    
    return self;
}
#pragma mark - UICollectionViewDataSource

- (nonnull __kindof UICollectionViewCell *) collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ACollectionViewCell.identifier forIndexPath:indexPath];
    cell.instruction = self.loader.instructions[indexPath.row];

    return cell;
}

- (NSInteger) collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.loader.instructions.count;
}

#pragma mark - UICollectionViewDelegate

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.handleTouch collectioinViewHandle:self didTouchInstruction:self.loader.instructions[indexPath.row]];
}

- (void) collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.redColor;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.whiteColor;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ACollectionViewCell.identifier forIndexPath:indexPath];
    cell.instruction = self.loader.instructions[indexPath.row];
    
    CGFloat maxSize = [cell maxSizeForInstruction:self.loader.instructions[indexPath.row] withWidth:collectionView.bounds.size.width];
    
    return CGSizeMake(collectionView.bounds.size.width, maxSize);
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0f;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

@end
