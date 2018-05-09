//
//  UIFont+LGFLoadTTF.h
//  LGFOCTool
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (LGFLoadTTF)

#pragma mark - 根据路径字符串加载 TTF字体

+ (UIFont *)lgf_FontWithTTFAtPath:(NSString *)path size:(CGFloat)size;

#pragma mark - 根据路径URL加载 TTF字体

+ (UIFont *)lgf_FontWithTTFAtURL:(NSURL *)URL size:(CGFloat)size;

@end
