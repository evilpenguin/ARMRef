//
//  AInstructionLoader.m
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


#import "AInstructionLoader.h"
#import "AInstruction.h"

NSString *const AInstructionLoaderFinishedNotificaton = @"AInstructionLoaderFinishedNotificaton";

@interface AInstructionLoader ()
@property (nonatomic, strong) NSString *architecture;
@property (nonatomic, strong) AInstructions<NSString *, NSMutableArray *> *_instructions;

@end

@implementation AInstructionLoader

- (instancetype) init {
    if (self = [super init]) {
        // Load 64bit first :)
        [self loadArchitecture:AInstructionLoader.supportedArchitecture.firstObject];
    }
    
    return self;
}

#pragma mark - Public

- (void) loadArchitecture:(NSString *)architecture {
    if (architecture.length) {
        self.architecture = architecture;
        
        [self _load];
    }
}

#pragma mark - Public class

+ (NSArray<NSString *> *) supportedArchitecture {
    static dispatch_once_t onceToken;
    static NSArray *versions;
    
    dispatch_once(&onceToken, ^{
        versions = @[
            @"ARMv8.6a",
            @"ARMv8.6a (32-bit)"
        ];
    });
    
    return versions;
}

#pragma mark - Private

- (void) _load {
    weakify(self);
    dispatch_async_global(^ {
        strongify(self);
        
        NSString *jsonFile = [NSBundle.mainBundle pathForResource:self.architecture ofType:@"json"];
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

- (AInstructions<NSString *, NSMutableArray *> *) instructions {
    if (self.filerString.length) {
        NSString *firstChar = self.filerString.firstCharacter;
        NSArray *instructions = self._instructions[firstChar];
        
        weakify(self);
        NSIndexSet *indices = [instructions indexesOfObjectsPassingTest:^BOOL(AInstruction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            strongify(self);
            return [obj.mnemonic rangeOfString:self.filerString options:NSCaseInsensitiveSearch].location != NSNotFound;
        }];
        
        return [AInstructions dictionaryWithDictionary:@{firstChar: [instructions objectsAtIndexes:indices]}];
    }
    
    return self._instructions;
}

#pragma mark - Lazy

- (AInstructions *) _instructions {
    if (!__instructions) {
        __instructions = [[AInstructions alloc] init];
    }
    
    return __instructions;
}

#pragma mark - Private

- (void) _parsedArrayToInstructiions:(NSArray<NSDictionary *> *)array {
    // Clear
    [self._instructions removeAllObjects];
    
    // Create
    for (NSDictionary *instructionDict in array) {
        AInstruction *instruction = [[AInstruction alloc] initWithDictionary:instructionDict];
        
        NSString *section = instruction.mnemonic.firstCharacter;
        if (section) {
            [self._instructions[section] addObject:instruction];
        }
    }
    
    // Sort
    [self._instructions sort];
}

@end
