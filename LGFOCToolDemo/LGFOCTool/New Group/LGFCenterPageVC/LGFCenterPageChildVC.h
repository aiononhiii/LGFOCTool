//
//  pageChildVC.h
//  LGFOCTool
//
//  Created by apple on 2018/10/27.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"
#import "LGFCenterPageVC.h"

typedef NS_ENUM(NSUInteger, lgf_ChildLoadType) {
    lgf_ChildLoadData,
    lgf_ChildLoadMoreData,
};

@protocol LGFCenterPageChildVCDelegate <NSObject>
// lgf_CenterPageCV 分页主控制器加载数据
- (void)lgf_CenterPageVCLoadData;
// lgf_CenterPageChildCV 子控制器加载数据
- (void)lgf_CenterPageChildVCLoadData:(UIViewController *)centerPageChildVC selectIndex:(NSInteger)selectIndex loadType:(lgf_ChildLoadType)loadType;
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
@interface LGFCenterPageChildVC : UIViewController
@property (nonatomic, weak, nullable) id <LGFCenterPageChildVCDelegate> delegate;
// 内部子控制器 UICollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *lgf_CenterChildPageCV;
// 用于控制联动的 空白ScrollView
@property (weak, nonatomic) IBOutlet UIScrollView *lgf_PanScrollView;
// 外部分页滚动 UICollectionView
@property (weak, nonatomic) UICollectionView *lgf_CenterPageCV;
@property (strong, nonatomic) NSMutableArray *lgf_PageChildDataArray;
// 父控制器传进来的
@property (weak, nonatomic) UIView *lgf_HeaderTapView;
@property (weak, nonatomic) UIView *lgf_HeaderSuperView;
@property (weak, nonatomic) UIView *LGFCenterPageView;
@property (nonatomic, assign) NSInteger lgf_SelectIndex;
@property (nonatomic, assign) CGFloat lgf_HeaderHeight;
@property (nonatomic, assign) CGFloat lgf_PageTitleViewHeight;
@property (assign, nonatomic) BOOL lgf_PageTitleViewIsCenter;
@property (assign, nonatomic) BOOL lgf_IsGreaterFullContentSize;
@property (assign, nonatomic) NSInteger lgf_Page;

lgf_SBViewControllerForH;
// 同步 lgf_PanScrollView 和 lgf_CenterChildPageCV 的 ContentSize
- (void)lgf_SynContentSize;
- (void)lgf_SetMJMJRefreshHeader;
- (void)lgf_SetMJMJRefreshFooter;
@end
