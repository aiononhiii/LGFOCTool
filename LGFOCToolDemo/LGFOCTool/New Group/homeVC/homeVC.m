//
//  homeVC.m
//  LGFOCTool
//
//  Created by apple on 2018/6/15.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "homeVC.h"
#import "homeVCCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "FLAnimatedImage.h"
#import "QTNoDataView.h"

@interface homeVC ()
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UIView *navLine;
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UICollectionView *homeCV;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView4;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *backImageVIew;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@end

@implementation homeVC

lgf_SBViewControllerForM(homeVC, @"Main", @"FirstViewController");

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

//    NSString *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:@"2.gif" ofType:nil];
//    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538308168299&di=497b679e09cd7cd8529850084c83e852&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F902397dda144ad34610f98c4dba20cf430ad85c4.jpg"]]];
    self.backImageVIew.animatedImage = image;
    CGFloat totalHeight = 1040;
    [self.homeCV setContentInset:UIEdgeInsetsMake(totalHeight, 0, 0, 0)];
    [self.homeCV lgf_ScrollToTop];
    self.headerView.frame = CGRectMake(0, -totalHeight, lgf_ScreenWidth, totalHeight);
    [self.homeCV addSubview:self.headerView];
    MJRefreshGifHeader *ref_header = LGFMJGifHeader(self, @selector(loaddata));
    ref_header.ignoredScrollViewContentInsetTop = 1040;
    ref_header.stateLabel.textColor = [UIColor whiteColor];
    ref_header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    [self.homeCV lgf_SetGifHeader:ref_header gifName:@"timg12" gifSize:CGSizeMake(100, 60)];
    self.homeCV.lgf_Footer = LGFMJFooter(self, @selector(loadmoredata));
    
    [self.bannerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538283659307&di=688a984505bec8496768a4d2d647b574&imgtype=0&src=http%3A%2F%2Fpic33.nipic.com%2F20131008%2F10748501_141114297000_2.jpg"]];
    [self.categoryImageView1 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538302421141&di=0d22c3c9b9b07e790c403b5a56d06b0e&imgtype=0&src=http%3A%2F%2Fd9.yihaodianimg.com%2FN08%2FM01%2F71%2F9E%2FChEi1lfHyFSATUjzAAFoXElsuZ859000.jpg"]];
    [self.categoryImageView2 sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2473898977,3579373960&fm=200&gp=0.jpg"]];
    [self.categoryImageView3 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538302421141&di=0d22c3c9b9b07e790c403b5a56d06b0e&imgtype=0&src=http%3A%2F%2Fd9.yihaodianimg.com%2FN08%2FM01%2F71%2F9E%2FChEi1lfHyFSATUjzAAFoXElsuZ859000.jpg"]];
    [self.categoryImageView4 sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538302421141&di=0d22c3c9b9b07e790c403b5a56d06b0e&imgtype=0&src=http%3A%2F%2Fd9.yihaodianimg.com%2FN08%2FM01%2F71%2F9E%2FChEi1lfHyFSATUjzAAFoXElsuZ859000.jpg"]];
    [self loaddata];
}

- (void)loaddata {
    self.page = 1;
    [self.dataArray removeAllObjects];
    [self loadmoredata];
}

- (void)loadmoredata {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.dataArray addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538283659307&di=688a984505bec8496768a4d2d647b574&imgtype=0&src=http%3A%2F%2Fpic33.nipic.com%2F20131008%2F10748501_141114297000_2.jpg"];
        [self.dataArray addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538283659307&di=688a984505bec8496768a4d2d647b574&imgtype=0&src=http%3A%2F%2Fpic33.nipic.com%2F20131008%2F10748501_141114297000_2.jpg"];
        [self.dataArray addObject:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538283659307&di=688a984505bec8496768a4d2d647b574&imgtype=0&src=http%3A%2F%2Fpic33.nipic.com%2F20131008%2F10748501_141114297000_2.jpg"];
        [self.homeCV lgf_EndRefreshing];
        if (self.page >= 4) {
            [self.homeCV lgf_ReloadData:9 noMoreDataView:[QTNoDataView lgf]];
        } else {
            [self.homeCV lgf_ReloadData:10 noMoreDataView:[QTNoDataView lgf]];
        }
        self.page++;
    });
}

#pragma mark - Collection View DataSource And Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.lgf_width / 2, 300);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    homeVCCell *cell = lgf_CVGetCell(collectionView, homeVCCell, indexPath);
    [cell.testImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538283659307&di=688a984505bec8496768a4d2d647b574&imgtype=0&src=http%3A%2F%2Fpic33.nipic.com%2F20131008%2F10748501_141114297000_2.jpg"]];
    cell.index = indexPath;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //  <#cellClass#> *cell = [collectionView cellForItemAtIndexPath:indexPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f", scrollView.contentOffset.y);
    if (scrollView == self.homeCV) {
//        self.topView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:MIN(1, MAX(0, (self.recommendCV.contentOffset.y + QTHomeVCHeaderHeight) / 80))];
        if ((self.homeCV.contentOffset.y + 1040) > 10) {
//            [self.topBar toLight];
        } else {
//            [self.topBar toDark];
        }
        if (self.backImageVIew.alpha == 0) {
            if (self.homeCV.contentOffset.y <= -1030) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.backImageVIew.alpha = 1.0;
                    self.navLine.alpha = 0.0;
                }];
                [self.addressBtn setImage:[UIImage imageNamed:@"定位-2"] forState:UIControlStateNormal];
                [self.searchImageView setImage:[UIImage imageNamed:@"搜索_2"]];
            }
        } else {
            if (self.homeCV.contentOffset.y > -1030) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.backImageVIew.alpha = 0.0;
                    self.navLine.alpha = 1.0;
                }];
                [self.addressBtn setImage:[UIImage imageNamed:@"定位-3"] forState:UIControlStateNormal];
                [self.searchImageView setImage:[UIImage imageNamed:@"搜索_3"]];
            }
        }
        
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

@end
