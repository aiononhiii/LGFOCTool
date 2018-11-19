//  代码地址: https://github.com/CoderMJLee/LGFRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>

const CGFloat LGFRefreshLabelLeftInset = 25;
const CGFloat LGFRefreshHeaderHeight = 54.0;
const CGFloat LGFRefreshFooterHeight = 44.0;
const CGFloat LGFRefreshFastAnimationDuration = 0.25;
const CGFloat LGFRefreshSlowAnimationDuration = 0.4;

NSString *const LGFRefreshKeyPathContentOffset = @"contentOffset";
NSString *const LGFRefreshKeyPathContentInset = @"contentInset";
NSString *const LGFRefreshKeyPathContentSize = @"contentSize";
NSString *const LGFRefreshKeyPathPanState = @"state";

NSString *const LGFRefreshHeaderLastUpdatedTimeKey = @"LGFRefreshHeaderLastUpdatedTimeKey";

NSString *const LGFRefreshHeaderIdleText = @"LGFRefreshHeaderIdleText";
NSString *const LGFRefreshHeaderPullingText = @"LGFRefreshHeaderPullingText";
NSString *const LGFRefreshHeaderRefreshingText = @"LGFRefreshHeaderRefreshingText";

NSString *const LGFRefreshAutoFooterIdleText = @"LGFRefreshAutoFooterIdleText";
NSString *const LGFRefreshAutoFooterRefreshingText = @"LGFRefreshAutoFooterRefreshingText";
NSString *const LGFRefreshAutoFooterNoMoreDataText = @"LGFRefreshAutoFooterNoMoreDataText";

NSString *const LGFRefreshBackFooterIdleText = @"LGFRefreshBackFooterIdleText";
NSString *const LGFRefreshBackFooterPullingText = @"LGFRefreshBackFooterPullingText";
NSString *const LGFRefreshBackFooterRefreshingText = @"LGFRefreshBackFooterRefreshingText";
NSString *const LGFRefreshBackFooterNoMoreDataText = @"LGFRefreshBackFooterNoMoreDataText";

NSString *const LGFRefreshHeaderLastTimeText = @"LGFRefreshHeaderLastTimeText";
NSString *const LGFRefreshHeaderDateTodayText = @"LGFRefreshHeaderDateTodayText";
NSString *const LGFRefreshHeaderNoneLastDateText = @"LGFRefreshHeaderNoneLastDateText";
