//
//  MRCAction+Private.h
//  FastFood
//
//  Created by Oborn.Jung on 16/6/30.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCAction.h"

@interface MRCAction (Private)

/**
 *    目前只对MRCViewModel+Engine开放(线程安全)
 */
+ (void)setActionTemplete:(MRCAction *)action;

+ (MRCAction *)actionTemplete;

@end
