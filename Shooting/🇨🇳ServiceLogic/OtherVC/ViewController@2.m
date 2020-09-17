//
//  ViewController@2.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@2.h"

@interface ViewController_2 (){
    
}

@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)SPAlertController *spaVC;

@end

@implementation ViewController_2

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
    self.btn.alpha = 1;
    self.btn2.alpha = 1;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{

    Ivar ivar = class_getInstanceVariable([SPAlertController class], "_headerView");//必须是下划线接属性
    UIView *view = object_getIvar(self.spaVC, ivar);
    view.backgroundColor = kRedColor;

}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = kBlackColor;
//        _btn.
        [_btn setImage:kIMG(@"播放")
              forState:UIControlStateNormal];
        [_btn setTitle:@"1\n2\n71"
              forState:UIControlStateNormal];
        _btn.titleLabel.numberOfLines = 0;
        [self.view addSubview:_btn];
        _btn.frame = CGRectMake(100, 100, 70, 200);
        [_btn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                              imageTitleSpace:150];
        _btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        //内边距问题
    }return _btn;
}

-(UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn2.backgroundColor = KBrownColor;
        [_btn2 setImage:kIMG(@"播放")
              forState:UIControlStateNormal];
        [_btn2 setTitle:@"123456"
              forState:UIControlStateNormal];
        [self.view addSubview:_btn2];
        _btn2.frame = CGRectMake(100, 400, 270, 70);
        [_btn2 layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                              imageTitleSpace:10];
        _btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
        //内边距问题
    }return _btn2;
}


@end
