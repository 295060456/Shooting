//
//  DDCollectionViewCell_Style2.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/26.
//

#import "DDInvitationModel.h"

#import "CollectionViewCell.h"
#import "DDCollectionViewCell_Style3.h"
#if __has_include(<GKPhotoBrowser/GKPhotoBrowser.h>)
#import <GKPhotoBrowser/GKPhotoBrowser.h>
#else
#import "GKPhotoBrowser.h"
#endif

NS_ASSUME_NONNULL_BEGIN
///(图文 或者 纯文字 或者 纯图片 )+评论
@interface DDCollectionViewCell_Style2 : CollectionViewCell

//UI /** 不能强引用 */
@property(nonatomic,weak)GKPhotoBrowser *browser;
@property(nonatomic,weak)DDCollectionViewCell_Style3 *selectCell;
//Data
@property(nonatomic,strong)DDInvitationModel *invitationModel;
@property(nonatomic,strong)NSMutableArray <GKPhoto *>*photosMutArr;//photos
@property(nonatomic,copy)MKDataBlock collectionViewCell_Style2Block;
@property(nonatomic,assign)BOOL isCoverShow;

-(void)actionBlockCollectionViewCell_Style2:(MKDataBlock)collectionViewCell_Style2Block;

@end

NS_ASSUME_NONNULL_END
