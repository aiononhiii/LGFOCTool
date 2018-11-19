//  代码地址: https://github.com/CoderMJLee/LGFRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>
#import <objc/message.h>

// 弱引用
#define MJWeakSelf __weak typeof(self) weakSelf = self;

// 日志输出
#ifdef DEBUG
#define LGFRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define LGFRefreshLog(...)
#endif

// 过期提醒
#define LGFRefreshDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 运行时objc_msgSend
#define LGFRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define LGFRefreshMsgTarget(target) (__bridge void *)(target)

// RGB颜色
#define LGFRefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define LGFRefreshLabelTextColor LGFRefreshColor(90, 90, 90)

// 字体大小
#define LGFRefreshLabelFont [UIFont boldSystemFontOfSize:14]

// 常量
UIKIT_EXTERN const CGFloat LGFRefreshLabelLeftInset;
UIKIT_EXTERN const CGFloat LGFRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat LGFRefreshFooterHeight;
UIKIT_EXTERN const CGFloat LGFRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat LGFRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const LGFRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const LGFRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const LGFRefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const LGFRefreshKeyPathPanState;

UIKIT_EXTERN NSString *const LGFRefreshHeaderLastUpdatedTimeKey;

UIKIT_EXTERN NSString *const LGFRefreshHeaderIdleText;
UIKIT_EXTERN NSString *const LGFRefreshHeaderPullingText;
UIKIT_EXTERN NSString *const LGFRefreshHeaderRefreshingText;

UIKIT_EXTERN NSString *const LGFRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const LGFRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const LGFRefreshAutoFooterNoMoreDataText;

UIKIT_EXTERN NSString *const LGFRefreshBackFooterIdleText;
UIKIT_EXTERN NSString *const LGFRefreshBackFooterPullingText;
UIKIT_EXTERN NSString *const LGFRefreshBackFooterRefreshingText;
UIKIT_EXTERN NSString *const LGFRefreshBackFooterNoMoreDataText;

UIKIT_EXTERN NSString *const LGFRefreshHeaderLastTimeText;
UIKIT_EXTERN NSString *const LGFRefreshHeaderDateTodayText;
UIKIT_EXTERN NSString *const LGFRefreshHeaderNoneLastDateText;

// 状态检查
#define LGFRefreshCheckState \
LGFRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];
