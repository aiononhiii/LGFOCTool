//
//  UIDevice+LGFDevice.h
//  LGFOCTool
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import <UIKit/UIKit.h>
// 是ipad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define lgf_DEVICE_IOS_VERSION [[UIDevice currentDevice].systemVersion floatValue]
#define lgf_DEVICE_HARDWARE_BETTER_THAN(i) [[UIDevice currentDevice] isCurrentDeviceHardwareBetterThan:i]
#define lgf_DEVICE_HAS_RETINA_DISPLAY (fabs([UIScreen mainScreen].scale - 2.0) <= fabs([UIScreen mainScreen].scale - 2.0)*DBL_EPSILON)
#define lgf_IS_IOS7_OR_LATER (((double)(lgf_DEVICE_IOS_VERSION)-7.0) > -((double)(lgf_DEVICE_IOS_VERSION)-7.0)*DBL_EPSILON)
#define lgf_NSStringAdd568hIfIphone4inch(str) [NSString stringWithFormat:[UIDevice currentDevice].isIphoneWith4inchDisplay ? @"%@-568h" : @"%@", str]
// 是 iphone5
#define lgf_IS_IPHONE_5 [[UIScreen mainScreen] applicationFrame].size.height == 568

typedef enum {
    NOT_AVAILABLE,
    
    IPHONE_2G,
    IPHONE_3G,
    IPHONE_3GS,
    IPHONE_4,
    IPHONE_4_CDMA,
    IPHONE_4S,
    IPHONE_5,
    IPHONE_5_CDMA_GSM,
    IPHONE_5C,
    IPHONE_5C_CDMA_GSM,
    IPHONE_5S,
    IPHONE_5S_CDMA_GSM,
    IPHONE_6,
    IPHONE_6_PLUS,
    
    IPOD_TOUCH_1G,
    IPOD_TOUCH_2G,
    IPOD_TOUCH_3G,
    IPOD_TOUCH_4G,
    IPOD_TOUCH_5G,
    
    IPAD,
    IPAD_2,
    IPAD_2_WIFI,
    IPAD_2_CDMA,
    IPAD_3,
    IPAD_3G,
    IPAD_3_WIFI,
    IPAD_3_WIFI_CDMA,
    IPAD_4,
    IPAD_4_WIFI,
    IPAD_4_GSM_CDMA,
    
    IPAD_MINI,
    IPAD_MINI_WIFI,
    IPAD_MINI_WIFI_CDMA,
    IPAD_MINI_RETINA_WIFI,
    IPAD_MINI_RETINA_WIFI_CDMA,
    
    IPAD_AIR_WIFI,
    IPAD_AIR_WIFI_GSM,
    IPAD_AIR_WIFI_CDMA,
    
    SIMULATOR
} Hardware;


@interface UIDevice (LGFDevice)

#pragma mark - 返回当前设备硬件 系统默认字符串

- (NSString*)lgf_HardwareString;

#pragma mark - 返回当前设备硬件 可读性枚举

- (Hardware)lgf_Hardware;

#pragma mark - 返回当前设备硬件 可读性字符串

- (NSString*)lgf_HardwareDescription;

#pragma mark - 如果一些设备未标注支持网络类型 则手动描述 并返回可读性字符串

- (NSString *)lgf_HardwareSimpleDescription;

#pragma mark - 当前设备如果性能优于 Hardware枚举选择的硬件设备 则返回YES

- (BOOL)lgf_IsCurrentDeviceHardwareBetterThan:(Hardware)hardware;

#pragma mark - 返回当前设备最大支持图像的分辨率

- (CGSize)lgf_BackCameraStillImageResolutionInPixels;

#pragma mark - 如果当前设备是iPhone并且具有 4 显示，则此方法返回 YES

- (BOOL)lgf_IsIphoneWith4inchDisplay;

#pragma mark - 返回 MAC 地址

+ (NSString *)lgf_MacAddress;

#pragma mark - 返回当前设备 CPU 频率

+ (NSUInteger)lgf_CpuFrequency;

#pragma mark - 返回当前设备 BUS 频率

+ (NSUInteger)lgf_BusFrequency;

#pragma mark - 返回当前设备 RAM(运行内存) 大小

+ (NSUInteger)lgf_RamSize;

#pragma mark - 返回电池电量

+ (float)lgf_BatteryQuantity;

#pragma mark - 返回当前设备 CPU 型号

+ (NSUInteger)lgf_CpuNumber;

#pragma mark - 获取当前手机iOS系统的版本号

+ (NSString *)lgf_SystemVersion;

#pragma mark - 判断当前系统是否有摄像头

+ (BOOL)lgf_HasCamera;

#pragma mark - 获取手机内存总容量, 返回的是字节数

+ (long long)lgf_TotalMemorySize;

#pragma mark - 获取手机内存可用容量, 返回的是字节数

+ (long long)lgf_FreeMemorySize;

#pragma mark - 获取手机内存已用容量, 返回的是字节数

+ (long long)lgf_UsedMemorySize;

#pragma mark - 获取手机硬盘总容量, 返回的是字节数

+ (long long)lgf_TotalDiskSize;

#pragma mark - 获取手机可用硬盘容量, 返回的是字节数

+ (long long)lgf_FreeDiskSize;

#pragma mark - 获取手机已用硬盘容量, 返回的是字节数

+ (long long)lgf_UsedDiskSize;

#pragma mark - 获取手机硬盘容量,转换成可视字符串

+ (NSString *)lgf_DiskSizeToString:(unsigned long long)fileSize;

#pragma mark - 取得当前网络环境IP地址

+ (NSString *)lgf_IPAddress;

#pragma mark - 取得当前连接Wifi名字

+ (NSString *)lgf_WifiName;

#pragma mark - 获取当前设备 UUID

+ (NSString *)lgf_DeviceUUID;

#pragma mark - 打开手电筒
/**
 @param isOn YES 打开, NO 关闭
 */
+ (void)lgf_TurnOnTheFlashlight:(BOOL)isOn;

@end

