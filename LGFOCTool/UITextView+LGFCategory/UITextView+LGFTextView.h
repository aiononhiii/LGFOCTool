//
//  UITextView+LGFTextView.h
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LGFTextView)

#pragma mark - UITextView输入长度限制
/**
 @param maxLength 限制的长度
 */
- (void)limitIncludeForLength:(NSUInteger)maxLength;

@end
