//
//  DDCollectionViewCell_Style2TBVCell.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/6.
//

#import <UIKit/UIKit.h>
#import "DDCollectionViewCell_Style2TBVCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDCollectionViewCell_Style2TBVCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
-(void)richElementsInCellWithModel:(DDCollectionViewCell_Style2TBVCellModel *_Nullable)model;
+(CGFloat)cellHeightWithModel:(DDCollectionViewCell_Style2TBVCellModel *_Nullable)model;

@end

NS_ASSUME_NONNULL_END
