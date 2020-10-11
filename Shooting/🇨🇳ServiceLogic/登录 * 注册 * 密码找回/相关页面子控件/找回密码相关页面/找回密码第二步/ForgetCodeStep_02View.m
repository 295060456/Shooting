//
//  ForgetCodeStep_02.m
//  Shooting
//
//  Created by Jobs on 2020/9/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ForgetCodeStep_02View.h"

@interface ForgetCodeStep_02View ()

@property(nonatomic,copy)MKDataBlock forgetCodeStep_02ViewKeyboardBlock;
@property(nonatomic,copy)MKDataBlock forgetCodeStep_02inputViewBlock;

@property(nonatomic,strong)NSMutableArray <UIImage *>*headerImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleStrMutArr;

@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,assign)BOOL isEdit;//本页面是否当下正处于编辑状态
@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,assign)CGRect registerContentViewRect;

@end

@implementation ForgetCodeStep_02View

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        [UIView cornerCutToCircleWithView:self
                          AndCornerRadius:8];
        self.backgroundColor = KLightGrayColor;
        [self keyboard];
        [self makeInputView];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.isOK) {
        self.registerContentViewRect = self.frame;
        self.isOK = YES;
    }
}

-(void)keyboard{
#warning 此处必须禁用IQKeyboardManager，因为框架的原因，弹出键盘的时候是整个VC全部向上抬起，一个是弹出的高度不对，第二个是弹出的逻辑不正确，就只是需要评论页向上同步弹出键盘高度即可。可是一旦禁用IQKeyboardManager这里就必须手动监听键盘弹出高度，再根据这个高度对评论页做二次约束
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
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;
    
    CGFloat offset = 80;
    
    DoorInputViewStyle_1 *验证码 = (DoorInputViewStyle_1 *)self.inputViewMutArr[0];
    DoorInputViewStyle_3 *新密码 = (DoorInputViewStyle_3 *)self.inputViewMutArr[1];
    DoorInputViewStyle_3 *确认新密码 = (DoorInputViewStyle_3 *)self.inputViewMutArr[2];
    
    self.isEdit = 验证码.tf.isEditting | 新密码.tf.isEditting | 确认新密码.tf.isEditting;
    
    NSLog(@"SSS = %d",self.isEdit);
    
    if (self.isOpen){
        if (self.isEdit) {
            if (self.registerContentViewRect.origin.y == self.mj_y) {
                [self showForgetCodeStep_02ViewWithOffsetY:offset];
            }
        }else{
            if (self.registerContentViewRect.origin.y != self.mj_y) {
                [self showForgetCodeStep_02ViewWithOffsetY:-offset];
            }
        }
    }
}

-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{
    if (self.isOpen) {
        NSLog(@"键盘弹出");
        NSLog(@"键盘关闭");
    }
}

-(void)makeInputView{
    for (int t = 0; t < self.headerImgMutArr.count; t++) {
        if (t == 0) {
            DoorInputViewStyle_1 *inputView = DoorInputViewStyle_1.new;
            inputView.titleStr = self.titleStrMutArr[t];
            UIImageView *imgv = UIImageView.new;
            imgv.image = self.headerImgMutArr[t];
            inputView.inputViewWidth = 250;
            inputView.inputViewHeight = 42;
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
            [self.inputViewMutArr addObject:inputView];
            @weakify(self)
            [inputView actionBlockDoorInputViewStyle_1CountDownBtnClick:^(id data) {
                @strongify(self)
                if (self.forgetCodeStep_02inputViewBlock) {
                    self.forgetCodeStep_02inputViewBlock(data);
                }
            }];
       
            [self addSubview:inputView];
            [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(50);
                make.centerX.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(250, 42));
            }];
            [self layoutIfNeeded];
//有点意思
            [UIView appointCornerCutToCircleWithTargetView:inputView
                                         byRoundingCorners:UIRectCornerBottomLeft
                                               cornerRadii:CGSizeMake((inputView.tf.mj_h) / 4, (inputView.tf.mj_h) / 4)];
            
            [UIView appointCornerCutToCircleWithTargetView:inputView.tf
                                         byRoundingCorners:UIRectCornerTopLeft
                                               cornerRadii:CGSizeMake((inputView.tf.mj_h) / 4, (inputView.tf.mj_h) / 4)];
        }else{
            DoorInputViewStyle_3 *inputView = DoorInputViewStyle_3.new;
            
            inputView.isShowSecurityMode = YES;
            
            inputView.titleStr = self.titleStrMutArr[t];
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
                make.centerX.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(250, 42));
                DoorInputViewStyle_3 *InputView = (DoorInputViewStyle_3 *)self.inputViewMutArr[t - 1];
                make.top.equalTo(InputView.mas_bottom).offset(15);
            }];
            [self layoutIfNeeded];
            [UIView cornerCutToCircleWithView:inputView.tf
                              AndCornerRadius:(inputView.tf.mj_h - 12) / 2];
        }
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
-(void)showForgetCodeStep_02ViewWithOffsetY:(CGFloat)offsetY{
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

-(void)removeForgetCodeStep_02ViewWithOffsetY:(CGFloat)offsetY{
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

-(void)actionForgetCodeStep_02ViewKeyboardBlock:(MKDataBlock)forgetCodeStep_02ViewKeyboardBlock{
    _forgetCodeStep_02ViewKeyboardBlock = forgetCodeStep_02ViewKeyboardBlock;
}

-(void)acrtionBlockForgetCodeStep_02inputView:(MKDataBlock)forgetCodeStep_02inputViewBlock{
    _forgetCodeStep_02inputViewBlock = forgetCodeStep_02inputViewBlock;
}
#pragma mark —— lazyLoad
-(NSMutableArray<UIImage *> *)headerImgMutArr{
    if (!_headerImgMutArr) {
        _headerImgMutArr = NSMutableArray.array;
        [_headerImgMutArr addObject:KBuddleIMG(nil,@"登录 * 注册 * 密码找回", nil, @"验证ICON")];
        [_headerImgMutArr addObject:KBuddleIMG(nil,@"登录 * 注册 * 密码找回",nil, @"Lock")];
        [_headerImgMutArr addObject:KBuddleIMG(nil,@"登录 * 注册 * 密码找回",nil, @"Lock")];
    }return _headerImgMutArr;
}

-(NSMutableArray<NSString *> *)placeHolderMutArr{
    if (!_placeHolderMutArr) {
        _placeHolderMutArr = NSMutableArray.array;
        [_placeHolderMutArr addObject:@"请输入验证码"];
        [_placeHolderMutArr addObject:@"请输入6-12位字母或数字的密码"];
        [_placeHolderMutArr addObject:@"请再次输入密码"];
    }return _placeHolderMutArr;
}

-(NSMutableArray<UIImage *> *)btnSelectedImgMutArr{
    if (!_btnSelectedImgMutArr) {
        _btnSelectedImgMutArr = NSMutableArray.array;
        [_btnSelectedImgMutArr addObject:KBuddleIMG(nil,@"登录 * 注册 * 密码找回", nil, @"空白图")];
        [_btnSelectedImgMutArr addObject:KBuddleIMG(nil,@"登录 * 注册 * 密码找回", nil, @"codeDecode")];
        [_btnSelectedImgMutArr addObject:KBuddleIMG(nil,@"登录 * 注册 * 密码找回",nil, @"codeDecode")];
    }return _btnSelectedImgMutArr;
}

-(NSMutableArray<UIImage *> *)btnUnselectedImgMutArr{
    if (!_btnUnselectedImgMutArr) {
        _btnUnselectedImgMutArr = NSMutableArray.array;
        [_btnUnselectedImgMutArr addObject:KBuddleIMG(nil,@"登录 * 注册 * 密码找回",nil, @"closeCircle")];
        [_btnUnselectedImgMutArr addObject:KBuddleIMG(nil,@"登录 * 注册 * 密码找回",nil, @"codeEncode")];
        [_btnUnselectedImgMutArr addObject:KBuddleIMG(nil,@"登录 * 注册 * 密码找回",nil, @"codeEncode")];
    }return _btnUnselectedImgMutArr;
}

-(NSMutableArray<DoorInputViewStyle *> *)inputViewMutArr{
    if (!_inputViewMutArr) {
        _inputViewMutArr = NSMutableArray.array;
    }return _inputViewMutArr;
}

-(NSMutableArray<NSString *> *)titleStrMutArr{
    if (!_titleStrMutArr) {
        _titleStrMutArr = NSMutableArray.array;
        [_titleStrMutArr addObject:@"验证码"];
        [_titleStrMutArr addObject:@"新密码"];
        [_titleStrMutArr addObject:@"确认新密码"];
    }return _titleStrMutArr;
}


@end
