//
//  DDAttentionAndFansView.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/5.
//

#import <UIKit/UIKit.h>
#import "TwoVerticalArrangementLabsView.h"

NS_ASSUME_NONNULL_BEGIN
// 关注数&粉丝数
@interface DDAttentionAndFansView : UIView

-(void)richElementsInCellWithModel:(id _Nullable)model;
-(void)actionBlockAttentionAndFansView:(MKDataBlock)attentionAndFansViewBlock;

@end

NS_ASSUME_NONNULL_END
