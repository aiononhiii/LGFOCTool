//
//  UITextField+LGFTextField.h
//  LGFOCTool
//
//  Created by apple on 2018/5/2.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LGFTextField)

#pragma mark - UITextField输入长度限制
/**
 @param maxLength 限制的长度
 */
- (void)limitIncludeForLength:(NSUInteger)maxLength;

@end
