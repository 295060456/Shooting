//
//  ForgetCodeStep_01.m
//  Shooting
//
//  Created by Jobs on 2020/9/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ForgetCodeStep_01View.h"

@interface ForgetCodeStep_01View ()

@property(nonatomic,copy)MKDataBlock forgetCodeStep_01ViewBlock;
@property(nonatomic,copy)MKDataBlock forgetCodeStep_01ViewKeyboardBlock;

@property(nonatomic,strong)NSMutableArray <UIImage *>*headerImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleStrMutArr;

@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,assign)BOOL isEdit;//本页面是否当下正处于编辑状态
@property(nonatomic,assign)CGRect registerContentViewRect;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation ForgetCodeStep_01View

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
         self.backgroundColor = KLightGrayColor;
        [self keyboard];
        [UIView cornerCutToCircleWithView:self
                          AndCornerRadius:8];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.isOK) {
        [self makeInputView];
        self.registerContentViewRect = self.frame;
        self.isOK= YES;
    }
}

-(void)makeInputView{
    for (int t = 0; t < self.headerImgMutArr.count; t++) {
        DoorInputViewStyle_3 *inputView = DoorInputViewStyle_3.new;
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
        
        if (t == 1) {
            inputView.tf.keyboardType = UIKeyboardTypePhonePad;
        }
        
        [self addSubview:inputView];
        [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(250, 42));
            if (t == 0) {
                make.top.equalTo(self).offset(50);
            }else{
                make.bottom.equalTo(self.mas_bottom).offset(-30);
            }
        }];
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:inputView.tf
                          AndCornerRadius:15];
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
    
    DoorInputViewStyle_3 *用户名 = self.inputViewMutArr[0];
    DoorInputViewStyle_3 *手机号码 = self.inputViewMutArr[1];
    
    self.isEdit = 用户名.tf.isEditting | 手机号码.tf.isEditting;
    
    NSLog(@"SSS = %d",self.isEdit);
    
    if (self.isOpen){
        if (self.isEdit) {
            if (self.registerContentViewRect.origin.y == self.mj_y) {
                [self showForgetCodeStep_01ViewWithOffsetY:offset];
            }
        }else{
            if (self.registerContentViewRect.origin.y != self.mj_y) {
                [self showForgetCodeStep_01ViewWithOffsetY:-offset];
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
/*
 *    使用弹簧的描述时间曲线来执行动画 ,当dampingRatio == 1 时,动画会平稳的减速到最终的模型值,而不会震荡.
 *    小于1的阻尼比在达到完全停止之前会震荡的越来越多.
 *    如果你可以使用初始的 spring velocity 来 指定模拟弹簧末端的对象在加载之前移动的速度.
 *    他是一个单位坐标系统,其中2被定义为在一秒内移动整个动画距离.
 *    如果你在动画中改变一个物体的位置,你想在动画开始前移动到 100 pt/s 你会超过0.5,
 *    dampingRatio 阻尼
 *    velocity 速度
 */
-(void)showForgetCodeStep_01ViewWithOffsetY:(CGFloat)offsetY{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.centerX = MAINSCREEN_WIDTH / 2;
        self.centerY -= offsetY;
    } completion:^(BOOL finished) {
        self.isOpen = YES;
    }];
}

-(void)removeForgetCodeStep_01ViewWithOffsetY:(CGFloat)offsetY{
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

-(void)actionForgetCodeStep_01ViewBlock:(MKDataBlock)forgetCodeStep_01ViewBlock{
    _forgetCodeStep_01ViewBlock = forgetCodeStep_01ViewBlock;
}

-(void)actionForgetCodeStep_01ViewKeyboardBlock:(MKDataBlock)forgetCodeStep_01ViewKeyboardBlock{
    _forgetCodeStep_01ViewKeyboardBlock = forgetCodeStep_01ViewKeyboardBlock;
}
#pragma mark —— lazyLoad
-(NSMutableArray<UIImage *> *)headerImgMutArr{
    if (!_headerImgMutArr) {
        _headerImgMutArr = NSMutableArray.array;
        [_headerImgMutArr addObject:KBuddleIMG(@"⚽️PicResource",@"登录 * 注册 * 密码找回",nil, @"用户名称")];
        [_headerImgMutArr addObject:KBuddleIMG(@"⚽️PicResource",@"登录 * 注册 * 密码找回",nil, @"手机ICON")];
    }return _headerImgMutArr;
}

-(NSMutableArray<NSString *> *)placeHolderMutArr{
    if (!_placeHolderMutArr) {
        _placeHolderMutArr = NSMutableArray.array;
        [_placeHolderMutArr addObject:@"4-11位字母或数字的用户名"];
        [_placeHolderMutArr addObject:@"请输入11位手机号码"];
    }return _placeHolderMutArr;
}

-(NSMutableArray<UIImage *> *)btnSelectedImgMutArr{
    if (!_btnSelectedImgMutArr) {
        _btnSelectedImgMutArr = NSMutableArray.array;
        [_btnSelectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource",@"登录 * 注册 * 密码找回", nil, @"空白图")];
        [_btnSelectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource",@"登录 * 注册 * 密码找回",nil, @"codeDecode")];
    }return _btnSelectedImgMutArr;
}

-(NSMutableArray<UIImage *> *)btnUnselectedImgMutArr{
    if (!_btnUnselectedImgMutArr) {
        _btnUnselectedImgMutArr = NSMutableArray.array;
        [_btnUnselectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource",@"登录 * 注册 * 密码找回", nil, @"closeCircle")];
        [_btnUnselectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource",@"登录 * 注册 * 密码找回",nil, @"codeEncode")];
    }return _btnUnselectedImgMutArr;
}

-(NSMutableArray<DoorInputViewStyle_3 *> *)inputViewMutArr{
    if (!_inputViewMutArr) {
        _inputViewMutArr = NSMutableArray.array;
    }return _inputViewMutArr;
}

-(NSMutableArray<NSString *> *)titleStrMutArr{
    if (!_titleStrMutArr) {
        _titleStrMutArr = NSMutableArray.array;
        [_titleStrMutArr addObject:@"用户名"];
        [_titleStrMutArr addObject:@"手机号码"];
    }return _titleStrMutArr;
}

@end
