//
//  ForgetCodeVC.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ForgetCodeVC.h"
#import "FindCodeFlowChartView.h"

@interface ForgetCodeVC ()

@property(nonatomic,strong)FindCodeFlowChartView *findCodeFlowChartView;
@property(nonatomic,strong)UILabel *tipsLab;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*subTitleMutArr;

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
    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
    self.gk_navLineHidden = YES;
    self.gk_navTitle = @"密码找回";
    self.gk_navTitleColor = kWhiteColor;
    self.gk_navTitleFont = [UIFont systemFontOfSize:17
                                             weight:UIFontWeightBold];
    self.findCodeFlowChartView.alpha = 1;
    self.tipsLab.alpha = 1;
}
#pragma mark —— LazyLoad
-(FindCodeFlowChartView *)findCodeFlowChartView{
    if (!_findCodeFlowChartView) {
        _findCodeFlowChartView = FindCodeFlowChartView.new;
        _findCodeFlowChartView.flowNum = 3;
        _findCodeFlowChartView.titleMutArr = self.titleMutArr;
        _findCodeFlowChartView.subTitleMutArr = self.subTitleMutArr;
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
            make.centerX.bottom.equalTo(self.view);
            make.width.mas_equalTo(SCREEN_WIDTH / 2);
        }];
    }return _tipsLab;
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



@end
