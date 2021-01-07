//
//  DDCommentMsgModel.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 评论消息
@interface DDCommentMsgModel : NSObject

@property(nonatomic,strong)UIImage *userHeaderIMG;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *time;

@end

NS_ASSUME_NONNULL_END
