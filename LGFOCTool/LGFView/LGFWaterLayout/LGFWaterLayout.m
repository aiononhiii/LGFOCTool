//
//  LGFWaterLayout.m
//  JKRFallsDemo
//
//  Created by apple on 2018/6/6.
//  Copyright © 2018年 Lucky. All rights reserved.
//

#import "LGFWaterLayout.h"

@interface LGFWaterLayout ()
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *lgf_AttrsArray; // 所有的cell的布局
@property (nonatomic, strong) NSMutableArray *lgf_ColumnHeights;                                  // 每一列的高度
@property (nonatomic, assign) NSInteger lgf_NoneDoubleTime;                                       // 没有生成大尺寸次数
@property (nonatomic, assign) NSInteger lgf_LastDoubleIndex;                                      // 最后一次大尺寸的列数
@property (nonatomic, assign) NSInteger lgf_LastFixIndex;                                         // 最后一次对齐矫正列数
- (CGFloat)lgf_ColumnCount;     // 列数
- (CGFloat)lgf_ColumnMargin;    // 列边距
- (CGFloat)lgf_RowMargin;       // 行边距
- (UIEdgeInsets)lgf_EdgeInsets; // collectionView边距

@end

@implementation LGFWaterLayout

#pragma mark - 默认参数
static const CGFloat lgf_DefaultColumnCount = 2;                           // 默认列数
static const CGFloat lgf_DefaultColumnMargin = 1;                         // 默认列边距
static const CGFloat lgf_DefaultRowMargin = 1;                            // 默认行边距
static const UIEdgeInsets lgf_DefaultUIEdgeInsets = {0, 0, 0, 0};      // 默认collectionView边距

#pragma mark - 布局计算
// collectionView 首次布局和之后重新布局的时候会调用
// 并不是每次滑动都调用，只有在数据源变化的时候才调用
- (void)prepareLayout
{
    // 重写必须调用super方法
    [super prepareLayout];
    
    // 判断如果有50个cell（首次刷新），就重新计算
    if ([self.collectionView numberOfItemsInSection:0] == 50) {
        [self.lgf_AttrsArray removeAllObjects];
        [self.lgf_ColumnHeights removeAllObjects];
    }
    // 当列高度数组为空时，即为第一行计算，每一列的基础高度加上collection的边框的top值
    if (!self.lgf_ColumnHeights.count) {
        for (NSInteger i = 0; i < self.lgf_ColumnCount; i++) {
            [self.lgf_ColumnHeights addObject:@(self.lgf_EdgeInsets.top)];
        }
    }
    // 遍历所有的cell，计算所有cell的布局
    for (NSInteger i = self.lgf_AttrsArray.count; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 计算布局属性并将结果添加到布局属性数组中
        [self.lgf_AttrsArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}

// 返回布局属性，一个UICollectionViewLayoutAttributes对象数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.lgf_AttrsArray;
}

// 计算布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView的宽度
    CGFloat collectionViewW = [self.delegate lgf_cellHeightInWaterLayout:self indexPath:indexPath].width;
    // cell的宽度
    CGFloat w = (collectionViewW - self.lgf_EdgeInsets.left - self.lgf_EdgeInsets.right -
                 self.lgf_ColumnMargin * (self.lgf_ColumnCount - 1)) / self.lgf_ColumnCount;
    // cell的高度
    CGFloat h = [self.delegate lgf_cellHeightInWaterLayout:self indexPath:indexPath].height;
    
    // cell应该拼接的列数
    NSInteger destColumn = 0;
    
    // 高度最小的列数高度
    CGFloat minColumnHeight = [self.lgf_ColumnHeights[0] doubleValue];
    // 获取高度最小的列数
    for (NSInteger i = 1; i < self.lgf_ColumnCount; i++) {
        CGFloat columnHeight = [self.lgf_ColumnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    // 计算cell的x
    CGFloat x = self.lgf_EdgeInsets.left + destColumn * (w + self.lgf_ColumnMargin);
    // 计算cell的y
    CGFloat y = minColumnHeight;
    if (y != self.lgf_EdgeInsets.top) {
        y += self.lgf_RowMargin;
    }
    
    //    // 随机数，用来随机生成大尺寸cell
    //    NSUInteger randomOfWhetherDouble = arc4random() % 100;
    //    // 判断是否放大
    //    if (destColumn < self.columnCount - 1                               // 放大的列数不能是最后一列（最后一列方法超出屏幕）
    //        && _noneDoubleTime >= 1                                         // 如果前个cell有放大就不放大，防止连续出现两个放大
    //        && (randomOfWhetherDouble >= 45 || _noneDoubleTime >= 8)        // 45%几率可能放大，如果累计8次没有放大，那么满足放大条件就放大
    //        && [self.columnHeights[destColumn] doubleValue] == [self.columnHeights[destColumn + 1] doubleValue] // 当前列的顶部和下一列的顶部要对齐
    //        && _lastDoubleIndex != destColumn) {             // 最后一次放大的列不等当前列，防止出现连续两列出现放大不美观
    //        _noneDoubleTime = 0;
    //        _lastDoubleIndex = destColumn;
    //        // 重定义当前cell的布局:宽度*2,高度*2
    //        attrs.frame = CGRectMake(x, y, w * 2 + self.columnMargin, h * 2 + self.rowMargin);
    //        // 当前cell列的高度就是当前cell的最大Y值
    //        self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    //        // 当前cell列下一列的高度也是当前cell的最大Y值，因为cell宽度*2,占两列
    //        self.columnHeights[destColumn + 1] = @(CGRectGetMaxY(attrs.frame));
    //        return attrs;
    //    }
    // 正常cell的布局
    if (_lgf_NoneDoubleTime <= 3 || _lgf_LastFixIndex == destColumn) {                     // 如果没有放大次数小于3且当前列等于上次矫正的列，就不矫正
        attrs.frame = CGRectMake(x, y, w, h);
    } else if (self.lgf_ColumnHeights.count > destColumn + 1                         // 越界判断
               && y + h - [self.lgf_ColumnHeights[destColumn + 1] doubleValue] < w * 0.1) { // 当前cell填充后和上一列的高度偏差不超过cell最大高度的10%，就和下一列对齐
        attrs.frame = CGRectMake(x, y, w, [self.lgf_ColumnHeights[destColumn + 1] doubleValue] - y);
        _lgf_LastFixIndex = destColumn;
    } else if (destColumn >= 1                                                   // 越界判断
               && y + h - [self.lgf_ColumnHeights[destColumn - 1] doubleValue] < w * 0.1) { // 当前cell填充后和上上列的高度偏差不超过cell最大高度的10%，就和下一列对齐
        attrs.frame = CGRectMake(x, y, w, [self.lgf_ColumnHeights[destColumn - 1] doubleValue] - y);
        _lgf_LastFixIndex = destColumn;
    } else {
        attrs.frame = CGRectMake(x, y, w, h);
    }
    // 当前cell列的高度就是当前cell的最大Y值
    self.lgf_ColumnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    _lgf_NoneDoubleTime += 1;
    // 返回计算获取的布局
    return attrs;
}

#pragma mark - 返回collectionView的ContentSize
- (CGSize)collectionViewContentSize {
    // collectionView的contentSize的高度等于所有列高度中最大的值
    CGFloat maxColumnHeight = [self.lgf_ColumnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.lgf_ColumnCount; i++) {
        CGFloat columnHeight = [self.lgf_ColumnHeights[i] doubleValue];
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(0, maxColumnHeight + self.lgf_EdgeInsets.bottom);
}

#pragma mark - 懒加载
- (NSMutableArray *)lgf_AttrsArray {
    if (!_lgf_AttrsArray) {
        _lgf_AttrsArray = [NSMutableArray array];
    }
    return _lgf_AttrsArray;
}

- (NSMutableArray *)lgf_ColumnHeights {
    if (!_lgf_ColumnHeights) {
        _lgf_ColumnHeights = [NSMutableArray array];
    }
    return _lgf_ColumnHeights;
}

- (CGFloat)lgf_RowMargin {
    if ([self.delegate respondsToSelector:@selector(lgf_RowMarginInWaterLayout:)]) {
        return [self.delegate lgf_RowMarginInWaterLayout:self];
    } else {
        return lgf_DefaultRowMargin;
    }
}

- (CGFloat)lgf_ColumnCount {
    if ([self.delegate respondsToSelector:@selector(lgf_ColumnCountInWaterLayout:)]) {
        return [self.delegate lgf_ColumnCountInWaterLayout:self];
    } else {
        return lgf_DefaultColumnCount;
    }
}

- (CGFloat)lgf_ColumnMargin {
    if ([self.delegate respondsToSelector:@selector(lgf_ColumnMarginInWaterLayout:)]) {
        return [self.delegate lgf_ColumnMarginInWaterLayout:self];
    } else {
        return lgf_DefaultColumnMargin;
    }
}

- (UIEdgeInsets)lgf_EdgeInsets {
    if ([self.delegate respondsToSelector:@selector(lgf_EdgeInsetsInWaterLayout:)]) {
        return [self.delegate lgf_EdgeInsetsInWaterLayout:self];
    } else {
        return lgf_DefaultUIEdgeInsets;
    }
}

@end
