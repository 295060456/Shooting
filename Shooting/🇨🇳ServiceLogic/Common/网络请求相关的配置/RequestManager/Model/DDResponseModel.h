//
//  DDResponseModel.h
//  DouDong-II
//
//  Created by xxx on 2021/1/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDResponseModel : NSObject

@property(nonatomic,assign) int code;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,strong) id data;


@end

NS_ASSUME_NONNULL_END
