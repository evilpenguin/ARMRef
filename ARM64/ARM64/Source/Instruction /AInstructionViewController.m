//
//  AInstructionViewController.m
//  ARM64
//
//  Created by evilpenguin on 7/3/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import "AInstructionViewController.h"
#import "AInstructionView.h"
#import "AInstruction.h"

@interface AInstructionViewController ()

@end

@implementation AInstructionViewController

#pragma mark - AInstructionViewController

- (instancetype) init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationPageSheet;
    }
    
    return self;
}

- (void) loadView {
    self.view = [[AInstructionView alloc] init];
}

#pragma mark - Setters

- (void) setInstruction:(AInstruction *)instruction {
    _instruction = instruction;
    
    self.title = instruction.mnemonic;
    ((AInstructionView *)self.view).instruction = instruction;
}

@end
