//
//  FFMRCDescModel.m
//  FastFood
//
//  Created by Oborn.Jung on 16/5/20.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCDescModel.h"
#import "MRCTableCommonTag.h"

@implementation MRCDescModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tag = kMRCDescModelTag;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title describe:(NSString *)describe {
    self = [self init];
    if (self) {
        _title = [title copy];
        _describe = [describe copy];
    }
    return self;
}

@end
