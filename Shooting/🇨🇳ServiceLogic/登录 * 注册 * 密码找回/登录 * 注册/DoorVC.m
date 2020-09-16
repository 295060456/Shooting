//
//  DoorVC.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

//#import "DoorVC+VM.h"
#import "CustomZFPlayerControlView.h"

#import "DoorVC.h"
#import "ForgetCodeVC.h"

ZFPlayerController *ZFPlayer_DoorVC;

@interface DoorVC ()

@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;
@property(nonatomic,strong,nullable)RegisterContentView *registerContentView;//注册页面
@property(nonatomic,strong,nullable)LogoContentView *logoContentView;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation DoorVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);

    [_logoContentView removeFromSuperview];
    [_loginContentView removeFromSuperview];
    [_registerContentView removeFromSuperview];
    [_backBtn removeFromSuperview];
    _logoContentView = nil;
    _loginContentView = nil;
    _registerContentView = nil;
    _backBtn = nil;
    
    [_customPlayerControlView removeFromSuperview];
    _customPlayerControlView = nil;
    [_player.currentPlayerManager stop];
    _playerManager = nil;
    _player = nil;
    PrintRetainCount(self);
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
    [UIView animationAlert:self.backBtn];
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
//                    [NSObject getAuthCode_networking:^(id data) {
//                        if ([data isKindOfClass:NSDictionary.class]) {
//                            NSDictionary *dic = (NSDictionary *)data;
//                            DoorInputViewStyle_2 *doorInputViewStyle_2 = (DoorInputViewStyle_2 *)self.registerContentView.inputViewMutArr.lastObject;
//                            doorInputViewStyle_2.imageCodeView.CodeStr = dic[@"imgCode"];
//                            self.captchaKey = dic[@"captchaKey"];
//                        }
//                    }];
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
                    [self.view endEditing:YES];
                    DoorInputViewStyle_3 *用户名 = (DoorInputViewStyle_3 *)self.loginContentView.inputViewMutArr[0];
                    DoorInputViewStyle_3 *密码 = (DoorInputViewStyle_3 *)self.loginContentView.inputViewMutArr[1];

                }else if ([btn.titleLabel.text isEqualToString:@"先去逛逛"]){
                    [self backBtnClickEvent:nil];
                }else{
                    
                }
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
                }else if ([btn.titleLabel.text isEqualToString:@"注册"]) {
                    [self.loginContentView showLoginContentViewWithOffsetY:0];
                    [self.registerContentView removeRegisterContentViewWithOffsetY:0];
                    //注册成功即登录
//                    DoorInputViewStyle_3 *用户名 = (DoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[0];
//                    DoorInputViewStyle_3 *密码 = (DoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[1];
//                    DoorInputViewStyle_3 *确认密码 = (DoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[2];
//                    DoorInputViewStyle_2 *填写验证码 = (DoorInputViewStyle_2 *)self.registerContentView.inputViewMutArr[3];
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
        
        [_registerContentView actionRegisterContentViewAuthcodeBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSDictionary.class]) {
                NSDictionary *dic = (NSDictionary *)data;
                self.captchaKey = dic[@"captchaKey"];
            }
        }];
        
        [self.view addSubview:_registerContentView];
        _registerContentView.frame = CGRectMake(SCREEN_WIDTH,
                                             SCREEN_HEIGHT / 3,
                                             SCREEN_WIDTH - 100,
                                             SCREEN_HEIGHT/ 3);
    }return _registerContentView;
}

-(void)reInputAuthCode{
    
}

-(void)reInputCode{
    DoorInputViewStyle_3 *密码 = (DoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[1];
    DoorInputViewStyle_3 *确认密码 = (DoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[2];
    密码.tf.text = @"";
    确认密码.tf.text = @"";
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

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = UIButton.new;
        [_backBtn setImage:kIMG(@"登录注册关闭")
                  forState:UIControlStateNormal];
        @weakify(self)
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self backBtnClickEvent:x];
        }];
        [self.view addSubview:_backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.top.mas_equalTo(@50);
            make.right.equalTo(self.view).offset(-25);
        }];
        
    }return _backBtn;
}

@end
