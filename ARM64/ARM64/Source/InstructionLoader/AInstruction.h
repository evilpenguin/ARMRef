//
//  AInstruction.h
//  ARM64
//
//  Created by James Emrich (EvilPenguin) on 6/28/20.
//  Copyright © 2020 James Emrich (EvilPenguin). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AInstruction : NSObject
@property (nonatomic, strong) NSString *mnemonic;
@property (nonatomic, strong) NSString *shortDesc;
@property (nonatomic, strong) NSString *fullDesc;
@property (nonatomic, strong) NSArray<NSString *> *syntax;
@property (nonatomic, strong) NSArray<NSString *> *symbols;
@property (nonatomic, strong) NSString *decode;
@property (nonatomic, strong) NSString *operation;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
