//
//  lgf_CenterPageCV.m
//  LGFOCTool
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFCenterPageVC.h"

@interface LGFCenterPageVC () <LGFPageTitleViewDelegate, LGFCenterPageChildVCDelegate>
// header view
@property (strong, nonatomic) IBOutlet UIView *lgf_HeaderViewForSB;
// lgf_PageTitleView 父控件(superview)
@property (strong, nonatomic) IBOutlet UIView *lgf_PageTitleSuperViewForSB;
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
@property (nonatomic, strong) NSMutableArray *lgf_ChildVCArray;
// 子控制器记录用 contentOffset.y
@property (nonatomic, assign) CGFloat lgf_OffsetY;
// 当前选择子控制器 selectIndex
@property (nonatomic, assign) NSInteger lgf_SelectIndex;
// 是否滚动到顶部
@property (nonatomic, assign) BOOL lgf_IsTopScroll;
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
    [self.lgf_PageTitleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LGFCenterPageChildVC *vc = [LGFCenterPageChildVC lgf];
        vc.title = obj;
        vc.lgf_HeaderHeight = self.lgf_HeaderHeight;
        vc.lgf_PageTitleViewHeight = self.lgf_PageTitleViewHeight;
        vc.lgf_SelectIndex = idx;
        vc.lgf_CenterPageCV = self.lgf_CenterPageCV;
        vc.LGFCenterPageView = self.view;
        vc.lgf_HeaderTapView = self.lgf_HeaderTapView;
        vc.lgf_HeaderSuperView = self.lgf_HeaderSuperView;
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        [self.lgf_ChildVCArray addObject:vc];
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
    if (index == self.lgf_SelectIndex) {
        self.lgf_OffsetY = [noti.object[0] floatValue];
        self.lgf_HeaderSuperView.transform = CGAffineTransformMakeTranslation(0, MAX(-(self.lgf_OffsetY + self.lgf_HeaderHeight), -(self.lgf_HeaderHeight - self.lgf_PageTitleViewHeight)));
        self.lgf_HeaderTapView.transform = self.lgf_HeaderSuperView.transform;
    }
    LGFCenterPageChildVC *vc = self.lgf_ChildVCArray[index];
    if ((self.lgf_HeaderSuperView.transform.ty > -(self.lgf_HeaderHeight - self.lgf_PageTitleViewHeight)) && vc.lgf_IsGreaterFullContentSize) {
        self.lgf_IsTopScroll = YES;
        self.lgf_PageTitleSuperViewLine.hidden = YES;
    } else {
        self.lgf_PageTitleSuperViewLine.hidden = NO;
    }
}

#pragma mark - LGFCenterPageChildVC Delegate

- (void)lgf_CenterPageVCLoadData {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterPageVCLoadData:)]) {
        [self.delegate lgf_CenterPageVCLoadData:self];
    }
}

- (void)lgf_CenterChildPageVCDidLoad:(UIViewController *)centerPageChildVC {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageVCDidLoad:)]) {
        return [self.delegate lgf_CenterChildPageVCDidLoad:centerPageChildVC];
    }
}

- (void)lgf_CenterPageChildVCLoadData:(UIViewController *)centerPageChildVC selectIndex:(NSInteger)selectIndex loadType:(lgf_ChildLoadType)loadType {
    LGFCenterPageChildVC *vc = (LGFCenterPageChildVC *)centerPageChildVC;
    if ([self.delegate respondsToSelector:@selector(lgf_CenterPageChildVCLoadData:selectIndex:loadType:)]) {
        [self.delegate lgf_CenterPageChildVCLoadData:vc selectIndex:selectIndex loadType:loadType == lgf_ChildLoadData ? lgf_LoadData : lgf_LoadMoreData];
    }
}

- (NSInteger)lgf_NumberOfItems:(UIViewController *)lgf_CenterChildPageVC {
    if ([self.delegate respondsToSelector:@selector(lgf_NumberOfItems:)]) {
        return [self.delegate lgf_NumberOfItems:lgf_CenterChildPageVC];
    }
    return 0;
}

- (CGSize)lgf_SizeForItemAtIndexPath:(NSIndexPath *)indexPath centerPageChildVC:(UIViewController *)centerPageChildVC {
    if ([self.delegate respondsToSelector:@selector(lgf_SizeForItemAtIndexPath:centerPageChildVC:)] && self) {
        return [self.delegate lgf_SizeForItemAtIndexPath:indexPath centerPageChildVC:self];
    }
    return CGSizeZero;
}

- (Class)lgf_CenterChildPageCVCellClass:(UIViewController *)lgf_CenterChildPageVC {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageCVCellClass:)]) {
        return [self.delegate lgf_CenterChildPageCVCellClass:lgf_CenterChildPageVC];
    }
    return nil;
}

- (void)lgf_CenterChildPageVC:(UIViewController *)lgf_CenterChildPageVC cell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageVC:cell:indexPath:)]) {
        [self.delegate lgf_CenterChildPageVC:lgf_CenterChildPageVC cell:cell indexPath:indexPath];
    }
}

- (void)lgf_CenterChildPageVC:(UIViewController *)lgf_CenterChildPageVC didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(lgf_CenterChildPageVC:didSelectItemAtIndexPath:)]) {
        [self.delegate lgf_CenterChildPageVC:lgf_CenterChildPageVC didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - Collection View DataSource And Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.lgf_ChildVCArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.lgf_size;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = lgf_CVGetCell(collectionView, UICollectionViewCell, indexPath);
    cell.tag = indexPath.item;
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    LGFCenterPageChildVC *vc = self.lgf_ChildVCArray[indexPath.item];
    vc.delegate = self;
    vc.view.frame = cell.bounds;
    [cell addSubview:vc.view];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    LGFCenterPageChildVC *vc = self.lgf_ChildVCArray[indexPath.item];
    if (vc.lgf_PageChildDataArray.count == 0) {
        if ([self.delegate respondsToSelector:@selector(lgf_CenterPageChildVCLoadData:selectIndex:loadType:)]) {
            [self.delegate lgf_CenterPageChildVCLoadData:vc selectIndex:indexPath.item loadType:lgf_LoadData];
        }
    }
    if (vc.lgf_SelectIndex != self.lgf_SelectIndex) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.lgf_HeaderSuperView.transform.ty > -(self.lgf_HeaderHeight - self.lgf_PageTitleViewHeight)) {
                [vc.lgf_CenterChildPageCV setContentOffset:CGPointMake(0, self.lgf_OffsetY) animated:NO];
            } else {
                if (self.lgf_IsTopScroll) {
                    [vc.lgf_CenterChildPageCV setContentOffset:CGPointMake(0, -(self.lgf_HeaderHeight + self.lgf_HeaderSuperView.transform.ty)) animated:NO];
                } else {
                    if (!vc.lgf_PageChildDataArray || vc.lgf_PageChildDataArray.count == 0) {
                        [vc.lgf_CenterChildPageCV setContentOffset:CGPointMake(0, -(self.lgf_PageTitleViewHeight)) animated:NO];
                    } else {
                        if (vc.lgf_CenterChildPageCV.contentOffset.y < -(self.lgf_PageTitleViewHeight)) {
                            [vc.lgf_CenterChildPageCV setContentOffset:CGPointMake(0, -(self.lgf_PageTitleViewHeight)) animated:NO];
                        }
                    }
                }
            }
            if (vc.lgf_CenterChildPageCV.contentOffset.y >= -(self.lgf_PageTitleViewHeight)) {
                vc.lgf_PageTitleViewIsCenter = YES;
            }
        });
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.lgf_CenterPageCV) {
        self.lgf_HeaderSuperView.userInteractionEnabled = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.lgf_CenterPageCV) {
        self.lgf_HeaderSuperView.userInteractionEnabled = YES;
    }
}

#pragma arguments LGFPageTitleViewDelegate
- (void)lgf_SelectPageTitle:(NSInteger)selectIndex {
    self.lgf_IsTopScroll = NO;
    self.lgf_SelectIndex = selectIndex;
    [self lgf_AddPanGestureRecognizer];
}

- (void)lgf_AddPanGestureRecognizer {
    LGFCenterPageChildVC *vc = self.lgf_ChildVCArray[self.lgf_SelectIndex];
    [self.lgf_HeaderSuperView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.lgf_HeaderSuperView removeGestureRecognizer:obj];
    }];
    [self.lgf_HeaderSuperView addGestureRecognizer:vc.lgf_PanScrollView.panGestureRecognizer];
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

- (NSMutableArray *)lgf_ChildVCArray {
    if (!_lgf_ChildVCArray) {
        _lgf_ChildVCArray = [NSMutableArray new];
    }
    return _lgf_ChildVCArray;
}

- (LGFPageTitleView *)lgf_PageTitleView {
    if (!_lgf_PageTitleView) {
        _lgf_PageTitleView = [[LGFPageTitleView na] initWithStyle:self.lgf_PageTitleStyle super_vc:self super_view:self.lgf_PageTitleSuperViewForSB page_view:self.lgf_CenterPageCV];
        _lgf_PageTitleView.lgf_PageTitleViewDelegate = self;
    }
    return _lgf_PageTitleView;
}

@end
