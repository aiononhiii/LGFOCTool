//
//  NSBundle+LGFRefresh.h
//  LGFRefreshExample
//
//  Created by MJ Lee on 16/6/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (LGFRefresh)
+ (instancetype)lgf_refreshBundle;
+ (UIImage *)lgf_arrowImage;
+ (NSString *)lgf_localizedStringForKey:(NSString *)key value:(NSString *)value;
+ (NSString *)lgf_localizedStringForKey:(NSString *)key;
@end
