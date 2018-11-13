//
//  pageChildVC.h
//  LGFOCTool
//
//  Created by apple on 2018/10/27.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"

@protocol LGFCenterPageChildVCDelegate <NSObject>
// 配置内部 UICollectionView
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
@interface LGFCenterPageChildVC : UIViewController
@property (nonatomic, weak, nullable) id <LGFCenterPageChildVCDelegate> delegate;
// 内部子控制器 UICollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *lgf_CenterChildPageCV;
// 用于控制联动的 空白ScrollView
@property (weak, nonatomic) IBOutlet UIScrollView *lgf_PanScrollView;
// 父控制器传进来的 
@property (weak, nonatomic) UIView *lgf_HeaderTapView;
@property (weak, nonatomic) UIView *lgf_HeaderSuperView;
@property (weak, nonatomic) UIView *LGFCenterPageView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat pageHeight;
lgf_SBViewControllerForH;
@end
