//
//  LoginContentView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "LoginContentView.h"
#import "DoorInputView.h"
#import "ForgetCodeVC.h"

@interface LoginContentView ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *forgetCodeBtn;//忘记密码
@property(nonatomic,strong)UIButton *toRegisterBtn;//去注册
@property(nonatomic,copy)MKDataBlock loginContentViewBlock;

@property(nonatomic,strong)NSMutableArray <UIImage *>*headerImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;
@property(nonatomic,strong)NSMutableArray <DoorInputViewStyle_3 *> *inputViewMutArr;


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
        self.backgroundColor = kBlackColor;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.titleLab.alpha = 1;
    self.forgetCodeBtn.alpha = 1;
    self.toRegisterBtn.alpha = 1;
    [self makeInputView];
}

-(void)makeInputView{
    for (int t = 0; t < self.headerImgMutArr.count; t++) {
        DoorInputViewStyle_3 *inputView = DoorInputViewStyle_3.new;
        UIImageView *imgv = UIImageView.new;
        imgv.image = self.headerImgMutArr[t];
        inputView.inputViewWidth = 192;
        inputView.tf.leftView = imgv;
        inputView.tf.ZYtextFont = [UIFont systemFontOfSize:9.6
                                                    weight:UIFontWeightRegular];
        inputView.tf.ZYtextColor = kWhiteColor;
        inputView.tf.ZYtintColor = kWhiteColor;
        inputView.tf.ZYplaceholderLabelFont_1 = inputView.tf.ZYtextFont;
        inputView.tf.ZYplaceholderLabelFont_2 = inputView.tf.ZYtextFont;
        inputView.tf.ZYplaceholderLabelTextColor_1 = inputView.tf.ZYtextColor;
        inputView.tf.ZYplaceholderLabelTextColor_2 = inputView.tf.ZYtextColor;
        
        inputView.tf.leftViewMode = UITextFieldViewModeAlways;
        inputView.tf.placeholder = self.placeHolderMutArr[t];
        inputView.btnSelectedIMG = self.btnSelectedImgMutArr[t];
        inputView.btnUnSelectedIMG = self.btnUnselectedImgMutArr[t];
        [self.inputViewMutArr addObject:inputView];
        
        [self addSubview:inputView];
        [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.titleLab.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(192, 32));
            if (t == 0) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(29);
            }else{
                DoorInputViewStyle_3 *InputView = self.inputViewMutArr[t - 1];
                make.top.equalTo(InputView.mas_bottom).offset(15);
            }
        }];
        [self layoutIfNeeded];
    }
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

-(UIButton *)toRegisterBtn{
    if (!_toRegisterBtn) {
        _toRegisterBtn = UIButton.new;
        _toRegisterBtn.titleLabel.numberOfLines = 0;
        _toRegisterBtn.backgroundColor = COLOR_RGB(69,
                                                   69,
                                                   69,
                                                   0.7);
        [_toRegisterBtn setTitle:@"新\n用\n户\n注\n册"
                        forState:UIControlStateNormal];
        [_toRegisterBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                        imageTitleSpace:8];
        [_toRegisterBtn setImage:kIMG(@"用户名称")
              forState:UIControlStateNormal];
        [self addSubview:_toRegisterBtn];
        [_toRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
        }];
    }return _toRegisterBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"登录";
        _titleLab.textColor = RGBA_COLOR(255,
                                         255,
                                         255,
                                         1);
        _titleLab.font = [UIFont systemFontOfSize:14
                                           weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(20);
        }];
    }return _titleLab;
}

-(NSMutableArray<UIImage *> *)headerImgMutArr{
    if (!_headerImgMutArr) {
        _headerImgMutArr = NSMutableArray.array;
        [_headerImgMutArr addObject:kIMG(@"用户名称")];
        [_headerImgMutArr addObject:kIMG(@"Lock")];
    }return _headerImgMutArr;
}

-(NSMutableArray<NSString *> *)placeHolderMutArr{
    if (!_placeHolderMutArr) {
        _placeHolderMutArr = NSMutableArray.array;
        [_placeHolderMutArr addObject:@"用户名"];
        [_placeHolderMutArr addObject:@"密码"];
    }return _placeHolderMutArr;
}

-(NSMutableArray<UIImage *> *)btnSelectedImgMutArr{
    if (!_btnSelectedImgMutArr) {
        _btnSelectedImgMutArr = NSMutableArray.array;
        [_btnSelectedImgMutArr addObject:kIMG(@"空白图")];
        [_btnSelectedImgMutArr addObject:kIMG(@"codeDecode")];
    }return _btnSelectedImgMutArr;
}

-(NSMutableArray<UIImage *> *)btnUnselectedImgMutArr{
    if (!_btnUnselectedImgMutArr) {
        _btnUnselectedImgMutArr = NSMutableArray.array;
        [_btnUnselectedImgMutArr addObject:kIMG(@"closeCircle")];
        [_btnUnselectedImgMutArr addObject:kIMG(@"codeEncode")];
    }return _btnUnselectedImgMutArr;
}

-(NSMutableArray<DoorInputViewStyle_3 *> *)inputViewMutArr{
    if (!_inputViewMutArr) {
        _inputViewMutArr = NSMutableArray.array;
    }return _inputViewMutArr;
}

@end
