//
//  UIScrollView+LGFLGFMJRefresh.h
//  OptimalLive
//
//  Created by apple on 2018/7/23.
//  Copyright © 2018年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGFOCTool.h"
#import "LGFMJRefresh.h"

#undef LGFMJHeader
#define LGFMJHeader(Target, SEL) [LGFMJRefreshNormalHeader headerWithRefreshingTarget:Target refreshingAction:SEL]
#undef LGFMJGifHeader
#define LGFMJGifHeader(Target, SEL) [LGFMJRefreshGifHeader headerWithRefreshingTarget:Target refreshingAction:SEL]
#undef LGFMJFooter
#define LGFMJFooter(Target, SEL) [LGFMJRefreshAutoNormalFooter footerWithRefreshingTarget:Target refreshingAction:SEL]

@interface UIScrollView (LGFRefresh)
// 我是有底线的view
@property (nonatomic, strong) UIView *lgf_NoMoreView;
@property (nonatomic, strong) LGFMJRefreshHeader *lgf_Header;
@property (nonatomic, strong) LGFMJRefreshFooter *lgf_Footer;
// header 和 footer 同时结束刷新
- (void)lgf_EndRefreshing;
// 传入 数据数组count 判断是否要显示 我是有底线的view 并且刷新
- (void)lgf_ReloadDataAndNoMoreDataView:(UIView *)noMoreDataView isShow:(BOOL)isShow;

- (void)lgf_SetGifHeader:(LGFMJRefreshGifHeader *)gifHeader gifName:(NSString *)gifName gifSize:(CGSize)gifSize;
@end
