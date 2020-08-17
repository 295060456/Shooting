//
//  MKShootVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKShootVC.h"
#import "MKShootVC+VM.h"
//#import "MKRecoderHeader.h"
//#import "MKRecordVideoVC.h"
#import "StartOrPauseBtn.h"
#import "MyCell.h"
#import "VedioTools.h"//视频处理类

#import "YHGPUImageBeautifyFilter.h"
#import "GPUImageVideoCamera.h"
#import "MKGPUImageView.h"
#import "GPUImage.h"

@interface MKShootVC ()
#pragma mark —— UI
@property(nonatomic,strong)UIButton *overturnBtn;
@property(nonatomic,strong)UIButton *deleteFilmBtn;//删除视频
@property(nonatomic,strong)UIButton *sureFilmBtn;//保存视频
@property(nonatomic,strong)__block StartOrPauseBtn *recordBtn;
@property(nonatomic,strong)WMZBannerParam *param;
@property(nonatomic,strong)__block WMZBannerView *bannerView;
@property(nonatomic,strong)UIView *indexView;

@property(nonatomic,assign)CGFloat __block time;
@property(nonatomic,assign)BOOL __block isClickMyGPUImageView;
@property(nonatomic,copy)MKDataBlock MKShootVCBlock;

@property(nonatomic,assign)BOOL isCameraCanBeUsed;//鉴权的结果 —— 摄像头是否可用？
@property(nonatomic,assign)BOOL isMicrophoneCanBeUsed;//鉴权的结果 —— 麦克风是否可用？
@property(nonatomic,assign)BOOL ispPhotoAlbumCanBeUsed;//鉴权的结果 —— 相册是否可用

@end

@implementation MKShootVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        self.time = 5 * 60;// 最大可录制时间（秒）
        self.isCameraCanBeUsed = NO;
        self.isMicrophoneCanBeUsed = NO;
        self.ispPhotoAlbumCanBeUsed = NO;
        self.recordBtn.safetyTime = 10;//
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:kIMG(@"MKShootVC")];

    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.overturnBtn];
    self.gk_navTitle = @"";
    [self hideNavLine];
    
    //视频管理工具类
    [self MakeVedioTools];

    //如果没有开系统权限 是黑屏 所以不用放在鉴权的block里面，放进去了反而第一次进去的时候会黑屏，第二次进去ok
    [self LIVE];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //鉴权 开启摄像头、麦克风
    [self check];
    
    if (self.MKShootVCBlock) {
        self.MKShootVCBlock(@YES);
    }
    self.isClickMyGPUImageView = NO;
    self.gk_navigationBar.hidden = NO;
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [VedioTools.sharedInstance.myGPUVideoCamera startCameraCapture];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.MKShootVCBlock) {
        self.MKShootVCBlock(@NO);
    }
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
    
    //后续要加上去的补充功能
//    self.overturnBtn.alpha = 0;
//    self.deleteFilmBtn.alpha = 0;
//    self.sureFilmBtn.alpha = 0;
//    self.recordBtn.alpha = 0;
//    self.bannerView.alpha = 0;
//    self.indexView.alpha = 0;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
//实况视频
-(void)LIVE{
    [VedioTools.sharedInstance LIVE];
    
    self.recordBtn.alpha = 1;
    self.bannerView.alpha = 1;
    self.indexView.alpha = 1;
    
    [self.view bringSubviewToFront:self.gk_navigationBar];
}

-(void)MakeVedioTools{
    [self.view addSubview:VedioTools.sharedInstance.myGPUImageView];
    @weakify(self)
    [VedioTools.sharedInstance actionVedioToolsBlock:^(id data) {
        @strongify(self)
        if ([data isKindOfClass:MKGPUImageView.class]) {//鉴权部分
            
            MKDataBlock block = ^(NSString *title){
                NSLog(@"打开失败");
                @strongify(self)
                [self alertControllerStyle:SYS_AlertController
                        showAlertViewTitle:title
                                   message:nil
                           isSeparateStyle:YES
                               btnTitleArr:@[@"去获取"]
                            alertBtnAction:@[@"pushToSysConfig"]
                              alertVCBlock:^(id data) {
                    //DIY
                }];
            };
            
            if (self.isCameraCanBeUsed &&
                self.isMicrophoneCanBeUsed &&
                self.deleteFilmBtn.alpha == 0 &&
                self.sureFilmBtn.alpha == 0 &&
                VedioTools.sharedInstance.vedioShootType != VedioShootType_on &&
                VedioTools.sharedInstance.vedioShootType != VedioShootType_continue) {
                self.isClickMyGPUImageView = !self.isClickMyGPUImageView;
                [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = !self.isClickMyGPUImageView;

                self.gk_navigationBar.hidden = self.isClickMyGPUImageView;
                self.recordBtn.alpha = !self.isClickMyGPUImageView;
                self.bannerView.alpha = !self.isClickMyGPUImageView;
                self.deleteFilmBtn.alpha = !self.isClickMyGPUImageView;
            }else{
                if (!self.isCameraCanBeUsed &&
                    self.isMicrophoneCanBeUsed) {
                    NSLog(@"仅仅只有摄像头不可用");
                    if (block) {
                        block(@"仅仅只有摄像头不可用");
                    }
                }else if (self.isCameraCanBeUsed &&
                          !self.isMicrophoneCanBeUsed){
                    NSLog(@"仅仅只有麦克风不可用");
                    if (block) {
                        block(@"仅仅只有麦克风不可用");
                    }
                }else if (!self.isCameraCanBeUsed &&
                          !self.isMicrophoneCanBeUsed){
                    NSLog(@"麦克风 和 摄像头 皆不可用");
                    if (block) {
                        block(@"麦克风 和 摄像头 皆不可用");
                    }
                }else{
                    NSLog(@"");
                    //这里做动作
                }
            }
            
        }else if ([data isKindOfClass:VedioTools.class]){//处理完毕的回调
            //视频处理完毕后，你想干嘛？！

        }else{}
    }];
}
//摄像头鉴权结果不利的UI状况
-(void)checkRes:(BOOL)result{
    result = !result;
    self.overturnBtn.hidden = result;
    self.deleteFilmBtn.hidden = result;
    self.sureFilmBtn.hidden = result;
    self.recordBtn.hidden = result;
    self.bannerView.hidden = result;
    self.indexView.hidden = result;
}
#pragma mark —— 开始录制
-(void)shootting_on{
    NSLog(@"开始录制");
    self.gk_navigationBar.hidden = YES;
    self.bannerView.alpha = 0;
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.indexView.alpha = 0;
//创建本地缓存的文件夹，位置于沙盒中tmp
//给定一个路径 self.FileByUrl 需要他的父节点
    if ([FileFolderHandleTool isExistsAtPath:[FileFolderHandleTool directoryAtPath:VedioTools.sharedInstance.FileByUrl]]) {//存在则清除旗下所有的东西
        //先清除缓存
        [FileFolderHandleTool cleanFilesWithPath:[FileFolderHandleTool directoryAtPath:VedioTools.sharedInstance.FileByUrl]];
    }else{//不存在即创建
        ///创建文件夹：
        [FileFolderHandleTool createDirectoryAtPath:VedioTools.sharedInstance.FileByUrl
                                              error:nil];
    }
//准备工作已完成，现在开始进数据流
    [VedioTools.sharedInstance vedioShoottingOn];
}
#pragma mark —— 结束录制
-(void)shootting_end{
    NSLog(@"结束录制");
    @weakify(self)
    [VedioTools.sharedInstance vedioShoottingEnd];//包含合成视频
    //对相册进行鉴权操作
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Photos
                                              accessStatus:^id(ECAuthorizationStatus status,
                                                               ECPrivacyType type) {
        @strongify(self)
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
            NSLog(@"已经开启相册权限");
            self.ispPhotoAlbumCanBeUsed = YES;
//创建本App的独属相册
            //在个人相册里面创建一个以本App名字的相册 视频文件以时间戳名命名
            [FileFolderHandleTool createFolder:HDAppDisplayName
                             ifExitFolderBlock:^(id data) {
                //已经存在这个文件夹
                //保存tmp文件夹下的视频文件到系统相册
                [FileFolderHandleTool saveRes:[NSURL URLWithString:VedioTools.sharedInstance.FileByUrl]];
            }
                             completionHandler:^(id data,//success ? fail
                                                 id data2) {// error
                if ([data isKindOfClass:NSNumber.class]) {
                    NSNumber *num = (NSNumber *)data;
                    if (num.boolValue) {//success
                        //保存tmp文件夹下的视频文件到系统相册
                        [FileFolderHandleTool saveRes:[NSURL URLWithString:VedioTools.sharedInstance.FileByUrl]];
                    }else{//fail
                        if ([data2 isKindOfClass:NSError.class]) {
                            NSError *err = (NSError *)data2;
                            NSLog(@"err = %@",err);
                        }
                    }
                }
            }];
            return nil;
        }else{
            NSLog(@"相册不可用:%lu",(unsigned long)status);
            [self alertControllerStyle:SYS_AlertController
                    showAlertViewTitle:@"获取系统相册权限"
                               message:nil
                       isSeparateStyle:YES
                           btnTitleArr:@[@"去获取"]
                        alertBtnAction:@[@"pushToSysConfig"]
                          alertVCBlock:^(id data) {
                //DIY
            }];
            return nil;
        }
    }];
}
#pragma mark —— 暂停录制
-(void)shootting_suspend{
    NSLog(@"暂停录制");
    self.gk_navigationBar.hidden = NO;
    self.bannerView.alpha = 0;
    self.deleteFilmBtn.alpha = 1;
    self.sureFilmBtn.alpha = 1;
    self.indexView.alpha = 0;

    [VedioTools.sharedInstance vedioShoottingSuspend];
}
#pragma mark —— 继续录制
-(void)shootting_continue{
    NSLog(@"继续录制");
    self.gk_navigationBar.hidden = YES;
    self.bannerView.alpha = 0;
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.indexView.alpha = 0;
    
    [VedioTools.sharedInstance vedioShoottingContinue];
}
#pragma mark —— 取消录制
-(void)shootting_off{
    NSLog(@"取消录制");
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.indexView.alpha = 1;
    
    [VedioTools.sharedInstance vedioShoottingOff];
}

-(void)ActionMKShootVCBlock:(MKDataBlock)MKShootVCBlock{
    self.MKShootVCBlock = MKShootVCBlock;
}

-(void)reShoot{
    
}

-(void)sure{
    NSLog(@"删除作品成功");
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.bannerView.alpha = 1;
#warning 没干完的
    //StartOrPauseBtn 归零
//    self.recordBtn.progressLabel.text = @"开始";
    self.recordBtn.backgroundColor = kBlueColor;
    [self.recordBtn.mytimer invalidate];
    
    ///功能性的 删除tmp文件夹下的文件
    [FileFolderHandleTool cleanFilesWithPath:[FileFolderHandleTool directoryAtPath:VedioTools.sharedInstance.FileByUrl]];
}

-(void)Cancel{}

-(void)exit{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
    
    if (self.MKShootVCBlock) {
        self.MKShootVCBlock(NSStringFromSelector(_cmd));
    }
}
#pragma mark —— 点击事件
-(void)sureFilmBtnClickEvent:(UIButton *)sender{
    NSLog(@"结束录制 —— 这个作品我要了");
    //判定规则：小于3秒的被遗弃，不允许被保存
    if (self.recordBtn.currentTime <= self.recordBtn.safetyTime) {
        [MBProgressHUD wj_showPlainText:[NSString stringWithFormat:@"不能保存录制时间低于%.2f秒的视频",self.recordBtn.safetyTime]
                                   view:self.view];
    }else{
        [self shootting_end];
    }
    self.deleteFilmBtn.alpha = 0;
    self.sureFilmBtn.alpha = 0;
    self.bannerView.alpha = 1;
    self.indexView.alpha = 1;
}

-(void)deleteFilmBtnClickEvent:(UIButton *)sender{
    NSLog(@"删除作品？");
    [self alertControllerStyle:SYS_AlertController
            showAlertViewTitle:@"删除作品？"
                       message:nil
               isSeparateStyle:NO
                   btnTitleArr:@[@"确认",@"取消"]
                alertBtnAction:@[@"sure",@"Cancel"]
                  alertVCBlock:^(id data) {
        //DIY
    }];
}

-(void)backBtnClickEvent:(UIButton *)sender{
    [self alertControllerStyle:SYS_AlertController
          showActionSheetTitle:nil
                       message:nil
               isSeparateStyle:YES
                   btnTitleArr:@[@"重新拍摄",@"退出",@"取消"]
                alertBtnAction:@[@"reShoot",@"exit",@"reShoot"]
                        sender:nil
                  alertVCBlock:^(id data) {
        //DIY
    }];
}
//翻转摄像头
-(void)overturnBtnClickEvent:(UIButton *)sender{
    [VedioTools.sharedInstance overturnCamera];
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
            self.isCameraCanBeUsed = YES;
            [self LIVE];
            return nil;
        }else{
            NSLog(@"摄像头不可用:%lu",(unsigned long)status);
            self.isCameraCanBeUsed = NO;
            [self checkRes:self.isCameraCanBeUsed];
            if (VedioTools.sharedInstance.VedioToolsBlock) {
                VedioTools.sharedInstance.VedioToolsBlock(VedioTools.sharedInstance.myGPUImageView);
            }
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
            self.isMicrophoneCanBeUsed = YES;
            return nil;
        }else{
            NSLog(@"麦克风不可用:%lu",(unsigned long)status);
            self.isMicrophoneCanBeUsed = NO;
            [self checkRes:self.isMicrophoneCanBeUsed];
            if (VedioTools.sharedInstance.VedioToolsBlock) {
                VedioTools.sharedInstance.VedioToolsBlock(VedioTools.sharedInstance.myGPUImageView);
            }
            return nil;
        }
    }];
}
#pragma mark —— lazyLoad
-(UIButton *)overturnBtn{
    if (!_overturnBtn) {
        _overturnBtn = UIButton.new;
        [_overturnBtn setImage:kIMG(@"翻转镜头")
                      forState:UIControlStateNormal];
        [_overturnBtn addTarget:self
                         action:@selector(overturnBtnClickEvent:)
               forControlEvents:UIControlEventTouchUpInside];
    }return _overturnBtn;
}

-(StartOrPauseBtn *)recordBtn{
    if (!_recordBtn) {
        _recordBtn = StartOrPauseBtn.new;
        _recordBtn.backgroundColor = kBlueColor;
//        单个视频上传最大支持时长为5分钟，最低不得少于30秒
        _recordBtn.time = self.time;// 准备跑多少秒 —— 预设值。本类的init里面设置了是默认值5分钟
        _recordBtn.safetyTime = 30.0f;
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
                        [self shootting_on];
                    }break;
                    case ShottingStatus_suspend:{//暂停录制
                        [self shootting_suspend];
                    }break;
                    case ShottingStatus_continue:{//继续录制
                        [self shootting_continue];
                    }break;
                    case ShottingStatus_off:{//取消录制
                        [self shootting_off];
                    }break;
                        
                    default:
                        break;
                }
            }
        }];
    }return _recordBtn;
}

-(CGFloat)time{
    if (_time == 0.0f) {
        _time = 60 * 3;//默认值 3分钟
    }return _time;
}

- (NSArray *)getData{
    return @[
      @{@"name":@"拍 3 分钟",
        @"time":@"180",
        @"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744105022&di=f06819b43c8032d203642874d1893f3d&imgtype=0&src=http%3A%2F%2Fi2.sinaimg.cn%2Fent%2Fs%2Fm%2Fp%2F2009-06-25%2FU1326P28T3D2580888F326DT20090625072056.jpg"},
      @{@"name":@"拍 5 分钟",
        @"time":@"300",
        @"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1577338893&di=189401ebacb9704d18f6ab02b7336923&imgtype=jpg&er=1&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201308%2F05%2F20130805105309_5E2zE.jpeg"},
      @{@"name":@"拍 1 分钟",
        @"time":@"60",
        @"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744105022&di=f4aadd0b85f93309a4629c998773ae83&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1206%2F07%2Fc0%2F11909864_1339034191111.jpg"}
      ];
}

#define itemW BannerWitdh / 4
#define itemX (BannerWitdh - 3 * itemW) / 2

-(WMZBannerParam *)param{
    if (!_param) {
        @weakify(self)
        _param = BannerParam()
        //自定义视图必传
        .wMyCellClassNameSet(@"MyCell")

        .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath,
                                            UICollectionView *collectionView,
                                            id model,
                                            UIImageView *bgImageView,
                                            NSArray *dataArr) {
            //自定义视图
            @strongify(self)
            MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyCell class]) forIndexPath:indexPath];
            cell.leftText.text = model[@"name"];
            NSLog(@"row = %ld",(long)indexPath.row);
            switch (indexPath.row) {
                case 0:{//1mins
                    self.time = 1 * 60;
                    self.recordBtn.time = self.time;// 准备跑多少秒
                }break;
                case 1:{//3mins
                    self.time = 3 * 60;
                    self.recordBtn.time = self.time;// 准备跑多少秒
                }break;
                case 2:{//5mins
                    self.time = 5 * 60;
                    self.recordBtn.time = self.time;// 准备跑多少秒
                }break;
                default:
                    break;
            }
            NSLog(@"分钟 %f",self.time);
            [cell.icon sd_setImageWithURL:[NSURL URLWithString:model[@"icon"]]
                         placeholderImage:nil];
            return cell;
        })
        
        .wEventScrollEndSet(^(id anyID,
                              NSInteger index,
                              BOOL isCenter,
                              UICollectionViewCell* cell){
            if (isCenter) {
                NSLog(@"KKKKK = index = %ld,isCenter = %d",(long)index,isCenter);
            }
        })
        
        .wFrameSet(CGRectMake(itemX,
                              SCREEN_HEIGHT - SCALING_RATIO(95),
                              BannerWitdh - 2 * itemX,
                              SCALING_RATIO(35)))
        .wDataSet([self getData])
        //关闭pageControl
        .wHideBannerControlSet(YES)
        //开启缩放
        .wScaleSet(YES)
        //自定义item的大小
        .wItemSizeSet(CGSizeMake(itemW - SCALING_RATIO(10),
                                 SCALING_RATIO(35)))
        //固定移动的距离
        .wContentOffsetXSet(0.5)
         //循环
         .wRepeatSet(YES)
        //整体左右间距  设置为size.width的一半 让最后一个可以居中
        .wSectionInsetSet(UIEdgeInsetsMake(0,
                                           10,
                                           0,
                                           BannerWitdh * 0.55 * 0.3))
        //间距
        .wLineSpacingSet(10)
        ;
    }return _param;
}

-(WMZBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[WMZBannerView alloc] initConfigureWithModel:self.param];
        [self.view addSubview:_bannerView];
    }return _bannerView;
}

-(UIView *)indexView{
    if (!_indexView) {
        _indexView = UIView.new;
        _indexView.backgroundColor = kBlackColor;
        [self.view addSubview:_indexView];
        [_indexView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 10));
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.bannerView.mas_bottom).offset(6);
        }];
        [UIView cornerCutToCircleWithView:_indexView AndCornerRadius:10/2];
    }return _indexView;
}

-(UIButton *)deleteFilmBtn{
    if (!_deleteFilmBtn) {
        _deleteFilmBtn = UIButton.new;
        _deleteFilmBtn.alpha = 0;
        [_deleteFilmBtn setImage:kIMG(@"删除")
                        forState:UIControlStateNormal];
        [_deleteFilmBtn addTarget:self
                           action:@selector(deleteFilmBtnClickEvent:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_deleteFilmBtn];
        [_deleteFilmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.recordBtn);
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(30), SCALING_RATIO(20)));
            make.left.equalTo(self.recordBtn.mas_right).offset(SCALING_RATIO(10));
        }];
    }return _deleteFilmBtn;
}

-(UIButton *)sureFilmBtn{
    if (!_sureFilmBtn) {
        _sureFilmBtn = UIButton.new;
        _sureFilmBtn.alpha = 0;
        [_sureFilmBtn setImage:kIMG(@"sure")
                        forState:UIControlStateNormal];
        [_sureFilmBtn addTarget:self
                           action:@selector(sureFilmBtnClickEvent:)
                 forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_sureFilmBtn];
        [_sureFilmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.recordBtn);
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(30), SCALING_RATIO(20)));
            make.left.equalTo(self.deleteFilmBtn.mas_right).offset(SCALING_RATIO(10));
        }];
    }return _sureFilmBtn;
}

@end
