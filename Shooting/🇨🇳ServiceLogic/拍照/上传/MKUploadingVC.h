//
//  MKUploadingVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKUploadingVC : BaseVC

@property(nonatomic,copy)MKDataBlock MKUploadingBlock;
///发布成功以后做的事情
-(void)afterRelease;
-(void)actionMKUploadingBlock:(MKDataBlock)MKUploadingBlock;

@end

NS_ASSUME_NONNULL_END
