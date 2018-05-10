//
//  NSData+LGFBase64.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (LGFBase64)

#pragma mark - base64 字符串 转 NSData
+ (NSData *)lgf_Base64DataFromString:(NSString *)string;

@end
