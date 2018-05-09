//
//  NSString+LGFBase64.h
//  LGFOCTool
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LGFBase64)

#pragma mark - NSData 转 base64 字符串
+ (NSString *)lgf_Base64StringFromData:(NSData *)data length:(NSUInteger)length;

@end
