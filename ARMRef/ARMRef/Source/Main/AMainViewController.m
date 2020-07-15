//
//  ViewController.m
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


#import "AMainViewController.h"
#import "AInstructionLoader.h"
#import "ACollectionView.h"
#import "ACollectionViewDataHandle.h"
#import "AInstructionViewController.h"
#import "AArchitectureViewController.h"

@interface AMainViewController () <UISearchBarDelegate, ACollectionViewDelegatesTouchHandle>
@property (nonatomic, weak) AInstructionLoader *loader;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UILabel *noDataLabel;
@property (nonatomic, strong) ACollectionView *collectionView;
@property (nonatomic, strong) ACollectionViewDataHandle *collectionViewDataHandle;

@end

@implementation AMainViewController

#pragma mark - AMainViewController

- (instancetype) initWithLoader:(AInstructionLoader *)loader {
    if (self = [super init]) {
        self.loader                             = loader;
        self.navigationItem.leftBarButtonItem   = [[UIBarButtonItem alloc] initWithTitle:@"Arch" style:UIBarButtonItemStylePlain target:self action:@selector(_changeArch:)];

        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(_loaderNotification:)
                                                   name:AInstructionLoaderFinishedNotificaton
                                                 object:nil];
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Self
    self.view.backgroundColor = [UIColor colorFromHex:0x333e48];
    
    // Serach
    [self.view addSubview:self.searchBar];
    
    // No data
    [self.view addSubview:self.noDataLabel];
    
    // Collection View
    [self.view addSubview:self.collectionView];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // Points
    CGFloat leftRightInset = self.view.safeAreaInsets.left + self.view.safeAreaInsets.right;
    
    // Search
    self.searchBar.frame = CGRectMake(0.0f, self.view.safeAreaInsets.top, self.view.bounds.size.width, 45.0f);
    
    // No Data
    self.noDataLabel.frame = self.view.bounds;
    
    // Collection view
    CGRect collectionViewFrame = CGRectMake(self.view.safeAreaInsets.left,
                                            CGRectGetMaxY(self.searchBar.frame),
                                            self.view.bounds.size.width - leftRightInset,
                                            self.view.bounds.size.height - (CGRectGetMaxY(self.searchBar.frame) + 5.0f));

    self.collectionView.frame = collectionViewFrame;
    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - Private

- (void) _changeArch:(UIBarButtonItem *)item {
    AArchitectureViewController *viewController = [[AArchitectureViewController alloc] initWithLoader:self.loader];
    
    weakify(self);
    viewController.pickCompletion = ^(NSString *arch) {
        strongify(self);
        
        [self _showNoDataStyle:YES];
    };
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void) _loaderNotification:(NSNotification *)notification {
    self.title = self.loader.architecture;
    [self _updateDataAndLoaderWithString:nil];
}

- (void) _updateDataAndLoaderWithString:(NSString *)string {
    self.loader.filerString = string;
    
    self.collectionViewDataHandle.instructions = self.loader.instructions;
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointZero animated:NO];
    
    [self _showNoDataStyle:!self.collectionViewDataHandle.instructions.count];
}

- (void) _showNoDataStyle:(BOOL)show {
    self.title = (show ? nil : self.loader.architecture);
    self.noDataLabel.alpha = (show ? 1.0f : 0.0f);
    self.collectionView.alpha = (show ? 0.0f : 1.0f);
}

#pragma mark - Lazy

- (UISearchBar *) searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.backgroundColor = [UIColor colorFromHex:0x424C54];
        _searchBar.backgroundImage = UIImage.new;
        _searchBar.backgroundImage = UIImage.new;
        _searchBar.tintColor = UIColor.whiteColor;
        _searchBar.barTintColor = UIColor.whiteColor;
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = YES;
        _searchBar.searchTextField.backgroundColor = UIColor.whiteColor;
        _searchBar.searchTextField.tintColor = _searchBar.backgroundColor;
        _searchBar.searchTextField.textColor = _searchBar.backgroundColor;
        _searchBar.searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchBar.searchTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    
    return _searchBar;
}

- (UILabel *) noDataLabel {
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc] init];
        _noDataLabel.font = [UIFont systemFontOfSize:25.0f weight:UIFontWeightMedium];
        _noDataLabel.backgroundColor = UIColor.clearColor;
        _noDataLabel.textColor = UIColor.whiteColor;
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
        _noDataLabel.text = @"No Data...";
    }
    
    return _noDataLabel;
}

- (ACollectionView *) collectionView {
    if (!_collectionView) {
        _collectionView = [[ACollectionView alloc] init];
        _collectionView.dataSource = self.collectionViewDataHandle;
        _collectionView.delegate = self.collectionViewDataHandle;
        _collectionView.alpha = 0.0f;
    }
    
    return _collectionView;
}

- (ACollectionViewDataHandle *) collectionViewDataHandle {
    if (!_collectionViewDataHandle) {
        _collectionViewDataHandle = [[ACollectionViewDataHandle alloc] init];
        _collectionViewDataHandle.handleTouch = self;
    }
    
    return _collectionViewDataHandle;
}

#pragma mark - UISearchBarDelegate

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self _updateDataAndLoaderWithString:searchText];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    
    [self _updateDataAndLoaderWithString:nil];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - ACollectionViewDelegatesTouchHandle

- (void) collectioinViewHandle:(ACollectionViewDataHandle *)handle didTouchInstruction:(AInstruction *)instruction {
    AInstructionViewController *instructionViewController = [[AInstructionViewController alloc] init];
    instructionViewController.instruction = instruction;
    
    [self.navigationController pushViewController:instructionViewController animated:YES];
}

@end

