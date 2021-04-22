//
//  MKUploadingVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<TZImagePickerController/TZImagePickerController.h>)
#import <TZImagePickerController/TZImagePickerController.h>
#else
#import "TZImagePickerController.h"
#endif

#import "UIViewController+TZLocationManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKUploadingVC : UIViewController

///发布成功以后做的事情
-(void)afterRelease;

@end

NS_ASSUME_NONNULL_END
