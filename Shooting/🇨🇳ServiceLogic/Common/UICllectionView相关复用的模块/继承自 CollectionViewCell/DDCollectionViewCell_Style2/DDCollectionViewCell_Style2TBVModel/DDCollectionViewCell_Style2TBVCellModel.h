//
//  DDCollectionViewCell_Style2TBVCellModel.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDCollectionViewCell_Style2TBVCellModel : NSObject

@property(nonatomic,strong)UIImage *userHeaderIMG;//发帖用户头像
@property(nonatomic,strong)NSString *usernameStr;//发帖用户名
@property(nonatomic,strong)NSString *postTimeStr;//发帖时间
@property(nonatomic,strong)NSString *postContentStr;//发帖内容

@end

NS_ASSUME_NONNULL_END
