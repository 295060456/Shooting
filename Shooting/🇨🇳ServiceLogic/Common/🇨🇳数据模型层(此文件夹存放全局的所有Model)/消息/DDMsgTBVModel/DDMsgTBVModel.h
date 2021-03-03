//
//  DDMsgTBVModel.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/22.
//

#import "BaseModel.h"
#import "DefineStructure.h"

NS_ASSUME_NONNULL_BEGIN
// 我的消息总页面
@interface DDMsgTBVModel : BaseModel

@property(nonatomic,assign)DDMsgTBVCellType msgTBVCellType;
@property(nonatomic,assign)int newMsgsNum;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *msg;

@end

NS_ASSUME_NONNULL_END
