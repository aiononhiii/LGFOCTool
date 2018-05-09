//
//  LGFAllSpecialMethod.h
//  LGFOCTool
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFPch.h"

@interface LGFAllMethod : NSObject

#pragma mark - 根据PNG图片url获取PNG图片尺寸
+ (CGSize)lgf_GetPNGImageSizeWithUrl:(NSURL *)url;

#pragma mark - 根据GIF图片url获取GIF图片尺寸
+ (CGSize)lgf_GetGIFImageSizeWithUrl:(NSURL *)url;

#pragma mark - 根据JPG图片url获取JPG图片尺寸
+ (CGSize)lgf_GetJPGImageSizeWithUrl:(NSURL *)url;

#pragma mark - 返回可用系统内存容量
+ (CGFloat)lgf_GetDiskFreeSize;

#pragma mark - 运行时方法替换
/**
 @param class 方法所属的类
 @param selOne 被替换的方法
 @param selTwo 替换的方法
 */
+ (void)lgf_MethodReplaceWithClass:(Class)class selOne:(SEL)selOne selTwo:(SEL)selTwo;
@end
