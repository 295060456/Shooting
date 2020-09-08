//
//  DoorVC.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "Door.h"
#import "CustomZFPlayerControlView.h"

#import "DoorVC.h"
#import "ForgetCodeVC.h"

ZFPlayerController *ZFPlayer_DoorVC;

@interface DoorVC ()

@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong)CustomZFPlayerControlView *customPlayerControlView;
@property(nonatomic,strong)LoginContentView *loginContentView;
@property(nonatomic,strong)RegisterContentView *registerContentView;
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
    self.loginContentView.alpha = 0.7;
    [UIView animationAlert:self.logoContentView];
    IQKeyboardManager.sharedManager.enable = NO;
//    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.loginContentView showLoginContentViewWithOffsetY:0];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player.currentPlayerManager pause];
//    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark —— LazyLoad
-(LoginContentView *)loginContentView{
    if (!_loginContentView) {
        _loginContentView = LoginContentView.new;
        @weakify(self)
        [_loginContentView actionLoginContentViewBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:@"新\n用\n户\n注\n册"]) {
                    [self.registerContentView showRegisterContentViewWithOffsetY:0];
                    [self.loginContentView removeLoginContentViewWithOffsetY:0];
                }else if ([btn.titleLabel.text isEqualToString:@"记住密码"]){
                    
                }else if ([btn.titleLabel.text isEqualToString:@"忘记密码"]){
                    [ForgetCodeVC ComingFromVC:weak_self
                                   comingStyle:ComingStyle_PUSH
                             presentationStyle:UIModalPresentationFullScreen
                                 requestParams:nil
                                       success:^(id data) {}
                                      animated:YES];
                }else if ([btn.titleLabel.text isEqualToString:@"登录"]){
                    
                }else if ([btn.titleLabel.text isEqualToString:@"先去逛逛"]){
                    [self backBtnClickEvent:nil];
                }else{}
            }
        }];
        [_loginContentView actionLoginContentViewKeyboardBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *b = (NSNumber *)data;
                if (b.intValue > 0) {
                    NSLog(@"开始编辑");
                    self.logoContentView.alpha = 0;
                }else if(b.intValue < 0){
                    NSLog(@"正常模式");
                    self.logoContentView.alpha = 1;
                }else{}
            }
        }];
        [self.view addSubview:_loginContentView];
        _loginContentView.frame = CGRectMake(SCREEN_WIDTH,
                                             SCREEN_HEIGHT / 3,
                                             SCREEN_WIDTH - 100,
                                             SCREEN_HEIGHT/ 3);
    }return _loginContentView;
}

-(RegisterContentView *)registerContentView{
    if (!_registerContentView) {
        _registerContentView = RegisterContentView.new;
        _registerContentView.alpha = 0.7;
        @weakify(self)
        [_registerContentView actionRegisterContentViewBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:@"返\n回\n登\n录"]) {
                    [self.loginContentView showLoginContentViewWithOffsetY:0];
                    [self.registerContentView removeRegisterContentViewWithOffsetY:0];
                }else{}
            }
        }];
        
        [_registerContentView actionRegisterContentViewKeyboardBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *b = (NSNumber *)data;
                if (b.intValue > 0) {
                    NSLog(@"开始编辑");
                    self.logoContentView.alpha = 0;
                }else if(b.intValue < 0){
                    NSLog(@"正常模式");
                    self.logoContentView.alpha = 1;
                }else{}
            }
        }];
        [self.view addSubview:_registerContentView];
        _registerContentView.frame = CGRectMake(SCREEN_WIDTH,
                                             SCREEN_HEIGHT / 3,
                                             SCREEN_WIDTH - 100,
                                             SCREEN_HEIGHT/ 3);
    }return _registerContentView;
}

-(ZFAVPlayerManager *)playerManager{
    if (!_playerManager) {
        _playerManager = ZFAVPlayerManager.new;
        _playerManager.shouldAutoPlay = YES;
        
//        _playerManager.assetURL = [NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"];

        if ([[UIDevice platformString] containsString:@"iPhone 11"]) {
            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iph_X"
                                                                                             ofType:@"mp4"]];
        }else{
            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"非iph_X"
                                                                                             ofType:@"mp4"]];
        }
    }return _playerManager;
}

-(ZFPlayerController *)player{
    if (!_player) {
        _player = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager
                                                      containerView:self.view];
        _player.controlView = self.customPlayerControlView;
        ZFPlayer_DoorVC = _player;
        @weakify(self)
        [_player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            @strongify(self)
            [self.playerManager replay];//设置循环播放
        }];
    }return _player;
}

-(LogoContentView *)logoContentView{
    if (!_logoContentView) {
        _logoContentView = LogoContentView.new;
        [self.view addSubview:_logoContentView];
        [_logoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 50));
            make.bottom.equalTo(self.loginContentView.mas_top).offset(-50);
            make.centerX.equalTo(self.view);
        }];
    }return _logoContentView;
}

-(CustomZFPlayerControlView *)customPlayerControlView{
    if (!_customPlayerControlView) {
        _customPlayerControlView = CustomZFPlayerControlView.new;
        @weakify(self)
        [_customPlayerControlView actionCustomZFPlayerControlViewBlock:^(id data) {
            @strongify(self)
            [self.view endEditing:YES];
        }];
    }return _customPlayerControlView;
}

@end
