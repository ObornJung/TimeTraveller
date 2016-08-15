//
//  MRCSplitLineModel.h
//  MRC
//
//  Created by Oborn.Jung on 16/5/20.
//  Copyright © 2016年 WDK. All rights reserved.
//  MRC 分割线model

#import "MRCModel.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MRCSplitLineStyle) {
    MRCSplitLineStyleLine,
    MRCSplitLineStyleDotLine,
    MRCSplitLineStyleDashLine,
};

@interface MRCSplitLineModel : MRCModel

@property (nonatomic, assign, readonly) MRCSplitLineStyle   style;  ///< default MRCSplitLineStyleLine
@property (nonatomic, assign) CGFloat                       width;  ///< default 0.5f
@property (nonatomic, assign) UIEdgeInsets                  insets; ///< default: UIEdgeInsetsZero
@property (nonatomic, strong) UIColor                       * color;

+ (instancetype)splitLineWithStyle:(MRCSplitLineStyle)style;

- (instancetype)initWithStyle:(MRCSplitLineStyle)style;

@end