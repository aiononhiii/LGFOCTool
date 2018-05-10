//
//  UIView+LGFViewController.m
//  LGFOCTool
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "UIView+LGFViewController.h"

@implementation UIView (LGFViewController)

#pragma mark - 找到当前view所在的viewcontroler

- (UIViewController *)lgf_ViewController {
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

@end
