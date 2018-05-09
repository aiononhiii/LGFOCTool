//
//  ViewController.m
//  LGFOCTool
//
//  Created by apple on 2018/4/28.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+LGFVCLog.h"
#import "LGFOCTool.h"
#import "FirstViewController.h"
#import "PopViewController.h"

typedef void(^test)(NSString *ff, NSString *gg);
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testBtnTwo;
@property (weak, nonatomic) IBOutlet LGFCountDownButton *testBtn;
@property (weak, nonatomic) IBOutlet UIImageView *testImage;
@property (weak, nonatomic) IBOutlet UICollectionView *testCV;
@property (copy, nonatomic) test tt;
@property (strong, nonatomic) NSMutableArray *aaaa;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    @lgf_Weak(self);
    self.tt = ^(NSString *ff, NSString *gg) {
        @lgf_Strong(self);
        [self.aaaa removeAllObjects];
    };
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage lgf_ColorImageWithCornerRadius:0.0 cornerColor:nil fillColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];

    LGFTopMessageStyle *style = [LGFTopMessageStyle na];
    style.lgf_Message = @"来国锋发的消息息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息la的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我b发息我发的消息label发的消息l";
    style.lgf_MessageMode = lgf_Overlay;
    style.lgf_LabelMaxLine = 100;
    style.lgf_IconWidth = 40;
    style.lgf_MessageIcon = [UIImage imageNamed:@"testIcon"];
    style.lgf_MessageLabelFont = [UIFont systemFontOfSize:15];
    [self lgf_ShowTopMessageWithStyle:style withTapBlock:^{
        NSLog(@"点击了")
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
    NSLog(@"123123");
}
- (IBAction)testBtnClick:(LGFCountDownButton *)sender {
    [sender lgf_TimeFailBeginFrom:10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View DataSource And Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width, 100);
}

- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell =  lgf_CVGetCell(collectionView, UICollectionViewCell, indexPath);
    cell.backgroundColor = lgf_RandomColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor lgf_ColorWithHexString:@"EEEEEE"]];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
}

@end
