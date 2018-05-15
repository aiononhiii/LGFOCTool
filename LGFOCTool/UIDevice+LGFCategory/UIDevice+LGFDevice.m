//
//  UIDevice+LGFDevice.m
//  LGFOCTool
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "UIDevice+LGFDevice.h"
#import "LGFOCTool.h"

#include <sys/types.h>
#include <sys/sysctl.h>

#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation UIDevice (LGFDevice)

#pragma mark - 返回当前设备硬件 系统默认字符串

- (NSString*)lgf_HardwareString {
    int name[] = {CTL_HW,HW_MACHINE};
    size_t size = 100;
    sysctl(name, 2, NULL, &size, NULL, 0); // getting size of answer
    char *hw_machine = malloc(size);
    
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}

#pragma mark - 返回当前设备硬件 可读性枚举

- (Hardware)lgf_Hardware {
    NSString *hardware = [self lgf_HardwareString];
    if ([hardware isEqualToString:@"iPhone1,1"])    return IPHONE_2G;
    if ([hardware isEqualToString:@"iPhone1,2"])    return IPHONE_3G;
    if ([hardware isEqualToString:@"iPhone2,1"])    return IPHONE_3GS;
    if ([hardware isEqualToString:@"iPhone3,1"])    return IPHONE_4;
    if ([hardware isEqualToString:@"iPhone3,2"])    return IPHONE_4;
    if ([hardware isEqualToString:@"iPhone3,3"])    return IPHONE_4_CDMA;
    if ([hardware isEqualToString:@"iPhone4,1"])    return IPHONE_4S;
    if ([hardware isEqualToString:@"iPhone5,1"])    return IPHONE_5;
    if ([hardware isEqualToString:@"iPhone5,2"])    return IPHONE_5_CDMA_GSM;
    if ([hardware isEqualToString:@"iPhone5,3"])    return IPHONE_5C;
    if ([hardware isEqualToString:@"iPhone5,4"])    return IPHONE_5C_CDMA_GSM;
    if ([hardware isEqualToString:@"iPhone6,1"])    return IPHONE_5S;
    if ([hardware isEqualToString:@"iPhone6,2"])    return IPHONE_5S_CDMA_GSM;
    
    if ([hardware isEqualToString:@"iPhone7,1"])    return IPHONE_6_PLUS;
    if ([hardware isEqualToString:@"iPhone7,2"])    return IPHONE_6;
    
    if ([hardware isEqualToString:@"iPod1,1"])      return IPOD_TOUCH_1G;
    if ([hardware isEqualToString:@"iPod2,1"])      return IPOD_TOUCH_2G;
    if ([hardware isEqualToString:@"iPod3,1"])      return IPOD_TOUCH_3G;
    if ([hardware isEqualToString:@"iPod4,1"])      return IPOD_TOUCH_4G;
    if ([hardware isEqualToString:@"iPod5,1"])      return IPOD_TOUCH_5G;
    
    if ([hardware isEqualToString:@"iPad1,1"])      return IPAD;
    if ([hardware isEqualToString:@"iPad1,2"])      return IPAD_3G;
    if ([hardware isEqualToString:@"iPad2,1"])      return IPAD_2_WIFI;
    if ([hardware isEqualToString:@"iPad2,2"])      return IPAD_2;
    if ([hardware isEqualToString:@"iPad2,3"])      return IPAD_2_CDMA;
    if ([hardware isEqualToString:@"iPad2,4"])      return IPAD_2;
    if ([hardware isEqualToString:@"iPad2,5"])      return IPAD_MINI_WIFI;
    if ([hardware isEqualToString:@"iPad2,6"])      return IPAD_MINI;
    if ([hardware isEqualToString:@"iPad2,7"])      return IPAD_MINI_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad3,1"])      return IPAD_3_WIFI;
    if ([hardware isEqualToString:@"iPad3,2"])      return IPAD_3_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad3,3"])      return IPAD_3;
    if ([hardware isEqualToString:@"iPad3,4"])      return IPAD_4_WIFI;
    if ([hardware isEqualToString:@"iPad3,5"])      return IPAD_4;
    if ([hardware isEqualToString:@"iPad3,6"])      return IPAD_4_GSM_CDMA;
    if ([hardware isEqualToString:@"iPad4,1"])      return IPAD_AIR_WIFI;
    if ([hardware isEqualToString:@"iPad4,2"])      return IPAD_AIR_WIFI_GSM;
    if ([hardware isEqualToString:@"iPad4,3"])      return IPAD_AIR_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad4,4"])      return IPAD_MINI_RETINA_WIFI;
    if ([hardware isEqualToString:@"iPad4,5"])      return IPAD_MINI_RETINA_WIFI_CDMA;
    
    
    if ([hardware isEqualToString:@"i386"])         return SIMULATOR;
    if ([hardware isEqualToString:@"x86_64"])       return SIMULATOR;
    return NOT_AVAILABLE;
}

#pragma mark - 返回当前设备硬件 可读性字符串

- (NSString*)lgf_HardwareDescription {
    NSString *hardware = [self lgf_HardwareString];
    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([hardware isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM Rev. A)";
    if ([hardware isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (Global)";
    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5C (GSM)";
    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5C (Global)";
    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5S (GSM)";
    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5S (Global)";
    
    if ([hardware isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([hardware isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad (WiFi)";
    if ([hardware isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi Rev. A)";
    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3 (Global)";
    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4 (CDMA)";
    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4 (Global)";
    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air (WiFi+GSM)";
    if ([hardware isEqualToString:@"iPad4,3"])      return @"iPad Air (WiFi+CDMA)";
    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (WiFi+CDMA)";
    if ([hardware isEqualToString:@"i386"])         return @"Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"Simulator";
    
    NSLog(@"This is a device which is not listed in this category. Please visit https://github.com/inderkumarrathore/UIDevice-Hardware and add a comment there.");
    NSLog(@"Your device hardware string is: %@", hardware);
    if ([hardware hasPrefix:@"iPhone"]) return @"iPhone";
    if ([hardware hasPrefix:@"iPod"]) return @"iPod";
    if ([hardware hasPrefix:@"iPad"]) return @"iPad";
    return nil;
}

#pragma mark - 如果一些设备未标注支持网络类型 则手动描述 并返回可读性字符串

- (NSString*)lgf_HardwareSimpleDescription {
    NSString *hardware = [self lgf_HardwareString];
    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    
    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([hardware isEqualToString:@"iPad1,2"])      return @"iPad";
    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4";
    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4";
    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([hardware isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina";
    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina";
    
    if ([hardware isEqualToString:@"i386"])         return @"Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"Simulator";
    
    NSLog(@"This is a device which is not listed in this category. Please visit https://github.com/inderkumarrathore/UIDevice-Hardware and add a comment there.");
    NSLog(@"Your device hardware string is: %@", hardware);
    
    if ([hardware hasPrefix:@"iPhone"]) return @"iPhone";
    if ([hardware hasPrefix:@"iPod"]) return @"iPod";
    if ([hardware hasPrefix:@"iPad"]) return @"iPad";
    
    return nil;
}


- (float)lgf_HardwareNumber:(Hardware)hardware {
    switch (hardware) {
        case IPHONE_2G: return 1.1f;
        case IPHONE_3G: return 1.2f;
        case IPHONE_3GS: return 2.1f;
        case IPHONE_4:    return 3.1f;
        case IPHONE_4_CDMA:    return 3.3f;
        case IPHONE_4S:    return 4.1f;
        case IPHONE_5:    return 5.1f;
        case IPHONE_5_CDMA_GSM:    return 5.2f;
        case IPHONE_5C:    return 5.3f;
        case IPHONE_5C_CDMA_GSM:    return 5.4f;
        case IPHONE_5S:    return 6.1f;
        case IPHONE_5S_CDMA_GSM:    return 6.2f;
            
        case IPHONE_6:         return 7.2f;
        case IPHONE_6_PLUS:    return 7.1f;
            
        case IPOD_TOUCH_1G:    return 1.1f;
        case IPOD_TOUCH_2G:    return 2.1f;
        case IPOD_TOUCH_3G:    return 3.1f;
        case IPOD_TOUCH_4G:    return 4.1f;
        case IPOD_TOUCH_5G:    return 5.1f;
            
        case IPAD:    return 1.1f;
        case IPAD_3G:    return 1.2f;
        case IPAD_2_WIFI:    return 2.1f;
        case IPAD_2:    return 2.2f;
        case IPAD_2_CDMA:    return 2.3f;
        case IPAD_MINI_WIFI:    return 2.5f;
        case IPAD_MINI:    return 2.6f;
        case IPAD_MINI_WIFI_CDMA:    return 2.7f;
        case IPAD_3_WIFI:    return 3.1f;
        case IPAD_3_WIFI_CDMA:    return 3.2f;
        case IPAD_3:    return 3.3f;
        case IPAD_4_WIFI:    return 3.4f;
        case IPAD_4:    return 3.5f;
        case IPAD_4_GSM_CDMA:    return 3.6f;
        case IPAD_AIR_WIFI:    return 4.1f;
        case IPAD_AIR_WIFI_GSM:    return 4.2f;
        case IPAD_AIR_WIFI_CDMA:    return 4.3f;
        case IPAD_MINI_RETINA_WIFI:    return 4.4f;
        case IPAD_MINI_RETINA_WIFI_CDMA:    return 4.5f;
            
        case SIMULATOR:    return 100.0f;
        case NOT_AVAILABLE:    return 200.0f;
    }
    return 200.0f; //Device is not available
}

#pragma mark - 当前设备如果性能优于 Hardware枚举选择的硬件设备 则返回YES

- (BOOL)lgf_IsCurrentDeviceHardwareBetterThan:(Hardware)hardware {
    float otherHardware = [self lgf_HardwareNumber:hardware];
    float currentHardware = [self lgf_HardwareNumber:[self lgf_Hardware]];
    return currentHardware >= otherHardware;
}

#pragma mark - 返回当前设备最大支持图像的分辨率

- (CGSize)lgf_BackCameraStillImageResolutionInPixels {
    switch ([self lgf_Hardware]) {
        case IPHONE_2G:
        case IPHONE_3G:
            return CGSizeMake(1600, 1200);
            break;
        case IPHONE_3GS:
            return CGSizeMake(2048, 1536);
            break;
        case IPHONE_4:
        case IPHONE_4_CDMA:
        case IPAD_3_WIFI:
        case IPAD_3_WIFI_CDMA:
        case IPAD_3:
        case IPAD_4_WIFI:
        case IPAD_4:
        case IPAD_4_GSM_CDMA:
            return CGSizeMake(2592, 1936);
            break;
        case IPHONE_4S:
        case IPHONE_5:
        case IPHONE_5_CDMA_GSM:
        case IPHONE_5C:
        case IPHONE_5C_CDMA_GSM:
            return CGSizeMake(3264, 2448);
            break;
            
        case IPOD_TOUCH_4G:
            return CGSizeMake(960, 720);
            break;
        case IPOD_TOUCH_5G:
            return CGSizeMake(2440, 1605);
            break;
            
        case IPAD_2_WIFI:
        case IPAD_2:
        case IPAD_2_CDMA:
            return CGSizeMake(872, 720);
            break;
            
        case IPAD_MINI_WIFI:
        case IPAD_MINI:
        case IPAD_MINI_WIFI_CDMA:
            return CGSizeMake(1820, 1304);
            break;
        default:
            NSLog(@"We have no resolution for your device's camera listed in this category. Please, make photo with back camera of your device, get its resolution in pixels (via Preview Cmd+I for example) and add a comment to this repository on GitHub.com in format Device = Hpx x Wpx.");
            NSLog(@"Your device is: %@", [self lgf_HardwareDescription]);
            break;
    }
    return CGSizeZero;
}

#pragma mark - 如果当前设备是iPhone并且具有 4 显示，则此方法返回 YES

- (BOOL)lgf_IsIphoneWith4inchDisplay {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        double height = [[UIScreen mainScreen] bounds].size.height;
        if (fabs(height-568.0f) < DBL_EPSILON) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 返回 MAC 地址

+ (NSString *)lgf_MacAddress {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return NULL;
    }
    
    if(sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return outstring;
}

#pragma mark - 获取当前手机iOS系统的版本号

+ (NSString *)lgf_SystemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

#pragma mark - 判断当前系统是否有摄像头

+ (BOOL)lgf_HasCamera {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (NSUInteger)lgf_GetSysInfo:(uint)typeSpecifier {
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

#pragma mark - 返回当前设备 CPU 频率

+ (NSUInteger)lgf_CpuFrequency {
    return [self lgf_GetSysInfo:HW_CPU_FREQ];
}

#pragma mark - 返回当前设备 BUS 频率

+ (NSUInteger)lgf_BusFrequency {
    return [self lgf_GetSysInfo:HW_BUS_FREQ];
}

#pragma mark - 返回当前设备 RAM(运行内存) 大小

+ (NSUInteger)lgf_RamSize {
    return [self lgf_GetSysInfo:HW_MEMSIZE];
}

#pragma mark - 返回电池电量

+ (float)lgf_BatteryQuantity {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return [[UIDevice currentDevice] batteryLevel];
}

#pragma mark - 返回当前设备 CPU 型号

+ (NSUInteger)lgf_CpuNumber {
    return [self lgf_GetSysInfo:HW_NCPU];
}

#pragma mark - 获取手机内存总容量, 返回的是字节数

+ (long long)lgf_TotalMemorySize {
    return [NSProcessInfo processInfo].physicalMemory;
}

#pragma mark - 获取手机内存可用容量, 返回的是字节数

+ (long long)lgf_FreeMemorySize {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

#pragma mark - 获取手机内存已用容量, 返回的是字节数

+ (long long)lgf_UsedMemorySize {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size;
}

#pragma mark - 获取手机硬盘总容量, 返回的是字节数

+ (long long)lgf_TotalDiskSize {
    struct statfs buf;
    unsigned long long maxspace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        maxspace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return maxspace;
}

#pragma mark - 获取手机可用硬盘容量, 返回的是字节数

+ (long long)lgf_FreeDiskSize {
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}

#pragma mark - 获取手机已用硬盘容量, 返回的是字节数

+ (long long)lgf_UsedDiskSize {
    return [self lgf_TotalDiskSize] - [self lgf_FreeDiskSize];
}

#pragma mark - 获取手机可用内存,转换成可视字符串

+ (NSString *)lgf_DiskSizeToString:(unsigned long long)diskSize {
    NSInteger KB = 1024;
    NSInteger MB = KB*KB;
    NSInteger GB = MB*KB;
    
    if (diskSize < 10) {
        return @"0 B";
    }else if (diskSize < KB) {
        return @"< 1 KB";
    }else if (diskSize < MB) {
        return [NSString stringWithFormat:@"%.1fKB",((CGFloat)diskSize)/KB];
    }else if (diskSize < GB) {
        return [NSString stringWithFormat:@"%.1fMB",((CGFloat)diskSize)/MB];
    }else   {
        return [NSString stringWithFormat:@"%.1fGB",((CGFloat)diskSize)/GB];
    }
}

#pragma mark - 取得当前网络环境IP地址

+ (NSString *)lgf_IPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

#pragma mark - 取得当前连接Wifi名字

+ (NSString *)lgf_WifiName {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
    return info[@"SSID"];
}

#pragma mark - 获取当前设备 UUID

+ (NSString *)lgf_DeviceUUID {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

#pragma mark - 是否打开手电筒

+ (void)lgf_TurnOnTheFlashlight:(BOOL)isOn {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (isOn) {
            [device setTorchMode:AVCaptureTorchModeOn];//手电筒打开
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];//手电筒关闭
        }
        [device unlockForConfiguration];
    }
}

@end

