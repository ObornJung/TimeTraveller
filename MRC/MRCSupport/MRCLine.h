//
//  MRCLine.h
//  MRC
//
//  Created by Oborn.Jung on 15/10/27.
//  Copyright © 2015年 WDK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MRCLineType) {
    MRCLineTypeLine = 0,
    MRCLineTypeDash,
    MRCLineTypeDot,
};

@interface MRCLine : UIView

@property (nonatomic, assign) MRCLineType   type;
@property (nonatomic, assign) CGFloat       width;
@property (nonatomic, strong) UIColor       * color;

+ (instancetype)lineWithType:(MRCLineType)type
                       color:(UIColor *)color
                       width:(CGFloat)width;

- (instancetype)initWithType:(MRCLineType)type
                       color:(UIColor *)color
                       width:(CGFloat)width;

@end
