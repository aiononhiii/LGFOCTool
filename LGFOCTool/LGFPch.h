//
//  LGFPch.h
//  LGFOCTool
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#ifndef LGFPch_h
#define LGFPch_h

// 自动 NSLog
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

// 是否大于某个系统版本
#define lgf_IOSSystemVersion(V) [[UIDevice currentDevice] systemVersion].floatValue >= (V)

// RGB颜色
#define lgf_RGBColor(R, G, B, A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

//随机色
#define lgf_RandomColor lgf_RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.0)

// 设置字号
#define lgf_Font(fontSize) [UIFont systemFontOfSize:fontSize]

// 系统电池栏小菊花
#undef lgf_NWA
#define lgf_NWA LGFApplication.networkActivityIndicatorVisible

// UIApplication
#undef lgf_Application
#define lgf_Application [UIApplication sharedApplication]

// 通知中心
#undef lgf_NotificationCenter
#define lgf_NCenter [NSNotificationCenter defaultCenter]

// NSUserDefaults 缓存
#undef lgf_UserDefaults
#define lgf_Defaults [NSUserDefaults standardUserDefaults]

// 获取对应名字 storyboard
#undef lgf_GetSBWithName
#define lgf_GetSBWithName(sbStrName, bundleStrName)\
[UIStoryboard storyboardWithName:sbStrName bundle:lgf_Bundle(bundleStrName)]

// storyboard
#undef lgf_GetSBVC
#define lgf_GetSBVC(vcClass, sbStrName, bundleStrName)\
[lgf_GetSBWithName((sbStrName), (bundleStrName)) instantiateViewControllerWithIdentifier:NSStringFromClass([vcClass class])]

// 资源文件 Bundle
#undef lgf_Bundle
#define lgf_Bundle(bundleName)\
bundleName ? [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:bundleName ofType:@"bundle"]] ?: [NSBundle mainBundle] : [NSBundle mainBundle]

//---------------------- 常用系统信息获取 ----------------------

// app版本
#undef lgf_AppVersion
#define lgf_AppVersion [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]

// 设备模型数据
#undef lgf_DeviceModel
#define lgf_DeviceModel [UIDevice currentDevice].model

// 屏幕尺寸
#undef lgf_ScreenWidth
#define lgf_ScreenWidth ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#undef lgf_ScreenHeight
#define lgf_ScreenHeight ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

//---------------------- 全局包含头文件 ----------------------
#ifdef __OBJC__
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreImage/CoreImage.h>
#import <CoreLocation/CoreLocation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#endif

//---------------------- 常用数据非空判断 ----------------------
// 字符串是否为空
#undef lgf_StringIsEmpty
#define lgf_StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 数组是否为空
#undef lgf_ArrayIsEmpty
#define lgf_ArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 字典是否为空
#undef lgf_DictIsEmpty
#define lgf_DictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

//---------------------- 注册 Nib CollectionViewCell ----------------------
#undef lgf_RegNibCVCell
#define lgf_RegisterNibCollectionViewCell(collectionView, cellClass, bundle)\
[collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([cellClass class]) bundle:bundle] forCellWithReuseIdentifier:NSStringFromClass([cellClass class])];

//---------------------- 初始化 CollectionViewCell ----------------------
#undef lgf_CollectionViewGetCell
#define lgf_CVGetCell(collectionView, cellClass, indexPath)\
[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([cellClass class]) forIndexPath:indexPath];

//---------------------- Block 引用控制 ----------------------
// 判断 block 是否被引用
#define lgf_HaveBlock(block, ...) if (block) { block(__VA_ARGS__); };
// block 防止强引用
#ifndef lgf_Weak
#if DEBUG
#if __has_feature(objc_arc)
#define lgf_Weak(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define lgf_Weak(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define lgf_Weak(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define lgf_Weak(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif
#ifndef lgf_Strong
#if DEBUG
#if __has_feature(objc_arc)
#define lgf_Strong(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define lgf_Strong(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define lgf_Strong(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define lgf_Strong(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

//---------------------- 单列快捷设置 ----------------------

// 添加到 .h 文件
#define lgf_AllocOnlyOnceForH(methodName) + (instancetype)shared##methodName
// 添加到 .m 文件
#define lgf_AllocOnlyOnceForM(name,methodName) static name* _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+ (instancetype)shared##methodName{\
\
return [[name alloc] init];\
}\
- (instancetype)init{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super init];\
});\
return _instance;\
}\
\
- (instancetype)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
- (instancetype)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}

//---------------------- 多线程 GCD 宏 ----------------------
// 主队列 + 异步执行
#undef lgf_MAIN
#define lgf_MAIN(demo) dispatch_async(dispatch_get_main_queue(),^{demo});
// 主队列 + 同步执行 通常情况下不建议使用
#undef lgf_MAINT
#define lgf_MAINT(demo) dispatch_sync(dispatch_get_main_queue(),^{demo});
// 并行队列 + 同步执行 主线程执行 一个一个执行 不用等待任务添加到队列立即执行
#undef lgf_CONCURRENTT
#define lgf_CONCURRENTT(demo) dispatch_sync(dispatch_queue_create("lgf", DISPATCH_QUEUE_CONCURRENT), ^{demo});
// 并行队列 + 异步执行 开启新线程 同时执行 将所有任务添加到队列之后开始异步执行
#undef lgf_CONCURRENTY
#define lgf_CONCURRENTY(demo) dispatch_async(dispatch_queue_create("lgf", DISPATCH_QUEUE_CONCURRENT), ^{demo});
// 串行队列 + 同步执行 主线程执行 一个一个执行 不用等待任务添加到队列立即执行
#undef lgf_SERIALT
#define lgf_SERIALT(demo) dispatch_sync(dispatch_queue_create("lgf", DISPATCH_QUEUE_SERIAL), ^{demo});
// 串行队列 + 异步执行 开启新线程 一个一个执行 将所有任务添加到队列之后开始同步执行
#undef lgf_SERIALY
#define lgf_SERIALY(demo) dispatch_async(dispatch_queue_create("lgf", DISPATCH_QUEUE_SERIAL), ^{demo});
// 延时
#undef lgf_AFTER
#define lgf_AFTER(time,demo) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((time) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{demo});
// 异步
#undef lgf_GLOBAL
#define lgf_GLOBAL(demo) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{demo})
// 异步栏栅 用于分隔两批异步任务
#undef lgf_BARRIER
#define lgf_BARRIER(demo) dispatch_barrier_async(dispatch_queue_create("lgf", DISPATCH_QUEUE_CONCURRENT), ^{demo});
// 队列组 异步执行多个耗时操作，然后当所有耗时操作都执行完毕后再回到主线程执行操作
#undef lgf_GROUPGLOBAL
#define lgf_GROUPGLOBAL(demo) dispatch_group_async(dispatch_group_create(), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{demo});
#undef lgf_GROUPMAIN
#define lgf_GROUPMAIN(demo) dispatch_group_notify(dispatch_group_create(), dispatch_get_main_queue(), ^{demo});

#endif /* LGFPch_h */
