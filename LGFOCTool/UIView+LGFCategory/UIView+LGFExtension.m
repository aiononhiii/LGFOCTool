//
//  UIView+LGFExtension.m
//  LGFOCTool
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIView+LGFExtension.h"

@implementation UIView (LGFExtension)

- (void)setLgf_x:(CGFloat)lgf_x {
    CGRect frame = self.frame;
    frame.origin.x = lgf_x;
    self.frame = frame;
}

- (void)setLgf_y:(CGFloat)lgf_y {
    CGRect frame = self.frame;
    frame.origin.y = lgf_y;
    self.frame = frame;
}

- (CGFloat)lgf_x {
    return self.frame.origin.x;
}

- (CGFloat)lgf_y {
    return self.frame.origin.y;
}

- (void)setLgf_centerX:(CGFloat)lgf_centerX {
    CGPoint center = self.center;
    center.x = lgf_centerX;
    self.center = center;
}

- (CGFloat)lgf_centerX {
    return self.center.x;
}

- (void)setLgf_centerY:(CGFloat)lgf_centerY {
    CGPoint center = self.center;
    center.y = lgf_centerY;
    self.center = center;
}

- (CGFloat)lgf_centerY {
    return self.center.y;
}

- (void)setLgf_width:(CGFloat)lgf_width {
    CGRect frame = self.frame;
    frame.size.width = lgf_width;
    self.frame = frame;
}

- (void)setLgf_height:(CGFloat)lgf_height {
    CGRect frame = self.frame;
    frame.size.height = lgf_height;
    self.frame = frame;
}

- (CGFloat)lgf_height {
    return self.frame.size.height;
}

- (CGFloat)lgf_width {
    return self.frame.size.width;
}

- (void)setLgf_size:(CGSize)lgf_size {
    CGRect frame = self.frame;
    frame.size = lgf_size;
    self.frame = frame;
}

- (CGSize)lgf_size {
    return self.frame.size;
}

- (void)setLgf_origin:(CGPoint)lgf_origin {
    CGRect frame = self.frame;
    frame.origin = lgf_origin;
    self.frame = frame;
}

- (CGPoint)lgf_origin {
    return self.frame.origin;
}

@end
