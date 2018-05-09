//
//  UIColor+LGFGradient.m
//  LGFOCTool
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIColor+LGFGradient.h"

@implementation UIColor (LGFGradient)

#pragma mark -  上下 竖渐变
/**
 @param fromColor 渐变 开始色
 @param toColor 渐变 结束色
 @param height 渐变高度
 @return 渐变后的颜色
 */
+ (UIColor *)lgf_GradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor height:(int)height {
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    NSArray* colors = [NSArray arrayWithObjects:(id)fromColor.CGColor, (id)toColor.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}

#pragma mark -  左右 横渐变
/**
 @param fromColor 渐变 开始色
 @param toColor 渐变 结束色
 @param width 渐变 宽度
 @return 渐变后的颜色
 */
+ (UIColor *)lgf_GradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor width:(int)width {
    CGSize size = CGSizeMake(width, 1);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    NSArray* colors = [NSArray arrayWithObjects:(id)fromColor.CGColor, (id)toColor.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(size.width, 1), 0);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}

@end
