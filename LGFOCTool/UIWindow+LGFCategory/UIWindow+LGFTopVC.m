//
//  UIWindow+LGFTopVC.m
//  LGFOCTool
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "UIWindow+LGFTopVC.h"

@implementation UIWindow (LGFTopVC)

#pragma mark - 获取顶层控制器

- (UIViewController*) topMostController {
    UIViewController *topController = [self rootViewController];
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    return topController;
}

#pragma mark - 获取当前选中控制器

- (UIViewController*)currentViewController {
    UIViewController *currentViewController = [self topMostController];
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
    currentViewController = [(UINavigationController*)currentViewController topViewController];
    return currentViewController;
}
@end
