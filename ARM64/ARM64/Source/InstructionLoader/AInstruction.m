//
//  AInstruction.m
//  ARM64
//
//  Created by evilpenguin on 6/28/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

#import "AInstruction.h"
@import ObjectiveC.runtime;

@implementation AInstruction

#pragma mark - AInstruction

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
