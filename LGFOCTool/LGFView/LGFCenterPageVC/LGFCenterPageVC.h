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
@protocol LGFCenterPageVCDelegate <NSObject>
// 外部可以配置内部 UICollectionView
- (void)lgf_CenterChildPageCVConfig:(UICollectionView *)collectionView;
// 返回 cell 个数
- (NSInteger)lgf_NumberOfItemsInSelectIndex:(NSInteger)selectIndex collectionView:(UICollectionView *)collectionView;
// 返回 cellclass 用于注册cell 如果是xibcell 请建立与 cellclass 相同名字的 xib
- (Class)lgf_CenterChildPageCVCellClassForCV:(UICollectionView *)collectionView;
// cell 数据源赋值
- (void)lgf_CenterChildPageCVCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath selectIndex:(NSInteger)selectIndex collectionView:(UICollectionView *)collectionView;
// cell 点击事件
- (void)lgf_CenterChildPageCV:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectIndex:(NSInteger)selectIndex;
@end
@interface LGFCenterPageVC : UIViewController
@property (nonatomic, weak, nullable) id <LGFCenterPageVCDelegate> delegate;
@property (strong, nonatomic) LGFPageTitleStyle *lgf_PageTitleStyle;
// header view
@property (strong, nonatomic) UIView *lgf_HeaderView;
// lgf_PageTitleView 父控件(superview)
@property (strong, nonatomic) UIView *lgf_PageTitleSuperView;
// header view 高度
@property (assign, nonatomic) CGFloat lgf_HeaderHeight;
// page title view 高度
@property (assign, nonatomic) CGFloat lgf_PageTitleViewHeight;
// 分页滚动 UICollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *lgf_CenterPageCV;
// page title 数组
@property (nonatomic, strong) NSMutableArray *lgf_PageTitleArray;
lgf_SBViewControllerForH;
- (void)lgf_ShowInVC:(UIViewController *)VC view:(UIView *)view;
@end
