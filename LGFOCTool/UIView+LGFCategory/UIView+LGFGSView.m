//
//  UIView+LGFGSView.m
//  LGFOCTool
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIView+LGFGSView.h"
#import <objc/runtime.h>

static const char *lgf_ViewNameKey = "lgf_ViewNameKey";
static const char *lgf_CornerRadiusKey = "lgf_CornerRadiusKey";
static const char *lgf_BorderColorKey = "lgf_BorderColorKey";
static const char *lgf_BorderWidthKey = "lgf_BorderWidthKey";
static const char *lgf_ShadowColorKey = "lgf_ShadowColorKey";
static const char *lgf_ShadowRadiusKey = "lgf_ShadowRadiusKey";
static const char *lgf_ShadowOffsetKey = "lgf_ShadowOffsetKey";
static const char *lgf_ShadowOpacityKey = "lgf_ShadowOpacityKey";

@implementation UIView (LGFGSView)

@dynamic lgf_ViewName;
@dynamic lgf_CornerRadius;
@dynamic lgf_BorderColor;
@dynamic lgf_BorderWidth;
@dynamic lgf_ShadowColor;
@dynamic lgf_ShadowRadius;
@dynamic lgf_ShadowOffset;
@dynamic lgf_ShadowOpacity;

#pragma mark - 控件唯一名字(通常用于确定某一个特殊的view)

- (NSString *)lgf_ViewName {
    return objc_getAssociatedObject(self, lgf_ViewNameKey);
}

- (void)setLgf_ViewName:(NSString *)lgf_ViewName {
    objc_setAssociatedObject(self, lgf_ViewNameKey, lgf_ViewName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - 圆角

- (CGFloat)lgf_CornerRadius {
    return [objc_getAssociatedObject(self, lgf_CornerRadiusKey) floatValue];
}

- (void)setLgf_CornerRadius:(CGFloat)lgf_CornerRadius {
    objc_setAssociatedObject(self, lgf_CornerRadiusKey, [NSNumber numberWithFloat:lgf_CornerRadius], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.cornerRadius = lgf_CornerRadius;
}

#pragma mark - 边框颜色

- (UIColor *)lgf_BorderColor {
    return objc_getAssociatedObject(self, lgf_BorderColorKey);
}

- (void)setLgf_BorderColor:(UIColor *)lgf_BorderColor {
    objc_setAssociatedObject(self, lgf_BorderColorKey, lgf_BorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderColor = lgf_BorderColor.CGColor;
}

#pragma mark - 边框宽度

- (CGFloat)lgf_BorderWidth {
    return [objc_getAssociatedObject(self, lgf_BorderWidthKey) floatValue];
}

- (void)setLgf_BorderWidth:(CGFloat)lgf_BorderWidth {
    objc_setAssociatedObject(self, lgf_BorderWidthKey, [NSNumber numberWithFloat:lgf_BorderWidth], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderWidth = lgf_BorderWidth;
}

#pragma mark - 阴影颜色

- (UIColor *)lgf_ShadowColor {
    return objc_getAssociatedObject(self, lgf_ShadowColorKey);
}

- (void)setLgf_ShadowColor:(UIColor *)lgf_ShadowColor {
    objc_setAssociatedObject(self, lgf_ShadowColorKey, lgf_ShadowColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.shadowColor = lgf_ShadowColor.CGColor;
}

#pragma mark - 阴影圆角

- (CGFloat)lgf_ShadowRadius {
    return [objc_getAssociatedObject(self, lgf_ShadowRadiusKey) floatValue];
}

- (void)setLgf_ShadowRadius:(CGFloat)lgf_ShadowRadius {
    objc_setAssociatedObject(self, lgf_ShadowRadiusKey, [NSNumber numberWithFloat:lgf_ShadowRadius], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.shadowRadius = lgf_ShadowRadius;
}

#pragma mark - 阴影偏移量

- (CGSize)lgf_ShadowOffset {
    return [objc_getAssociatedObject(self, lgf_ShadowOffsetKey) CGSizeValue];
}

- (void)setLgf_ShadowOffset:(CGSize)lgf_ShadowOffset {
    objc_setAssociatedObject(self, lgf_ShadowOffsetKey, [NSValue valueWithCGSize:lgf_ShadowOffset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.shadowOffset = lgf_ShadowOffset;
}

#pragma mark - 阴影透明度

- (float)lgf_ShadowOpacity {
    return [objc_getAssociatedObject(self, lgf_ShadowOpacityKey) floatValue];
}

- (void)setLgf_ShadowOpacity:(float)lgf_ShadowOpacity {
    objc_setAssociatedObject(self, lgf_ShadowOpacityKey, [NSNumber numberWithFloat:lgf_ShadowOpacity], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.shadowOpacity = lgf_ShadowOpacity;
}

@end
