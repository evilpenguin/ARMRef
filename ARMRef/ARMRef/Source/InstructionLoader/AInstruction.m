//
//  AInstruction.m
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


#import "AInstruction.h"
@import ObjectiveC.runtime;

@implementation AInstruction

#pragma mark - AInstruction

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.mnemonic = dictionary[@"mnemonic"];
        self.shortDesc = dictionary[@"short_desc"];
        self.fullDesc = dictionary[@"full_desc"];
        self.symbols = dictionary[@"symbols"];
        self.syntax = dictionary[@"syntax"];
        self.decode = dictionary[@"decode"];
        self.operation = dictionary[@"operation"];
    }
    
    return self;;
}

- (NSString *) description {
    NSMutableString *desc = super.description.mutableCopy;

    uint32_t propertyCount;
    objc_property_t *properties = class_copyPropertyList(self.class, &propertyCount);
    
    for (NSInteger i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        [desc appendFormat:@"%@: %@;\n", propName, [self valueForKey:propName]];
    }
    
    return desc.copy;
}

#pragma mark - Setters

- (void) setDecode:(NSString *)decode {
    _decode = decode;
    
    _decode = [_decode stringByReplacingOccurrencesOfString:@"; " withString:@";"];
    _decode = [_decode stringByReplacingOccurrencesOfString:@";" withString:@";\n"];
    _decode = [_decode stringByReplacingCharactersInRange:NSMakeRange(_decode.length - 1, 1) withString:@""];
}

- (void) setOperation:(NSString *)operation {
    _operation = operation;
    
    _operation = [_operation stringByReplacingOccurrencesOfString:@"; " withString:@";"];
    _operation = [_operation stringByReplacingOccurrencesOfString:@";" withString:@";\n"];
    _operation = [_operation stringByReplacingCharactersInRange:NSMakeRange(_operation.length - 1, 1) withString:@""];
}

@end
