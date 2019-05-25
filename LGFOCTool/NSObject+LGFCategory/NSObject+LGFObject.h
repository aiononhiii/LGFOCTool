//
//  NSObject+LGFObject.h
//  LGFOCTool
//
//  Created by apple on 2019/4/28.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LGFObject)
#pragma mark - 保留 N 位小数 取消四舍五入
- (NSString *)lgf_KeepDecimals:(int)num;
@end

NS_ASSUME_NONNULL_END
