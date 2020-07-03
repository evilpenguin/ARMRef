//
//  AInstructionLoader.m
//  ARM64
//
//  Created by James Emrich (EvilPenguin) on 6/28/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

#import "AInstructionLoader.h"
#import "AInstruction.h"

NSString *const AInstructionLoaderFinishedNotificaton = @"AInstructionLoaderFinishedNotificaton";

@interface AInstructionLoader ()
@property (nonatomic, strong) NSMutableArray<AInstruction *> *allInstructions;

@end

@implementation AInstructionLoader

- (instancetype) init {
    if (self = [super init]) {
        self.armVersion = @"ARMv8";
        
        [self _load];
    }
    
    return self;
}

#pragma mark - Private

- (void) _load {
    weakify(self);
    dispatch_async_global(^ {
        strongify(self);
        
        NSString *jsonFile = [NSBundle.mainBundle pathForResource:self.armVersion ofType:@"json"];
        if (jsonFile.length) {
            NSData *jsonData = [NSData dataWithContentsOfFile:jsonFile];
            if (jsonData.length) {
                NSArray *instructions = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
                if (instructions.count) {
                    [self _parsedArrayToInstructiions:instructions];
                    
                    // Notify
                    dispatch_async_main(^{
                        [NSNotificationCenter.defaultCenter postNotificationName:AInstructionLoaderFinishedNotificaton object:nil];
                    });
                }
            }
        }
    });
}

#pragma mark - Getter

- (NSArray<AInstruction *> *) instructions {
    if (self.filerString.length) {
        NSIndexSet *indices = [self.allInstructions indexesOfObjectsPassingTest:^BOOL(AInstruction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [obj.mnemonic rangeOfString:self.filerString options:NSCaseInsensitiveSearch].location != NSNotFound;
        }];
        
        return [self.allInstructions objectsAtIndexes:indices];
    }
    
    return self.allInstructions;
}

#pragma mark - Lazy

- (NSMutableArray<AInstruction *> *) allInstructions {
    if (!_allInstructions) _allInstructions = [NSMutableArray array];
    
    return _allInstructions;
}

#pragma mark - Private

- (void) _parsedArrayToInstructiions:(NSArray<NSDictionary *> *)array {
    // Create
    for (NSDictionary *instructionDict in array) {
        AInstruction *instruction = [[AInstruction alloc] init];
        instruction.mnemonic = instructionDict[@"mnemonic"];
        
        instruction.shortDesc = instructionDict[@"short_desc"];
        instruction.fullDesc = instructionDict[@"full_desc"];
        instruction.symbols = instructionDict[@"symbol"];
        instruction.syntax = instructionDict[@"syntax"];
        instruction.decode = instructionDict[@"decode"];
        instruction.operation = instructionDict[@"operation"];
        
        [self.allInstructions addObject:instruction];
    }
    
    // Sort
    [self.allInstructions sortUsingComparator:^NSComparisonResult(AInstruction *obj1, AInstruction *obj2) {
        return [obj1.mnemonic compare:obj2.mnemonic];
    }];
}

@end
