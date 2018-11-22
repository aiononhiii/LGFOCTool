//
//  UIScrollView+LGFLGFMJRefresh.m
//  OptimalLive
//
//  Created by apple on 2018/7/23.
//  Copyright © 2018年 LGF. All rights reserved.
//

#import "UIScrollView+LGFRefresh.h"

@implementation UIScrollView (LGFRefresh)

@dynamic lgf_NoMoreView;
@dynamic lgf_Footer;
@dynamic lgf_Header;

static const char *lgf_NoMoreViewKey = "lgf_NoMoreViewKey";

- (LGFMJRefreshFooter *)lgf_Footer {
    return (LGFMJRefreshFooter *)self.lgfmj_footer;
}

- (LGFMJRefreshHeader *)lgf_Header {
    return (LGFMJRefreshHeader *)self.lgfmj_header;
}

- (void)setLgf_Header:(LGFMJRefreshHeader *)lgf_Header {
    self.lgfmj_header = lgf_Header;
}

- (void)setLgf_Footer:(LGFMJRefreshFooter *)lgf_Footer {
    LGFMJRefreshAutoNormalFooter *footer = (LGFMJRefreshAutoNormalFooter *)lgf_Footer;
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.textColor = [UIColor clearColor];
    [footer setTitle:@"" forState:LGFMJRefreshStateIdle];
    [footer setTitle:@"" forState:LGFMJRefreshStateRefreshing];
    [footer setTitle:@"" forState:LGFMJRefreshStateNoMoreData];
    self.lgfmj_footer = footer;
}

- (void)lgf_SetGifHeader:(LGFMJRefreshGifHeader *)gifHeader gifName:(NSString *)gifName gifSize:(CGSize)gifSize {
    gifHeader.stateLabel.textColor = [UIColor whiteColor];
    gifHeader.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    // 以后如果要给header加gif动画， 加在这里
    NSMutableArray *images = [NSMutableArray arrayWithArray:[UIImage lgf_ImagesWithGif:gifName]];
    if (images.count > 0) {
        [gifHeader setImages:images forState:LGFMJRefreshStateIdle];
        [gifHeader setImages:images forState:LGFMJRefreshStateWillRefresh];
        [gifHeader setImages:@[images.firstObject] forState:LGFMJRefreshStatePulling];
        [gifHeader setImages:images forState:LGFMJRefreshStateRefreshing];
        gifHeader.lastUpdatedTimeLabel.hidden = YES;
        gifHeader.stateLabel.hidden = YES;
        gifHeader.lgf_height = gifSize.height;
        gifHeader.gifView.translatesAutoresizingMaskIntoConstraints = NO;
        [gifHeader.gifView addConstraint:[NSLayoutConstraint constraintWithItem:gifHeader.gifView
                                                                      attribute:NSLayoutAttributeWidth
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1.0
                                                                       constant:gifSize.width]];
        [gifHeader.gifView addConstraint:[NSLayoutConstraint constraintWithItem:gifHeader.gifView
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:nil
                                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                                     multiplier:1.0
                                                                       constant:gifSize.height]];
        [gifHeader addConstraint:[NSLayoutConstraint constraintWithItem:gifHeader.gifView
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:gifHeader
                                                              attribute:NSLayoutAttributeCenterX multiplier:1.0
                                                               constant:0]];
        [gifHeader addConstraint:[NSLayoutConstraint constraintWithItem:gifHeader.gifView
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:gifHeader
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1.0
                                                               constant:0]];
    }
    self.lgfmj_header = gifHeader;
}

- (void)setLgf_NoMoreView:(UIView *)lgf_NoMoreView {
    objc_setAssociatedObject(self, &lgf_NoMoreViewKey, lgf_NoMoreView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)lgf_NoMoreView {
    return objc_getAssociatedObject(self, &lgf_NoMoreViewKey);
}

- (void)lgf_EndRefreshing {
    [self.lgfmj_footer endRefreshing];
    [self.lgfmj_header endRefreshing];
}

- (void)lgf_ReloadDataAndNoMoreDataView:(UIView *)noMoreDataView isShow:(BOOL)isShow {
    [self.lgf_NoMoreView removeFromSuperview];
    // 数据数组count小于10 显示我是有底线的view
    if (isShow) {
        [self.lgfmj_footer endRefreshingWithNoMoreData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lgf_NoMoreView = noMoreDataView;
            self.lgf_NoMoreView.frame = self.lgfmj_footer.bounds;
            [self.lgfmj_footer addSubview:self.lgf_NoMoreView];
        });
    } else {
        [self.lgfmj_footer resetNoMoreData];
    }
    // 刷新数据源
    if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *cv = (UICollectionView *)self;
        [cv reloadData];
    } else if ([self isKindOfClass:[UITableView class]]) {
        UITableView *cv = (UITableView *)self;
        [cv reloadData];
    }
}

@end
