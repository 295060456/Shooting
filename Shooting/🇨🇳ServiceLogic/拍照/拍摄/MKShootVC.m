//
//  MKShootVC.m
//  Shooting
//
//  Created by Jobs on 2020/8/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKShootVC.h"
#import "GPUImageTools.h"

#import "StartOrPauseBtn.h"

@interface MKShootVC ()

@property(nonatomic,strong)__block StartOrPauseBtn *recordBtn;
@property(nonatomic,assign)CGFloat safetyTime;//小于等于这个时间点的录制的视频不允许被保存，而是应该被遗弃
@property(nonatomic,assign)CGFloat __block time;




@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation MKShootVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    MKShootVC *vc = MKShootVC.new;
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

-(instancetype)init{
    if (self = [super init]) {
        self.time = 60;// 最大可录制时间（秒），预设值
        self.safetyTime = 30;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:kIMG(@"MKShootVC")];
    [self check];
    [self.view addSubview:GPUImageTools.sharedInstance.GPUImageView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

//鉴权
-(void)check{
    @weakify(self)
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Camera
                                          accessStatus:^id(ECAuthorizationStatus status,
                                                           ECPrivacyType type) {
        @strongify(self)
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
            NSLog(@"已经开启摄像头权限");
//            self.isCameraCanBeUsed = YES;
//            [self LIVE];
            return nil;
        }else{
            NSLog(@"摄像头不可用:%lu",(unsigned long)status);
//            self.isCameraCanBeUsed = NO;
//            [self checkRes:self.isCameraCanBeUsed];
            
//            if (VedioTools.sharedInstance.actionVedioToolsClickBlock) {
//                VedioTools.sharedInstance.actionVedioToolsClickBlock(VedioTools.sharedInstance.myGPUImageView);
//            }
            return nil;
        }
    }];

    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Microphone
                                          accessStatus:^id(ECAuthorizationStatus status,
                                                           ECPrivacyType type) {
        @strongify(self)
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
            NSLog(@"已经开启麦克风权限");
//            self.isMicrophoneCanBeUsed = YES;
            
            [GPUImageTools.sharedInstance LIVE];
            self.recordBtn.alpha = 1;
            
            return nil;
        }else{
            NSLog(@"麦克风不可用:%lu",(unsigned long)status);
//            self.isMicrophoneCanBeUsed = NO;
//            [self checkRes:self.isMicrophoneCanBeUsed];
            
//            if (VedioTools.sharedInstance.actionVedioToolsClickBlock) {
//                VedioTools.sharedInstance.actionVedioToolsClickBlock(VedioTools.sharedInstance.myGPUImageView);
//            }
            return nil;
        }
    }];
}

-(StartOrPauseBtn *)recordBtn{
    if (!_recordBtn) {
        _recordBtn = StartOrPauseBtn.new;
        _recordBtn.backgroundColor = kBlueColor;
        _recordBtn.safetyTime = self.safetyTime;// 单个视频上传最大支持时长为5分钟，最低不得少于30秒
        _recordBtn.time = self.time;// 准备跑多少秒 —— 预设值。本类的init里面设置了是默认值5分钟
        [self.view addSubview:_recordBtn];
        [_recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(80), SCALING_RATIO(80)));
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view).offset(-SCALING_RATIO(100));
        }];
        [_recordBtn layoutIfNeeded];
        [UIView cornerCutToCircleWithView:_recordBtn
                          AndCornerRadius:SCALING_RATIO(80) / 2];
        @weakify(self)
        //点击手势回调
        [_recordBtn actionTapGRHandleSingleFingerBlock:^(id data) {
//            @strongify(self)
        }];
        //长按手势回调
//        [_recordBtn actionLongPressGRBlock:^(id data) {
//            @strongify(self)
//        }];
        //点击后的录制状态回调 是录制还是没录制
        [_recordBtn actionStartOrPauseBtnBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)data;
                switch (num.intValue) {
                    case ShottingStatus_on:{//开始录制
                        [GPUImageTools.sharedInstance vedioShoottingOn];
                    }break;
                    case ShottingStatus_suspend:{//暂停录制
//                        [GPUImageTools.sharedInstance vedioShoottingSuspend];
#warning
                        [GPUImageTools.sharedInstance vedioShoottingEnd];
                        
                    }break;
                    case ShottingStatus_continue:{//继续录制
                        [GPUImageTools.sharedInstance vedioShoottingContinue];
                    }break;
                    case ShottingStatus_off:{//取消录制
                        [GPUImageTools.sharedInstance vedioShoottingOff];
                    }break;
                        
                    default:
                        break;
                }
            }
        }];
    }return _recordBtn;
}



@end
