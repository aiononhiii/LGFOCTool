//
//  resViewController.m
//  LGFOCTool
//
//  Created by apple on 2018/6/15.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "resViewController.h"
#import "shareView.h"
#import "shareImageVC.h"
//#import "ZSPlayerView.h"
//#import "LGFPlayerView.h"

@interface resViewController ()
{
    CGSize _videoCellSize;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoTop;
@property (weak, nonatomic) IBOutlet UICollectionView *videoCV;

//@property (weak, nonatomic) LGFPlayerView *videoView;
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (nonatomic, assign) CGRect smallFrame;
@end

@implementation resViewController

lgf_SBViewControllerForM(resViewController, @"Main", @"FirstViewController");

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.videoView = [LGFPlayerView lgf];
//    _videoCellSize = CGSizeMake(self.videoCV.lgf_width, self.videoCV.lgf_height);
}

- (void)dealloc {
//    [self.videoView killLGFPlayerView];
//    [self.videoView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)showShare:(UIButton *)sender {
    shareView *view = [shareView lgf];
    [view showShareView:self.view shareUrl:@"https://www.baidu.com"];
    view.shareBlock = ^(UIImage *image) {
        shareImageVC *vc = [shareImageVC lgf_SBViewController];
        vc.image = image;
        //        [self.navigationController pushViewController:vc animated:YES];
        
    };
}


#pragma mark - Collection View DataSource And Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.videoCV.lgf_width, self.videoCV.lgf_height);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        UICollectionViewCell *cell = lgf_CVGetCell(collectionView, UICollectionViewCell, indexPath);
//        [cell addSubview:self.videoView];
//        [self.videoView playWithUrl:@"http://221.228.226.5/15/t/s/h/v/tshvhsxwkbjlipfohhamjkraxuknsc/sh.yinyuetai.com/88DC015DB03C829C2126EEBBB5A887CB.mp4" SV:cell];
//        [self.videoView showToolView];
//        self.videoView.playerViewUnFullScreenBlock = ^(IJKFFMoviePlayerController *ijkPlayer) {
//            [LGFAllMethod lgf_ToTransformUnScreenView:collectionView];
//            collectionView.scrollEnabled = YES;
//        };
        return cell;
    }
    UICollectionViewCell *cell = lgf_CVGetCell(collectionView, UICollectionViewCell, indexPath);
    cell.backgroundColor = lgf_RandomColor;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSInteger index = scrollView.contentOffset.x / lgf_ScreenWidth;
//    if (index == 0) {
//        [self.videoView.ijkPlayer play];
//    } else {
//        [self.videoView.ijkPlayer pause];
//    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        if (collectionView.scrollEnabled) {
            [LGFAllMethod lgf_ToTransformScreenView:collectionView];
            collectionView.scrollEnabled = NO;
            
        }
    }
}
@end
