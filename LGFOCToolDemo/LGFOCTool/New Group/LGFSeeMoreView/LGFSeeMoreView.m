//
//  LGFSeeMoreView.m
//  LGFOCTool
//
//  Created by apple on 2019/3/16.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "LGFSeeMoreView.h"

@implementation LGFSeeMoreView

- (void)setRadian:(CGFloat)radian {
    _radian = radian;
    
}

- (void)drawRect:(CGRect)rect {
    // float x = rect.origin.x;
    // float y = rect.origin.y;
    float w = rect.size.width;
    float h = rect.size.height;
    // 一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 画笔线的颜色
    CGContextSetRGBStrokeColor(context,1,0,0,0);
    // 线的宽度
    CGContextSetLineWidth(context, 1.0);
    // 填充颜色
    UIColor *fullColor = [UIColor redColor];
    CGContextSetFillColorWithColor(context, fullColor.CGColor);
    [fullColor setStroke];
    // 绘制路径
    CGContextMoveToPoint(context, w / 2, 0);
    CGContextAddLineToPoint(context, w, 0);
    CGContextAddLineToPoint(context, w, h);
    CGContextAddLineToPoint(context, w / 2, h);
    CGContextAddArcToPoint(context, w / 2, h / 2, 0, w / 2, w);
//    CGContextAddLineToPoint(context, x, h);
    CGContextStrokePath(context);
    // 绘制路径加填充
    //    CGContextDrawPath(context, kCGPathFillStroke);
}


@end
