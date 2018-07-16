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
#import "YDFMFMHistoryCVCell.h"
#import "UIImageView+WebCache.h"
#import "YYWebImage.h"
#import "MJRefresh.h"
#import "YYCache.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UINavigationController+LGFAnimatedTransition.h"

#import "SBTestViewController.h"

typedef void(^test)(NSString *ff, NSString *gg);
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testBtnTwo;
@property (weak, nonatomic) IBOutlet UIView *testview;
@property (weak, nonatomic) IBOutlet LGFCountDownButton *testBtn;
@property (weak, nonatomic) IBOutlet UIImageView *testImage;
@property (weak, nonatomic) IBOutlet UICollectionView *testCV;
@property (copy, nonatomic) test tt;
@property (strong, nonatomic) NSMutableArray *aaaa;
@property (strong, nonatomic) NSMutableArray *historyData;
@end

@implementation ViewController

lgf_AllocOnlyOnceForM(ViewController, ViewController);

+ (instancetype)GetSBVC {
    return lgf_GetSBVC(ViewController, @"Main", @"LGFOCTool");
}

- (void)dealloc {
    NSLog(@"已经释放完毕");
}

- (NSMutableArray *)historyData {
    if (!_historyData) {
        _historyData = [NSMutableArray new];
    }
    return _historyData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _testview.backgroundColor = [UIColor lgf_GradientFromColor:[UIColor greenColor] toColor:[UIColor redColor] width:_testview.lgf_width];
//    LGFTopMessageStyle *style = [LGFTopMessageStyle na];
//    style.lgf_Message = @"来国锋发的消息息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息la的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我b发息我发的消息label发的消息l";
//    //    style.lgf_MessageMode = lgf_Resize;
//    style.lgf_LabelMaxLine = 5;
//    style.lgf_IconWidth = 40;
//    style.lgf_MessageIcon = [UIImage imageNamed:@"testIcon"];
//    style.lgf_MessageLabelFont = [UIFont systemFontOfSize:15];
//    [self lgf_ShowTopMessageWithStyle:style withTapBlock:^{
//        NSLog(@"点击了")
//    }];
    
    @lgf_Weak(self);
    self.tt = ^(NSString *ff, NSString *gg) {
        @lgf_Strong(self);
        [self.aaaa removeAllObjects];
    };
    
    [self.testBtnTwo lgf_ShowGrayIndicator];
    
    lgf_AFTER(5.0, [self.testBtnTwo lgf_HideIndicator];);
    
    LGFNetworkHeader *model = [LGFNetworkHeader sharedHeader];
    model.appId = @"10002";
    model.AppUserId = @"1141150";
    model.lat = @"30.178021";
    model.lon = @"120.205129";
    model.password = @"123456";
    model.version = @"1.1.5";
    model.locationID = @"3371";
    model.locationName = @"滨江区";
    model.platform = @"ios";
    model.token = @"97d2b45683fd473fbadd9904dfc8d243";
    model.nickname = @"18358173172";
    model.icon = @"http://7xk3oj.com2.z0.glb.qiniucdn.com/E4BB1891726631C75A2C8C895CC83DA6";
    
    [LGFNetwork sharedNetwork].lgf_Host = @"http://brain.readyidu.com:8666";
    [LGFNetwork sharedNetwork].lgf_Header = model;
    
    
    LGFFPSLabel *fps = [[LGFFPSLabel alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height - 300, 80, 30)];
    [self.view addSubview:fps];
    
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
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage lgf_ColorImageWithCornerRadius:0.0 cornerColor:nil fillColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];

    
//    [self.view lgf_ShowToastActivity];
    
//    lgf_AFTER(3.0, [self.view lgf_HideToastActivity];);
    
    NSLog(@"%@",[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]);
    
    _testCV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
}

- (void)loadData {
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    // 清空缓存
    [cache.memoryCache removeAllObjects];
    [cache.diskCache removeAllObjects];
    [self.historyData removeAllObjects];
    NSDictionary *dic = @{@"userId" : @"1141150",
                          @"type" : @(0),
                          @"pageNo" : @(1),
                          @"pageSize" : @(40)
                          };
    [LGFReqest lgf_Request:lgf_GET url:@"fmHistorical/list" param:dic completed:^(NSDictionary *data, NSError *error) {
        [self.testCV.mj_header endRefreshing];
        if (!error) {
            NSLog(@"%@", data);
            NSArray *rows = data[@"rows"];
            for (NSDictionary *dict in rows) {
                [self.historyData addObject:[NSDictionary lgf_DictFromString:dict[@"albumOrColumnOrRadioJson"]]];
            }
            [self.testCV reloadData];
            LGFTopMessageStyle *style = [LGFTopMessageStyle na];
            style.lgf_MessageBackColor = [UIColor redColor];
            style.lgf_MessageTextColor = [UIColor whiteColor];
            style.lgf_Message = [NSString stringWithFormat:@"已获取%ld条最新数据", (long)rows.count];
            style.lgf_MessageLabelFont = [UIFont systemFontOfSize:15];
            [self lgf_ShowTopMessageWithStyle:style withTapBlock:^{}];
            return;
        }
        [self.view lgf_ShowToastMessage:error.localizedDescription completion:nil];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self.view lgf_ShowToastActivity:UIEdgeInsetsMake(0, 0, 0, 0)];
//
//    lgf_AFTER(3.0, [self.view lgf_HideToastActivity];);
    
    
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
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    [self.view lgf_ShowToastMessage:@"测试试试试我测试试我测试试我测试试试试试我测试试我测试试我测试试试试我测试试我测试试我测试试试试我测试试我测试试我测试试试试我测试试我测试试我测试试试试我测试试我测试试我测试我测试我知"];
    
    
}

- (IBAction)goCP:(UIButton *)sender {
    [[LGFUploadImage sharedLGFUploadImage] lgf_GetSystemPhotoWithVC:self title:@"从相册获取图片" returnImage:^(UIImage *image) {
        [self.view lgf_ShowToastMessage:[NSString stringWithFormat:@"%@", image] duration:2.0 completion:nil];
    }];
//    SBTestViewController *vc =[SBTestViewController lgf_SBViewController];
//    
//    [self.navigationController pushViewController:vc animated:YES];
//    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View DataSource And Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.historyData.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width, 100);
}

- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDFMFMHistoryCVCell *cell =  lgf_CVGetCell(collectionView, YDFMFMHistoryCVCell, indexPath);
    NSDictionary *dict = self.historyData[indexPath.item];
    [cell.coverUrlMiddle yy_setImageWithURL:[NSURL URLWithString:dict[@"cover_url_middle"]] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
    cell.title.text = dict[@"album_title"];
    cell.intro.text = dict[@"album_intro"];
    cell.playCount.text = [NSString lgf_GetNumStrWithNum:[dict[@"play_count"] integerValue] unitType:lgf_OnlyWan unitStrType:lgf_CCharacter];
    cell.includeTrackCount.text = [NSString stringWithFormat:@"%@集", dict[@"include_track_count"]];
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
