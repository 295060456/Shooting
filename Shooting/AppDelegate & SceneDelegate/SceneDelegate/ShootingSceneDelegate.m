//
//  ShootingSceneDelegate.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ShootingAppDelegate.h"
#import "ShootingSceneDelegate.h"
#import "ShootingAppDelegate+PopupView.h"

API_AVAILABLE(ios(13.0))

@interface ShootingSceneDelegate ()

@end

@implementation ShootingSceneDelegate

static ShootingSceneDelegate *static_sceneDelegate = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_sceneDelegate) {
            static_sceneDelegate = ShootingSceneDelegate.new;
        }
    }return static_sceneDelegate;
}

-(instancetype)init{
    if (self = [super init]) {
        static_sceneDelegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(noti1:)
                                                     name:UISceneWillConnectNotification
                                                   object:nil];
    }return self;
}

-(void)noti1:(NSNotification *)notification{
    self.windowScene = notification.object;
}

- (void)scene:(UIScene *)scene
willConnectToSession:(UISceneSession *)session
      options:(UISceneConnectionOptions *)connectionOptions {
    
    //在这里手动创建新的window
    if (@available(iOS 13.0, *)) {
        self.windowScene = (UIWindowScene *)scene;
        XHLaunchAd * ad = [XHLaunchAd setWaitDataDuration:10];
        [ad scene:self.windowScene];
        self.window.alpha = 1;
        [[ShootingAppDelegate sharedInstance] Popupview];// 弹出框
    }
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}

- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    NSLog(@"---applicationDidBecomeActive----");//进入前台
//    extern ZFPlayerController *ZFPlayer_DoorVC;
//    extern ZFPlayerController *ZFPlayer_ForgetCodeVC;
//    if (ZFPlayer_DoorVC) {
//        [ZFPlayer_DoorVC.currentPlayerManager play];
//    }
//    if (ZFPlayer_ForgetCodeVC) {
//        [ZFPlayer_ForgetCodeVC.currentPlayerManager play];
//    }
}

- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}

- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    [(ShootingAppDelegate *)UIApplication.sharedApplication.delegate saveContext];
    [[NSNotificationCenter defaultCenter] postNotificationName:UBLEnterBackgroundStopPlayer object:nil];
    NSLog(@"---applicationDidEnterBackground----"); //进入后台
//    extern ZFPlayerController *ZFPlayer_DoorVC;
//    extern ZFPlayerController *ZFPlayer_ForgetCodeVC;
//    if (ZFPlayer_DoorVC) {
//        [ZFPlayer_DoorVC.currentPlayerManager pause];
//    }
//    if (ZFPlayer_ForgetCodeVC) {
//        [ZFPlayer_ForgetCodeVC.currentPlayerManager pause];
//    }
}
#pragma mark —— lazyLoad
-(UIWindow *)window{
    [_window setRootViewController:ShootingAppDelegate.sharedInstance.tabBarVC];
    [_window makeKeyAndVisible];
    return _window;
}

@end
