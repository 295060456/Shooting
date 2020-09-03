//
//  DoorVC.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorVC.h"
#import "Door.h"

#import "ForgetCodeVC.h"

@interface DoorVC ()

@property(nonatomic,strong)LoginContentView *loginContentView;
@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong)LogoContentView *logoContentView;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation DoorVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    DoorVC *vc = DoorVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (rootVC.navigationController) {
                vc.isPush = YES;
                vc.isPresent = NO;
                [rootVC.navigationController pushViewController:vc
                                                       animated:animated];
            }else{
                vc.isPush = NO;
                vc.isPresent = YES;
                [rootVC presentViewController:vc
                                     animated:animated
                                   completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            vc.isPush = NO;
            vc.isPresent = YES;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            vc.modalPresentationStyle = presentationStyle;
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KYellowColor;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.player.currentPlayerManager play];
    self.loginContentView.alpha = 1;
    [UIView animationAlert:self.logoContentView];
//    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.loginContentView showLogoContentView];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player.currentPlayerManager stop];
//    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
     [self.loginContentView removeLogoContentView];
}

-(void)KKK{
    @weakify(self)
    [ForgetCodeVC ComingFromVC:weak_self
                   comingStyle:ComingStyle_PUSH
             presentationStyle:UIModalPresentationFullScreen
                 requestParams:nil
                       success:^(id data) {}
                      animated:YES];
}
#pragma mark —— LazyLoad
-(LoginContentView *)loginContentView{
    if (!_loginContentView) {
        _loginContentView = LoginContentView.new;
        _loginContentView.backgroundColor = kBlueColor;
        @weakify(self)
        [_loginContentView actionLoginContentViewBlock:^(id data) {
            @strongify(self)
            [self KKK];
        }];
        [self.view addSubview:_loginContentView];
        _loginContentView.frame = CGRectMake(SCREEN_WIDTH,
                                             SCREEN_HEIGHT / 3,
                                             SCREEN_WIDTH - 100,
                                             SCREEN_HEIGHT/ 2);
    }return _loginContentView;
}

-(ZFAVPlayerManager *)playerManager{
    if (!_playerManager) {
        _playerManager = ZFAVPlayerManager.new;
        _playerManager.shouldAutoPlay = YES;
        
//        _playerManager.assetURL = [NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"];

        _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"niupi"
                                                                                         ofType:@"mp4"]];
    }return _playerManager;
}

-(ZFPlayerController *)player{
    if (!_player) {
        _player = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager
                                                      containerView:self.view];
    }return _player;
}

-(LogoContentView *)logoContentView{
    if (!_logoContentView) {
        _logoContentView = LogoContentView.new;
        [self.view addSubview:_logoContentView];
        [_logoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 50));
            make.top.mas_equalTo(100);
            make.centerX.equalTo(self.view);
        }];
    }return _logoContentView;
}

@end
