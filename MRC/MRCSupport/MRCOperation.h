//
//  MRCOperation.h
//  MRC
//
//  Created by Oborn.Jung on 16/6/29.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCAction.h"
#import <Foundation/Foundation.h>

@interface MRCOperation : NSObject

@property (nonatomic, strong, readonly) MRCAction   * action;
@property (nonatomic, assign, readonly) BOOL        hasExecuted;

+ (instancetype)operationWithAction:(MRCAction *)action;

- (instancetype)initWithAction:(MRCAction *)action;

/**
 *    hasExecuted=NO，同步执行block，同时hasExecuted=YES；
 *
 *    @param block block
 *
 *    @return self
 */
- (instancetype)execute:(void (^)(MRCAction * action))block;
/**
 *    hasExecuted=NO，mainThread异步调用execute执行block(cancel上次未执行block)
 *
 *    @param block block
 *
 *    @return self
 */
- (instancetype)asyncExecute:(void (^)(MRCAction * action))block;

@end
