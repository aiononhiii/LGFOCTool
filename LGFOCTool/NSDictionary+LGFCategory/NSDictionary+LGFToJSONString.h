//
//  NSDictionary+LGFToJSONString.h
//  LGFOCTool
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LGFToJSONString)

#pragma mark - 字典转 JSON字符串

- (NSString *)lgf_DictionaryToJson;

#pragma mark - 字典转 JSON字符串

- (NSString *)lgf_DictionaryToJsonTwo;

#pragma mark - 字典转 urlEncoded字符串

- (NSString *)lgf_UrlEncodedKeyValueString;

#pragma mark - JSON字符串转字典

+ (NSDictionary *)lgf_DictFromString:(NSString *)jsonString;

@end
