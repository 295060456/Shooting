//
//  DoorVC.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorVC.h"
#import "Door.h"

@interface DoorVC ()

@property(nonatomic,strong)LoginContentView *loginContentView;

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
    self.loginContentView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

//    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.loginContentView showLogoContentView];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
     [self.loginContentView removeLogoContentView];
}

#pragma mark —— LazyLoad
-(LoginContentView *)loginContentView{
    if (!_loginContentView) {
        _loginContentView = LoginContentView.new;
        _loginContentView.backgroundColor = kBlueColor;
        [self.view addSubview:_loginContentView];
        _loginContentView.frame = CGRectMake(SCREEN_WIDTH,
                                             SCREEN_HEIGHT / 3,
                                             SCREEN_WIDTH - 100,
                                             SCREEN_HEIGHT/ 2);
    }return _loginContentView;
}

@end
