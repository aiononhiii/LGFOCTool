//
//  NSData+LGFDate.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

#define lgf_Components (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define lgf_Calendar [NSCalendar currentCalendar]

@interface NSDate (LGFDate)

#pragma mark - 自动格式化字符串
/**
 @param DateFormat 格式化类型
 @param date 传入时间 NSDate 或 NSString（如果传的是字符串 DateFormat 必须和该字符串一致）
 @return 传入 NSDate 返回 NSString， 传入 NSString 返回 NSDate
 */
+ (id)lgf_NeedDateFormat:(NSString*)DateFormat date:(id)date;

#pragma mark - 根据时间戳自动格式化字符串
/**
 @param DateFormat 格式化类型
 @param timeInterval 传入时间戳
 @return 时间字符串
 */
+ (id)lgf_NeedDateFormat:(NSString*)DateFormat timeInterval:(double)timeInterval;

#pragma mark - 返回当前时间戳
+ (NSInteger)lgf_GetNowTimeStamp;

#pragma mark - 当前时间是否是工作日
- (BOOL)lgf_IsWorkDay;

#pragma mark - 当前时间是否是未来时间
- (BOOL)lgf_IsInFuture;

#pragma mark - 当前时间是否是过去时间
- (BOOL)lgf_IsInPast;

#pragma mark - 当前时间 时
- (NSInteger)lgf_Hour;
#pragma mark - 当前时间 分
- (NSInteger)lgf_Minute;
#pragma mark - 当前时间 秒
- (NSInteger)lgf_Seconds;
#pragma mark - 当前时间 日
- (NSInteger)lgf_Day;
#pragma mark - 当前时间 月
- (NSInteger)lgf_Month;
#pragma mark - 当前时间 周
- (NSInteger)lgf_Week;
#pragma mark - 当前时间 星期几
- (NSInteger)lgf_Weekday;
#pragma mark - 当前时间 当前月第几个星期
- (NSInteger)lgf_NthWeekday;
#pragma mark - 当前时间 年
- (NSInteger)lgf_Year;
@end
