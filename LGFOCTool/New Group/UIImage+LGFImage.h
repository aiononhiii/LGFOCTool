//
//  UIImage+LGFImage.h
//  LGFOCTool
//
//  Created by apple on 2018/5/3.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LGFImage)

#pragma mark - 截图指定view成图片
/**
 @param view 要截图的 截图
 @return 图片
 */
+ (UIImage *)lgf_ScreenshotWithView:(UIView *)view;

#pragma mark - 取图片某一点的颜色
/**
 @param point 某一点
 @return 颜色
 */
- (UIColor *)lgf_ColorAtPoint:(CGPoint )point;

#pragma mark - 取某一像素的颜色
/**
 @param pixel 一像素
 @return 颜色
 */
- (UIColor *)lgf_ColorAtPixel:(CGPoint)pixel;

#pragma mark - 返回该图片是否有透明度
/**
 @return 是否有透明度通道
 */
- (BOOL)lgf_HasAlphaChannel;

#pragma mark - 返回灰度图
+ (UIImage*)lgf_CovertToGrayImageFromImage:(UIImage*)sourceImage;

#pragma mark - 压缩上传图片到指定字节
/**
 @param image     压缩的图片
 @param maxLength 压缩后最大字节大小
 @return 压缩后图片的二进制
 */
+ (NSData *)lgf_CompressImage:(UIImage *)image toMaxLength:(NSInteger)maxLength maxWidth:(NSInteger)maxWidth;

#pragma mark - 获得指定size的图片
/**
 @param image   原始图片
 @param newSize 指定的size
 @return 调整后的图片
 */
+ (UIImage *)lgf_ResizeImage:(UIImage *)image withNewSize:(CGSize)newSize;

#pragma mark - 通过指定图片最长边，获得等比例的图片size
/**
 @param image       原始图片
 @param imageLength 图片允许的最长宽度（高度）
 @return 获得等比例的size
 */
+ (CGSize)lgf_ScaleImage:(UIImage *)image withLength:(CGFloat)imageLength;

@end
