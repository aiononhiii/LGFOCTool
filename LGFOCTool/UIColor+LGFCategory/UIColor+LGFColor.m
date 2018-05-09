//
//  UIColor+LGFColor.m
//  LGFOCTool
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIColor+LGFColor.h"

CGFloat lgf_ColorComponentFrom(NSString *string, NSUInteger start, NSUInteger length) {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@implementation UIColor (LGFColor)

#pragma mark - Hex颜色 For UInt32
+ (UIColor *)lgf_ColorWithHex:(UInt32)hex {
    return [UIColor lgf_ColorWithHex:hex alpha:1.0];
}
+ (UIColor *)lgf_ColorWithHex:(UInt32)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((hex >> 16) & 0xFF)/255.0
                           green:((hex >> 8) & 0xFF)/255.0
                            blue:(hex & 0xFF)/255.0
                           alpha:alpha];
}

#pragma mark - Hex颜色 For NSString
+ (UIColor *)lgf_ColorWithHexString:(NSString *)hexString {
    return [UIColor lgf_ColorWithHexString:hexString alpha:1.0];
}
+ (UIColor *)lgf_ColorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    CGFloat red, blue, green;
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    switch ([colorString length]) {
        case 3: // #RGB
            red   = lgf_ColorComponentFrom(colorString, 0, 1);
            green = lgf_ColorComponentFrom(colorString, 1, 1);
            blue  = lgf_ColorComponentFrom(colorString, 2, 1);
            break;
        case 4: // #ARGB
            red   = lgf_ColorComponentFrom(colorString, 1, 1);
            green = lgf_ColorComponentFrom(colorString, 2, 1);
            blue  = lgf_ColorComponentFrom(colorString, 3, 1);
            break;
        case 6: // #RRGGBB
            red   = lgf_ColorComponentFrom(colorString, 0, 2);
            green = lgf_ColorComponentFrom(colorString, 2, 2);
            blue  = lgf_ColorComponentFrom(colorString, 4, 2);
            break;
        case 8: // #AARRGGBB
            red   = lgf_ColorComponentFrom(colorString, 2, 2);
            green = lgf_ColorComponentFrom(colorString, 4, 2);
            blue  = lgf_ColorComponentFrom(colorString, 6, 2);
            break;
        default:
            return nil;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark - 当前颜色的Hex结果 For NSString
/**
 @return Hex 字符串 @"#RRGGBB"
 */
- (NSString *)lgf_HexString {
    UIColor* color = self;
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

@end
