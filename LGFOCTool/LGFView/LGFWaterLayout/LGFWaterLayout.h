//
//  LGFWaterLayout.h
//  JKRFallsDemo
//
//  Created by apple on 2018/6/6.
//  Copyright © 2018年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGFWaterLayout;
@protocol LGFWaterLayoutDelegate <NSObject>
@optional

#pragma mark - 显示 列数
- (CGFloat)lgf_ColumnCountInWaterLayout:(LGFWaterLayout *)waterLayout;

#pragma mark - 列间距
- (CGFloat)lgf_ColumnMarginInWaterLayout:(LGFWaterLayout *)waterLayout;

#pragma mark - 行间距
- (CGFloat)lgf_RowMarginInWaterLayout:(LGFWaterLayout *)waterLayout;

#pragma mark - collectionView 上下左右 边距
- (UIEdgeInsets)lgf_EdgeInsetsInWaterLayout:(LGFWaterLayout *)waterLayout;

@required
#pragma mark - 设置动态cell高度
/**
 @param waterLayout LGFWaterLayout
 @param indexPath 当前 cell 的 indexPath
 @return cell高度
 */
- (CGFloat)lgf_cellHeightInWaterLayout:(LGFWaterLayout *)waterLayout indexPath:(NSIndexPath *)indexPath;

@end

@interface LGFWaterLayout : UICollectionViewLayout
@property (nonatomic, weak) id<LGFWaterLayoutDelegate> delegate;
@end
