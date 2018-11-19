//  代码地址: https://github.com/CoderMJLee/LGFRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIView+Extension.m
//  LGFRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "UIView+LGFMJExtension.h"

@implementation UIView (LGFMJExtension)
- (void)setLgf_x:(CGFloat)lgf_x
{
    CGRect frame = self.frame;
    frame.origin.x = lgf_x;
    self.frame = frame;
}

- (CGFloat)lgf_x
{
    return self.frame.origin.x;
}

- (void)setLgf_y:(CGFloat)lgf_y
{
    CGRect frame = self.frame;
    frame.origin.y = lgf_y;
    self.frame = frame;
}

- (CGFloat)lgf_y
{
    return self.frame.origin.y;
}

- (void)setLgf_w:(CGFloat)lgf_w
{
    CGRect frame = self.frame;
    frame.size.width = lgf_w;
    self.frame = frame;
}

- (CGFloat)lgf_w
{
    return self.frame.size.width;
}

- (void)setLgf_h:(CGFloat)lgf_h
{
    CGRect frame = self.frame;
    frame.size.height = lgf_h;
    self.frame = frame;
}

- (CGFloat)lgf_h
{
    return self.frame.size.height;
}

- (void)setLgf_size:(CGSize)lgf_size
{
    CGRect frame = self.frame;
    frame.size = lgf_size;
    self.frame = frame;
}

- (CGSize)lgf_size
{
    return self.frame.size;
}

- (void)setLgf_origin:(CGPoint)lgf_origin
{
    CGRect frame = self.frame;
    frame.origin = lgf_origin;
    self.frame = frame;
}

- (CGPoint)lgf_origin
{
    return self.frame.origin;
}
@end
