//
//  ForgetCodeVC.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ForgetCodeVC.h"
#import "CustomZFPlayerControlView.h"
#import "FindCodeFlowChartView.h"
#import "ForgetCodeStep_01View.h"
#import "ForgetCodeStep_02View.h"

ZFPlayerController *ZFPlayer_ForgetCodeVC;

@interface ForgetCodeVC ()

@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong)CustomZFPlayerControlView *customPlayerControlView;
@property(nonatomic,strong)FindCodeFlowChartView *findCodeFlowChartView;
@property(nonatomic,strong)ForgetCodeStep_01View *step_01;
@property(nonatomic,strong)ForgetCodeStep_02View *step_02;
@property(nonatomic,strong)UILabel *tipsLab;
@property(nonatomic,strong)UIButton *nextStepBtn;//下一步
@property(nonatomic,strong)UIButton *successBtn;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*subTitleMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*backImageMutArr;
///一共几个流程节点
@property(nonatomic,assign)NSInteger flowNum;
///当前流程序号 从0开始
@property(nonatomic,assign)NSInteger currentFlowSerialNum;

@end

@implementation ForgetCodeVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    ForgetCodeVC *vc = ForgetCodeVC.new;
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

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = KLinkColor;
    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
    self.gk_navLineHidden = YES;
    self.gk_navTitle = @"密码找回";
    self.gk_navTitleColor = kWhiteColor;
    self.gk_navTitleFont = [UIFont systemFontOfSize:17
                                             weight:UIFontWeightBold];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.player.currentPlayerManager play];
    self.step_01.alpha = 0.7;
    IQKeyboardManager.sharedManager.enable = NO;
    [self.view bringSubviewToFront:self.gk_navigationBar];
    self.currentFlowSerialNum = 0;
    self.flowNum = 3;
    self.findCodeFlowChartView.alpha = 1;
    self.findCodeFlowChartView.currentFlowSerialNum = self.currentFlowSerialNum;//步骤从0开始
    
    self.tipsLab.alpha = 1;
    self.nextStepBtn.alpha = 1;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.step_01 showForgetCodeStep_01ViewWithOffsetY:0];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player.currentPlayerManager pause];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark —— LazyLoad
-(FindCodeFlowChartView *)findCodeFlowChartView{
    if (!_findCodeFlowChartView) {
        _findCodeFlowChartView = FindCodeFlowChartView.new;
        _findCodeFlowChartView.flowNum = self.flowNum;
        _findCodeFlowChartView.titleMutArr = self.titleMutArr;
        _findCodeFlowChartView.subTitleMutArr = self.subTitleMutArr;
        _findCodeFlowChartView.backImageMutArr = self.backImageMutArr;
        [self.view addSubview:_findCodeFlowChartView];
        [_findCodeFlowChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.gk_navigationBar.mas_bottom);
            make.height.mas_equalTo(60);
        }];
    }return _findCodeFlowChartView;
}

-(UILabel *)tipsLab{
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        _tipsLab.font = [UIFont systemFontOfSize:10
                                          weight:UIFontWeightRegular];
        _tipsLab.textColor = kWhiteColor;
        _tipsLab.text = @"如用户名没有绑定手机号\n请去环球体育APP联系客服找回密码";
        _tipsLab.numberOfLines = 0;
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        [_tipsLab sizeToFit];
        [self.view addSubview:_tipsLab];
        [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-21);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
        }];
    }return _tipsLab;
}

-(UIButton *)nextStepBtn{
    if (!_nextStepBtn) {
        _nextStepBtn = UIButton.new;
        [self.view addSubview:_nextStepBtn];
        [_nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(192, 32));
            make.bottom.equalTo(self.tipsLab.mas_top).offset(-123);
        }];
        [self.view layoutIfNeeded];
        [UIView setView:_nextStepBtn
                  layer:_nextStepBtn.titleLabel.layer
          gradientLayer:RGBCOLOR(247,
                                 131,
                                 97)
               endColor:RGBCOLOR(245,
                                 75,
                                 100)];
        [_nextStepBtn setTitle:@"下一步"
                   forState:UIControlStateNormal];
        [_nextStepBtn setTitleColor:kWhiteColor
                        forState:UIControlStateNormal];
        [[_nextStepBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
             NSLog(@"下一步");
            if (self.currentFlowSerialNum < self.flowNum - 1) {
                self.currentFlowSerialNum += 1;
                [self.findCodeFlowChartView removeFromSuperview];
                self.findCodeFlowChartView = nil;
                self.findCodeFlowChartView.currentFlowSerialNum = self.currentFlowSerialNum;
            }
        }];
        [UIView cornerCutToCircleWithView:_nextStepBtn
                          AndCornerRadius:16];
    }return _nextStepBtn;
}

-(ForgetCodeStep_01View *)step_01{
    if (!_step_01) {
        _step_01 = ForgetCodeStep_01View.new;
        @weakify(self)
        [_step_01 actionForgetCodeStep_01ViewBlock:^(id data) {
            @strongify(self)
            [self.step_02 showForgetCodeStep_02ViewWithOffsetY:0];
            [self.step_01 removeForgetCodeStep_01ViewWithOffsetY:0];
        }];
        
        [_step_01 actionForgetCodeStep_01ViewKeyboardBlock:^(id data) {
//            @strongify(self)
        }];
        [self.view addSubview:_step_01];
        _step_01.frame = CGRectMake(SCREEN_WIDTH,
                                    SCREEN_HEIGHT / 3,
                                    SCREEN_WIDTH - 100,
                                    175);
    }return _step_01;
}

-(ForgetCodeStep_02View *)step_02{
    if (!_step_02) {
        _step_02 = ForgetCodeStep_02View.new;
        @weakify(self)
        [_step_02 actionForgetCodeStep_02ViewBlock:^(id data) {
            @strongify(self)
            [self.step_02 removeForgetCodeStep_02ViewWithOffsetY:0];
            self.successBtn.alpha = 1;
            [[self.nextStepBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                NSLog(@"去登陆");
            }];
        }];
        
        [_step_02 actionForgetCodeStep_02ViewKeyboardBlock:^(id data) {
//            @strongify(self)
        }];
        _step_02.frame = CGRectMake(SCREEN_WIDTH,
                                    SCREEN_HEIGHT / 3,
                                    SCREEN_WIDTH - 100,
                                    219);
    }return _step_02;
}

-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:@"01"];
        [_titleMutArr addObject:@"02"];
        [_titleMutArr addObject:@"03"];
    }return _titleMutArr;
}

-(NSMutableArray<NSString *> *)subTitleMutArr{
    if (!_subTitleMutArr) {
        _subTitleMutArr = NSMutableArray.array;
        [_subTitleMutArr addObject:@"身份登录"];
        [_subTitleMutArr addObject:@"修改密码"];
        [_subTitleMutArr addObject:@"完成"];
    }return _subTitleMutArr;
}

-(NSMutableArray<UIImage *> *)backImageMutArr{
    if (!_backImageMutArr) {
        _backImageMutArr = NSMutableArray.array;
        [_backImageMutArr addObject:kIMG(@"di_1")];
        [_backImageMutArr addObject:kIMG(@"di_2")];
        [_backImageMutArr addObject:kIMG(@"di_3")];
        [_backImageMutArr addObject:kIMG(@"di_4")];
    }return _backImageMutArr;
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
        _player.controlView = self.customPlayerControlView;
        ZFPlayer_ForgetCodeVC = _player;
        @weakify(self)
        [_player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            @strongify(self)
            [self.playerManager replay];//设置循环播放
        }];
    }return _player;
}

-(UIButton *)successBtn{
    if (!_successBtn) {
        _successBtn = UIButton.new;
        [_successBtn setTitle:@"密码修改成功"
                     forState:UIControlStateNormal];
        _successBtn.titleLabel.font = [UIFont systemFontOfSize:17
                                                        weight:UIFontWeightLight];
        [_successBtn setImage:kIMG(@"密码修改成功")
                     forState:UIControlStateNormal];
        [[_successBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"密码修改成功");
        }];
        [self.view addSubview:_successBtn];
        [_successBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
        [_successBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                         imageTitleSpace:8];
    }return _successBtn;
}

@end
