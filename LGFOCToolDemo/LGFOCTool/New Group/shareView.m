//
//  shareView.m
//  LGFOCTool
//
//  Created by apple on 2018/10/9.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "shareView.h"

@implementation shareView

lgf_XibViewForM(shareView, @"shareView");

- (void)showShareView:(UIView *)SV shareUrl:(NSString *)shareUrl {
    self.frame = lgf_Application.keyWindow.bounds;
    [lgf_Application.keyWindow addSubview:self];
    [self.codeImageView setImage:[LGFAllMethod lgf_GetCodeImageWithUrl:shareUrl imgWidth:100]];
    self.shareBackView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    self.shareViewBottom.constant = -20;
    [UIView animateWithDuration:0.3 animations:^{
        [self.superview layoutIfNeeded];
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    } completion:^(BOOL finished) {
        self.shareBackView.alpha = 1.0;
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.shareBackView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.3 animations:^{
        self.shareBackView.alpha = 0.0;
        self.shareBackView.transform = CGAffineTransformIdentity;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.15];
    } completion:^(BOOL finished) {
        self.shareViewBottom.constant = -200;
        [UIView animateWithDuration:0.3 animations:^{
            [self.superview layoutIfNeeded];
            self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            lgf_HaveBlock(self.shareBlock, [UIImage lgf_ScreenshotWithView:self.shareView]);
            [self removeFromSuperview];
        }];
    }];
}

@end
