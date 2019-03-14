//
//  LGFCenterPageVC.h
//  LGFOCTool
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"
#import "LGFPageTitleView.h"

typedef NS_ENUM(NSUInteger, lgf_LoadType) {
    lgf_LoadData,
    lgf_LoadMoreData,
};

@protocol LGFCenterPageVCDelegate <NSObject>
// lgf_CenterPageCV 分页主控制器加载数据
- (void)lgf_CenterPageVCLoadData:(UIViewController *)centerPageVC;
// lgf_CenterPageChildCV 子控制器加载数据
- (void)lgf_CenterPageChildVCLoadData:(UIViewController *)centerPageChildVC selectIndex:(NSInteger)selectIndex loadType:(lgf_LoadType)loadType;
// 配置内部 centerPageChildVC
- (void)lgf_CenterChildPageVCDidLoad:(UIViewController *)centerPageChildVC;
// 返回 cell 个数
- (NSInteger)lgf_NumberOfItems:(UIViewController *)centerPageChildVC;
// 返回 cell 大小
- (CGSize)lgf_SizeForItemAtIndexPath:(NSIndexPath *)indexPath centerPageChildVC:(UIViewController *)centerPageChildVC;
// 返回 cellclass 用于注册cell 如果是xibcell 请建立与 cellclass 相同名字的 xib
- (Class)lgf_CenterChildPageCVCellClass:(UIViewController *)centerPageChildVC;
// cell 数据源赋值
- (void)lgf_CenterChildPageVC:(UIViewController *)centerPageChildVC cell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath;
// cell 点击事件
- (void)lgf_CenterChildPageVC:(UIViewController *)centerPageChildVC didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface LGFCenterPageVC : UIViewController
@property (nonatomic, weak, nullable) id <LGFCenterPageVCDelegate> delegate;
@property (strong, nonatomic) LGFPageTitleStyle *lgf_PageTitleStyle;
// header view
@property (weak, nonatomic) UIView *lgf_HeaderView;
// lgf_PageTitleView 父控件(superview)
@property (strong, nonatomic) UIView *lgf_PageTitleSuperView;
// header view 高度
@property (assign, nonatomic) CGFloat lgf_HeaderHeight;
// page title view 高度
@property (assign, nonatomic) CGFloat lgf_PageTitleViewHeight;
// 分页滚动 UICollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *lgf_CenterPageCV;
// 子控制器数组
@property (nonatomic, strong) NSMutableArray *lgf_ChildVCArray;
lgf_SBViewControllerForH;
- (void)reloadPageTitleWidthArray:(NSMutableArray *)dataArray;
- (void)lgf_ShowInVC:(UIViewController *)VC view:(UIView *)view;
@end
