//
//  DDInvitationModel.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/27.
//

#import "BaseModel.h"
#import "DefineStructure.h"
#import "DDCollectionViewCell_Style2TBVCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDInvitationModel : BaseModel

@property(nonatomic,strong)NSArray <UIImage *>*imageArr;//图
@property(nonatomic,strong)NSString *string;//文
@property(nonatomic,strong)NSString *playerUrlStr;//播放地址
@property(nonatomic,strong)NSString *adUrlStr;//广告地址
@property(nonatomic,strong)NSArray <DDCollectionViewCell_Style2TBVCellModel *>*commentModelArr;
@property(nonatomic,assign)DDCollectionViewCell_Style2Location style2Location;//用户回帖的文字显示条数
@property(nonatomic,assign)CollectionViewCell_Style2MsgType style2MsgType;//用户发帖的文字显示行数

@end

NS_ASSUME_NONNULL_END
