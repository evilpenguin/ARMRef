//
//  AInstructions.m
//  ARMRef
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

#import "AInstructions.h"

@interface AInstructions()
@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, strong) NSMutableDictionary *dict;

@end

@implementation AInstructions

#pragma mark - AInstructions

+ (instancetype) dictionaryWithDictionary:(NSDictionary *)dict {
    AInstructions *instructions = [[AInstructions alloc] init];
    [instructions.dict addEntriesFromDictionary:dict];
    [instructions.keys addObjectsFromArray:dict.allKeys];
    
    return instructions;
}

- (NSString *) description {
    return self.dict.description;
}

- (NSUInteger) count {
    return self.keys.count;
}

- (NSEnumerator *) keyEnumerator {
    return self.keys.objectEnumerator;
}

- (void) removeAllObjects {
    [self.dict removeAllObjects];
}

- (void) removeObjectForKey:(id)aKey {
    [self.dict removeObjectForKey:aKey];
}

- (id) objectForKey:(id)key {
    return [self objectForKeyedSubscript:key];
}

- (id) objectForKeyedSubscript:(id)key {
    // Check for array
    id object = [self.dict objectForKeyedSubscript:key];
    if (!object) {
        object = [NSMutableArray array];
        
        // Add Array
        self.dict[key] = object;
        
        // Keys
        [self.keys addObject:key];
        [self.keys sortUsingSelector:@selector(compare:)];
    }
    
    return object;
}

#pragma mark - Public

- (AInstruction *__nullable) instructionAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = safetyObjectAtIndex(self.allKeys, indexPath.section);
    
    return safetyObjectAtIndex(self[key], indexPath.row);
}

#pragma mark - Lazy

- (NSMutableArray *) keys {
    if (!_keys) {
        _keys = [NSMutableArray array];
    }
    
    return _keys;
}

- (NSMutableDictionary *) dict {
    if (!_dict) {
        _dict = [NSMutableDictionary dictionary];
    }
    
    return _dict;
}

@end
