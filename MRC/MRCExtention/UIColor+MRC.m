//
//  UIColor+MRC.m
//  FastFood
//
//  Created by Oborn.Jung on 12/14/15.
//  Copyright © 2015 WDK. All rights reserved.
//

#import "UIColor+MRC.h"

@implementation UIColor (MRC)

+ (UIColor *)mrc_colorWithRGB:(NSUInteger)rgb {
    return [self mrc_colorWithRGB:rgb alpha:1.0f];
}

+ (UIColor *)mrc_colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha {
    NSUInteger r = (rgb >> 16) & 0xFF;
    NSUInteger g = (rgb >> 8 ) & 0xFF;
    NSUInteger b = rgb & 0xFF;
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:alpha];
    
}

@end
