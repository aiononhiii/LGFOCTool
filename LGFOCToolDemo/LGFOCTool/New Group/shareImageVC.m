//
//  shareImageVC.m
//  LGFOCTool
//
//  Created by apple on 2018/10/9.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "shareImageVC.h"

@interface shareImageVC ()
@property (weak, nonatomic) IBOutlet UIImageView *shareImage;

@end

@implementation shareImageVC

lgf_SBViewControllerForM(shareImageVC, @"Main", @"shareImageVC");

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.shareImage setImage:self.image];
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
