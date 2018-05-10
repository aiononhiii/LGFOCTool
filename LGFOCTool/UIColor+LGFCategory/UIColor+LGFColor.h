//
//  UIColor+LGFColor.h
//  LGFOCTool
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LGFColor)

#pragma mark - Hex颜色 For UInt32
+ (UIColor *)lgf_ColorWithHex:(UInt32)hex;
+ (UIColor *)lgf_ColorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

#pragma mark - Hex颜色 For NSString
+ (UIColor *)lgf_ColorWithHexString:(NSString *)hexString;
+ (UIColor *)lgf_ColorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

#pragma mark - 当前颜色的Hex结果 For NSString
/**
 @return Hex 字符串 @"#RRGGBB"
 */
- (NSString *)lgf_HexString;

@end
