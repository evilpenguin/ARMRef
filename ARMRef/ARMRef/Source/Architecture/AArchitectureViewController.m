//
//  AArchitectureViewController.m
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
