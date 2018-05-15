//
//  UIViewController+LGFVCLog.m
//  LGFOCTool
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "UIViewController+LGFVCLog.h"
#import "LGFOCTool.h"

@implementation UIViewController (LGFVCLog)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 如果是实例方法:
        Class class = [self class];
        // 如果是类方法
        // Class class = object_getClass((id)self);
        
        // 替换 viewDidLoad
        SEL viewDidLoad = @selector(viewDidLoad);
        SEL lgf_ViewDidLoad = @selector(lgf_ViewDidLoad);
        [class lgf_SwizzleMethod:viewDidLoad withMethod:lgf_ViewDidLoad];
        
        // 替换 viewDidAppear
        SEL viewDidAppear = @selector(viewDidAppear:);
        SEL lgf_ViewDidAppear = @selector(lgf_ViewDidAppear);
        [class lgf_SwizzleMethod:viewDidAppear withMethod:lgf_ViewDidAppear];
        
        // 替换 dealloc
        SEL dealloc = NSSelectorFromString(@"dealloc");
        SEL lgf_Dealloc = @selector(lgf_Dealloc);
        [class lgf_SwizzleMethod:dealloc withMethod:lgf_Dealloc];
    });
}

- (void)lgf_ViewDidLoad {
    NSLog(@"LGF的控制器:%@ --- 已经走 ViewDidLoad", self);
}

- (void)lgf_ViewDidAppear {
    NSLog(@"LGF的控制器:%@ --- 已经走 viewDidAppear 全部加载完毕", self);
}

- (void)lgf_Dealloc {
    NSLog(@"LGF的控制器:%@ --- 已经释放", self);
}

@end
