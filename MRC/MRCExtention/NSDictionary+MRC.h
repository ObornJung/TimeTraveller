//
//  NSDictionary+MRC.h
//  FastFood
//
//  Created by Oborn.Jung on 12/1/15.
//  Copyright © 2015 WDK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MRC)
/**
 *  从json文件中实例化一个dictionary
 *
 *  @param fileName 文件名
 *
 *  @return 实例化的dictionary
 */
+ (instancetype)mrc_dictionaryWithJsonContentFile:(NSString *)fileName;

- (NSDictionary *)mrc_deepCopy;

- (NSMutableDictionary *)mrc_mutableDeepCopy;

@end
