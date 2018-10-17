//
//  shareVC.m
//  LGFOCTool
//
//  Created by apple on 2018/10/9.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "shareVC.h"

@interface shareVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareViewBottom;
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIView *shareBottomView;
@end

@implementation shareVC

lgf_SBViewControllerForM(shareVC, @"shareVC", @"shareVC");

- (void)viewDidLoad {
    [super viewDidLoad];
    // 动画
    self.shareViewBottom.constant = -20;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    } completion:^(BOOL finished) {
        self.shareView.alpha = 1.0;
        self.shareView.transform = CGAffineTransformMakeScale(0.85, 0.85);
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.view layoutIfNeeded];
            self.shareView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
