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
    BOOL d;
}

@property(nonatomic,strong)WGradientProgress *gradProg;
@property(nonatomic,strong)WGradientProgressView *__block progressView;

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
    self.view.backgroundColor = kRedColor;
    
    self.gradProg.alpha = 1;
//    [self.gradProg setTransformRadians:1];
    [self.gradProg start];//启动定时器
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    d = !d;
    if (d) {
        [self.gradProg pause];
    }else{
//        [self.gradProg resume];
        [self.gradProg reset];
    }
}

-(WGradientProgress *)gradProg{
    if (!_gradProg) {
        _gradProg = WGradientProgress.new;
        
        _gradProg.isShowRoad = YES;
        _gradProg.isShowFence = YES;
        _gradProg.length_timeInterval = 1;
        
        @weakify(self)
        [_gradProg actionWGradientProgressBlock:^(NSNumber *data,
                                                  CAGradientLayer *data2) {
            @strongify(self)
            self.progressView.titleStr = [NSString stringWithFormat:@"%.2f",data.floatValue];
            
            NSLog(@"SSS = %f",data2.frame.size.width);
            
            [self.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(25, 25));
                make.bottom.equalTo(self.gradProg.mas_top);
                make.left.mas_equalTo(data2.frame.size.width + 25);
            }];
            
//            self.progressView.centerX = data2.frame.size.width;
//            NSLog(@"");
        }];
        
        [self.view addSubview:_gradProg];
        [_gradProg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.width.mas_equalTo(MAINSCREEN_WIDTH);
            make.height.mas_equalTo(5);
            make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        }];
        [self.view layoutIfNeeded];
        self.progressView.centerX = 0;
        [_gradProg showOnParent];
//        [_gradProg start];//启动定时器
    }return _gradProg;
}

-(WGradientProgressView *)progressView{
    if (!_progressView) {
        _progressView = WGradientProgressView.new;
        _progressView.titleStr = @"1234";
        _progressView.titleFont = [UIFont systemFontOfSize:6.4
                                                   weight:UIFontWeightRegular];
        _progressView.titleColor = kWhiteColor;
        _progressView.img = KIMG(@"水平进度条");
        [self.view addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.bottom.equalTo(self.gradProg.mas_top);
            make.left.mas_equalTo(- (25 / 2));
        }];
    }return _progressView;
}


@end
