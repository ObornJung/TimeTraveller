//
//  NSError+MRC.h
//  FastFood
//
//  Created by Oborn.Jung on 16/7/2.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (MRC)

+ (nullable instancetype)mrc_errorWithDomain:(nullable NSString *)errorStr;

@end
