//
//  DDCollectionViewCell_Style2+GKPhotoBrowserDelegate.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/28.
//

#import "DDCollectionViewCell_Style2.h"

NS_ASSUME_NONNULL_BEGIN

@interface SaveImageModel : NSObject

@property(nonatomic,assign)NSInteger longPressWithIndex;
@property(nonatomic,assign)NSIndexPath *idxPath;
@property(nonatomic,weak)DDCollectionViewCell_Style2 *cell;
@property(nonatomic,assign)GKPhotoBrowser *photoBrowser;

@end

@interface DDCollectionViewCell_Style2 (GKPhotoBrowserDelegate)

@end

NS_ASSUME_NONNULL_END
