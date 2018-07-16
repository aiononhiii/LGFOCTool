//
//  LGFPageTitleView.m
//  LGFPageTitleView
//
//  Created by apple on 2018/3/23.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "LGFPageTitleView.h"

@interface LGFPageTitleView () <UIScrollViewDelegate>

/**
 外部父视图控制器
 */
@property (weak, nonatomic) UIViewController *super_vc;

/**
 外部父控件（用于确定添加的位置）
 */
@property (weak, nonatomic) UIView *super_view;

/**
 外部分页控制器
 */
@property (weak, nonatomic) UICollectionView *page_view;

/**
 底部滚动条
 */
@property (weak, nonatomic) LGFTitleLine *title_line;

/**
 将要选中下标
 */
@property (assign, nonatomic) NSInteger select_index;

/**
 前一个选中下标
 */
@property (assign, nonatomic) NSInteger un_select_index;

/**
 前一个x坐标点
 */
@property (assign, nonatomic) NSInteger old_off_set_x;

/**
 所有标数组
 */
@property (strong, nonatomic) NSMutableArray *title_buttons;

/**
 title 字体渐变色
 */
@property (strong, nonatomic) NSArray *deltaRGBA;
@property (strong, nonatomic) NSArray *select_colorRGBA;
@property (strong, nonatomic) NSArray *un_select_colorRGBA;
@end

@implementation LGFPageTitleView

- (void)setPage_view:(UICollectionView *)page_view {
    // 默认强制横向滚动 + 分页滚动
    page_view.pagingEnabled = YES;
    UICollectionViewFlowLayout *newLayout = [[UICollectionViewFlowLayout alloc] init];
    newLayout.minimumLineSpacing = 0.0;
    newLayout.minimumInteritemSpacing = 0.0;
    newLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [page_view setCollectionViewLayout:newLayout];
    [page_view addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    _page_view = page_view;
}

/**
 底部滚动条
 */
- (LGFTitleLine *)title_line {
    if (!self.style.is_show_line) {
        return nil;
    }
    if (!_title_line) {
        _title_line = [LGFTitleLine style:self.style];
    }
    return _title_line;
}

/**
 未选中颜色数组
 */
- (NSArray *)un_select_colorRGBA {
    if (!_un_select_colorRGBA) {
        NSArray *normal_colorRGBA = [LGFMethod getColorRGBA:self.style.un_select_color];
        NSAssert(normal_colorRGBA, @"设置普通状态的文字颜色时 请使用RGBA空间的颜色值");
        _un_select_colorRGBA = normal_colorRGBA;
    }
    return  _un_select_colorRGBA;
}

/**
 选中颜色数组
 */
- (NSArray *)select_colorRGBA {
    if (!_select_colorRGBA) {
        NSArray *select_colorRGBA = [LGFMethod getColorRGBA:self.style.select_color];
        NSAssert(select_colorRGBA, @"设置选中状态的文字颜色时 请使用RGBA空间的颜色值");
        _select_colorRGBA = select_colorRGBA;
    }
    return  _select_colorRGBA;
}

/**
 中和颜色数组
 */
- (NSArray *)deltaRGBA {
    if (_deltaRGBA == nil) {
        NSArray *un_select_colorRGBA = self.un_select_colorRGBA;
        NSArray *select_colorRGBA = self.select_colorRGBA;
        NSArray *delta;
        if (un_select_colorRGBA && select_colorRGBA) {
            CGFloat deltaR = [un_select_colorRGBA[0] floatValue] - [select_colorRGBA[0] floatValue];
            CGFloat deltaG = [un_select_colorRGBA[1] floatValue] - [select_colorRGBA[1] floatValue];
            CGFloat deltaB = [un_select_colorRGBA[2] floatValue] - [select_colorRGBA[2] floatValue];
            CGFloat deltaA = [un_select_colorRGBA[3] floatValue] - [select_colorRGBA[3] floatValue];
            delta = [NSArray arrayWithObjects:@(deltaR), @(deltaG), @(deltaB), @(deltaA), nil];
            _deltaRGBA = delta;
        }
    }
    return _deltaRGBA;
}

/**
 标数组
 */
- (NSMutableArray *)title_buttons {
    if (!_title_buttons) {
        _title_buttons = [NSMutableArray new];
    }
    return _title_buttons;
}

#pragma mark - 初始化标view

+ (instancetype)na {
    LGFPageTitleView *pageTitleView = [LGFBundle loadNibNamed:NSStringFromClass([LGFPageTitleView class]) owner:self options:nil][0];
    pageTitleView.delegate = pageTitleView;
    return pageTitleView;
}

#pragma mark - 标view配置

- (instancetype)initWithStyle:(LGFPageTitleStyle *)style super_vc:(UIViewController *)super_vc super_view:(UIView *)super_view page_view:(UICollectionView *)page_view {
    NSAssert(super_vc, @"请在initWithStyle方法中传入父视图控制器! 否则将无法联动控件");
    NSAssert(page_view, @"请在initWithStyle方法中传入分页控件! 否则将无法联动控件");
    [super_view setNeedsLayout];
    [super_view layoutIfNeeded];
    self.style = style;
    self.super_vc = super_vc;
    self.page_view = page_view;
    self.un_select_index = 0;
    self.style.page_title_view = self;
    if (super_view) {
        if (CGRectEqualToRect(self.style.page_title_view_frame, CGRectZero)) {
            self.frame = super_view.bounds;
        } else {
            self.frame = style.page_title_view_frame;
        }
        self.backgroundColor = super_view.backgroundColor;
        [super_view addSubview:self];
    }
    return self;
}

#pragma mark - 添加底部线

- (void)addScrollLine {
    if (self.style.is_show_line) {
        [self addSubview:self.title_line];
        [self sendSubviewToBack:self.title_line];
    }
}

#pragma mark - 添加所有标

- (void)reloadAllTitlesSelectIndex:(NSInteger)index {
    if (self.style.titles.count == 0 || !self.style.titles) {
        return;
    }
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.title_buttons removeAllObjects];
    __block CGFloat contentWidth = 0.0;
    [self.style.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LGFTitleButton *title = [LGFTitleButton title:obj index:idx style:self.style];
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(autoTitleSelect:)];
        [title addGestureRecognizer:tapRecognize];
        [self.title_buttons addObject:title];
        contentWidth += title.frame.size.width;
    }];
    // 标view 滚动区域配置
    [self setContentSize:CGSizeMake(contentWidth + self.style.title_left_right_spacing * 2, 0.0)];
    if (self.style.is_title_center) {
        if (self.contentSize.width < self.width) {
            self.x = (self.width / 2) - (self.contentSize.width / 2);
        } else {
            self.x = 0.0;
        }
    }
    // 添加底部滚动线
    [self addScrollLine];
    [self selectTitleForIndex:index];
}

#pragma mark - 标点击事件

- (void)autoTitleSelect:(UITapGestureRecognizer *)sender {
    LGFTitleButton *view = (LGFTitleButton *)sender.view;
    [self selectTitleForTag:view.title.tag];
}

#pragma mark - 滚动到指定tag位置

- (void)selectTitleForTag:(NSInteger)index {
    if ([self.page_view numberOfItemsInSection:0] == 0 || [self.page_view numberOfItemsInSection:0] <= index || self.style.titles.count == 0 || self.select_index == index) {
        return;
    }
    self.select_index = index;
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        // 更新标view的UI
        [self adjustUIWhenBtnOnClickWithAnimate:true taped:YES];
    });
    dispatch_async(queue, ^{
        // 外部分页控制器 滚动到对应下标
        [self.page_view setContentOffset:CGPointMake(self.page_view.width * self.select_index, 0)];
    });
}

#pragma mark - 滚动到指定index位置

- (void)selectTitleForIndex:(NSInteger)index {
    if ([self.page_view numberOfItemsInSection:0] == 0 || [self.page_view numberOfItemsInSection:0] <= index) {
        return;
    }
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        [self.page_view setContentOffset:CGPointMake(self.page_view.width * index, 0)];
    });
    dispatch_async(queue, ^{
        self.un_select_index = index;
        self.select_index = index < 0 || (index >= self.style.titles.count) ? 0 : index;
    });
    dispatch_async(queue, ^{
        [self autoSelectWithAnimated:NO];
    });
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark - 标自动滚动

- (void)autoScrollTitle {
    self.select_index = (self.page_view.contentOffset.x / (NSInteger)self.page_view.bounds.size.width);
    [self autoSelectWithAnimated:YES];
}

- (void)autoSelectWithAnimated:(BOOL)animated {
    if (self.style.titles.count == 0 || self.select_index >= self.style.titles.count) {
        return;
    }
    LGFLog(@"当前选中:%@", self.style.titles[self.select_index]);
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        [self adjustUIWithProgress:1.0 oldIndex:self.un_select_index currentIndex:self.select_index];
    });
    dispatch_async(queue, ^{
        [self adjustTitleOffSetToSelectIndex:self.select_index animated:animated];
    });
}

#pragma mark - 调整title位置 使其滚动到中间

- (void)adjustTitleOffSetToSelectIndex:(NSInteger)select_index animated:(BOOL)animated {
    if (self.title_buttons.count == 0 || select_index >= self.title_buttons.count) {
        return;
    }
    //    self.un_select_index = select_index;
    //    // 重置渐变/缩放效果附近其他item的缩放和颜色
    //    int index = 0;
    //    for (LGFTitleButton *title in self.title_buttons) {
    //        if (index != select_index) {
    //            [title.title setTitleColor:self.style.un_select_color forState:UIControlStateNormal];
    //            title.currentTransformSx = 1.0;
    //        } else {
    //            [title.title setTitleColor:self.style.select_color forState:UIControlStateNormal];
    //            if (self.style.title_big_scale != 0) {
    //                title.currentTransformSx = self.style.title_big_scale;
    //            }
    //        }
    //        index++;
    //    }
    
    if (self.style.title_scroll_follow_type == LGFTitleScrollFollowDefult) {
        LGFTitleButton *select_title = (LGFTitleButton *)self.title_buttons[select_index];
        CGFloat offSetx = select_title.center.x - self.width * 0.5;
        if (offSetx < 0) {
            offSetx = 0;
        }
        CGFloat maxOffSetX = self.contentSize.width - self.width;
        if (maxOffSetX < 0) {
            maxOffSetX = 0;
        }
        if (offSetx > maxOffSetX) {
            offSetx = maxOffSetX;
        }
        [self setContentOffset:CGPointMake(offSetx, 0.0) animated:animated];
    } else if (self.style.title_scroll_follow_type == LGFTitleScrollFollowLeftRight) {
        NSAssert(self.style.title_scroll_follow_type != LGFTitleScrollFollowDefult, @"LGFTitleScrollFollowLeftRight -- 改方法暂时未实现功能 现不可用");
    }
}

#pragma mark -  外层分页控制器 contentOffset 转化

- (void)onProgress:(CGFloat)contentOffset_x {
    CGFloat tempProgress = contentOffset_x / self.page_view.bounds.size.width;
    NSInteger tempIndex = tempProgress;
    CGFloat progress = tempProgress - floor(tempProgress);
    if (progress == 0.0) {
        return;
    }
    CGFloat deltaX = contentOffset_x - _old_off_set_x;
    if (contentOffset_x < 0) { return; }
    if (deltaX > 0) {// 向左
        self.select_index = tempIndex + 1;
        self.un_select_index = tempIndex;
    } else if (deltaX < 0) {
        progress = 1.0 - progress;
        self.un_select_index = tempIndex + 1;
        self.select_index = tempIndex;
    } else {
        return;
    }
    [self adjustUIWithProgress:progress oldIndex:self.un_select_index currentIndex:self.select_index];
}

#pragma mark - 更新标view的UI(用于滚动外部分页控制器的时候)

- (void)adjustUIWithProgress:(CGFloat)progress oldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex {
    // 判断是否满足UI更新条件
    if (oldIndex < 0 || oldIndex >= self.title_buttons.count || currentIndex < 0 || currentIndex >= self.title_buttons.count) {
        return;
    }
    NSAssert(self.style.un_select_image_names.count == self.style.select_image_names.count, @"选中图片数组和未选中图片数组count必须一致");
    self.un_select_index = currentIndex;
    // 取得 前一个选中的标 和ś将要选中的标
    LGFTitleButton *un_select_title = (LGFTitleButton *)self.title_buttons[oldIndex];
    LGFTitleButton *select_title = (LGFTitleButton *)self.title_buttons[currentIndex];
    // 标颜色渐变
    if (self.style.select_color != self.style.un_select_color) {
        [un_select_title.title setTitleColor:[UIColor
                                              colorWithRed:[self.select_colorRGBA[0] floatValue] + [self.deltaRGBA[0] floatValue] * progress
                                              green:[self.select_colorRGBA[1] floatValue] + [self.deltaRGBA[1] floatValue] * progress
                                              blue:[self.select_colorRGBA[2] floatValue] + [self.deltaRGBA[2] floatValue] * progress
                                              alpha:[self.select_colorRGBA[3] floatValue] + [self.deltaRGBA[3] floatValue] * progress] forState:UIControlStateNormal];
        [select_title.title setTitleColor:[UIColor
                                           colorWithRed:[self.un_select_colorRGBA[0] floatValue] - [self.deltaRGBA[0] floatValue] * progress
                                           green:[self.un_select_colorRGBA[1] floatValue] - [self.deltaRGBA[1] floatValue] * progress
                                           blue:[self.un_select_colorRGBA[2] floatValue] - [self.deltaRGBA[2] floatValue] * progress
                                           alpha:[self.un_select_colorRGBA[3] floatValue] - [self.deltaRGBA[3] floatValue] * progress] forState:UIControlStateNormal];
    }
    // 字体改变
    if (![self.style.select_title_font isEqual:self.style.un_select_title_font]) {
        if (progress > 0.5) {
            un_select_title.title.titleLabel.font = self.style.un_select_title_font;
            select_title.title.titleLabel.font = self.style.select_title_font ?: self.style.un_select_title_font;
        } else {
            un_select_title.title.titleLabel.font = self.style.select_title_font ?: self.style.un_select_title_font;
            select_title.title.titleLabel.font = self.style.un_select_title_font;
        }
    }
    // 左边图标选中
    if (self.style.left_image_width > 0.0) {
        if (self.style.select_image_names && self.style.select_image_names.count > 0 && self.style.un_select_image_names && self.style.un_select_image_names.count > 0) {
            if (progress > 0.5) {
                [un_select_title.left_image setImage:[UIImage imageNamed:self.style.un_select_image_names[oldIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
                [select_title.left_image setImage:[UIImage imageNamed:self.style.select_image_names[currentIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
            } else {
                [un_select_title.left_image setImage:[UIImage imageNamed:self.style.select_image_names[oldIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
                [select_title.left_image setImage:[UIImage imageNamed:self.style.un_select_image_names[currentIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
            }
        }
    }
    // 右边图标选中
    if (self.style.right_image_width > 0.0) {
        if (self.style.select_image_names && self.style.select_image_names.count > 0 && self.style.un_select_image_names && self.style.un_select_image_names.count > 0) {
            if (progress > 0.5) {
                [un_select_title.right_image setImage:[UIImage imageNamed:self.style.un_select_image_names[oldIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
                [select_title.right_image setImage:[UIImage imageNamed:self.style.select_image_names[currentIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
            } else {
                [un_select_title.right_image setImage:[UIImage imageNamed:self.style.select_image_names[oldIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
                [select_title.right_image setImage:[UIImage imageNamed:self.style.un_select_image_names[currentIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
            }
        }
    }
    // 顶部图标选中
    if (self.style.top_image_height > 0.0) {
        if (self.style.select_image_names && self.style.select_image_names.count > 0 && self.style.un_select_image_names && self.style.un_select_image_names.count > 0) {
            if (progress > 0.5) {
                [un_select_title.top_image setImage:[UIImage imageNamed:self.style.un_select_image_names[oldIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
                [select_title.top_image setImage:[UIImage imageNamed:self.style.select_image_names[currentIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
            } else {
                [un_select_title.top_image setImage:[UIImage imageNamed:self.style.select_image_names[oldIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
                [select_title.top_image setImage:[UIImage imageNamed:self.style.un_select_image_names[currentIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
            }
        }
    }
    // 底部图标选中
    if (self.style.bottom_image_height > 0.0) {
        if (self.style.select_image_names && self.style.select_image_names.count > 0 && self.style.un_select_image_names && self.style.un_select_image_names.count > 0) {
            if (progress > 0.5) {
                [un_select_title.bottom_image setImage:[UIImage imageNamed:self.style.un_select_image_names[oldIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
                [select_title.bottom_image setImage:[UIImage imageNamed:self.style.select_image_names[currentIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
            } else {
                [un_select_title.bottom_image setImage:[UIImage imageNamed:self.style.select_image_names[oldIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
                [select_title.bottom_image setImage:[UIImage imageNamed:self.style.un_select_image_names[currentIndex] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
            }
        }
    }
    // 标缩放大小改变
    if (self.style.title_big_scale != 0) {
        CGFloat deltaScale = self.style.title_big_scale - 1.0;
        un_select_title.currentTransformSx = self.style.title_big_scale - deltaScale * progress;
        select_title.currentTransformSx = 1.0 + deltaScale * progress;
    }
    // 标底部滚动条 更新位置
    if (self.title_line && self.style.is_show_line) {
        if (self.style.line_animation == LGFPageLineAnimationDefult) {
            if (self.style.line_width_type == EqualTitle) {
                CGFloat xDistance = select_title.x - un_select_title.x;
                CGFloat wDistance = (select_title.title.width - un_select_title.title.width) * self.style.title_big_scale;
                self.title_line.x = un_select_title.x + xDistance * progress;
                self.title_line.width = un_select_title.width + wDistance * progress;
            } else if (self.style.line_width_type == EqualTitleSTRAndImage) {
                CGFloat xDistance = select_title.x - un_select_title.x;
                CGFloat wDistance = (select_title.title.width - un_select_title.title.width) * self.style.title_big_scale;
                self.title_line.x = self.style.title_fixed_width > 0 ? un_select_title.x + xDistance * progress : (self.style.title_left_right_spacing * self.style.title_big_scale + un_select_title.x + xDistance * progress);
                self.title_line.width = self.style.title_fixed_width > 0 ? un_select_title.width + (select_title.width - un_select_title.width) * progress : ((un_select_title.title.width + self.style.left_image_spacing + self.style.right_image_spacing + self.style.left_image_width + self.style.right_image_width) * self.style.title_big_scale + wDistance * progress);
            } else if (self.style.line_width_type == EqualTitleSTR) {
                CGFloat xDistance = select_title.x - un_select_title.x;
                CGFloat wDistance = (select_title.title.width - un_select_title.title.width) * self.style.title_big_scale;
                self.title_line.x = self.style.title_fixed_width > 0 ? un_select_title.x + xDistance * progress : (self.style.title_left_right_spacing + self.style.left_image_spacing + self.style.left_image_width) * self.style.title_big_scale + un_select_title.x + xDistance * progress;
                self.title_line.width = self.style.title_fixed_width > 0 ? un_select_title.width + (select_title.width - un_select_title.width) * progress : (un_select_title.title.width * self.style.title_big_scale) + wDistance * progress;
            } else if (self.style.line_width_type == FixedWith) {
                CGFloat select_title_x = select_title.x + ((select_title.width - self.style.line_width) / 2);
                CGFloat un_select_title_x = un_select_title.x + ((un_select_title.width - self.style.line_width) / 2);
                CGFloat xDistance = select_title_x - un_select_title_x;
                CGFloat xxDistance = select_title.x - un_select_title.x;
                CGFloat wDistance = select_title.width - un_select_title.width;
                self.title_line.x = self.style.line_width > un_select_title.width + wDistance * progress ? un_select_title.x + xxDistance * progress : un_select_title_x + xDistance * progress;
                self.title_line.width = MIN(self.style.line_width, un_select_title.width + wDistance * progress);
            }
        } else if (self.style.line_animation == LGFPageLineAnimationSmallToBig) {
            NSAssert(self.style.line_animation != LGFPageLineAnimationDefult, @"LGFPageLineAnimationSmallToBig -- 改方法暂时未实现功能 现不可用");
            
        }
    }
}

#pragma mark - 更新标view的UI(用于点击标的时候)

- (void)adjustUIWhenBtnOnClickWithAnimate:(BOOL)animated taped:(BOOL)taped {
    if (self.un_select_index < 0 || self.un_select_index >= self.title_buttons.count || self.select_index < 0 || self.select_index >= self.title_buttons.count) {
        return;
    }
    
    NSAssert(self.style.un_select_image_names.count == self.style.select_image_names.count, @"选中图片数组和未选中图片数组count必须一致");
    
    // 判断是否满足UI更新条件
    if (self.select_index == self.un_select_index && taped) { return; }
    // 取得 前一个选中的标 和 将要选中的标
    LGFTitleButton *un_select_title = (LGFTitleButton *)self.title_buttons[self.un_select_index];
    LGFTitleButton *select_title = (LGFTitleButton *)self.title_buttons[self.select_index];
    CGFloat animatedTime = animated ? 0.30 : 0.0;
    @lgf_Weak(self);
    [UIView animateWithDuration:animatedTime animations:^{
        @lgf_Strong(self);
        // 标颜色渐变
        [un_select_title.title setTitleColor:self.style.un_select_color forState:UIControlStateNormal];
        [select_title.title setTitleColor:self.style.select_color forState:UIControlStateNormal];
        // 字体改变
        if (![self.style.select_title_font isEqual:self.style.un_select_title_font]) {
            un_select_title.title.titleLabel.font = self.style.un_select_title_font;
            select_title.title.titleLabel.font = self.style.select_title_font ?: self.style.un_select_title_font;
        }
        // 左边图标选中
        if (self.style.left_image_width > 0.0) {
            if (self.style.select_image_names && self.style.select_image_names.count > 0 && self.style.un_select_image_names && self.style.un_select_image_names.count > 0) {
                [un_select_title.left_image setImage:[UIImage imageNamed:self.style.un_select_image_names[self.un_select_index] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
                [select_title.left_image setImage:[UIImage imageNamed:self.style.select_image_names[self.select_index] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
            }
        }
        // 右边图标选中
        if (self.style.right_image_width > 0.0) {
            if (self.style.select_image_names && self.style.select_image_names.count > 0 && self.style.un_select_image_names && self.style.un_select_image_names.count > 0) {
                [un_select_title.right_image setImage:[UIImage imageNamed:self.style.un_select_image_names[self.un_select_index] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
                [select_title.right_image setImage:[UIImage imageNamed:self.style.select_image_names[self.select_index] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
            }
        }
        // 顶部图标选中
        if (self.style.top_image_height > 0.0) {
            if (self.style.select_image_names && self.style.select_image_names.count > 0 && self.style.un_select_image_names && self.style.un_select_image_names.count > 0) {
                [un_select_title.top_image setImage:[UIImage imageNamed:self.style.un_select_image_names[self.un_select_index] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
                [select_title.top_image setImage:[UIImage imageNamed:self.style.select_image_names[self.select_index] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
            }
        }
        // 底部图标选中
        if (self.style.bottom_image_height > 0.0) {
            if (self.style.select_image_names && self.style.select_image_names.count > 0 && self.style.un_select_image_names && self.style.un_select_image_names.count > 0) {
                [un_select_title.bottom_image setImage:[UIImage imageNamed:self.style.un_select_image_names[self.un_select_index] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
                [select_title.bottom_image setImage:[UIImage imageNamed:self.style.select_image_names[self.select_index] inBundle:self.style.title_image_bundel compatibleWithTraitCollection:nil]];
            }
        }
        // 标缩放大小改变
        if (self.style.title_big_scale != 0) {
            un_select_title.currentTransformSx = 1.0;
            select_title.currentTransformSx = self.style.title_big_scale;
        }
        // 标底部滚动条 更新位置
        if (self.title_line && self.style.is_show_line) {
            if (self.style.line_animation == LGFPageLineAnimationDefult) {
                if (self.style.line_width_type == EqualTitle) {
                    self.title_line.x = select_title.x;
                    self.title_line.width = select_title.width;
                } else if (self.style.line_width_type == EqualTitleSTRAndImage) {
                    self.title_line.x = self.style.title_fixed_width > 0.0 ? select_title.x : (self.style.title_left_right_spacing * self.style.title_big_scale + select_title.x);
                    self.title_line.width = self.style.title_fixed_width > 0.0 ? select_title.width : ((select_title.title.width + self.style.left_image_spacing + self.style.right_image_spacing + self.style.left_image_width + self.style.right_image_width) * self.style.title_big_scale);
                } else if (self.style.line_width_type == EqualTitleSTR) {
                    self.title_line.x = self.style.title_fixed_width > 0.0 ? select_title.x : ((self.style.title_left_right_spacing + self.style.left_image_spacing + self.style.left_image_width) * self.style.title_big_scale + select_title.x);
                    self.title_line.width = self.style.title_fixed_width > 0.0 ? select_title.width : (select_title.title.width * self.style.title_big_scale);
                } else if (self.style.line_width_type == FixedWith){
                    self.title_line.x = self.style.line_width > select_title.width ? select_title.x : select_title.x + ((select_title.width - self.style.line_width) / 2);
                    self.title_line.width = MIN(self.style.line_width, select_title.width);
                }
            } else if (self.style.line_animation == LGFPageLineAnimationSmallToBig) {
                NSAssert(self.style.line_animation != LGFPageLineAnimationDefult, @"LGFPageLineAnimationSmallToBig -- 改方法暂时未实现功能 现不可用");
                
            }
        }
    } completion:^(BOOL finished) {
        @lgf_Strong(self);
        [self adjustTitleOffSetToSelectIndex:self.select_index animated:YES];
    }];
    
    // 下标反转
    self.un_select_index = self.select_index;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.old_off_set_x = scrollView.contentOffset.x;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self onProgress:self.page_view.contentOffset.x];
    }
}

#pragma mark - 已销毁

- (void)dealloc {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
    [self.page_view removeObserver:self forKeyPath:@"contentOffset"];
    [self.super_vc.childViewControllers makeObjectsPerformSelector:@selector(willMoveToParentViewController:)];
    [self.super_vc.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self.title_buttons removeAllObjects];
    self.title_buttons = nil;
    self.deltaRGBA = nil;
    self.select_colorRGBA = nil;
    self.un_select_colorRGBA = nil;
    LGFLog(@"%@_____dealloc_已销毁", self);
}



@end

