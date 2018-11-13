//
//  lgf_CenterPageCV.m
//  LGFOCTool
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFCenterPageVC.h"
#import "LGFCenterPageChildVC.h"

@interface LGFCenterPageVC () <LGFPageTitleViewDelegate, LGFCenterPageChildVCDelegate>
// header view
@property (strong, nonatomic) IBOutlet UIView *lgf_HeaderViewForSB;
// lgf_PageTitleView 父控件(superview)
@property (strong, nonatomic) IBOutlet UIView *lgf_PageTitleSuperViewForSB;
// 导航栏整体view
@property (weak, nonatomic) IBOutlet UIView *naviView;
// 导航栏标view
@property (weak, nonatomic) IBOutlet UIView *naviTitleView;
// 导航栏顶部约束 用于某些情况下需要隐藏导航栏 直接赋值（-系统导航栏电池栏总高度）
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *naviTop;
// 头部父控件
@property (strong, nonatomic) IBOutlet UIView *lgf_HeaderSuperView;
// 联动点击view
@property (strong, nonatomic) IBOutlet UIView *lgf_HeaderTapView;
// header view 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lgf_PageTitleSuperViewHeight;
// 分页控件 底部分割线 根据 contentOffset.y 自动显示
@property (weak, nonatomic) IBOutlet UIView *lgf_PageTitleSuperViewLine;
// 分页控件
@property (strong, nonatomic) LGFPageTitleView *lgf_PageTitleView;
// 子控制器数组
@property (nonatomic, strong) NSMutableArray *childVCArray;
// 子控制器记录用 contentOffset.y
@property (nonatomic, assign) CGFloat offsetY;
// 当前选择子控制器 selectIndex
@property (nonatomic, assign) NSInteger selectIndex;
// 是否滚动到顶部
@property (nonatomic, assign) BOOL isTopScroll;
@end

@implementation LGFCenterPageVC

lgf_SBViewControllerForM(LGFCenterPageVC, @"LGFCenterPageVC", @"LGFCenterPageVC");

- (void)lgf_ShowInVC:(UIViewController *)VC view:(UIView *)view {
    [VC addChildViewController:self];
    self.view.frame = view.bounds;
    [view addSubview:self.view];
    view.clipsToBounds = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.lgf_HeaderView) {
        self.lgf_HeaderView.frame = self.lgf_HeaderView.bounds;
        [self.lgf_HeaderViewForSB addSubview:self.lgf_HeaderView];
    }
    if (self.lgf_PageTitleSuperView) {
        self.lgf_PageTitleSuperView.frame = self.lgf_PageTitleSuperViewForSB.bounds;
        [self.lgf_PageTitleSuperViewForSB addSubview:self.lgf_PageTitleSuperView];
    }
    self.lgf_PageTitleSuperViewHeight.constant = self.lgf_PageTitleViewHeight;
    self.lgf_HeaderSuperView.frame = CGRectMake(0, self.lgf_CenterPageCV.lgf_y, lgf_ScreenWidth, self.lgf_HeaderHeight);
    self.lgf_HeaderTapView.frame = self.lgf_HeaderSuperView.frame;
    [self.view addSubview:self.lgf_HeaderTapView];
    [self.view addSubview:self.lgf_HeaderSuperView];
    [self.view bringSubviewToFront:self.naviView];
    [self.view bringSubviewToFront:self.naviTitleView];
    [self.lgf_PageTitleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LGFCenterPageChildVC *vc = [LGFCenterPageChildVC lgf];
        vc.title = obj;
        vc.headerHeight = self.lgf_HeaderHeight;
        vc.pageHeight = self.lgf_PageTitleViewHeight;
        vc.index = idx;
        vc.LGFCenterPageView = self.view;
        vc.lgf_HeaderTapView = self.lgf_HeaderTapView;
        vc.lgf_HeaderSuperView = self.lgf_HeaderSuperView;
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        [self.childVCArray addObject:vc];
    }];
    // 刷新数据源
    [self.lgf_CenterPageCV reloadData];
    // 刷新title数组
    self.lgf_PageTitleView.style.titles = self.lgf_PageTitleArray;
    [self.lgf_PageTitleView reloadAllTitlesSelectIndex:0];
    [lgf_NCenter addObserver:self selector:@selector(childScroll:) name:@"childScroll" object:nil];
}

- (void)dealloc {
    [lgf_NCenter removeObserver:self];
}

#pragma mark - 分页控制部分逻辑
- (void)childScroll:(NSNotification *)noti {
    NSInteger index = [noti.object[1] integerValue];
    if (index == self.selectIndex) {
        self.offsetY = [noti.object[0] floatValue];
        self.lgf_HeaderSuperView.transform = CGAffineTransformMakeTranslation(0, MAX(-(self.offsetY + self.lgf_HeaderHeight), -(self.lgf_HeaderHeight - self.lgf_PageTitleViewHeight)));
        self.lgf_HeaderTapView.transform = self.lgf_HeaderSuperView.transform;
    }
    if (self.lgf_HeaderSuperView.transform.ty > -(self.lgf_HeaderHeight - self.lgf_PageTitleViewHeight)) {
        self.isTopScroll = YES;
        [lgf_NCenter postNotificationName:@"superScroll" object:@[@(self.offsetY), @(self.selectIndex)]];
        self.lgf_PageTitleSuperViewLine.hidden = YES;
    } else {
        self.lgf_PageTitleSuperViewLine.hidden = NO;
    }
}

#pragma mark - LGFCenterPageChildVC Delegate
- (void)lgf_CenterChildPageCVConfig:(UICollectionView *)collectionView {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageCVConfig:)]) {
        return [self.delegate lgf_CenterChildPageCVConfig:collectionView];
    }
}

- (NSInteger)lgf_NumberOfItemsInSelectIndex:(NSInteger)selectIndex collectionView:(UICollectionView *)collectionView {
    if ([self.delegate respondsToSelector:@selector(lgf_NumberOfItemsInSelectIndex:collectionView:)]) {
        return [self.delegate lgf_NumberOfItemsInSelectIndex:selectIndex collectionView:collectionView];
    }
    return 0;
}

- (Class)lgf_CenterChildPageCVCellClassForCV:(UICollectionView *)collectionView {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageCVCellClassForCV:)]) {
        return [self.delegate lgf_CenterChildPageCVCellClassForCV:collectionView];
    }
    return nil;
}

- (void)lgf_CenterChildPageCVCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath selectIndex:(NSInteger)selectIndex collectionView:(UICollectionView *)collectionView {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageCVCell:indexPath:selectIndex:collectionView:)]) {
        [self.delegate lgf_CenterChildPageCVCell:cell indexPath:indexPath selectIndex:selectIndex collectionView:collectionView];
    }
}

- (void)lgf_CenterChildPageCV:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath selectIndex:(NSInteger)selectIndex {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageCV:didSelectItemAtIndexPath:selectIndex:)]) {
        [self.delegate lgf_CenterChildPageCV:collectionView didSelectItemAtIndexPath:indexPath selectIndex:selectIndex];
    }
}

#pragma mark - Collection View DataSource And Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childVCArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.lgf_size;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = lgf_CVGetCell(collectionView, UICollectionViewCell, indexPath);
    cell.tag = indexPath.item;
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    LGFCenterPageChildVC *vc = self.childVCArray[indexPath.item];
    vc.delegate = self;
    vc.view.frame = cell.bounds;
    [cell addSubview:vc.view];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.lgf_HeaderSuperView.transform.ty > -(self.lgf_HeaderHeight - self.lgf_PageTitleViewHeight)) {
        [lgf_NCenter postNotificationName:@"superScroll" object:@[@(self.offsetY), @(self.selectIndex)]];
    } else {
        if (self.isTopScroll) {
            [lgf_NCenter postNotificationName:@"superScroll" object:@[@(-(self.lgf_HeaderHeight + self.lgf_HeaderSuperView.transform.ty)), @(self.selectIndex)]];
        }
    }
}

#pragma arguments LGFPageTitleViewDelegate
- (void)lgf_SelectPageTitle:(NSInteger)selectIndex {
    self.isTopScroll = NO;
    self.selectIndex = selectIndex;
    [self addPan:self.selectIndex];
}

- (void)addPan:(NSInteger)index {
    LGFCenterPageChildVC *vc = self.childVCArray[self.selectIndex];
    [self.lgf_HeaderSuperView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.lgf_HeaderSuperView removeGestureRecognizer:obj];
    }];
    [self.lgf_HeaderSuperView addGestureRecognizer:vc.lgf_PanScrollView.panGestureRecognizer];
}

- (IBAction)tapHeader:(UITapGestureRecognizer *)sender {
    [lgf_Application.windows.firstObject.rootViewController.view lgf_ShowMessage:@"点击有效了" animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 懒加载/Set

- (NSMutableArray *)lgf_PageTitleArray {
    if (!_lgf_PageTitleArray) {
        _lgf_PageTitleArray = [NSMutableArray new];
    }
    return _lgf_PageTitleArray;
}

- (NSMutableArray *)childVCArray {
    if (!_childVCArray) {
        _childVCArray = [NSMutableArray new];
    }
    return _childVCArray;
}

- (LGFPageTitleView *)lgf_PageTitleView {
    if (!_lgf_PageTitleView) {
        _lgf_PageTitleView = [[LGFPageTitleView na] initWithStyle:self.lgf_PageTitleStyle super_vc:self super_view:self.lgf_PageTitleSuperViewForSB page_view:self.lgf_CenterPageCV];
        _lgf_PageTitleView.lgf_PageTitleViewDelegate = self;
    }
    return _lgf_PageTitleView;
}

@end
