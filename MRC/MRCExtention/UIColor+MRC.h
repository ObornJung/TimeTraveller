//
//  UIColor+MRC.h
//  FastFood
//
//  Created by Oborn.Jung on 12/14/15.
//  Copyright © 2015 WDK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MRC)

+ (UIColor *)mrc_colorWithRGB:(NSUInteger)rgb;

+ (UIColor *)mrc_colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha;

@end
