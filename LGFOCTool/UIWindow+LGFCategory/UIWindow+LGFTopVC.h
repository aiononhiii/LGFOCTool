//
//  UIWindow+LGFTopVC.h
//  LGFOCTool
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (LGFTopVC)

#pragma mark - 获取顶层控制器

- (UIViewController*) topMostController;

#pragma mark - 获取当前选中控制器

- (UIViewController*)currentViewController;
@end
