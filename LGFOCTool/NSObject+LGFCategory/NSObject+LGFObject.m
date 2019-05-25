//
//  NSObject+LGFObject.m
//  LGFOCTool
//
//  Created by apple on 2019/4/28.
//  Copyright © 2019年 来国锋. All rights reserved.
//

#import "NSObject+LGFObject.h"

@implementation NSObject (LGFObject)

- (NSString *)lgf_KeepDecimals:(int)num {
    NSString *floatStr = [NSString stringWithFormat:@"%@", self];
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:num raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:[floatStr doubleValue]];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@", roundedOunces];
}

@end
