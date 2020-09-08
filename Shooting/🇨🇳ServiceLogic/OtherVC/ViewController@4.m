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
    
    self.gradProg.alpha = 1;
    [self simulateProgress];
}

- (void)simulateProgress{
    if (self.gradProg.progress == 0) {
        CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
        CGFloat progress  = [self.gradProg progress] + increment;
        [self.gradProg setProgress:progress];
    }
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
        CGFloat progress  = [self.gradProg progress] + increment;
        NSLog(@"progress:%@", @(progress));
        [self.gradProg setProgress:progress];
        if (progress < 1.0) {
            [self simulateProgress];
        }
    });
}

-(WGradientProgress *)gradProg{
    if (!_gradProg) {
        _gradProg = WGradientProgress.new;
        [self.view addSubview:_gradProg];
        [_gradProg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        }];
        [self.view layoutIfNeeded];
        [_gradProg showOnParent:self.view];
    }return _gradProg;
}


@end
