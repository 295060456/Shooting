//
//  DDUserDetailsCollectionReusableView.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/4.
//

#import "BaseCollectionReusableView.h"
#import "DDAttentionAndFansView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDUserDetailsCollectionReusableView : BaseCollectionReusableView

-(void)actionBlockUserDetailsCollectionReusableView:(MKDataBlock)userDetailsCollectionReusableViewBlock;
-(void)richElementsInCellWithModel:(NSString *_Nullable)model;

@end

NS_ASSUME_NONNULL_END
