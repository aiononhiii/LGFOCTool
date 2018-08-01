//
//  LGFAllSpecialMethod.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFPch.h"

@interface LGFAllMethod : NSObject

#pragma mark - 滚动 scrollView 顶部 topView 自动隐藏
+ (void)lgf_ScrollHideForTopView:(UIView *)topView hideHeight:(CGFloat)hideHeight scrollView:(UIScrollView *)scrollView animateDuration:(NSTimeInterval)animateDuration;

#pragma mark - collectionview 长按cell排序方法
+ (void)lgf_SortCellWithGesture:(UILongPressGestureRecognizer *)sender collectionView:(UICollectionView *)collectionView fixedHorizontal:(BOOL)fixedHorizontal fixedVertical:(BOOL)fixedVertical;

#pragma mark - 根据PNG图片url获取PNG图片尺寸
+ (CGSize)lgf_GetPNGImageSizeWithUrl:(NSURL *)url;

#pragma mark - 根据GIF图片url获取GIF图片尺寸
+ (CGSize)lgf_GetGIFImageSizeWithUrl:(NSURL *)url;

#pragma mark - 根据JPG图片url获取JPG图片尺寸
+ (CGSize)lgf_GetJPGImageSizeWithUrl:(NSURL *)url;

#pragma mark - 返回可用系统内存容量
+ (CGFloat)lgf_GetDiskFreeSize;

@end
