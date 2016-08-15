//
//  MRCWebCommand.m
//  MRC
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCDefines.h"
#import "MRCWebCommand.h"
#import <libkern/OSAtomic.h>

@interface MRCWebCommand () {
    @private volatile BOOL  _showIndicator;
}

@property (nonatomic, assign) BOOL   showIndicator;

@end

@implementation MRCWebCommand
@synthesize showIndicator = _showIndicator;

- (RACSignal *)loadingIndicator {
    @weakify(self);
    return [[[super executing] filter:^BOOL(NSNumber * executing) {
        @strongify(self);
        if (executing.boolValue) {
            return self.showIndicator;
        }
        return YES;
    }] distinctUntilChanged];
}

- (RACSignal *)errorIndicator {
    @weakify(self);
    return [[super errors] filter:^BOOL(NSError * error) {
        @strongify(self);
        return self.showIndicator;
    }];
}

- (RACSignal *)execute:(id)input {
    return [self execute:input indicator:YES];
}

- (RACSignal *)execute:(id)input indicator:(BOOL)show {
    self.showIndicator = show;
    return [super execute:input];
}

- (void)setShowIndicator:(BOOL)showIndicator {
    if (showIndicator) {
        OSAtomicTestAndSet(7, &_showIndicator);
    } else {
        OSAtomicTestAndClear(7, &_showIndicator);
    }
}

@end
