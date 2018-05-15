//
//  ViewController.m
//  LGFOCTool
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+LGFVCLog.h"
#import "LGFOCTool.h"
#import "FirstViewController.h"
#import "PopViewController.h"

typedef void(^test)(NSString *ff, NSString *gg);
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testBtnTwo;
@property (weak, nonatomic) IBOutlet UIView *testview;
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
    
    [self.testBtnTwo lgf_ShowGrayIndicator];
    
    lgf_AFTER(5.0, [self.testBtnTwo lgf_HideIndicator];);
    
    
//
//    lgf_AFTER(2.0, LGFTopMessageStyle *style = [LGFTopMessageStyle na];
//              style.lgf_Message = @"来国锋发的消息息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息la的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我b发息我发的消息label发的消息l";
//              style.lgf_MessageMode = lgf_Resize;
//              style.lgf_LabelMaxLine = 2;
//              style.lgf_IconWidth = 40;
//              style.lgf_DimissDelay = 0.0;
//              style.lgf_MessageIcon = [UIImage imageNamed:@"testIcon"];
//              style.lgf_MessageLabelFont = [UIFont systemFontOfSize:15];
//              [self lgf_ShowTopMessageWithStyle:style withTapBlock:^{
//        NSLog(@"点击了")
//    }];)

//
//    lgf_AFTER(6.0, LGFTopMessageStyle *style = [LGFTopMessageStyle na];
//              style.lgf_Message = @"来国锋发的消息息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息la的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我b发息我发的消息label发的消息l";
////              style.lgf_MessageMode = lgf_Resize;
//              style.lgf_LabelMaxLine = 2;
//              style.lgf_IconWidth = 40;
//              style.lgf_MessageIcon = [UIImage imageNamed:@"testIcon"];
//              style.lgf_MessageLabelFont = [UIFont systemFontOfSize:15];
//              [self lgf_ShowTopMessageWithStyle:style withTapBlock:^{
//        NSLog(@"点击了")
//    }];)
    

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage lgf_ColorImageWithCornerRadius:0.0 cornerColor:nil fillColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];

    
    NSLog(@"%@",[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    LGFTopMessageStyle *style = [LGFTopMessageStyle na];
    style.lgf_Message = @"来国锋发的消息息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息la的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我b发息我发的消息label发的消息l";
//    style.lgf_MessageMode = lgf_Resize;
    style.lgf_LabelMaxLine = 5;
    style.lgf_IconWidth = 40;
    style.lgf_MessageIcon = [UIImage imageNamed:@"testIcon"];
    style.lgf_MessageLabelFont = [UIFont systemFontOfSize:15];
    [self lgf_ShowTopMessageWithStyle:style withTapBlock:^{
        NSLog(@"点击了")
    }];
    
}

#pragma mark 读取步数 查询数据
- (void)readStepCount {
    //查询采样信息
    HKSampleType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //NSSortDescriptor来告诉healthStore怎么样将结果排序
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:now];
    int hour = (int)[dateComponent hour];
    int minute = (int)[dateComponent minute];
    int second = (int)[dateComponent second];
    NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) ];
    //时间结果与想象中不同是因为它显示的是0区
    NSDate *nextDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second)  + 86400];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nowDay endDate:nextDay options:(HKQueryOptionNone)];
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]initWithSampleType:sampleType predicate:predicate limit:0 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        //设置一个int型变量来作为步数统计
        int allStepCount = 0;
        for (int i = 0; i < results.count; i ++) {
            //把结果转换为字符串类型
            HKQuantitySample *result = results[i];
            HKQuantity *quantity = result.quantity;
            NSMutableString *stepCount = (NSMutableString *)quantity;
            NSString *stepStr =[ NSString stringWithFormat:@"%@",stepCount];
            //获取51 count此类字符串前面的数字
            NSString *str = [stepStr componentsSeparatedByString:@" "][0];
            int stepNum = [str intValue];
            //把一天中所有时间段中的步数加到一起
            allStepCount = allStepCount + stepNum;
        }
        NSLog(@"今天的总步数＝＝＝＝%d",allStepCount);
    }];
    //执行查询
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    [healthStore executeQuery:sampleQuery];
}

- (void)dealloc {
    NSLog(@"123123");
}
- (IBAction)testBtnClick:(LGFCountDownButton *)sender {
    LGFTopMessageStyle *style = [LGFTopMessageStyle na];
    style.lgf_Message = @"来国锋发的消息息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息la的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我b发息我发的消息label发的消息l";
//    style.lgf_MessageMode = lgf_Resize;
    style.lgf_LabelMaxLine = 2;
    style.lgf_IconWidth = 40;
    style.lgf_MessageIcon = [UIImage imageNamed:@"testIcon"];
    style.lgf_MessageLabelFont = [UIFont systemFontOfSize:15];
    [self lgf_ShowTopMessageWithStyle:style withTapBlock:^{
        NSLog(@"点击了")
    }];
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
