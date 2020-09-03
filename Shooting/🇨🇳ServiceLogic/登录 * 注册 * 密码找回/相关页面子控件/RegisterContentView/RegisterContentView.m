//
//  RegisterContentView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "RegisterContentView.h"

@interface RegisterContentView ()

@property(nonatomic,strong)FSCustomButton *backToLoginBtn;//去注册

@end

@implementation RegisterContentView

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
    self.backToLoginBtn.alpha = 1;
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
#pragma mark —— lazyLoad
-(FSCustomButton *)backToLoginBtn{
    if (!_backToLoginBtn) {
        _backToLoginBtn = FSCustomButton.new;
        _backToLoginBtn.titleLabel.numberOfLines = 0;
        _backToLoginBtn.backgroundColor = COLOR_RGB(69,
                                                    69,
                                                    69,
                                                    0.7);
        [_backToLoginBtn setTitle:@"返\n回\n登\n录"
                        forState:UIControlStateNormal];
        _backToLoginBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        [_backToLoginBtn setImage:kIMG(@"用户名称")
              forState:UIControlStateNormal];
        [self addSubview:_backToLoginBtn];
        [_backToLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
        }];
    }return _backToLoginBtn;
}

@end
