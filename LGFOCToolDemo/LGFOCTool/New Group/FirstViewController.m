//
//  FirstViewController.m
//  LGFOCTool
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "FirstViewController.h"
#import "LGFOCTool.h"
#import "ViewController.h"
#import "UINavigationController+LGFAnimatedTransition.h"

@interface FirstViewController ()
@end

@implementation FirstViewController

lgf_SBViewControllerForM(FirstViewController, @"Main", @"FirstViewController")

- (void)viewDidLoad {
    [super viewDidLoad];
    [lgf_NCenter addObserver:self selector:@selector(scrollToTop:) name:LGFTabBarDoubleSelect object:nil];
}

- (void)scrollToTop:(NSNotification *)notif {
    NSDictionary *dict = notif.object;
    if ([dict[@"LGFTabBarSelectIndex"] integerValue] == 0) {
        [self.view lgf_ShowMessage:[NSString stringWithFormat:@"%@ 当前重复点击了, 这里添加滚到顶部代码", dict[@"LGFTabBarSelectIndex"]] animated:YES completion:^{
            
        }];
    }
}

- (void)dealloc {
    [lgf_NCenter removeObserver:self];
}

- (IBAction)goViewController:(UIButton *)sender {
    ViewController *vc = [ViewController lgf_SBViewController];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - Collection View DataSource And Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(lgf_ScreenWidth, 60);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = lgf_CVGetCell(collectionView, UICollectionViewCell, indexPath);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ViewController *vc = [ViewController lgf_SBViewController];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
