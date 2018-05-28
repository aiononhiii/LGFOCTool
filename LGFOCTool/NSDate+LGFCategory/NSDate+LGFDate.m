//
//  NSData+LGFDate.m
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "NSDate+LGFDate.h"

@implementation NSDate (LGFDate)

#pragma mark - 自动格式化时间字符串
/**
 @param DateFormat 格式化类型
 @param date 传入时间 NSDate 或 NSString（如果传的是字符串 DateFormat 必须和该字符串一致）
 @return 传入 NSDate 返回 NSString， 传入 NSString 返回 NSDate
 */
+ (id)lgf_NeedDateFormat:(NSString*)DateFormat date:(id)date {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setTimeZone:[NSTimeZone systemTimeZone]];
    [fmt setLocale:[NSLocale systemLocale]];
    fmt.dateFormat = DateFormat;
    if ([date isKindOfClass:[NSDate class]]) {       
        return [fmt stringFromDate:date];
    } else {
        return [fmt dateFromString:date];
    }
}

#pragma mark - 根据时间戳自动格式化字符串
/**
 @param DateFormat 格式化类型
 @param timeInterval 传入时间戳
 @return 时间字符串
 */
+ (id)lgf_NeedDateFormat:(NSString*)DateFormat timeInterval:(double)timeInterval {
    return [self lgf_NeedDateFormat:DateFormat date:[NSDate dateWithTimeIntervalSince1970:timeInterval / 1000]];
}

#pragma mark - 返回当前时间戳
+ (NSInteger)lgf_GetNowTimeStamp {
    NSInteger timeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
    return timeStamp;
}

#pragma mark - 当前时间是否是工作日
- (BOOL)lgf_IsWorkDay {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return NO;
    return YES;
}

#pragma mark - 当前时间是否是未来时间
- (BOOL)lgf_IsInFuture {
    return ([self compare:self] == NSOrderedAscending);
}

#pragma mark - 当前时间是否是过去时间
- (BOOL)lgf_IsInPast {
    return ([self compare:self] == NSOrderedDescending);
}

#pragma mark - 当前时间 时
- (NSInteger)lgf_Hour {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.hour;
}

#pragma mark - 当前时间 分
- (NSInteger)lgf_Minute {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.minute;
}

#pragma mark - 当前时间 秒
- (NSInteger)lgf_Seconds {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.second;
}

#pragma mark - 当前时间 日
- (NSInteger)lgf_Day {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.day;
}

#pragma mark - 当前时间 月
- (NSInteger)lgf_Month {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.month;
}

#pragma mark - 当前时间 周
- (NSInteger)lgf_Week {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.weekOfYear;
}

#pragma mark - 当前时间 星期几
- (NSInteger)lgf_Weekday {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.weekday;
}

#pragma mark - 当前时间 当前月第几个星期
- (NSInteger)lgf_NthWeekday {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.weekdayOrdinal;
}

#pragma mark - 当前时间 年
- (NSInteger)lgf_Year {
    NSDateComponents *components = [lgf_Calendar components:lgf_Components fromDate:self];
    return components.year;
}
@end
