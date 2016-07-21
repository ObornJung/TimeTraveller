//
//  MRCSplitLineModel.m
//  FastFood
//
//  Created by Oborn.Jung on 16/5/20.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCTableCommonTag.h"
#import "MRCSplitLineModel.h"

@implementation MRCSplitLineModel

+ (instancetype)splitLineWithStyle:(MRCSplitLineStyle)style {
    return [[MRCSplitLineModel alloc] initWithStyle:style];
}

- (instancetype)initWithStyle:(MRCSplitLineStyle)style {
    self = [super self];
    if (self) {
        self.tag = kMRCSplitLineTag;
        _style = style;
        _width = 0.5f;
        _insets = UIEdgeInsetsZero;
        _color = [UIColor grayColor];
    }
    return self;
}

@end
