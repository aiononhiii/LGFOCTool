//
//  YDFMFMHistoryCVCell.h
//  YDFM-YDFM
//
//  Created by apple on 2018/3/8.
//

#import <UIKit/UIKit.h>

@interface YDFMFMHistoryCVCell : UICollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@property (weak, nonatomic) IBOutlet UIImageView *coverUrlMiddle;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *intro;
@property (nonatomic, weak) IBOutlet UILabel *playCount;
@property (nonatomic, weak) IBOutlet UILabel *includeTrackCount;
@end
