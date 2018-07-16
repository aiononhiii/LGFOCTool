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

+ (instancetype)GetSBVC {
    return lgf_GetSBVC(ViewController, @"Main", nil);
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)goViewController:(UIButton *)sender {
    ViewController *vc = [ViewController GetSBVC];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
