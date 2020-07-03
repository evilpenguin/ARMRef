//
//  AInstructionLoader.m
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 EvilPenguin. All rights reserved.
//

#import "AInstructionLoader.h"
#import "AInstruction.h"

@interface AInstructionLoader ()
@property (nonatomic, strong) NSMutableArray<AInstruction *> *allInstructions;

@end

@implementation AInstructionLoader

- (instancetype) init {
    if (self = [super init]) {
        self.armVersion = @"ARMv8";
    }
    
    return self;
}

#pragma mark - Public

- (void) load {
    NSString *jsonFile = [NSBundle.mainBundle pathForResource:self.armVersion ofType:@"json"];
    if (jsonFile.length) {
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonFile];
        if (jsonData.length) {
            NSDictionary *instructionDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            if (instructionDict.count) {
                [self _dictionaryToinstructions:instructionDict];
            }
        }
    }
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

- (void) _dictionaryToinstructions:(NSDictionary *)dictionary {
    // Create
    for (NSString *key in dictionary.allKeys) {
        AInstruction *instruction = [[AInstruction alloc] init];
        instruction.mnemonic = key;
        
        NSDictionary *instructionDict = dictionary[key];
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
