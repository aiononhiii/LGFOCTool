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
@interface ViewController () <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *testBtnTwo;
@property (weak, nonatomic) IBOutlet UIView *testview;
@property (weak, nonatomic) IBOutlet LGFCountDownButton *testBtn;
@property (weak, nonatomic) IBOutlet UILabel *lightLabel;
@property (strong, nonatomic) NSMutableArray *historyData;
@end

@implementation ViewController

lgf_SBViewControllerForM(ViewController, @"Main", @"FirstViewController")

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
    
//    @lgf_Weak(self);
//    self.tt = ^(NSString *ff, NSString *gg) {
//        @lgf_Strong(self);
//        [self.aaaa removeAllObjects];
//    };
    
    LGFNetworkHeader *model = [LGFNetworkHeader lgf_Once];
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

    [LGFNetwork lgf_Once].lgf_Host = @"http://brain.readyidu.com:8666";
    [LGFNetwork lgf_Once].lgf_Header = model;
    
    
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
    
//    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage lgf_ColorImageWithCornerRadius:0.0 cornerColor:nil fillColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];

    
//    [self.view lgf_ShowToastActivity];
    
//    lgf_AFTER(3.0, [self.view lgf_HideToastActivity];);
    
//    NSLog(@"%@",[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]);
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

- (IBAction)showGrayIndicator:(UIButton *)sender {
    [sender lgf_ShowGrayIndicator];
    lgf_AFTER(2.0, [sender lgf_HideIndicator];);
}

- (IBAction)showToast:(UIButton *)sender {
    LGFToastStyle *style = [LGFToastStyle lgf];
    style.lgf_ToastImageName = @"2";
    style.lgf_ToastImageSize = CGSizeMake(30, 30);
    style.lgf_Duration = CGFLOAT_MAX;
    style.lgf_ToastMessage = @"加载中...";
    
    int rad = [LGFAllMethod lgf_GetRandomNumber:1 to:2];
    if (rad == 1) {
        [self.view lgf_ShowMessageStyle:style animated:YES completion:^{
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            style.lgf_ToastMessage = @"加载完毕";
            style.lgf_Duration = 1.0;
            [self.view lgf_ShowMessageStyle:style animated:NO completion:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        });
    } else if (rad == 2) {
        [self.view lgf_ShowMessage:@"测试测试测试测试测试测试测试测试测试测试测试测试" maxDuration:YES animated:YES completion:^{

        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.view lgf_ShowMessage:@"加载中。。。" maxDuration:YES animated:NO completion:^{

            }];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.view lgf_HideMessage:^{
                
            }];
        });
    }
}

- (IBAction)showPopMenu:(UIButton *)sender {
    LGFPopMenuStyle *style = [LGFPopMenuStyle lgf];
    int rad = [LGFAllMethod lgf_GetRandomNumber:1 to:4];
    if (rad == 1) {
        style.lgf_PopMenuDirection = lgf_TopPopMenu;
    } else if (rad == 2) {
        style.lgf_PopMenuDirection = lgf_BottomPopMenu;
    } else if (rad == 3) {
        style.lgf_PopMenuDirection = lgf_LeftPopMenu;
    } else if (rad == 4) {
        style.lgf_PopMenuDirection = lgf_RightPopMenu;
    }
    style.lgf_PopFromView = sender;
    style.lgf_PopArrowOffset = 4;
    style.lgf_PopArrowSize = CGSizeMake(15, 10);
    style.lgf_PopMenuView = [UIView new];
    style.lgf_PopMenuView.layer.cornerRadius = 8;
    style.lgf_PopMenuSize = CGSizeMake(80, 50);
    style.lgf_PopMenuViewbackColor = [UIColor lgf_ColorWithHexString:@"333333" alpha:0.7];
    [[LGFPopMenu lgf] lgf_ShowMenuWithStyle:style didDismiss:^(LGFPopMenu *popMenu) {
        
    }];
}

- (IBAction)showAlert:(UIButton *)sender {
    int rad = [LGFAllMethod lgf_GetRandomNumber:1 to:2];
    if (rad == 1) {
        LGFAlertViewStyle *style = [LGFAlertViewStyle lgf];
//        style.lgf_SureTitleBackColor = Color_FF5858;
        [[LGFAlertView lgf] lgf_ShowAlertWithStyle:style message:@"我是测试警报框我问范围可分为可分开我就饿回放看完回放看我" sure:^{
            
        }];
    } else if (rad == 2) {
        LGFAlertViewStyle *style = [LGFAlertViewStyle lgf];
        style.lgf_ConfirmTitleColor = [UIColor whiteColor];
        style.lgf_ConfirmBackColor = [UIColor lgf_ColorWithHexString:@"FF5858"];
        [[LGFAlertView lgf] lgf_ShowAlertWithStyle:style message:@"我是测试警报框我1341234123412" cancel:^{
            
        } confirm:^{
            
        }];
    }
    LGFAlertViewStyle *style = [LGFAlertViewStyle lgf];
    style.lgf_CancelTitle = @"取消";
    style.lgf_ConfirmTitle = @"确定";
//    style.lgf_ConfirmBackColor = Color_7474BF;
//    style.lgf_ConfirmBackColor = Color_FF5858;
    [[LGFAlertView lgf] lgf_ShowAlertWithStyle:style message:@"是否确定移除该房管？" cancel:^{
    } confirm:^{
        
    }];
    
}

- (IBAction)testBtnClick:(LGFCountDownButton *)sender {
    
    [sender lgf_TimeFailBeginFrom:5];
    
    LGFTopMessageStyle *style = [LGFTopMessageStyle lgf];
    style.lgf_Message = @"来国锋发的消息息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的消息label发的消息lab发息我发的";
    style.lgf_LabelMaxLine = 10;
    style.lgf_AnimateDuration = 0.4;
    style.lgf_DimissDelay = 2.5;
    style.lgf_IconWidth = 40;
//    style.lgf_MessageMode = lgf_Resize;
    style.lgf_MessageMode = lgf_Overlay;
    style.lgf_MessageIcon = [UIImage imageNamed:@"select"];
    style.lgf_MessageLabelFont = [UIFont systemFontOfSize:15];
    [self.toolView lgf_ShowTopMessageWithStyle:style withTapBlock:^{
        NSLog(@"点击了")
    }];
    
//    [self.view lgf_ShowToastMessage:@"测试试试试我测试试我测试试我测试试试试试我测试试我测试试我测试试试试我测试试我测试试我测试试试试我测试试我测试试我测试试试试我测试试我测试试我测试试试试我测试试我测试试我测试我测试我知"];
    
    
}

- (IBAction)goCP:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"从相册获取图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"相册", nil];
    [actionSheet showInView:self.view];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // 相机
    if (buttonIndex == 0) {
        [[LGFGetPhoto lgf_Once] lgf_GetPhoto:self type:LGFCamera returnImage:^(UIImage *image) {
        }];
    } else if (buttonIndex == 1) {// 相册
        [[LGFGetPhoto lgf_Once] lgf_GetPhoto:self type:LGFPhoto returnImage:^(UIImage *image) {
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
