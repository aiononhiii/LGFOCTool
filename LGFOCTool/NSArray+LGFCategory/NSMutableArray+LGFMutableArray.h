//
//  NSMutableArray+LGFMutableArray.h
//  LGFOCTool
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (LGFMutableArray)

#pragma mark - 数组填充 column - (self.count % column) 个空占位字符串
/**
 @param column 列数
 */
- (void)lgf_arraySupplementInteger:(int)column;
@end
