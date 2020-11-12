//
//  ShootingAppDelegate+Func.h
//  Shooting
//
//  Created by Jobs on 2020/11/11.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ShootingAppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShootingAppDelegate (Func)

#pragma mark —— 全局配置键盘
-(void)makeIQKeyboardManagerConfigure;
#pragma mark —— 全局配置GKNavigationBar
-(void)makeGKNavigationBarConfigure;
#pragma mark —— 网络环境监测
-(void)makeReachabilityConfigure;
#pragma mark —— 开屏广告
-(void)makeXHLaunchAdConfigure;
#pragma mark —— 滴滴打车团队出的一款小工具
-(void)makeDoraemonManagerConfigure;

@end

NS_ASSUME_NONNULL_END
