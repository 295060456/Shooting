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
    
    UIView *v = UIView.new;
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 200));
    }];
    [self.view layoutIfNeeded];
    
    WGradientProgress *gradProg = [WGradientProgress sharedInstance];
    [gradProg showOnParent:v position:WProgressPosUp];//self.gk_navigationBar

    //here we simulate change of progress
    [self simulateProgress];
    
    //add switch
    UISwitch *swi = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [swi addTarget:self action:@selector(touchSwitch:) forControlEvents:UIControlEventTouchUpInside];
    swi.center = self.view.center;
    [swi setOn:YES];
    [self.view addSubview:swi];
}

- (void)simulateProgress
{
    WGradientProgress *gradProg = [WGradientProgress sharedInstance];
    if (gradProg.progress == 0) {
        CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
        CGFloat progress  = [gradProg progress] + increment;
        [gradProg setProgress:progress];
    }
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
        CGFloat progress  = [gradProg progress] + increment;
        NSLog(@"progress:%@", @(progress));
        [gradProg setProgress:progress];
        if (progress < 1.0) {
            [self simulateProgress];
        }
    });
}

- (void)touchSwitch:(UISwitch *)swi
{
    WGradientProgress *gradProg = [WGradientProgress sharedInstance];
    if (swi.isOn) {
        [gradProg showOnParent:self.navigationController.navigationBar position:WProgressPosDown];
        [gradProg setProgress:0];
        [self simulateProgress];
    } else {
        [gradProg hide];
    }
}


@end
