//
//  NSString+LGFHash.h
//  LGFOCTool
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LGFHash)

#pragma mark -  md5 加密
@property (readonly) NSString *lgf_MD5String;

#pragma mark -  sha1 加密
@property (readonly) NSString *lgf_SHA1String;

#pragma mark -  sha256 加密
@property (readonly) NSString *lgf_SHA256String;

#pragma mark -  sha512 加密
@property (readonly) NSString *lgf_SHA512String;

#pragma mark - HMAC+MD5 加密
- (NSString *)lgf_HmacMD5StringWithKey:(NSString *)key;

#pragma mark - HMAC+SHA1 加密
- (NSString *)lgf_HmacSHA1StringWithKey:(NSString *)key;

#pragma mark - HMAC+SHA256 加密
- (NSString *)lgf_HmacSHA256StringWithKey:(NSString *)key;

#pragma mark - HMAC+SHA512 加密
- (NSString *)lgf_HmacSHA512StringWithKey:(NSString *)key;
@end
