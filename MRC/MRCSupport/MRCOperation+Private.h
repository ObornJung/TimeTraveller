//
//  MRCOperation+Private.h
//  FastFood
//
//  Created by Oborn.Jung on 16/7/2.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCOperation.h"

@interface MRCOperation (Private)

/**
 *    目前只对MRCViewModel+Engine开放
 */
@property (nonatomic, copy) void (^doNext)(MRCAction * action);
@property (nonatomic, copy) void (^didNext)(MRCAction * action);

@end
