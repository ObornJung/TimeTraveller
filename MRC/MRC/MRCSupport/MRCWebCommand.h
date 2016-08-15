//
//  MRCWebCommand.h
//  MRC
//
//  Created by Oborn.Jung on 16/7/1.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MRCWebCommand : RACCommand

@property (nonatomic, strong, readonly) RACSignal   * loadingIndicator;
@property (nonatomic, strong, readonly) RACSignal   * errorIndicator;

- (RACSignal *)execute:(id)input indicator:(BOOL)show;

@end
