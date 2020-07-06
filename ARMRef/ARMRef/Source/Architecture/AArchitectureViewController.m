//
//  AArchitectureViewController.m
//  ARMRef
//
//  Created by evilpenguin on 7/5/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import "AArchitectureViewController.h"

@interface AArchitectureViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) AInstructionLoader *loader;

@end

@implementation AArchitectureViewController

#pragma mark - AArchitectureViewController

- (instancetype) initWithLoader:(AInstructionLoader *)loader {
    if (self = [super initWithStyle:UITableViewStyleInsetGrouped]) {
        self.title = @"Architecture";
        self.loader = loader;
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Self
    self.view.backgroundColor = [UIColor colorFromHex:0x333e48];
    
    // Table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(10.0f, 0.0f, 0.0f, 0.0f);
    self.tableView.separatorColor = [UIColor colorFromHex:0x333e48];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *arch = AInstructionLoader.supportedArchitecture[indexPath.row];
    cell.textLabel.text = arch;
    
    if ([self.loader.architecture isEqualToString:arch]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *arch = AInstructionLoader.supportedArchitecture[indexPath.row];
    
    if (![self.loader.architecture isEqualToString:arch]) {
        BlockSafetyCallWithArgs(self.pickCompletion, arch);
        [self.loader loadArchitecture:arch];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return AInstructionLoader.supportedArchitecture.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.whiteColor;
    cell.tintColor = self.view.backgroundColor;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightBold];
    cell.textLabel.textColor = UIColor.blackColor;
    
    return cell;
}

@end
