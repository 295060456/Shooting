//
//  LoginContentView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "LoginContentView.h"
#import "ForgetCodeVC.h"

@interface LoginContentView ()

@property(nonatomic,strong)UIButton *forgetCodeBtn;//忘记密码
@property(nonatomic,strong)FSCustomButton *toRegisterBtn;//去注册
@property(nonatomic,copy)MKDataBlock loginContentViewBlock;

@end

@implementation LoginContentView

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        [UIView cornerCutToCircleWithView:self
                          AndCornerRadius:8];
        self.backgroundColor = COLOR_RGB(255,
                                         255,
                                         255,
                                         1);
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.forgetCodeBtn.alpha = 1;
    self.toRegisterBtn.alpha = 1;
}

/*
 *    使用弹簧的描述时间曲线来执行动画 ,当dampingRatio == 1 时,动画会平稳的减速到最终的模型值,而不会震荡.
 *    小于1的阻尼比在达到完全停止之前会震荡的越来越多.
 *    如果你可以使用初始的 spring velocity 来 指定模拟弹簧末端的对象在加载之前移动的速度.
 *    他是一个单位坐标系统,其中2被定义为在一秒内移动整个动画距离.
 *    如果你在动画中改变一个物体的位置,你想在动画开始前移动到 100 pt/s 你会超过0.5,
 *    dampingRatio 阻尼
 *    velocity 速度
 */
-(void)showLogoContentView{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.centerX = SCREEN_WIDTH / 2;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)removeLogoContentView{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.mj_x = SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)btnClickEvent:(UIButton *)sender{
    if (self.loginContentViewBlock) {
        self.loginContentViewBlock(self);
    }
}

-(void)actionLoginContentViewBlock:(MKDataBlock)loginContentViewBlock{
    _loginContentViewBlock = loginContentViewBlock;
}
#pragma mark —— lazyLoad
-(UIButton *)forgetCodeBtn{
    if (!_forgetCodeBtn) {
        _forgetCodeBtn = UIButton.new;
        _forgetCodeBtn.backgroundColor = kRedColor;
        [_forgetCodeBtn addTarget:self
                 action:@selector(btnClickEvent:)
       forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_forgetCodeBtn];
        [_forgetCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.center.equalTo(self);
        }];
    }return _forgetCodeBtn;
}

-(FSCustomButton *)toRegisterBtn{
    if (!_toRegisterBtn) {
        _toRegisterBtn = FSCustomButton.new;
        _toRegisterBtn.titleLabel.numberOfLines = 0;
        _toRegisterBtn.backgroundColor = COLOR_RGB(69,
                                                   69,
                                                   69,
                                                   0.7);
        [_toRegisterBtn setTitle:@"新\n用\n户\n注\n册"
                        forState:UIControlStateNormal];
        _toRegisterBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        [_toRegisterBtn setImage:kIMG(@"用户名称")
              forState:UIControlStateNormal];
        [self addSubview:_toRegisterBtn];
        [_toRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
        }];
    }return _toRegisterBtn;
}

@end
