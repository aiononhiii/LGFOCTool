//
//  SBTestViewController.m
//  LGFOCTool
//
//  Created by apple on 2018/7/4.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "SBTestViewController.h"
#import "SBtestCollectionViewCell.h"
#import "LGFTitles.h"
#import "OneViewController.h"
#import "TwoViewController.h"

@interface SBTestViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *TESTcv;
@property (weak, nonatomic) IBOutlet UIView *pageview;
@property (nonatomic, strong) NSArray *ccvarr;
@property (nonatomic, strong) LGFPageTitleView *titleview;
@end

@implementation SBTestViewController

lgf_SBViewControllerForM(SBTestViewController, @"SBTestViewController", @"SBTestViewController");

- (NSArray *)ccvarr {
    if (!_ccvarr) {
        _ccvarr = [NSMutableArray new];
    }
    return _ccvarr;
}

- (LGFPageTitleView *)titleview {
    if (!_titleview) {
        // 固定宽度title, 下划线圆角添加, 右边title图片添加, 每个title添加不同图片效果展示, 少量title时title居中显示
        LGFPageTitleStyle *style = [LGFPageTitleStyle na];
        // 固定宽度title 必要属性 （如果值为titleview宽度 ／ title数组count，titleview将取消滚动）
        style.title_fixed_width = self.view.width / 2;
        style.line_width_type = FixedWith;
        style.line_width = self.view.width;
        style.title_big_scale = 1.0;
        style.line_height = 5.0;
        style.line_bottom = 1.0;
        style.line_color = LGFRGB(155, 150, 255, 1.0);
        style.select_color = [UIColor greenColor];
        _titleview = [[LGFPageTitleView na] initWithStyle:style super_vc:self super_view:self.pageview page_view:self.TESTcv];
    }
    return _titleview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    OneViewController *onevc = [OneViewController lgf];
    onevc.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:onevc];
    TwoViewController *twovc = [TwoViewController lgf];
    twovc.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:twovc];
    self.ccvarr = @[onevc, twovc];
    
    // 刷新title数组
    self.titleview.style.titles = @[@"充值", @"消费"];
    [self.titleview reloadAllTitlesSelectIndex:1];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ccvarr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.lgf_width, collectionView.lgf_height);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = lgf_CVGetCell(collectionView, UICollectionViewCell, indexPath);
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (indexPath.item == 0) {
        OneViewController *onevc = self.ccvarr[indexPath.item];
        onevc.view.frame = cell.bounds;
        [cell addSubview:onevc.view];
    }
    TwoViewController *twovc = self.ccvarr[indexPath.item];
    twovc.view.frame = cell.bounds;
    [cell addSubview:twovc.view];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // titleview与pageview分离关联关键方法,必须设置 (此方法作用:关联titleview和外部pageview, 使其可以联动)
//    [self.titleview autoScrollTitle];
}


@end
