//
//  VideoTagModel.h
//  MonkeyKingVideo
//
//  Created by xxx on 2020/12/7.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoTagModel : NSObject
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *value;
@property(nonatomic,assign) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
