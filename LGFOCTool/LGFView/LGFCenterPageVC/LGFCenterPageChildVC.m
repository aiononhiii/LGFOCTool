//
//  pageChildVC.m
//  LGFOCTool
//
//  Created by apple on 2018/10/27.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFCenterPageChildVC.h"

#undef lgf_CenterChildPageCVRealRect
#define lgf_CenterChildPageCVRealRect ([self.view.superview convertRect:self.view.frame toView:nil])

@interface LGFCenterPageChildVC ()
@end

@implementation LGFCenterPageChildVC

lgf_SBViewControllerForM(LGFCenterPageChildVC, @"LGFCenterPageVC", @"LGFCenterPageChildVC");

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 给 header view 预留 top 空间
    if (self.lgf_CenterChildPageCV.contentInset.top != self.lgf_HeaderHeight) {
        [self.lgf_CenterChildPageCV setContentInset:UIEdgeInsetsMake(self.lgf_HeaderHeight, 0, 0, 0)];
        [self.lgf_PanScrollView setContentInset:UIEdgeInsetsMake(self.lgf_HeaderHeight, 0, 0, 0)];
    }
    
    // 外部 cell 注册
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageCVCellClass:)]) {
        lgf_RegisterNibCollectionViewCell(self.lgf_CenterChildPageCV, [self.delegate lgf_CenterChildPageCVCellClass:self], NSStringFromClass([self.delegate lgf_CenterChildPageCVCellClass:self]))
    }
    
    // 添加分页控制逻辑通知
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageCVConfig:)] && self) {
        [self.delegate lgf_CenterChildPageCVConfig:self.lgf_CenterChildPageCV];
    }
    
    if (self.lgf_SelectIndex == 0) {
        [self.lgf_CenterChildPageCV setContentOffset:CGPointMake(0, -self.lgf_HeaderHeight) animated:NO];
    }
    
    // 判断 数据源是否足以支撑全屏 ContentSize
    self.lgf_IsGreaterFullContentSize = self.lgf_CenterChildPageCV.contentSize.height > lgf_ScreenHeight - lgf_CenterChildPageCVRealRect.origin.y;
}

#pragma mark - 空白占位逻辑优化
- (void)lgf_SynContentSize {
    [self.lgf_CenterChildPageCV setNeedsLayout];
    [self.lgf_CenterChildPageCV layoutIfNeeded];
    self.lgf_PanScrollView.contentSize = self.lgf_CenterChildPageCV.contentSize;
    if (self.lgf_CenterChildPageCV.contentSize.height < lgf_ScreenHeight - lgf_CenterChildPageCVRealRect.origin.y - self.lgf_PageTitleViewHeight) {
        [self.lgf_CenterChildPageCV setContentInset:UIEdgeInsetsMake(self.lgf_HeaderHeight, 0, lgf_ScreenHeight - lgf_CenterChildPageCVRealRect.origin.y - self.lgf_PageTitleViewHeight - self.lgf_CenterChildPageCV.contentSize.height, 0)];
        [self.lgf_PanScrollView setContentInset:UIEdgeInsetsMake(self.lgf_HeaderHeight, 0, lgf_ScreenHeight - lgf_CenterChildPageCVRealRect.origin.y - self.lgf_PageTitleViewHeight - self.lgf_PanScrollView.contentSize.height, 0)];
        if (self.lgf_PageTitleViewIsCenter) {
            [self.lgf_CenterChildPageCV setContentOffset:CGPointMake(0, -(self.lgf_PageTitleViewHeight)) animated:NO];
        }
    }
}

#pragma mark - Collection View DataSource And Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(lgf_NumberOfItems:)] && self) {
        if (!self.lgf_PageChildDataArray || self.lgf_PageChildDataArray.count == 0) {
            return 0;
        }
        return [self.delegate lgf_NumberOfItems:self];
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(lgf_SizeForItemAtIndexPath:centerPageChildVC:)] && self) {
        return [self.delegate lgf_SizeForItemAtIndexPath:indexPath centerPageChildVC:self];
    }
    return CGSizeZero;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self.delegate lgf_CenterChildPageCVCellClass:self]) forIndexPath:indexPath];
    if (self.lgf_PageChildDataArray.count > 0) {
        if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageVC:cell:indexPath:)] && self) {
            [self.delegate lgf_CenterChildPageVC:self cell:cell indexPath:indexPath];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageVC:didSelectItemAtIndexPath:)] && self) {
        [self.delegate lgf_CenterChildPageVC:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - 以一个 空白ScrollView 联动两个非父子关系控件的核心代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f", scrollView.contentOffset.y);
    if (scrollView == self.lgf_PanScrollView) {
        // 让 lgf_CenterChildPageCV 与 lgf_PanScrollView 联动
        [self.lgf_CenterChildPageCV setContentOffset:self.lgf_PanScrollView.contentOffset];
        // 如果 lgf_CenterChildPageCV 滚动被暂停
        if (self.lgf_CenterChildPageCV.tracking) {
            [self showHeaderTapView];
            [self hidePanScrollView];
            // 暂停 lgf_PanScrollView 滚动
            [self.lgf_PanScrollView setContentOffset:self.lgf_PanScrollView.contentOffset animated:NO];
        }
    } else {
        // 让 lgf_PanScrollView 与 lgf_CenterChildPageCV 联动
        [self.lgf_PanScrollView setContentOffset:self.lgf_CenterChildPageCV.contentOffset];
        [lgf_NCenter postNotificationName:@"childScroll" object:@[@(scrollView.contentOffset.y), @(self.lgf_SelectIndex)]];
        // 如果 lgf_PanScrollView 滚动被暂停
        if (self.lgf_PanScrollView.tracking) {
            [self hideHeaderTapView];
            [self showPanScrollView];
            // 暂停 lgf_CenterChildPageCV 滚动
            [self.lgf_CenterChildPageCV setContentOffset:self.lgf_CenterChildPageCV.contentOffset animated:NO];
        }
    }
}
// 滚动是否手动暂停
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (!self.lgf_CenterChildPageCV.tracking) {
            [self hidePanScrollView];
        }
        if (!self.lgf_PanScrollView.tracking) {
            [self hideHeaderTapView];
        }
        self.lgf_CenterPageCV.scrollEnabled = YES;
    }
}
// 滚动是否开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lgf_CenterPageCV.scrollEnabled = NO;
}
// 滚动是否暂停
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!self.lgf_CenterChildPageCV.tracking) {
        [self hidePanScrollView];
    }
    if (!self.lgf_PanScrollView.tracking) {
        [self hideHeaderTapView];
    }
    self.lgf_CenterPageCV.scrollEnabled = YES;
}
// 隐藏 lgf_PanScrollView 展示 lgf_CenterChildPageCV, 并将 pan 手势重新赋值到 lgf_CenterChildPageCV
- (void)hidePanScrollView {
    [self.view bringSubviewToFront:self.lgf_CenterChildPageCV];
    [self.lgf_PanScrollView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         if ([obj isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.lgf_CenterChildPageCV addGestureRecognizer:obj];
         }
     }];
}
// 展示 lgf_PanScrollView 隐藏 lgf_CenterChildPageCV, 并将 pan 手势赋值到 空白ScrollView
- (void)showPanScrollView {
    [self.view bringSubviewToFront:self.lgf_PanScrollView];
    [self.lgf_CenterChildPageCV.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.lgf_PanScrollView addGestureRecognizer:obj];
        }
    }];
}
// 隐藏 lgf_HeaderTapView 展示 lgf_HeaderSuperView, 并将之前从 lgf_PanScrollView 得到的 pan 手势重新赋值到 lgf_HeaderSuperView
- (void)hideHeaderTapView {
    [self.LGFCenterPageView bringSubviewToFront:self.lgf_HeaderSuperView];
    [self.lgf_HeaderTapView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.lgf_HeaderSuperView addGestureRecognizer:obj];
        }
    }];
}
// 展示 lgf_HeaderTapView 隐藏 lgf_HeaderSuperView, 并将之前从 lgf_PanScrollView 得到的 pan 手势赋值到 lgf_HeaderTapView
- (void)showHeaderTapView {
    [self.LGFCenterPageView bringSubviewToFront:self.lgf_HeaderTapView];
    [self.lgf_HeaderSuperView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIPanGestureRecognizer class]]) {
            [self.lgf_HeaderTapView addGestureRecognizer:obj];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 懒加载
- (NSMutableArray *)lgf_PageChildDataArray {
    if (!_lgf_PageChildDataArray) {
        _lgf_PageChildDataArray = [NSMutableArray new];
    }
    return _lgf_PageChildDataArray;
}

@end
