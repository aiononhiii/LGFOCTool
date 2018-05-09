//
//  UIViewController+LGFVCLog.m
//  LGFOCTool
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 来国锋. All rights reserved.
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
        [self lgf_MethodReplaceWithClass:class selOne:viewDidLoad selTwo:lgf_ViewDidLoad];
        
        // 替换 viewDidAppear
        SEL viewDidAppear = @selector(viewDidAppear:);
        SEL lgf_ViewDidAppear = @selector(lgf_ViewDidAppear);
        [self lgf_MethodReplaceWithClass:class selOne:viewDidAppear selTwo:lgf_ViewDidAppear];
        
        // 替换 dealloc
        SEL dealloc = NSSelectorFromString(@"dealloc");
        SEL lgf_Dealloc = @selector(lgf_Dealloc);
        [self lgf_MethodReplaceWithClass:class selOne:dealloc selTwo:lgf_Dealloc];
    });
}

#pragma mark - 运行时方法替换
/**
 @param class 方法所属的类
 @param selOne 被替换的方法
 @param selTwo 替换的方法
 */
+ (void)lgf_MethodReplaceWithClass:(Class)class selOne:(SEL)selOne selTwo:(SEL)selTwo {
    Method met_One = class_getInstanceMethod(class, selOne);
    Method met_Two = class_getInstanceMethod(class, selTwo);
    BOOL didAddMethod =
    class_addMethod(class, selOne, method_getImplementation(met_Two), method_getTypeEncoding(met_Two));
    if (didAddMethod) {
        class_replaceMethod(class, selTwo, method_getImplementation(met_One), method_getTypeEncoding(met_One));
    } else {
        method_exchangeImplementations(met_One, met_Two);
    }
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
