//
//  LGFMJRefreshAutoFooter.m
//  LGFMJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LGFMJRefreshAutoFooter.h"

@interface LGFMJRefreshAutoFooter()
/** 一个新的拖拽 */
@property (assign, nonatomic, getter=isOneNewPan) BOOL oneNewPan;
@end

@implementation LGFMJRefreshAutoFooter

#pragma mark - 初始化
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) { // 新的父控件
        if (self.hidden == NO) {
            self.scrollView.lgfmj_insetB += self.lgfmj_h;
        }
        
        // 设置位置
        self.lgfmj_y = _scrollView.lgfmj_contentH;
    } else { // 被移除了
        if (self.hidden == NO) {
            self.scrollView.lgfmj_insetB -= self.lgfmj_h;
        }
    }
}

- (void)setBscrollView:(UIScrollView *)bscrollView {
    _bscrollView = bscrollView;
    if (self.hidden == NO) {
        self.bscrollView.lgfmj_insetB += self.lgfmj_h;
    }
    
    // 设置位置
    self.lgfmj_y = _bscrollView.lgfmj_contentH;
}

#pragma mark - 过期方法
- (void)setAppearencePercentTriggerAutoRefresh:(CGFloat)appearencePercentTriggerAutoRefresh
{
    self.triggerAutomaticallyRefreshPercent = appearencePercentTriggerAutoRefresh;
}

- (CGFloat)appearencePercentTriggerAutoRefresh
{
    return self.triggerAutomaticallyRefreshPercent;
}

#pragma mark - 实现父类的方法
- (void)prepare
{
    [super prepare];
    
    // 默认底部控件100%出现时才会自动刷新
    self.triggerAutomaticallyRefreshPercent = 1.0;
    
    // 设置为默认状态
    self.automaticallyRefresh = YES;
    
    // 默认是当offset达到条件就发送请求（可连续）
    self.onlyRefreshPerDrag = NO;
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    // 设置位置
    self.lgfmj_y = self.scrollView.lgfmj_contentH;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.state != LGFMJRefreshStateIdle || !self.automaticallyRefresh || self.lgfmj_y == 0) return;
    
    if (_scrollView.lgfmj_insetT + _scrollView.lgfmj_contentH > _scrollView.lgfmj_h) { // 内容超过一个屏幕
        // 这里的_scrollView.lgfmj_contentH替换掉self.lgfmj_y更为合理
        if (_scrollView.lgfmj_offsetY >= _scrollView.lgfmj_contentH - _scrollView.lgfmj_h + self.lgfmj_h * self.triggerAutomaticallyRefreshPercent + _scrollView.lgfmj_insetB - self.lgfmj_h) {
            // 防止手松开时连续调用
            CGPoint old = [change[@"old"] CGPointValue];
            CGPoint new = [change[@"new"] CGPointValue];
            if (new.y <= old.y) return;
            
            // 当底部刷新控件完全出现时，才刷新
            [self beginRefreshing];
        }
    }
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
    if (self.state != LGFMJRefreshStateIdle) return;
    
    UIGestureRecognizerState panState = _scrollView.panGestureRecognizer.state;
    UIGestureRecognizerState bpanState = _bscrollView.panGestureRecognizer.state;
    
    CGPoint translation = [_scrollView.panGestureRecognizer translationInView:self];
    CGPoint btranslation = [_bscrollView.panGestureRecognizer translationInView:self];
    CGFloat absX = fabs(translation.x);
    CGFloat absY = fabs(translation.y);
    CGFloat babsX = fabs(btranslation.x);
    CGFloat babsY = fabs(btranslation.y);
    if ((absY > absX) || babsY > babsX) {
        if (translation.y >= 0) {
            return;
        }
    }
    
    if ((panState == UIGestureRecognizerStateEnded) || (bpanState == UIGestureRecognizerStateEnded)) {// 手松开
        if ((_scrollView.lgfmj_insetT + _scrollView.lgfmj_contentH <= _scrollView.lgfmj_h) || (_bscrollView.lgfmj_insetT + _bscrollView.lgfmj_contentH <= _bscrollView.lgfmj_h)) {  // 不够一个屏幕
            if ((_scrollView.lgfmj_offsetY >= - _scrollView.lgfmj_insetT) || (_bscrollView.lgfmj_offsetY >= - _bscrollView.lgfmj_insetT)) { // 向上拽
                [self beginRefreshing];
            }
        } else { // 超出一个屏幕
            if ((_scrollView.lgfmj_offsetY >= _scrollView.lgfmj_contentH + _scrollView.lgfmj_insetB - _scrollView.lgfmj_h) || (_bscrollView.lgfmj_offsetY >= _bscrollView.lgfmj_contentH + _bscrollView.lgfmj_insetB - _bscrollView.lgfmj_h)) {
                [self beginRefreshing];
            }
        }
    } else if ((panState == UIGestureRecognizerStateBegan) || (bpanState == UIGestureRecognizerStateBegan)) {
        self.oneNewPan = YES;
    }
}

- (void)beginRefreshing
{
    if (!self.isOneNewPan && self.isOnlyRefreshPerDrag) return;
    
    [super beginRefreshing];
    
    self.oneNewPan = NO;
}

- (void)setState:(LGFMJRefreshState)state
{
    LGFMJRefreshCheckState
    
    if (state == LGFMJRefreshStateRefreshing) {
        [self executeRefreshingCallback];
    } else if (state == LGFMJRefreshStateNoMoreData || state == LGFMJRefreshStateIdle) {
        if (LGFMJRefreshStateRefreshing == oldState) {
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }
    }
}

- (void)setHidden:(BOOL)hidden
{
    BOOL lastHidden = self.isHidden;
    
    [super setHidden:hidden];
    
    if (!lastHidden && hidden) {
        self.state = LGFMJRefreshStateIdle;
        
        self.scrollView.lgfmj_insetB -= self.lgfmj_h;
    } else if (lastHidden && !hidden) {
        self.scrollView.lgfmj_insetB += self.lgfmj_h;
        
        // 设置位置
        self.lgfmj_y = _scrollView.lgfmj_contentH;
    }
}
@end
