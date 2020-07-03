//
//  ViewController.m
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import "AMainViewController.h"
#import "AInstructionLoader.h"
#import "ACollectionView.h"
#import "ACollectionViewDataHandle.h"
#import "AInstructionViewController.h"
#import "UIColor+A.h"

@interface AMainViewController () <UISearchBarDelegate, ACollectionViewDelegatesTouchHandle>
@property (nonatomic, weak) AInstructionLoader *loader;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) ACollectionView *collectionView;
@property (nonatomic, strong) ACollectionViewDataHandle *collectionViewDataHandle;

@end

@implementation AMainViewController

#pragma mark - AMainViewController

- (instancetype) initWithLoader:(AInstructionLoader *)loader {
    if (self = [super init]) {
        self.title  = loader.armVersion;
        self.loader = loader;
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Self
    self.view.backgroundColor = [UIColor colorFromHex:0x333e48];
    
    // Serach
    [self.view addSubview:self.searchBar];
    
    // Collection View
    [self.view addSubview:self.collectionView];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // Search
    self.searchBar.frame = CGRectMake(self.view.safeAreaInsets.left, self.view.safeAreaInsets.top, self.view.bounds.size.width, 45.0f);
    
    // Collection view
    CGFloat colletionViewHeight = self.view.bounds.size.height - (CGRectGetMaxY(self.searchBar.frame) + 5.0f);
    self.collectionView.frame = CGRectMake(self.view.safeAreaInsets.left, CGRectGetMaxY(self.searchBar.frame) + 5.0f, self.view.bounds.size.width, colletionViewHeight);
    [self.collectionView reloadData];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.collectionView reloadData];
}

#pragma mark - Lazy

- (UISearchBar *) searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.backgroundColor = [UIColor colorFromHex:0x424C54];
        _searchBar.backgroundImage = UIImage.new;
        _searchBar.backgroundImage = UIImage.new;
        _searchBar.tintColor = UIColor.whiteColor;
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = YES;
        _searchBar.searchTextField.backgroundColor = UIColor.whiteColor;
        _searchBar.searchTextField.tintColor = _searchBar.backgroundColor;
    }
    
    return _searchBar;
}

- (ACollectionView *) collectionView {
    if (!_collectionView) {
        _collectionView = [[ACollectionView alloc] init];
        _collectionView.dataSource = self.collectionViewDataHandle;
        _collectionView.delegate = self.collectionViewDataHandle;
    }
    
    return _collectionView;
}

- (ACollectionViewDataHandle *) collectionViewDataHandle {
    if (!_collectionViewDataHandle) {
        _collectionViewDataHandle = [[ACollectionViewDataHandle alloc] initWithLoader:self.loader];
        _collectionViewDataHandle.handleTouch = self;
    }
    
    return _collectionViewDataHandle;
}

#pragma mark - UISearchBarDelegate

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.loader.filerString = searchText;
    [self.collectionView reloadData];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.loader.filerString = nil;
    [self.collectionView reloadData];
    
    searchBar.text = nil;
    [searchBar resignFirstResponder];
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

