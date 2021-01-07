//
//  DDUserDetailsCollectionReusableView.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/4.
//

#import "CollectionReusableView.h"
#import "DDAttentionAndFansView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDUserDetailsCollectionReusableView : CollectionReusableView

-(void)actionBlockUserDetailsCollectionReusableView:(MKDataBlock)userDetailsCollectionReusableViewBlock;
-(void)richElementsInCellWithModel:(NSString *_Nullable)model;

@end

NS_ASSUME_NONNULL_END
