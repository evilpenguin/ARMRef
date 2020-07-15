//
//  ACollectionViewDataHandle.m
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
//  THE SOFTWARE..


#import "ACollectionViewDataHandle.h"
#import "AInstructionLoader.h"
#import "ACollectionViewCell.h"
#import "ACollectionReusableHeaderView.h"

@interface ACollectionViewDataHandle ()

@end

@implementation ACollectionViewDataHandle

#pragma mark - UICollectionViewDataSource

- (nonnull __kindof UICollectionViewCell *) collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ACollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ACollectionViewCell.identifier forIndexPath:indexPath];

    return cell;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.instructions.count;
}

- (NSInteger) collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *key = safetyObjectAtIndex(self.instructions.allKeys, section);
    
    return [self.instructions[key] count];
}

#pragma mark - UICollectionViewDelegate

- (void) collectionView:(UICollectionView *)collectionView willDisplayCell:(ACollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.instruction = [self.instructions instructionAtIndexPath:indexPath];
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AInstruction *instruction = [self.instructions instructionAtIndexPath:indexPath];
    [self.handleTouch collectioinViewHandle:self didTouchInstruction:instruction];
}

- (void) collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorFromHex:0xadb1b5];
}

- (void) collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.whiteColor;
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        ACollectionReusableHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                       withReuseIdentifier:ACollectionReusableHeaderView.identifier
                                                                                              forIndexPath:indexPath];
        headerView.label.text = [safetyObjectAtIndex(self.instructions.allKeys, indexPath.section) uppercaseString];

        return headerView;
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    AInstruction *instruction = [self.instructions instructionAtIndexPath:indexPath];
    CGFloat maxSize = [ACollectionViewCell heightForInstruction:instruction
                                                      withWidth:collectionView.bounds.size.width - 40.0f];

    return CGSizeMake(collectionView.bounds.size.width - 20.0f, maxSize);
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(collectionView.bounds.size.width, 40.0f);
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0f;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

@end
