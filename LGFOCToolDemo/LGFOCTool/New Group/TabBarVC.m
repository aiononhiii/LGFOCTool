//
//  TabBarVC.m
//  LGFOCTool
//
//  Created by apple on 2018/9/26.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "TabBarVC.h"
#import "LGFOCTool.h"
#import "FirstViewController.h"
#import "homeVC.h"
#import "resViewController.h"
#import "ViewController.h"
#import "UINavigationController+LGFAnimatedTransition.h"

@interface TabBarVC ()
@property (nonatomic, strong) LGFTabBarVC *tabvc;
@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabvc = [LGFTabBarVC lgf];
    self.tabvc.view.backgroundColor = lgf_RandomColor;
    FirstViewController *vc = [FirstViewController lgf];
    homeVC *twovc = [homeVC lgf];
    //    ThreeViewController *threevc = [ThreeViewController lgf_SBViewController];
    ViewController *fourvc = [ViewController lgf];
    ViewController *fivevc = [ViewController lgf];
    
    self.tabvc.lgf_BarChildVCs = @[vc, twovc, fourvc, fivevc];
    self.tabvc.lgf_BarItemTitles = @[@"首页", @"微淘", @"购物车", @"我的淘宝"];
    self.tabvc.lgf_SelectBarItemIcons = @[@"select", @"select", @"select", @"select"].mutableCopy;
    self.tabvc.lgf_UnSelectBarItemIcons = @[@"unselect", @"unselect", @"unselect", @"unselect"].mutableCopy;
    self.tabvc.lgf_SelectBarItemColor = [UIColor redColor];
    self.tabvc.lgf_UnSelectBarItemColor = [UIColor darkGrayColor];
    self.tabvc.lgf_DefultSelectIndex = 2;
    [self.tabvc lgf_TabBarVCShowInView:self];
    
    //    UIButton *centerBtn = [self.tabvc lgf_TabBarShowCenterBtnWithTop:35 size:CGSizeMake(60, 60)];
    //    centerBtn.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tabvc lgf_ShowTabBar];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.tabvc lgf_HideTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
