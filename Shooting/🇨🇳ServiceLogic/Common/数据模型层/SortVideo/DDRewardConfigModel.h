//
//  DDRewardConfigModel.h
//  DouDong-II
//
//  Created by xxx on 2020/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDRewardConfigModel : NSObject

@property(nonatomic,strong) NSString *userId;
@property(nonatomic,assign) NSInteger boxRewardNums;
@property(nonatomic,strong) NSString *randomRewardCount;
@property(nonatomic,assign) NSInteger durationForRandom;
@property(nonatomic,assign) NSInteger randomRewardNums;
@property(nonatomic,assign) NSInteger consume;
@property(nonatomic,assign) NSInteger durationForBox;

@end

NS_ASSUME_NONNULL_END
