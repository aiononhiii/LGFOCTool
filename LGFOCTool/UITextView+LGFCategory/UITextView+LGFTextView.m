//
//  UITextView+LGFTextView.m
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "UITextView+LGFTextView.h"
#import <objc/runtime.h>
#import "LGFOCTool.h"

static const char *lgf_IsZeroInsetKey = "lgf_IsZeroInsetKey";

@implementation UITextView (LGFTextView)

@dynamic lgf_IsZeroInset;

#pragma mark - 是否取消默认边距离

- (BOOL)lgf_IsZeroInset {
    return [objc_getAssociatedObject(self, &lgf_IsZeroInsetKey) boolValue];
}

- (void)setLgf_IsZeroInset:(BOOL)lgf_IsZeroInset {
    objc_setAssociatedObject(self, &lgf_IsZeroInsetKey, [NSNumber numberWithBool:lgf_IsZeroInset], OBJC_ASSOCIATION_ASSIGN);
    if (lgf_IsZeroInset) {
        self.textContainer.lineFragmentPadding = 0;
        self.textContainerInset = UIEdgeInsetsZero;
    }
}

#pragma mark - UITextView输入长度限制
/**
 @param maxLength 限制的长度
 */
- (void)lgf_LimitIncludeForLength:(NSUInteger)maxLength {
    NSString *toBeString = self.text;
    
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > maxLength) {
                self.text = [toBeString substringToIndex:maxLength];
            }
        }
    }else{
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > maxLength) {
            self.text = [toBeString substringToIndex:maxLength];
        }
    }
}

#pragma mark - 关键字高亮
/**
 @param color 关键字高亮颜色
 @param text 高亮关键字
 */
- (void)lgf_KeywordHighlightColor:(UIColor *)color text:(NSString *)text {
    return [self lgf_KeywordHighlightColor:color font:self.font text:text];
}
/**
 @param color 关键字高亮颜色
 @param font 关键字字体
 @param text 高亮关键字
 */
- (void)lgf_KeywordHighlightColor:(UIColor *)color font:(UIFont *)font text:(NSString *)text {
    // 获取关键字的位置
    NSRange range = [self.text rangeOfString:text];
    // 转换成可以操作的字符串类型.
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.text];
    // 添加属性(粗体)
    [attribute addAttribute:NSFontAttributeName value:font range:range];
    // 关键字高亮
    [attribute addAttribute:NSForegroundColorAttributeName value:color range:range];
    // 将带属性的字符串添加到cell.textLabel上.
    [self setAttributedText:attribute];
}

- (void)lgf_KeywordHighlightTexts:(NSArray *)texts {
    // 获取关键字的位置
    NSArray *ranges = [self rangeOfSubString:texts inString:self.text];
    // 转换成可以操作的字符串类型.
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attribute addAttribute:NSForegroundColorAttributeName value:self.textColor range:[self.text rangeOfString:self.text]];
    [attribute addAttribute:NSFontAttributeName value:self.font range:[self.text rangeOfString:self.text]];
    [ranges enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 添加属性(粗体)
        [attribute addAttribute:NSFontAttributeName value:self.font range:[obj[@"range"] rangeValue]];
        // 关键字高亮
        [attribute addAttribute:NSForegroundColorAttributeName value:lgf_HexColor(obj[@"color"]) range:[obj[@"range"] rangeValue]];
    }];
    // 将带属性的字符串添加到cell.textLabel上.
    [self setAttributedText:attribute];
}

- (NSArray*)rangeOfSubString:(NSArray *)texts inString:(NSString*)string {
    NSMutableArray *rangeArray = [NSMutableArray array];
    [texts enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull subStrDict, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *subStr = subStrDict[@"text"];
        NSString *string1 = [string stringByAppendingString:subStr];
        
        //
        NSString *temp;
        for(int i = 0; i < string.length; i ++) {
            temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
            if ([temp isEqualToString:subStr]) {
                NSRange range = {i, subStr.length};
                [rangeArray addObject:@{@"range" : [NSValue valueWithRange:range], @"color" : subStrDict[@"color"]}];
            }
        }
        // @""字符串高亮
        if ([subStr isEqualToString:@"@(\"([^\"]*)\")"]) {
            NSError *error = nil;
            NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:subStr options:NSRegularExpressionCaseInsensitive error:&error];
            [regularExp enumerateMatchesInString:self.text options:NSMatchingReportProgress range:NSMakeRange(0, self.text.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                if (result) {
                    [rangeArray addObject:@{@"range" : [NSValue valueWithRange:result.range], @"color" : subStrDict[@"color"]}];
                }
            }];
        }
        
    }];
    return rangeArray;
}

@end
