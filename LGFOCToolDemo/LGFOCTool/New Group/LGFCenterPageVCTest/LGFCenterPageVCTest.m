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
#import "LGFCenterPageChildVC.h"

@interface LGFCenterPageVCTest () <LGFCenterPageVCDelegate>
@property (strong, nonatomic) IBOutlet UIView *testHeaderView;
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (strong, nonatomic) NSMutableArray *dataArray;
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
    vc.lgf_HeaderHeight = 110 + 50;
    vc.lgf_PageTitleViewHeight = 50;
    vc.lgf_HeaderView = self.testHeaderView;
    [vc lgf_ShowInVC:self view:self.testView];
    self.dataArray = [NSMutableArray arrayWithArray:@[@"淘宝", @"京东", @"腾讯", @"网易", @"尚衣会", @"腾讯", @"网易", @"尚衣会", @"腾讯", @"网易", @"尚衣会", @"腾讯", @"网易", @"尚衣会"]];
    [vc reloadPageTitleWidthArray:(NSMutableArray *)@[@"淘宝", @"京东", @"腾讯", @"网易", @"尚衣会", @"腾讯", @"网易", @"尚衣会", @"腾讯", @"网易", @"尚衣会", @"腾讯", @"网易", @"尚衣会"]];
}

#pragma mark - LGFCenterPageChildVC Delegate

- (void)lgf_CenterPageVCLoadData:(UIViewController *)centerPageVC {
    
}

- (void)lgf_CenterPageChildVCLoadData:(UIViewController *)centerPageChildVC selectIndex:(NSInteger)selectIndex loadType:(lgf_LoadType)loadType {
    LGFCenterPageChildVC *vc = (LGFCenterPageChildVC *)centerPageChildVC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [vc.lgf_CenterChildPageCV lgf_PageEndRefreshing];
        [vc.lgf_PanScrollView lgf_PageEndRefreshing];
        // 加载数据
        if (selectIndex == 4) {
            vc.lgf_PageChildDataArray = [NSMutableArray arrayWithArray:@[@"水杯", @"笔记本", @"汽车"]];
        } else if (selectIndex == 6) {
            vc.lgf_PageChildDataArray = [NSMutableArray arrayWithArray:@[]];
        } else {
            if (vc.lgf_Page == 1) {
                vc.lgf_PageChildDataArray = [NSMutableArray arrayWithArray:@[@"淘宝", @"淘宝", @"淘宝", @"淘宝", @"淘宝"]];
            } else {
                [vc.lgf_PageChildDataArray addObjectsFromArray:@[@"淘宝"]];
                [vc.lgf_PageChildDataArray addObject:@"京东"];
                [vc.lgf_PageChildDataArray addObject:@"腾讯"];
            }
        }
        [vc.lgf_PageChildDataHeightArray removeAllObjects];
        [vc.lgf_PageChildDataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [vc.lgf_PageChildDataHeightArray addObject:@(250)];
        }];
        
        vc.lgf_Page++;
        // 加载数据完毕
        [vc.lgf_CenterChildPageCV reloadData];
        [vc lgf_SynContentSize];
    });
}

- (void)lgf_CenterChildPageVCDidLoad:(UIViewController *)centerPageChildVC {
    
}

- (NSInteger)lgf_NumberOfItems:(UIViewController *)centerPageChildVC {
    LGFCenterPageChildVC *vc = (LGFCenterPageChildVC *)centerPageChildVC;
    return vc.lgf_PageChildDataArray.count;
}

- (CGSize)lgf_SizeForItemAtIndexPath:(NSIndexPath *)indexPath centerPageChildVC:(UIViewController *)centerPageChildVC {
    LGFCenterPageChildVC *vc = (LGFCenterPageChildVC *)centerPageChildVC;
    return CGSizeMake(lgf_ScreenWidth, [vc.lgf_PageChildDataHeightArray[indexPath.item] floatValue]);
}

- (Class)lgf_CenterChildPageCVCellClass:(UIViewController *)centerPageChildVC {
    return [TestPageCell class];
}

- (void)lgf_CenterChildPageVC:(UIViewController *)centerPageChildVC cell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    LGFCenterPageChildVC *vc = (LGFCenterPageChildVC *)centerPageChildVC;
    TestPageCell *bcell = (TestPageCell *)cell;
    bcell.testLabel.text = vc.lgf_PageChildDataArray[indexPath.item];
    bcell.testLabelTwo.text = vc.lgf_PageChildDataArray[indexPath.item];
    bcell.testImage.image = [UIImage imageNamed:@"timg16.jpeg"];
}

- (void)lgf_CenterChildPageVC:(UIViewController *)centerPageChildVC didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [lgf_Application.windows.firstObject.rootViewController.view lgf_ShowMessage:@"点击有效了" animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

@end
