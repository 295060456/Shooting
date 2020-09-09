//
//  ViewController@4.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@4.h"
#import "WGradientProgress.h"

@interface ViewController_4 (){
    
}

@property(nonatomic,strong)WGradientProgress *gradProg;

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

}

-(WGradientProgress *)gradProg{
    if (!_gradProg) {
        _gradProg = WGradientProgress.new;
        _gradProg.isShowRoad = YES;
        _gradProg.isShowFence = YES;
        [self.view addSubview:_gradProg];
        [_gradProg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(5);
            make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        }];
        [self.view layoutIfNeeded];
        [_gradProg showOnParent:self.view];
    }return _gradProg;
}



@end
