//
//  shareView.h
//  LGFOCTool
//
//  Created by apple on 2018/10/9.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"

@interface shareView : UIView
typedef void(^shareViewBlock)(UIImage *image);
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareViewBottom;
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIView *shareBackView;
@property (weak, nonatomic) IBOutlet UIView *shareBottomView;
@property (nonatomic, copy) shareViewBlock shareBlock;
lgf_XibViewForH;
- (void)showShareView:(UIView *)SV shareUrl:(NSString *)shareUrl;
@end
