//  代码地址: https://github.com/CoderMJLee/LGFRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+LGFRefresh.m
//  LGFRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "UIScrollView+LGFRefresh.h"
#import "LGFRefreshHeader.h"
#import "LGFRefreshFooter.h"
#import <objc/runtime.h>

@implementation NSObject (LGFRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end

@implementation UIScrollView (LGFRefresh)

#pragma mark - header
static const char LGFRefreshHeaderKey = '\0';
- (void)setLgf_header:(LGFRefreshHeader *)lgf_header
{
    if (lgf_header != self.lgf_header) {
        // 删除旧的，添加新的
        [self.lgf_header removeFromSuperview];
        [self insertSubview:lgf_header atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"lgf_header"]; // KVO
        objc_setAssociatedObject(self, &LGFRefreshHeaderKey,
                                 lgf_header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"lgf_header"]; // KVO
    }
}

- (LGFRefreshHeader *)lgf_header
{
    return objc_getAssociatedObject(self, &LGFRefreshHeaderKey);
}

#pragma mark - footer
static const char LGFRefreshFooterKey = '\0';
- (void)setLgf_footer:(LGFRefreshFooter *)lgf_footer
{
    if (lgf_footer != self.lgf_footer) {
        // 删除旧的，添加新的
        [self.lgf_footer removeFromSuperview];
        [self insertSubview:lgf_footer atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"lgf_footer"]; // KVO
        objc_setAssociatedObject(self, &LGFRefreshFooterKey,
                                 lgf_footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"lgf_footer"]; // KVO
    }
}

- (LGFRefreshFooter *)lgf_footer
{
    return objc_getAssociatedObject(self, &LGFRefreshFooterKey);
}

#pragma mark - 过期
- (void)setFooter:(LGFRefreshFooter *)footer
{
    self.lgf_footer = footer;
}

- (LGFRefreshFooter *)footer
{
    return self.lgf_footer;
}

- (void)setHeader:(LGFRefreshHeader *)header
{
    self.lgf_header = header;
}

- (LGFRefreshHeader *)header
{
    return self.lgf_header;
}

#pragma mark - other
- (NSInteger)lgf_totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

static const char LGFRefreshReloadDataBlockKey = '\0';
- (void)setLgf_reloadDataBlock:(void (^)(NSInteger))lgf_reloadDataBlock
{
    [self willChangeValueForKey:@"lgf_reloadDataBlock"]; // KVO
    objc_setAssociatedObject(self, &LGFRefreshReloadDataBlockKey, lgf_reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"lgf_reloadDataBlock"]; // KVO
}

- (void (^)(NSInteger))lgf_reloadDataBlock
{
    return objc_getAssociatedObject(self, &LGFRefreshReloadDataBlockKey);
}

- (void)executeReloadDataBlock
{
    !self.lgf_reloadDataBlock ? : self.lgf_reloadDataBlock(self.lgf_totalDataCount);
}
@end

@implementation UITableView (LGFRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(lgf_reloadData)];
}

- (void)lgf_reloadData
{
    [self lgf_reloadData];
    
    [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (LGFRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(lgf_reloadData)];
}

- (void)lgf_reloadData
{
    [self lgf_reloadData];
    
    [self executeReloadDataBlock];
}
@end
