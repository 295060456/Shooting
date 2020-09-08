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

@interface LoginContentView (){
    CGFloat k;
}

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *storeCodeBtn;//记住密码
@property(nonatomic,strong)UIButton *forgetCodeBtn;//忘记密码
@property(nonatomic,strong)UIButton *toRegisterBtn;//去注册
@property(nonatomic,strong)UIButton *loginBtn;//登录
@property(nonatomic,strong)UIButton *giveUpLoginBtn;

@property(nonatomic,copy)MKDataBlock loginContentViewBlock;
@property(nonatomic,copy)MKDataBlock loginContentViewKeyboardBlock;

@property(nonatomic,strong)NSMutableArray <UIImage *>*headerImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;
@property(nonatomic,strong)NSMutableArray <DoorInputViewStyle_3 *> *inputViewMutArr;
@property(nonatomic,assign)BOOL isOpen;

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
        self.backgroundColor = KLightGrayColor;
        [self keyboard];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.titleLab.alpha = 1;
    self.toRegisterBtn.alpha = 1;
    [self makeInputView];
    self.storeCodeBtn.alpha = 1;
    self.forgetCodeBtn.alpha = 1;
    self.loginBtn.alpha = 1;
    self.giveUpLoginBtn.alpha = 1;
}

-(void)makeInputView{
    for (int t = 0; t < self.headerImgMutArr.count; t++) {
        DoorInputViewStyle_3 *inputView = DoorInputViewStyle_3.new;
        UIImageView *imgv = UIImageView.new;
        imgv.image = self.headerImgMutArr[t];
        inputView.inputViewWidth = 250;
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
            make.right.equalTo(self.toRegisterBtn.mas_left).offset(-10);
            make.height.mas_equalTo(32);
            make.left.equalTo(self).offset(10);
            if (t == 0) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(29);
            }else{
                DoorInputViewStyle_3 *InputView = self.inputViewMutArr[t - 1];
                make.top.equalTo(InputView.mas_bottom).offset(15);
            }
        }];
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:inputView.tf
                          AndCornerRadius:inputView.tf.mj_h / 2];
    }
}

-(void)keyboard{
#warning 此处必须禁用IQKeyboardManager，因为框架的原因，弹出键盘的时候是整个VC全部向上抬起，一个是弹出的高度不对，第二个是弹出的逻辑不正确，就只是需要评论页向上同步弹出键盘高度即可。可是一旦禁用IQKeyboardManager这里就必须手动监听键盘弹出高度，再根据这个高度对评论页做二次约束
    [IQKeyboardManager sharedManager].enable = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrameNotification:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{//键盘 弹出 和 收回 走这个方法
    if (self.isOpen){
        NSDictionary *userInfo = notification.userInfo;
        CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;
        NSLog(@"KeyboardOffsetY = %f",KeyboardOffsetY);
        NSLog(@"MMM beginFrameY = %f,endFrameY = %f",beginFrame.origin.y,endFrame.origin.y);
        CGFloat offset = 100;
        if (KeyboardOffsetY > 0) {
            k = endFrame.origin.y - self.mj_h - offset;
            [self showLoginContentViewWithOffsetY:k];
        }else{
            [self showLoginContentViewWithOffsetY:-k];
        }
        
        if (self.loginContentViewKeyboardBlock) {
            self.loginContentViewKeyboardBlock(@(KeyboardOffsetY));
        }
    }
}

-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{
    if (self.isOpen) {
        NSLog(@"键盘弹出");
        NSLog(@"键盘关闭");
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
-(void)showLoginContentViewWithOffsetY:(CGFloat)offsetY{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.centerX = SCREEN_WIDTH / 2;
        self.centerY -= offsetY;
    } completion:^(BOOL finished) {
        self.isOpen = YES;
    }];
}

-(void)removeLoginContentViewWithOffsetY:(CGFloat)offsetY{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.mj_x = -self.mj_w;
    } completion:^(BOOL finished) {
        self.isOpen = NO;
    }];
}

-(void)actionLoginContentViewBlock:(MKDataBlock)loginContentViewBlock{
    _loginContentViewBlock = loginContentViewBlock;
}

-(void)actionLoginContentViewKeyboardBlock:(MKDataBlock)loginContentViewKeyboardBlock{
    _loginContentViewKeyboardBlock = loginContentViewKeyboardBlock;
}
#pragma mark —— lazyLoad
-(UIButton *)toRegisterBtn{
    if (!_toRegisterBtn) {
        _toRegisterBtn = UIButton.new;
        _toRegisterBtn.titleLabel.numberOfLines = 0;
        _toRegisterBtn.backgroundColor =kBlackColor;
        _toRegisterBtn.alpha = 0.7f;
        [_toRegisterBtn setTitle:@"新\n用\n户\n注\n册"
                        forState:UIControlStateNormal];
        [_toRegisterBtn setImage:kIMG(@"用户名称")
              forState:UIControlStateNormal];
        [[_toRegisterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"新用户注册");
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(self->_toRegisterBtn);
            }
        }];
        [self addSubview:_toRegisterBtn];
        [_toRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
        }];
        [_toRegisterBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                        imageTitleSpace:8];
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

-(UIButton *)storeCodeBtn{
    if (!_storeCodeBtn) {
        _storeCodeBtn = UIButton.new;
        _storeCodeBtn.titleLabel.textColor = KLightGrayColor;
        _storeCodeBtn.titleLabel.font = [UIFont systemFontOfSize:10
                                                          weight:UIFontWeightRegular];
        [_storeCodeBtn setTitle:@"记住密码"
                       forState:UIControlStateNormal];
        [_storeCodeBtn setImage:kIMG(@"记住密码")
                       forState:UIControlStateNormal];
        [_storeCodeBtn setImage:kIMG(@"没有记住密码")
                       forState:UIControlStateSelected];
        [[_storeCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"存储密码");
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(self->_storeCodeBtn);
            }
        }];
        [self addSubview:_storeCodeBtn];
        [_storeCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.titleLab.mas_left).offset(-30);
            make.top.equalTo(self.inputViewMutArr.lastObject.mas_bottom).offset(5);
        }];
    }return _storeCodeBtn;
}

-(UIButton *)forgetCodeBtn{
    if (!_forgetCodeBtn) {
        _forgetCodeBtn = UIButton.new;
        _forgetCodeBtn.titleLabel.textColor = KLightGrayColor;
        _forgetCodeBtn.titleLabel.font = [UIFont systemFontOfSize:10
                                                          weight:UIFontWeightRegular];
        [_forgetCodeBtn.titleLabel sizeToFit];
        _forgetCodeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_forgetCodeBtn setTitle:@"忘记密码"
                       forState:UIControlStateNormal];
        [_forgetCodeBtn setImage:kIMG(@"KKK")
                       forState:UIControlStateNormal];
        [[_forgetCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(self->_forgetCodeBtn);
            }
        }];
        [self addSubview:_forgetCodeBtn];
        [_forgetCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.inputViewMutArr.lastObject.mas_bottom).offset(5);
            make.left.equalTo(self.titleLab.mas_right).offset(-7);
        }];
    }return _forgetCodeBtn;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = UIButton.new;
        [self addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(192, 32));
            make.bottom.equalTo(self).offset(-42);
        }];
        [self layoutIfNeeded];
        [UIView setView:_loginBtn
                  layer:_loginBtn.titleLabel.layer
          gradientLayer:RGBCOLOR(247,
                                 131,
                                 97)
               endColor:RGBCOLOR(245,
                                 75,
                                 100)];
        [_loginBtn setTitle:@"登录"
                   forState:UIControlStateNormal];
        [_loginBtn setTitleColor:kWhiteColor
                        forState:UIControlStateNormal];
        [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
             NSLog(@"注册");
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(self->_loginBtn);
            }
        }];
        [UIView cornerCutToCircleWithView:_loginBtn
                          AndCornerRadius:16];
    }return _loginBtn;
}

-(UIButton *)giveUpLoginBtn{
    if (!_giveUpLoginBtn) {
        _giveUpLoginBtn = UIButton.new;
        _giveUpLoginBtn.titleLabel.font = [UIFont systemFontOfSize:10
                                                            weight:UIFontWeightRegular];
        _giveUpLoginBtn.titleLabel.textColor = KLightGrayColor;
        [_giveUpLoginBtn setTitle:@"先去逛逛"
                         forState:UIControlStateNormal];
        [_giveUpLoginBtn.titleLabel sizeToFit];
        _giveUpLoginBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [[_giveUpLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"先去逛逛");
            if (self.loginContentViewBlock) {
                self.loginContentViewBlock(self->_giveUpLoginBtn);
            }
        }];
        [self addSubview:_giveUpLoginBtn];
        [_giveUpLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(32, 8));
            make.bottom.equalTo(self).offset(-26);
        }];
    }return _giveUpLoginBtn;
}


@end
