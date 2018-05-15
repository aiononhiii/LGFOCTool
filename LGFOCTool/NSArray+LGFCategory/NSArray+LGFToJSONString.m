//
//  NSArray+LGFToJSONString.m
//  LGFOCTool
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "NSArray+LGFToJSONString.h"

@implementation NSArray (LGFToJSONString)

#pragma mark - 数组转 JSON字符串

- (NSString *)lgf_ArrayToJson {
    NSString *json = nil;
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if(!error) {
        json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    } else {
        return error.localizedDescription;
    }
}

@end
