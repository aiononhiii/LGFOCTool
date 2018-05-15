//
//  LGFOCTool.h
//  LGFOCTool
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#ifndef LGFOCTool_h
#define LGFOCTool_h

// 宏集合
#import "LGFPch.h"

// 所有特殊方法
#import "LGFAllMethod.h"

// 所有权限配置
#import "LGFAllPermissions.h"

//****************************** 自定义控件 *******************************
// 倒计时按钮 用于发送验证码
#import "LGFCountDownButton.h"
// 优化后的定时器
#import "LGFTimer.h"
// Pop 菜单


//******************************** 分类 **********************************
//------------------ NSString 分类集合 -----------------
#import "NSString+LGFString.h"
// 字符串加密
#import "NSString+LGFHash.h"
// 字符串拼音处理
#import "NSString+LGFPinyin.h"
// 正则判断 手机号邮箱等等
#import "NSString+LGFRegex.h"
// 删除字符串中的 Emoji
#import "NSString+LGFRemoveEmoji.h"
// 取得字符串宽高
#import "NSString+LGFTextSize.h"
// js html 字符串处理
#import "NSString+LGFTrims.h"
// 转 Base64 字符串
#import "NSString+LGFBase64.h"
//------------------ NSDate 分类集合 --------------------
#import "NSDate+LGFDate.h"
//------------------ NSData 分类集合 --------------------
#import "NSData+LGFBase64.h"
//------------------ UIColor 分类集合 -------------------
#import "UIColor+LGFColor.h"
// 获取渐变色
#import "UIColor+LGFGradient.h"
//------------------ UITextView 分类集合 ----------------
#import "UITextView+LGFTextView.h"
//------------------ UITextField 分类集合 ---------------
#import "UITextField+LGFTextField.h"
//------------------ UIImage 分类集合 -------------------
#import "UIImage+LGFImage.h"
// 颜色转图片
#import "UIImage+LGFColorImage.h"
// 加载PDF图片
#import "UIImage+LGFPDFImage.h"
//------------------ UIImageView 分类集合 ---------------
#import "UIImageView+LGFImageView.h"
//------------------ UIViewController 分类集合 ----------
#import "UIViewController+LGFViewController.h"
// UIViewController 生命周期Log输出
#import "UIViewController+LGFVCLog.h"
// UIViewController 顶部提示条
#import "UIViewController+LGFTopBarMessage.h"
//------------------ UIView 分类集合 --------------------
#import "UIView+LGFExtension.h"
// 获取当前view的ViewController
#import "UIView+LGFViewController.h"
// 为故事版添加可勾选属性
#import "UIView+LGFGSView.h"
// 添加旋转动画 可断点暂停
#import "UIView+LGFRotateAnimation.h"
//------------------ UIButton 分类集合 ------------------
// 设置按钮图片的位置
#import "UIButton+LGFImagePosition.h"
// 按钮加载中句话显示
#import "UIButton+LGFIndicator.h"
//------------------ UIWindow 分类集合 ------------------
// 取得当前显示的 视图控制器
#import "UIWindow+LGFTopVC.h"
//------------------ UIDevice 分类集合 ------------------
// 获取各种设备信息
#import "UIDevice+LGFDevice.h"
//------------------ NSObject 分类集合 ------------------
// KVO Block回调
#import "NSObject+LGFKVOBlocks.h"
// 动态获取 类属性列表 方法列表 等等等
#import "NSObject+LGFReflection.h"
// JSON 数据解析
#import "NSObject+LGFModel.h"
// 动态方法添加／替换／判断等等
#import "NSObject+LGFRuntime.h"
//------------------ NSDictionary 分类集合 ---------------
// 字典转josn字符串
#import "NSDictionary+LGFToJSONString.h"
//------------------ NSArray 分类集合 --------------------
// 数组转josn字符串
#import "NSArray+LGFToJSONString.h"
//------------------ UIWebView 分类集合 ------------------
// UIWebView 清空 Cookies
#import "UIWebView+LGFClearCookies.h"
//------------------ CLLocation 分类集合 -----------------
// 火星坐标转换
#import "CLLocation+LGFCLLocation.h"
//------------------ UITabBarController 分类集合 ---------
// 动画显示隐藏 TabBar
#import "UITabBarController+LGFTabBarAnimatedHidden.h"

#endif /* LGFOCTool_h */
