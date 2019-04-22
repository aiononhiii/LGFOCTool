//
//  LGFEmoji.h
//  OptimalLive
//
//  Created by apple on 2019/4/17.
//  Copyright © 2019年 QT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGFEmoji : UIView
@property (weak, nonatomic) UITextView *lgf_EmojiTextView;
@property (strong, nonatomic) NSMutableArray *lgf_EmojiArray;
@property (strong, nonatomic) NSMutableArray *lgf_EmojiStrArray;
@property (strong, nonatomic) UIColor *lgf_EmojiReadySendColor;
@property (weak, nonatomic) IBOutlet UIButton *lgf_EmojiDelete;
@property (weak, nonatomic) IBOutlet UIButton *lgf_EmojiSend;
@property (weak, nonatomic) IBOutlet UIPageControl *lgf_EmojiPage;
@property (assign, nonatomic) CGFloat lgf_EmojiSpacing;
@property (assign, nonatomic) BOOL lgf_EmojiSendBtnSelect;
@property (nonatomic, copy) void (^lgf_EmojiDidchange)(void);
@property (nonatomic, copy) void (^lgf_EmojiSendBolck)(void);
+ (instancetype)lgf;
+ (NSMutableAttributedString *)lgf_ImageToEmojiForText:(NSString *)text Y:(CGFloat)Y;
@end

NS_ASSUME_NONNULL_END
