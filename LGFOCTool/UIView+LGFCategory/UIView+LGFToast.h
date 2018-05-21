//
//  UIView+LGFToast.h
//  LGFOCTool
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

#define lgf_AllocOnlyOnceForH(methodName) + (instancetype)shared##methodName
#define lgf_AllocOnlyOnceForM(name,methodName) static name* _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+ (instancetype)shared##methodName{\
return [[name alloc] init];\
}\
- (instancetype)init{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super init];\
});\
return _instance;\
}\
- (instancetype)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
- (instancetype)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}

typedef NS_ENUM(NSUInteger, LGFToastPosition) {
    LGFToastCenter,
    LGFToastTop,
    LGFToastBottom,
};

typedef NS_ENUM(NSUInteger, LGFToastImagePosition) {
    LGFToastImageTop,
    LGFToastImageBottom,
    LGFToastImageLeft,
    LGFToastImageRight,
};

@interface LGFToastStyle : NSObject
// Toast文字
@property (copy, nonatomic) NSString *LGFToastMessage;
// Toast文字字体
@property (strong, nonatomic) UIFont *LGFToastMessageFont;
// Toast文字颜色
@property (strong, nonatomic) UIColor *LGFToastMessageTextColor;
// Toast图片
@property (strong, nonatomic) UIImage *LGFToastImage;
// Toast位置
@property (assign, nonatomic) LGFToastPosition LGFToastPosition;
// 图片相对于文字位置
@property (assign, nonatomic) LGFToastImagePosition LGFToastImagePosition;
// Toast背景色
@property (strong, nonatomic) UIColor *LGFToastBackColor;
// Toast圆角
@property (assign, nonatomic) CGFloat LGFToastCornerRadius;
// Toast消失动画时间
@property (assign, nonatomic) NSTimeInterval LGFDismissDuration;
// Toast停留时间
@property (assign, nonatomic) NSTimeInterval LGFDuration;
// 图片文字间隔
@property (assign, nonatomic) CGFloat LGFMessageImageSpacing;
// 四边距离
@property (assign, nonatomic) CGFloat LGFToastSpacing;
// Toast最大宽度
@property (assign, nonatomic) CGFloat LGFMaxWidth;
// Toast最大高度
@property (assign, nonatomic) CGFloat LGFMaxHeight;
// 是否阻挡父View手势
@property (assign, nonatomic) BOOL LGFCancelSuperGesture;
// 是否有图片
@property (assign, nonatomic) BOOL LGFToastHaveIamge;
// 图片限定大小
@property (assign, nonatomic) CGSize LGFToastImageSize;
+ (instancetype)shard;
- (CGFloat)lgf_HeightWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;
- (CGFloat)lgf_WidthWithText:(NSString *)text font:(UIFont *)font height:(CGFloat)height;
@end

@interface LGFToastView : UIView
@property (strong, nonatomic) LGFToastStyle *style;
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *message;
lgf_AllocOnlyOnceForH(ToastView);
@end

@interface UIView (LGFToast)

- (void)lgf_ShowToastStyle:(LGFToastStyle *)style;
- (void)lgf_ShowToastMessage:(NSString *)message;
- (void)lgf_ShowToastMessage:(NSString *)message duration:(NSTimeInterval)duration;
- (void)lgf_ShowToastImage:(UIImage *)image;
- (void)lgf_ShowToastImage:(UIImage *)image duration:(NSTimeInterval)duration;
- (void)lgf_ShowToastImageAndMessage:(NSString *)message image:(UIImage *)image;
- (void)lgf_ShowToastImageAndMessage:(NSString *)message image:(UIImage *)image duration:(NSTimeInterval)duration;

- (void)lgf_ShowToastActivity;
- (void)lgf_HideToastActivity;

@end


