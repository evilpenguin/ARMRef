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
#import "AWebViewController.h"

@interface AMainViewController () <ACollectionViewDataHandleTouch>
@property (nonatomic, weak) AInstructionLoader *loader;
@property (nonatomic, strong) ACollectionView *collectionView;
@property (nonatomic, strong) ACollectionViewDataHandle *collectionViewDataHandle;


@end

@implementation AMainViewController

#pragma mark - AMainViewController

- (instancetype) initWithLoader:(AInstructionLoader *)loader {
    if (self = [super init]) {
        self.loader = loader;
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Self
    self.view.backgroundColor = UIColor.blackColor;
    
    // Collection View
    [self.view addSubview:self.collectionView];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // Collection view
    self.collectionView.frame = self.view.bounds;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
}

#pragma mark - Lazy

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

#pragma mark - ACollectionViewDataHandleTouch

- (void) collectioinViewHandle:(ACollectionViewDataHandle *)handle didTouchInstruction:(AInstruction *)instruction {
    AWebViewController *webViewController = [[AWebViewController alloc] init];
    [webViewController loadHTMLString:instruction.html];
    
    [self presentViewController:webViewController animated:YES completion:nil];
}

@end

