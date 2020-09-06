//
//  RegisterContentView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "RegisterContentView.h"
#import "DoorInputView.h"

@class DoorInputViewStyle;

@interface RegisterContentView (){
    CGFloat k;
}

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *backToLoginBtn;//去注册
@property(nonatomic,copy)MKDataBlock registerContentViewBlock;
@property(nonatomic,copy)MKDataBlock registerContentViewKeyboardBlock;

@property(nonatomic,strong)NSMutableArray <UIImage *>*headerImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;
@property(nonatomic,strong)NSMutableArray <DoorInputViewStyle *> *inputViewMutArr;
@property(nonatomic,assign)BOOL isOpen;

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
        self.backgroundColor = kBlackColor;
        [self keyboard];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.titleLab.alpha = 1;
    self.backToLoginBtn.alpha = 1;
    [self makeInputView];
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
                make.top.equalTo(self.titleLab.mas_bottom).offset(29);
            }else{
                DoorInputViewStyle_3 *InputView = (DoorInputViewStyle_3 *)self.inputViewMutArr[t - 1];
                make.top.equalTo(InputView.mas_bottom).offset(15);
            }
        }];
        [self layoutIfNeeded];
    }

    DoorInputViewStyle_2 *inputView = DoorInputViewStyle_2.new;
    UIImageView *imgv = UIImageView.new;
    imgv.image = self.headerImgMutArr.lastObject;
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
        if (KeyboardOffsetY > 0) {
            k = endFrame.origin.y - self.mj_h - offset;
            [self showRegisterContentViewWithOffsetY:k];
        }else{
            [self showRegisterContentViewWithOffsetY:-k];
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
#pragma mark —— lazyLoad
-(UIButton *)backToLoginBtn{
    if (!_backToLoginBtn) {
        _backToLoginBtn = UIButton.new;
        _backToLoginBtn.titleLabel.numberOfLines = 0;
        _backToLoginBtn.backgroundColor = COLOR_RGB(69,
                                                    69,
                                                    69,
                                                    0.7);
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
