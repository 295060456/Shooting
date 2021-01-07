//
//  DDCollectionViewCell_Style2+UICollectionViewDelegateFlowLayout.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/6.
//

#import "DDCollectionViewCell_Style2+UICollectionViewDelegateFlowLayout.h"

@implementation DDCollectionViewCell_Style2 (UICollectionViewDelegateFlowLayout)

#pragma mark —— UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [DDCollectionViewCell_Style3 cellSizeWithModel:self.invitationModel.imageArr[indexPath.row]];
}
///每个item之间的间距 横（行）间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 6;
}
///每个item之间的间距  列(纵)间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
///内间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout*)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(6,
                            0,
                            6,
                            0);
}

@end
