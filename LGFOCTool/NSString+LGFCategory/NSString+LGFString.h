//
//  NSString+LGFString.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGFPch.h"

typedef NS_ENUM(NSUInteger, lgf_UnitStrType) {
    lgf_SmallPinyin,// 小写拼音 (q w y)
    lgf_BigPinyin,// 大写拼音 (Q W Y)
    lgf_CCharacter,// 汉字 (千 万 亿)
};

typedef NS_ENUM(NSUInteger, lgf_UnitType) {
    lgf_OnlyWan,// 只带 万（0.5万 10万 10000万）
    lgf_OnlyQian,// 只带 千 (5千 100千 100000千）
    lgf_QianAndWan,// 带 千和万 (5千 10万 10000万）
    lgf_WanAndYi,// 带 万和亿 (0.5万 10万 10000万）
    lgf_QianAndWanAndYi,// 带 千和万和亿 (5千 10万 1亿）
};

typedef NS_ENUM(NSUInteger, lgf_TimeFormatType) {
    lgf_MS, // 00:00
    lgf_HMS,// 00:00:00
    lgf_CCharacterMS,// 00分00秒
    lgf_CCharacterHMS,// 00点00分00秒
};

@interface NSString (LGFString)

#pragma mark - string是否不为真
+ (BOOL)lgf_IsNull:(NSString *)string;

#pragma mark - 获取当前时间的 时间戳
+ (NSInteger)lgf_GetNowTimeStamp;

#pragma mark - 将某个时间字符串转化成 时间戳
/**
 @param timeStr 要转换的时间字符串
 @param format 格式化类型
 @return 时间戳
 */
+ (NSInteger)lgf_TimeStrSwitchTimeStamp:(NSString *)timeStr format:(NSString *)format;

#pragma mark - 将某个时间戳转化成 发布距离当前时间的字符串
/**
 @param timestamp 要转换的时间戳
 @return 发布距离当前时间的字符串:@"1年前" @"1个月前" @"1周前" @"1天前" @"1小时前" @"1分钟前" @"刚刚"
 */
+ (NSString *)lgf_TimeStampSwitchPublishTimeStr:(NSInteger)timestamp;

#pragma mark - 将某个时间戳转化成 时间字符串
/**
 @param timestamp 要转换的时间戳
 @param format 格式化类型
 @return 时间字符串
 */
+ (NSString *)lgf_TimeStampSwitchTimeStr:(NSInteger)timestamp format:(NSString *)format;

#pragma mark - 根据数字返回带单位字符串
/**
 @param num 要转换的数字
 @param unitType 单位范围类型
 @param unitStrType 单位类字符型 拼音还是汉子
 @return 带单位的数字符串
 */
+ (NSString *)lgf_GetNumStrWithNum:(NSUInteger)num unitType:(lgf_UnitType)unitType unitStrType:(lgf_UnitStrType)unitStrType;

#pragma mark - 根据视屏时长秒数返回时间字符串
/**
 @param timeLength 要转换的视屏秒数
 @param delimit 间隔符号 如果 TimeFormatType 为 lgf_CCharacterMS 或 lgf_CCharacterHMS 此项无效
 @param TimeFormatType 格式化类型
 @return 转换后的字符串
 */
+ (NSString *)lgf_GetVideoTimeLength:(NSUInteger)timeLength delimit:(NSString *)delimit TimeFormatType:(lgf_TimeFormatType)TimeFormatType;

#pragma mark - 格式化系统内存容量显示 B KB MB GB
+ (NSString *)lgf_FileSizeFormat:(CGFloat)bsize;

#pragma mark - 判断字符串是否包含 中文
- (BOOL)lgf_IsContainChinese;

#pragma mark - 判断字符串是否包含 空格
- (BOOL)lgf_IsContainBlank;

#pragma mark - url Encode
- (NSString*)lgf_UrlEncodedString;

#pragma mark - url Decoded
- (NSString*)lgf_UrlDecodedString;
@end
