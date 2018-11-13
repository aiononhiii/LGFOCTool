//
//  LGFCenterPageVCTest.m
//  LGFOCTool
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFCenterPageVCTest.h"
#import "TestPageCell.h"
#import "LGFCenterPageVC.h"

@interface LGFCenterPageVCTest () <LGFCenterPageVCDelegate>
@property (strong, nonatomic) IBOutlet UIView *testHeaderView;
@property (weak, nonatomic) IBOutlet UIView *testView;
@end

@implementation LGFCenterPageVCTest

lgf_SBViewControllerForM(LGFCenterPageVCTest, @"Main", @"LGFCenterPageVCTest");

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LGFCenterPageVC *vc = [LGFCenterPageVC lgf];
    LGFPageTitleStyle *style = [LGFPageTitleStyle na];
    style.line_width_type = FixedWith;
    style.line_width = 10;
    style.left_image_spacing = 15;
    style.right_image_spacing = 15;
    style.line_height = 4;
    style.title_big_scale = 1.6;
    style.line_bottom = 0;
    style.select_title_font = [UIFont boldSystemFontOfSize:14];
    style.un_select_title_font = [UIFont systemFontOfSize:14];
    style.select_color = lgf_HexColor(@"000000");
    style.un_select_color = lgf_HexColor(@"808080");
    style.is_title_center = NO;
    vc.lgf_PageTitleStyle = style;
    
    vc.delegate = self;
    vc.lgf_HeaderHeight = 990 + 50;
    vc.lgf_PageTitleViewHeight = 50;
    vc.lgf_PageTitleArray = (NSMutableArray *)@[@"淘宝", @"京东", @"腾讯", @"网易", @"尚衣会", @"腾讯", @"网易", @"尚衣会", @"腾讯", @"网易", @"尚衣会", @"腾讯", @"网易", @"尚衣会"];
    vc.lgf_HeaderView = self.testHeaderView;
    [vc lgf_ShowInVC:self view:self.testView];
    
    
}

#pragma mark - LGFCenterPageChildVC Delegate

- (void)lgf_CenterChildPageCVConfig:(UICollectionView *)collectionView {
    
}

- (NSInteger)lgf_NumberOfItemsInSelectIndex:(NSInteger)selectIndex collectionView:(UICollectionView *)collectionView {
    if (selectIndex == 2) {
        return 3;
    } else if (selectIndex == 4) {
        return 1;
    }
    return 15;
}

- (Class)lgf_CenterChildPageCVCellClassForCV:(UICollectionView *)collectionView {
    return [TestPageCell class];
}

- (void)lgf_CenterChildPageCVCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath selectIndex:(NSInteger)selectIndex collectionView:(UICollectionView *)collectionView {
    TestPageCell *bcell = (TestPageCell *)cell;
    if (indexPath.item % 2 == 0) {
        bcell.backgroundColor = [UIColor redColor];
    } else {
        bcell.backgroundColor = [UIColor whiteColor];
    }
}

- (void)lgf_CenterChildPageCV:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectIndex:(NSInteger)selectIndex {
    [lgf_Application.windows.firstObject.rootViewController.view lgf_ShowMessage:@"点击有效了" animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
