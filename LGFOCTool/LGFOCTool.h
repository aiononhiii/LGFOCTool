//
//  LGFOCTool.h
//  LGFOCTool
//
//  Created by apple on 2018/4/28.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#ifndef LGFOCTool_h
#define LGFOCTool_h

// 宏集合
#import "LGFPch.h"

//****************************** 自定义控件 *******************************
// 倒计时按钮 用于发送验证码
#import "LGFCountDownButton.h"
// Pop 菜单


//******************************** 分类 **********************************
//------------------ NSString 分类集合 ------------------
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
//------------------ NSDate 分类集合 ------------------
#import "NSDate+LGFDate.h"
//------------------ NSData 分类集合 ------------------
#import "NSData+LGFBase64.h"
//------------------ UIColor 分类集合 ------------------
#import "UIColor+LGFColor.h"
// 获取渐变色
#import "UIColor+LGFGradient.h"
//------------------ UITextView 分类集合 ------------------
#import "UITextView+LGFTextView.h"
//------------------ UITextField 分类集合 ------------------
#import "UITextField+LGFTextField.h"
//------------------ UIImage 分类集合 ------------------
#import "UIImage+LGFImage.h"
// 颜色转图片
#import "UIImage+LGFColorImage.h"
// 加载PDF图片
#import "UIImage+LGFPDFImage.h"
//------------------ UIImageView 分类集合 ------------------
#import "UIImageView+LGFImageView.h"
//------------------ UIViewController 分类集合 ------------------
#import "UIViewController+LGFViewController.h"
// UIViewController 生命周期Log输出
#import "UIViewController+LGFVCLog.h"
// UIViewController 顶部提示条
#import "UIViewController+LGFTopBarMessage.h"
//------------------ UIView 分类集合 ------------------
#import "UIView+LGFExtension.h"
//------------------ UIButton 分类集合 ------------------
// 设置按钮图片的位置
#import "UIButton+LGFImagePosition.h"
//------------------ UIWindow 分类集合 ------------------
// 取得当前显示的 视图控制器
#import "UIWindow+LGFTopVC.h"
//------------------ UIDevice 分类集合 ------------------
// 获取各种设备信息
#import "UIDevice+LGFDevice.h"




// 所有特殊方法
#import "LGFAllMethod.h"

#endif /* LGFOCTool_h */
