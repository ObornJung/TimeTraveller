//
//  NSArray+MRC.m
//  MRC
//
//  Created by Oborn.Jung on 12/2/15.
//  Copyright © 2015 WDK. All rights reserved.
//

#import "NSArray+MRC.h"

@implementation NSArray (MRC)

- (NSArray *)mrc_deepCopy {
    
    NSMutableArray * copyArray = [self mutableCopy];
    [self enumerateObjectsUsingBlock:^(id value, NSUInteger idx, BOOL * stop) {
        id copyValue = nil;
        if ([value respondsToSelector:@selector(mrc_deepCopy)]) {
            copyArray[idx] = [value mrc_deepCopy];
        } else if ([value respondsToSelector:@selector(copyWithZone:)]) {
            copyArray[idx] = [value copy];
        }
        if(copyValue!=nil) {
            copyArray[idx] = copyValue;
        }
    }];
    return [copyArray copy];
}

- (NSMutableArray *)mrc_mutableDeepCopy
{
    NSMutableArray * copyArray = [self mutableCopy];
    [self enumerateObjectsUsingBlock:^(id value, NSUInteger idx, BOOL * stop) {
        id copyValue;
        if ([value respondsToSelector:@selector(mrc_mutableDeepCopy)]) {
            copyValue = [value mrc_mutableDeepCopy];
        } else if ([value respondsToSelector:@selector(mutableCopyWithZone:)]) {
            copyValue = [value mutableCopy];
        } else if ([value respondsToSelector:@selector(copyWithZone:)]) {
            copyValue = [value copy];
        }
        if(copyValue!=nil) {
            copyArray[idx] = copyValue;
        }
    }];
    return copyArray;
}

@end
