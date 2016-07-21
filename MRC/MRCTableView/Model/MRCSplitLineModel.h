//
//  MRCSplitLineModel.h
//  FastFood
//
//  Created by Oborn.Jung on 16/5/20.
//  Copyright © 2016年 WDK. All rights reserved.
//

#import "MRCModel.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MRCSplitLineStyle) {
    MRCSplitLineStyleLine,
    MRCSplitLineStyleDotLine,
    MRCSplitLineStyleDashLine,
};

@interface MRCSplitLineModel : MRCModel

@property (nonatomic, assign, readonly) MRCSplitLineStyle   style;
@property (nonatomic, assign) CGFloat                       width;
@property (nonatomic, assign) UIEdgeInsets                  insets; ///< 左右边距
@property (nonatomic, strong) UIColor                       * color;

+ (instancetype)splitLineWithStyle:(MRCSplitLineStyle)style;

- (instancetype)initWithStyle:(MRCSplitLineStyle)style;

@end