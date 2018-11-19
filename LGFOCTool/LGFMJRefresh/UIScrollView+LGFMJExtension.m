//  代码地址: https://github.com/CoderMJLee/LGFRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+Extension.m
//  LGFRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "UIScrollView+LGFMJExtension.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@implementation UIScrollView (LGFMJExtension)

static BOOL gt_ios_11_;
+ (void)load
{
    // 缓存判断值
    gt_ios_11_ = [[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending;
}

- (UIEdgeInsets)lgf_inset
{
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        return self.adjustedContentInset;
    }
#endif
    return self.contentInset;
}

- (void)setLgf_insetT:(CGFloat)lgf_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = lgf_insetT;
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        inset.top -= (self.adjustedContentInset.top - self.contentInset.top);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)lgf_insetT
{
    return self.lgf_inset.top;
}

- (void)setLgf_insetB:(CGFloat)lgf_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = lgf_insetB;
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        inset.bottom -= (self.adjustedContentInset.bottom - self.contentInset.bottom);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)lgf_insetB
{
    return self.lgf_inset.bottom;
}

- (void)setLgf_insetL:(CGFloat)lgf_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = lgf_insetL;
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        inset.left -= (self.adjustedContentInset.left - self.contentInset.left);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)lgf_insetL
{
    return self.lgf_inset.left;
}

- (void)setLgf_insetR:(CGFloat)lgf_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = lgf_insetR;
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        inset.right -= (self.adjustedContentInset.right - self.contentInset.right);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)lgf_insetR
{
    return self.lgf_inset.right;
}

- (void)setLgf_offsetX:(CGFloat)lgf_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = lgf_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)lgf_offsetX
{
    return self.contentOffset.x;
}

- (void)setLgf_offsetY:(CGFloat)lgf_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = lgf_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)lgf_offsetY
{
    return self.contentOffset.y;
}

- (void)setLgf_contentW:(CGFloat)lgf_contentW
{
    CGSize size = self.contentSize;
    size.width = lgf_contentW;
    self.contentSize = size;
}

- (CGFloat)lgf_contentW
{
    return self.contentSize.width;
}

- (void)setLgf_contentH:(CGFloat)lgf_contentH
{
    CGSize size = self.contentSize;
    size.height = lgf_contentH;
    self.contentSize = size;
}

- (CGFloat)lgf_contentH
{
    return self.contentSize.height;
}
@end
#pragma clang diagnostic pop
