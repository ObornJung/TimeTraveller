//
//  NSDictionary+MRC.m
//  MRC
//
//  Created by Oborn.Jung on 12/1/15.
//  Copyright © 2015 WDK. All rights reserved.
//

#import "NSDictionary+MRC.h"

@implementation NSDictionary (MRC)

+ (instancetype)mrc_dictionaryWithJsonContentFile:(NSString *)fileName {
    if (fileName.length > 0) {
        NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@""]];
        return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    return nil;
}

- (NSDictionary *)mrc_deepCopy {
    
    NSMutableDictionary * copyDict = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
    
    for(id key in [self allKeys])
    {
        id value = [self objectForKey:key];
        id copyValue;
        if ([value respondsToSelector:@selector(mrc_deepCopy)]) {
            copyValue = [value mrc_deepCopy];
        } else if ([value respondsToSelector:@selector(copyWithZone:)]) {
            copyValue = [value copy];
        }
        if(copyValue==nil) {
            copyValue = value;
        }
        copyDict[key] = copyValue;
    }
    return [copyDict copy];
}

- (NSMutableDictionary *)mrc_mutableDeepCopy
{
    NSMutableDictionary * copyDict = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
    
    for(id key in [self allKeys])
    {
        id value = [self objectForKey:key];
        id copyValue;
        if ([value respondsToSelector:@selector(mrc_mutableDeepCopy)]) {
            copyValue = [value mrc_mutableDeepCopy];
        } else if ([value respondsToSelector:@selector(mutableCopyWithZone:)]) {
            copyValue = [value mutableCopy];
        } else if ([value respondsToSelector:@selector(copyWithZone:)]) {
            copyValue = [value copy];
        }
        if(copyValue==nil) {
            copyValue = value;
        }
        copyDict[key] = copyValue;
    }
    return copyDict;
}

@end
