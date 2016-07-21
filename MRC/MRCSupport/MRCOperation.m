//
//  MRCOperation.m
//  FastFood
//
//  Created by Oborn.Jung on 16/6/29.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCOperation.h"
#import <libkern/OSAtomic.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MRCOperation () {
    @private volatile int32_t _hasExecuted;
}

@property (nonatomic, strong) RACDisposable * exeDisposable;
@property (nonatomic, copy) void (^doNext)(MRCAction * action);
@property (nonatomic, copy) void (^didNext)(MRCAction * action);

@end

@implementation MRCOperation
@dynamic hasExecuted;

+ (instancetype)operationWithAction:(MRCAction *)action {
    return [[[self class] alloc] initWithAction:action];
}

- (instancetype)initWithAction:(MRCAction *)action {
    if ([super init]) {
        _action = action;
        _hasExecuted = 0;
    }
    return self;
}

- (BOOL)hasExecuted {
    return OSAtomicCompareAndSwap32(1, 1, &_hasExecuted);
}

- (instancetype)execute:(void (^)(MRCAction * action))block {
    if (OSAtomicCompareAndSwap32(0, 1, &_hasExecuted)) {
        self.doNext ? self.doNext(self.action) : nil;
        block ? block(self.action) : nil;
        self.didNext ? self.didNext(self.action) : nil;
    }
    return self;
}

- (instancetype)asyncExecute:(void (^)(MRCAction * action))block {
    if (block && !self.hasExecuted) {
        [self.exeDisposable dispose];
        self.exeDisposable = [[RACScheduler mainThreadScheduler] schedule:^{
            [self execute:block];
        }];
    }
    return self;
}

@end
