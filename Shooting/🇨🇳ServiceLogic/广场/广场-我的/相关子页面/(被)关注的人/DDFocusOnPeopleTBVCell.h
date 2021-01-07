//
//  DDFocusOnPeopleTBVCell.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDFocusOnPeopleTBVCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
-(void)richElementsInCellWithModel:(id _Nullable)model;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
-(void)actionBlockFocusOnPeopleTBVCell:(MKDataBlock)focusOnPeopleTBVCellBlock;

@end

NS_ASSUME_NONNULL_END
