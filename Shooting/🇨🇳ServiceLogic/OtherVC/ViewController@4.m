//
//  ViewController@4.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@4.h"

#import "WGradientProgress.h"
#import "WGradientProgressView.h"
#import "UIView+Measure.h"

@interface ViewController_4 (){
    
}

@property(nonatomic,strong)WGradientProgress *gradProg;
@property(nonatomic,strong)WGradientProgressView *__block progressLab;

@end

@implementation ViewController_4

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
       
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = kRedColor;
    
    self.gradProg.alpha = 1;
//    [self.gradProg setTransformRadians:1];

}

-(WGradientProgress *)gradProg{
    if (!_gradProg) {
        _gradProg = WGradientProgress.new;
        _gradProg.isShowRoad = YES;
        _gradProg.isShowFence = YES;
        @weakify(self)
        [_gradProg actionWGradientProgressBlock:^(NSNumber *data,
                                                  CAGradientLayer *data2) {
            @strongify(self)
            self.progressLab.titleStr = [NSString stringWithFormat:@"%.2f",data.floatValue];
            self.progressLab.centerX = data2.frame.size.width;
            [self.view layoutIfNeeded];
            NSLog(@"");
        }];
        
        [self.view addSubview:_gradProg];
        [_gradProg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(5);
            make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        }];
        [self.view layoutIfNeeded];
        self.progressLab.centerX = 0;
        [_gradProg showOnParent:self.view];
    }return _gradProg;
}

-(WGradientProgressView *)progressLab{
    if (!_progressLab) {
        _progressLab = WGradientProgressView.new;
        _progressLab.titleStr = @"1234";
        _progressLab.titleFont = [UIFont systemFontOfSize:6.4
                                                   weight:UIFontWeightRegular];
        _progressLab.titleColor = kWhiteColor;
        _progressLab.img = kIMG(@"水平进度条");
        [self.view addSubview:_progressLab];
        [_progressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.bottom.equalTo(self.gradProg.mas_top);
        }];
    }return _progressLab;
}


@end
