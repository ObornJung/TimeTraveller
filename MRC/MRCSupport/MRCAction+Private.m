//
//  MRCAction+Private.m
//  FastFood
//
//  Created by Oborn.Jung on 16/6/30.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCAction+Private.h"

static NSString * const kMRCActionTempleteKey = @"MRCActionTemplete";

@implementation MRCAction (Private)

+ (void)setActionTemplete:(MRCAction *)action {
    [NSThread currentThread].threadDictionary[kMRCActionTempleteKey] = action;
}

+ (MRCAction *)actionTemplete {
    return [NSThread currentThread].threadDictionary[kMRCActionTempleteKey];
}

@end
