//
//  NSMutableArray+LGFMutableArray.m
//  LGFOCTool
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "NSMutableArray+LGFMutableArray.h"

@implementation NSMutableArray (LGFMutableArray)

- (void)lgf_arraySupplementInteger:(int)column {
    int placeholderCount = column - (self.count % column);
    for (int i = 0; i < placeholderCount; i++) {
        [self addObject:@""];
    }
}

@end
