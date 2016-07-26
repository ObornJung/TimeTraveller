//
//  NSError+MRC.m
//  MRC
//
//  Created by Oborn.Jung on 16/7/2.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "NSError+MRC.h"

@implementation NSError (MRC)

+ (nullable instancetype)mrc_errorWithDomain:(nullable NSString *)errorStr {
    return errorStr ? [NSError errorWithDomain:errorStr code:0 userInfo:nil] : nil;
}

@end
