//
//  ACollectionView.m
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


#import "ACollectionView.h"
#import "ACollectionViewCell.h"
#import "ACollectionReusableHeaderView.h"

@implementation ACollectionView

#pragma mark - ACollectionView

- (instancetype) init {
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:ACollectionView._layout]) {
        self.backgroundColor                            = [UIColor colorFromHex:0x333e48];
        self.scrollIndicatorInsets                      = UIEdgeInsetsMake(self.contentInset.top + 40.0f, self.contentInset.left, self.contentInset.bottom, self.contentInset.right);
        self.alwaysBounceVertical                       = YES;
        self.translatesAutoresizingMaskIntoConstraints  = NO;
        
        [self registerClass:ACollectionViewCell.class forCellWithReuseIdentifier:ACollectionViewCell.identifier];
        [self registerClass:ACollectionReusableHeaderView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ACollectionReusableHeaderView.identifier];
        
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(_keyboardWillChangeFrameNotification:)
                                                   name:UIKeyboardWillChangeFrameNotification
                                                 object:nil];
    }
    
    return self;
}

#pragma mark - Private

+ (UICollectionViewFlowLayout *) _layout {
    UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInsetReference = UICollectionViewFlowLayoutSectionInsetFromContentInset;
    layout.sectionHeadersPinToVisibleBounds = YES;
    
    return layout;
}

- (void) _keyboardWillChangeFrameNotification:(NSNotification *)notification {
    CGRect endKeyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat bottomInset = (endKeyboardFrame.origin.y > self.bounds.size.height ? 10.0f : endKeyboardFrame.size.height + 10.0f);
    self.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, bottomInset, 0.0f);
    self.scrollIndicatorInsets = UIEdgeInsetsMake(self.contentInset.top + 40.0f, self.contentInset.left, self.contentInset.bottom, self.contentInset.right);
}

@end
