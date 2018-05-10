//
//  UIView+LGFViewController.h
//  LGFOCTool
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LGFViewController)

#pragma mark - 找到当前view所在的viewcontroler

@property (readonly) UIViewController *lgf_ViewController;

@end
