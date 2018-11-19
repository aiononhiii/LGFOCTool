//
//  UIScrollView+LGFLGFRefresh.m
//  OptimalLive
//
//  Created by apple on 2018/7/23.
//  Copyright © 2018年 LGF. All rights reserved.
//

#import "UIScrollView+LGFMJRefresh.h"

@implementation UIScrollView (LGFMJRefresh)

@dynamic lgf_NoMoreView;
@dynamic lgf_Footer;
@dynamic lgf_Header;
@dynamic lgf_BrotherScrollView;

static const char *lgf_NoMoreViewKey = "lgf_NoMoreViewKey";

- (LGFRefreshFooter *)lgf_Footer {
    return (LGFRefreshFooter *)self.lgf_footer;
}

- (LGFRefreshHeader *)lgf_header {
    return (LGFRefreshHeader *)self.lgf_header;
}

- (void)setLgf_BrotherScrollView:(UIScrollView *)lgf_BrotherScrollView {
    self.lgf_header.brotherScrollView = lgf_BrotherScrollView;
    self.lgf_footer.brotherScrollView = lgf_BrotherScrollView;
}

- (void)setLgf_Header:(LGFRefreshHeader *)lgf_Header {
    self.lgf_header = lgf_Header;
}

- (void)setLgf_Footer:(LGFRefreshFooter *)lgf_Footer {
    LGFRefreshAutoNormalFooter *footer = (LGFRefreshAutoNormalFooter *)lgf_Footer;
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.textColor = [UIColor clearColor];
    [footer setTitle:@"" forState:LGFRefreshStateIdle];
    [footer setTitle:@"" forState:LGFRefreshStateRefreshing];
    [footer setTitle:@"" forState:LGFRefreshStateNoMoreData];
    self.lgf_footer = footer;
}

- (void)lgf_SetGifHeader:(LGFRefreshGifHeader *)gifHeader gifName:(NSString *)gifName gifSize:(CGSize)gifSize {
    gifHeader.stateLabel.textColor = [UIColor whiteColor];
    gifHeader.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    // 以后如果要给header加gif动画， 加在这里
    NSMutableArray *images = [NSMutableArray arrayWithArray:[self cdi_imagesWithGif:gifName]];
    if (images.count > 0) {
        [gifHeader setImages:images forState:LGFRefreshStateIdle];
        [gifHeader setImages:images forState:LGFRefreshStateWillRefresh];
        [gifHeader setImages:@[images.firstObject] forState:LGFRefreshStatePulling];
        [gifHeader setImages:images forState:LGFRefreshStateRefreshing];
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
    self.lgf_header = gifHeader;
}

- (void)setLgf_NoMoreView:(UIView *)lgf_NoMoreView {
    objc_setAssociatedObject(self, &lgf_NoMoreViewKey, lgf_NoMoreView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)lgf_NoMoreView {
    return objc_getAssociatedObject(self, &lgf_NoMoreViewKey);
}

- (void)lgf_EndRefreshing {
    [self.lgf_footer endRefreshing];
    [self.lgf_header endRefreshing];
}

- (void)lgf_ReloadDataAndNoMoreDataView:(UIView *)noMoreDataView isShow:(BOOL)isShow {
    [self.lgf_NoMoreView removeFromSuperview];
    // 数据数组count小于10 显示我是有底线的view
    if (isShow) {
        [self.lgf_footer endRefreshingWithNoMoreData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lgf_NoMoreView = noMoreDataView;
            self.lgf_NoMoreView.frame = self.lgf_footer.bounds;
            [self.lgf_footer addSubview:self.lgf_NoMoreView];
        });
    } else {
        [self.lgf_footer resetNoMoreData];
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

- (NSArray *)cdi_imagesWithGif:(NSString *)gifNameInBoundle {
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:gifNameInBoundle withExtension:@"gif"];
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    size_t gifCount = CGImageSourceGetCount(gifSource);
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    for (size_t i = 0; i< gifCount; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [frames addObject:image];
        CGImageRelease(imageRef);
    }
    return frames;
}

@end
