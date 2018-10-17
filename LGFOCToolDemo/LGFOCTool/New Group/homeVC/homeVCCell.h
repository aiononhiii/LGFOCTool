//
//  homeVCCell.h
//  LGFOCTool
//
//  Created by apple on 2018/9/30.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeVCCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellRight;
@property (nonatomic, strong) NSIndexPath *index;
@end
