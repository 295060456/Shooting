//
//  RegisterContentView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "RegisterContentView.h"

@class DoorInputViewStyle;

@interface RegisterContentView (){
    CGFloat k;
}

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *backToLoginBtn;//返回登录
@property(nonatomic,strong)UIButton *toRegisterBtn;//去注册
@property(nonatomic,copy)MKDataBlock registerContentViewBlock;
@property(nonatomic,copy)MKDataBlock registerContentViewKeyboardBlock;
@property(nonatomic,copy)MKDataBlock registerContentViewAuthcodeBlock;

@property(nonatomic,strong)NSMutableArray <UIImage *>*headerImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;
@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,assign)BOOL isEdit;//本页面是否当下正处于编辑状态
@property(nonatomic,assign)CGRect registerContentViewRect;

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
        self.backgroundColor = KLightGrayColor;
        [self keyboard];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.titleLab.alpha = 1;
    self.backToLoginBtn.alpha = 1;
    [self makeInputView];
    self.toRegisterBtn.alpha = 1;
    self.registerContentViewRect = self.frame;
}

-(void)makeInputView{
    for (int t = 0; t < self.headerImgMutArr.count - 1; t++) {
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
            make.left.equalTo(self.backToLoginBtn.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(250, 32));
            if (t == 0) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(9);
            }else{
                DoorInputViewStyle_3 *InputView = (DoorInputViewStyle_3 *)self.inputViewMutArr[t - 1];
                make.top.equalTo(InputView.mas_bottom).offset(15);
            }
        }];
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:inputView.tf
                          AndCornerRadius:inputView.tf.mj_h / 2];
    }

    DoorInputViewStyle_2 *inputView = DoorInputViewStyle_2.new;
    @weakify(self)
    [inputView actionBlockDoorInputViewStyle_2:^(id data) {
        @strongify(self)
        if (self.registerContentViewAuthcodeBlock) {
            self.registerContentViewAuthcodeBlock(data);
        }
    }];
    UIImageView *imgv = UIImageView.new;
    imgv.image = self.headerImgMutArr.lastObject;
    inputView.inputViewWidth = 250;
    inputView.inputViewHeight = 32;
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
    inputView.tf.placeholder = self.placeHolderMutArr.lastObject;

    [self addSubview:inputView];
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backToLoginBtn.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(250, 32));
        DoorInputViewStyle_2 *InputView = (DoorInputViewStyle_2 *)self.inputViewMutArr.lastObject;
        make.top.equalTo(InputView.mas_bottom).offset(15);
    }];
    [self.inputViewMutArr addObject:inputView];
    [self layoutIfNeeded];
    [UIView cornerCutToCircleWithView:inputView
                      AndCornerRadius:inputView.mj_h / 2];
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
-(void)showRegisterContentViewWithOffsetY:(CGFloat)offsetY{
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

-(void)removeRegisterContentViewWithOffsetY:(CGFloat)offsetY{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.mj_x = -self.mj_w;;
    } completion:^(BOOL finished) {
        self.isOpen = NO;
    }];
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
    if (self.isOpen) {
        NSDictionary *userInfo = notification.userInfo;
        CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;
        NSLog(@"KeyboardOffsetY = %f",KeyboardOffsetY);
        NSLog(@"MMM beginFrameY = %f,endFrameY = %f",beginFrame.origin.y,endFrame.origin.y);
        
        CGFloat offset = 100;
        if (KeyboardOffsetY > 0) {//弹出
            self.isEdit = YES;
            k = endFrame.origin.y - self.mj_h - offset;
        }else if (KeyboardOffsetY < 0){//回落
            self.isEdit = NO;
        }else{
//界面上有多个输入框，当放弃一个输入框焦点的同同时激活一个输入框焦点，此时虽然走这个方法但是键盘的起始位置和终点位置重合，表现出来就是KeyboardOffsetY == 0
            self.isEdit = YES;//(50 164.333; 275 270.667)
        }
        
        if (self.isEdit) {
            if (self.registerContentViewRect.origin.y == self.mj_y) {
                [self showRegisterContentViewWithOffsetY:k];
            }
        }else{
            if (self.registerContentViewRect.origin.y != self.mj_y) {
                [self showRegisterContentViewWithOffsetY:-k];
            }
        }

        if (self.registerContentViewKeyboardBlock) {
            self.registerContentViewKeyboardBlock(@(KeyboardOffsetY));
        }
    }
}

-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{
    if (self.isOpen) {
        NSLog(@"键盘弹出");
        NSLog(@"键盘关闭");
    }
}

-(void)actionRegisterContentViewBlock:(MKDataBlock)registerContentViewBlock{
    _registerContentViewBlock = registerContentViewBlock;
}

-(void)actionRegisterContentViewKeyboardBlock:(MKDataBlock)registerContentViewKeyboardBlock{
    _registerContentViewKeyboardBlock = registerContentViewKeyboardBlock;
}

-(void)actionRegisterContentViewAuthcodeBlock:(MKDataBlock)registerContentViewAuthcodeBlock{
    _registerContentViewAuthcodeBlock = registerContentViewAuthcodeBlock;
}

#pragma mark —— lazyLoad
-(UIButton *)backToLoginBtn{
    if (!_backToLoginBtn) {
        _backToLoginBtn = UIButton.new;
        _backToLoginBtn.titleLabel.numberOfLines = 0;
        _backToLoginBtn.backgroundColor = kBlackColor;
        _backToLoginBtn.alpha = 0.7f;
        [_backToLoginBtn setTitle:@"返\n回\n登\n录"
                        forState:UIControlStateNormal];
        [_backToLoginBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                         imageTitleSpace:8];
        [_backToLoginBtn setImage:kIMG(@"用户名称")
              forState:UIControlStateNormal];
        [[_backToLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"返回登录");
            if (self.registerContentViewBlock) {
                self.registerContentViewBlock(self->_backToLoginBtn);
            }
        }];
        [self addSubview:_backToLoginBtn];
        [_backToLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
        }];
        [_backToLoginBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                         imageTitleSpace:8];
    }return _backToLoginBtn;
}

-(UIButton *)toRegisterBtn{
    if (!_toRegisterBtn) {
        _toRegisterBtn = UIButton.new;
        [self addSubview:_toRegisterBtn];
        [_toRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(192, 32));
            make.bottom.equalTo(self).offset(-10);
        }];
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:_toRegisterBtn
                          AndCornerRadius:16];
        [UIView setView:_toRegisterBtn
                  layer:_toRegisterBtn.titleLabel.layer
          gradientLayer:RGBCOLOR(247,
                                 131,
                                 97)
               endColor:RGBCOLOR(245,
                                 75,
                                 100)];
        [_toRegisterBtn setTitle:@"注册"
                        forState:UIControlStateNormal];
        [_toRegisterBtn setTitleColor:kWhiteColor
                        forState:UIControlStateNormal];
        [[_toRegisterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self endEditing:YES];
            NSLog(@"注册");
            
            DoorInputViewStyle_3 *用户名 = (DoorInputViewStyle_3 *)self.inputViewMutArr[0];
            DoorInputViewStyle_3 *密码 = (DoorInputViewStyle_3 *)self.inputViewMutArr[1];
            DoorInputViewStyle_3 *确认密码 = (DoorInputViewStyle_3 *)self.inputViewMutArr[2];
            DoorInputViewStyle_2 *填写验证码 = (DoorInputViewStyle_2 *)self.inputViewMutArr[3];
            
            CustomSYSUITabBarController *tbvc = [SceneDelegate sharedInstance].customSYSUITabBarController;
            
            if ([NSString isNullString:用户名.tf.text]) {
                [NSObject showSYSAlertViewTitle:@"请输入用户名"
                                        message:@""
                                isSeparateStyle:NO
                                    btnTitleArr:@[@"好的"]
                                 alertBtnAction:@[@""]
                                       targetVC:tbvc
                                   alertVCBlock:^(id data) {
                    //DIY
                }];
            }
            if ([NSString isNullString:密码.tf.text]) {
                [NSObject showSYSAlertViewTitle:@"请输入密码"
                                        message:@""
                                isSeparateStyle:NO
                                    btnTitleArr:@[@"好的"]
                                 alertBtnAction:@[@""]
                                       targetVC:tbvc
                                   alertVCBlock:^(id data) {
                    //DIY
                }];
            }
            if ([NSString isNullString:确认密码.tf.text]) {
                [NSObject showSYSAlertViewTitle:@"请输入确认密码"
                                        message:@""
                                isSeparateStyle:NO
                                    btnTitleArr:@[@"好的"]
                                 alertBtnAction:@[@""]
                                       targetVC:tbvc
                                   alertVCBlock:^(id data) {
                    //DIY
                }];
            }
            if ([NSString isNullString:填写验证码.tf.text]) {
                [NSObject showSYSAlertViewTitle:@"请输入验证码"
                                        message:@""
                                isSeparateStyle:NO
                                    btnTitleArr:@[@"好的"]
                                 alertBtnAction:@[@""]
                                       targetVC:tbvc
                                   alertVCBlock:^(id data) {
                    //DIY
                }];
            }
            
            if (![NSString isNullString:用户名.tf.text] &&
                ![NSString isNullString:密码.tf.text] &&
                ![NSString isNullString:确认密码.tf.text] &&
                ![NSString isNullString:填写验证码.tf.text]) {
                if ([密码.tf.text isEqualToString:确认密码.tf.text]) {
                    if ([填写验证码.tf.text isEqualToString:填写验证码.imageCodeView.CodeStr]) {
                        //各种判断过滤在内层做处理，在外层就直接用最终结果
                        if (self.registerContentViewBlock) {
                            self.registerContentViewBlock(self->_toRegisterBtn);
                        }
                    }else{
                        [NSObject showSYSAlertViewTitle:@"验证码不正确"
                                                message:@"请重新输入"
                                        isSeparateStyle:NO
                                            btnTitleArr:@[@"好的"]
                                         alertBtnAction:@[@"reInputAuthCode"]
                                               targetVC:tbvc
                                           alertVCBlock:^(id data) {
                            //DIY
                        }];
                    }
                }else{
                    [NSObject showSYSAlertViewTitle:@"两次密码输入不对等"
                                            message:@"请重新输入"
                                    isSeparateStyle:NO
                                        btnTitleArr:@[@"好的"]
                                     alertBtnAction:@[@"reInputCode"]
                                           targetVC:tbvc
                                       alertVCBlock:^(id data) {
                        //DIY
                    }];
                }
            }
        }];
    }return _toRegisterBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"注册";
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
        [_headerImgMutArr addObject:kIMG(@"Lock")];
        [_headerImgMutArr addObject:kIMG(@"验证ICON")];
    }return _headerImgMutArr;
}

-(NSMutableArray<NSString *> *)placeHolderMutArr{
    if (!_placeHolderMutArr) {
        _placeHolderMutArr = NSMutableArray.array;
        [_placeHolderMutArr addObject:@"用户名"];
        [_placeHolderMutArr addObject:@"密码"];
        [_placeHolderMutArr addObject:@"确认密码"];
        [_placeHolderMutArr addObject:@"填写验证码"];
    }return _placeHolderMutArr;
}

-(NSMutableArray<UIImage *> *)btnSelectedImgMutArr{
    if (!_btnSelectedImgMutArr) {
        _btnSelectedImgMutArr = NSMutableArray.array;
        [_btnSelectedImgMutArr addObject:kIMG(@"空白图")];
        [_btnSelectedImgMutArr addObject:kIMG(@"codeDecode")];
        [_btnSelectedImgMutArr addObject:kIMG(@"codeDecode")];
    }return _btnSelectedImgMutArr;
}

-(NSMutableArray<UIImage *> *)btnUnselectedImgMutArr{
    if (!_btnUnselectedImgMutArr) {
        _btnUnselectedImgMutArr = NSMutableArray.array;
        [_btnUnselectedImgMutArr addObject:kIMG(@"closeCircle")];
        [_btnUnselectedImgMutArr addObject:kIMG(@"codeEncode")];
        [_btnUnselectedImgMutArr addObject:kIMG(@"codeEncode")];
    }return _btnUnselectedImgMutArr;
}

-(NSMutableArray<DoorInputViewStyle *> *)inputViewMutArr{
    if (!_inputViewMutArr) {
        _inputViewMutArr = NSMutableArray.array;
    }return _inputViewMutArr;
}


@end
