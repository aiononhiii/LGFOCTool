//
//  PopViewController.m
//  LGFOCTool
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "PopViewController.h"
#import "LGFOCTool.h"

@interface PopViewController ()

@end

@implementation PopViewController

+ (instancetype)GetSBVC {
    return lgf_GetSBVC(PopViewController, @"Main", nil);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
