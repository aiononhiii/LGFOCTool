//
//  LGFLightTextLabel.m
//  LGFOCTool
//
//  Created by apple on 2018/10/9.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFLightTextLabel.h"

@implementation LGFLightTextLabel

lgf_XibViewForM(LGFLightTextLabel, @"LGFLightTextLabel");

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    self.lgf_LightTextDuration = 2.5;
    self.lgf_LightTextColor = [UIColor whiteColor];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 程序进入前台，并处于活动状态
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.fromValue = @[@0, @0, @0.25];
    animation.toValue = @[@0.75, @1, @1];
    animation.duration = self.lgf_LightTextDuration;
    animation.repeatCount = CGFLOAT_MAX;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.gradientLayer addAnimation:animation forKey:nil];
    self.layer.mask = self.gradientLayer;
}

- (void)dealloc {
    [self.gradientLayer removeAllAnimations];
    [self.gradientLayer removeFromSuperlayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradientLayer.frame = self.bounds;
}

#pragma mark - 懒加载

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[self.textColor colorWithAlphaComponent:0.3].CGColor,
                                  (__bridge id)self.lgf_LightTextColor.CGColor,
                                  (__bridge id)[self.textColor colorWithAlphaComponent:0.3].CGColor];
        _gradientLayer.startPoint = CGPointMake(0, 0);//设置渐变方向起点
        _gradientLayer.endPoint = CGPointMake(1, 0);  //设置渐变方向终点
        _gradientLayer.locations = @[@(0.0), @(0.0), @(0.1)]; //colors中各颜色对应的初始渐变点
    }
    return _gradientLayer;
}

@end
