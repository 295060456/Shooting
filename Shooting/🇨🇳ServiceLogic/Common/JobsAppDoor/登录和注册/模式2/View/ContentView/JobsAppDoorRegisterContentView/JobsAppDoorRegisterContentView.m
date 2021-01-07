//
//  RegisterContentView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorRegisterContentView.h"

@class JobsAppDoorDoorInputViewBaseStyle;

@interface JobsAppDoorRegisterContentView ()

@property(nonatomic,strong)UIButton *backToLoginBtn;// 返回登录
@property(nonatomic,strong)UILabel *titleLab;// 标题
@property(nonatomic,strong)UIButton *sendBtn;// 注册按钮
@property(nonatomic,copy)MKDataBlock registerContentViewBlock;
@property(nonatomic,strong)NSMutableArray <JobsAppDoorInputViewBaseStyleModel *>*registerDoorInputViewBaseStyleModelMutArr;

@end

@implementation JobsAppDoorRegisterContentView

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = Cor1;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
//外层数据渲染
-(void)richElementsInViewWithModel:(id _Nullable)contentViewModel{
    self.backToLoginBtn.alpha = 1;
    self.titleLab.alpha = 1;
    [self makeInputView];
    self.sendBtn.alpha = 1;
}

-(void)actionBlockRegisterContentView:(MKDataBlock)registerContentViewBlock{
    self.registerContentViewBlock = registerContentViewBlock;
}

-(void)makeInputView{
    for (int i = 0; i < self.registerDoorInputViewBaseStyleModelMutArr.count; i++) {
        // 3 3 3 1 4
        JobsAppDoorInputViewBaseStyle *inputViewBaseStyle = nil;
        if (i == 0 || i == 1 || i == 2) {
            JobsAppDoorInputViewBaseStyle_3 *inputView = JobsAppDoorInputViewBaseStyle_3.new;
            inputViewBaseStyle = (JobsAppDoorInputViewBaseStyle *)inputView;
            [self.registerDoorInputViewBaseStyleMutArr addObject:inputView];
            @weakify(self)
            [inputView actionBlockDoorInputViewStyle_3:^(id data) {
                @strongify(self)
                if (self.registerContentViewBlock) {
                    self.registerContentViewBlock(data);
                }
            }];
        }else if(i == 3){
            JobsAppDoorInputViewBaseStyle_1 *inputView = JobsAppDoorInputViewBaseStyle_1.new;
            inputViewBaseStyle = (JobsAppDoorInputViewBaseStyle *)inputView;
            [self.registerDoorInputViewBaseStyleMutArr addObject:inputView];
            @weakify(self)
            [inputView actionBlockDoorInputViewStyle_1:^(id data) {
                @strongify(self)
                if (self.registerContentViewBlock) {
                    self.registerContentViewBlock(data);
                }
            }];
        }else if (i == 4){
            JobsAppDoorInputViewBaseStyle_4 *inputView = JobsAppDoorInputViewBaseStyle_4.new;
            inputViewBaseStyle = (JobsAppDoorInputViewBaseStyle *)inputView;
            [self.registerDoorInputViewBaseStyleMutArr addObject:inputView];
            @weakify(self)
            [inputView actionBlockDoorInputViewStyle_4:^(id data) {
                @strongify(self)
                if (self.registerContentViewBlock) {
                    self.registerContentViewBlock(data);
                }
            }];
        }else{}
        [inputViewBaseStyle richElementsInViewWithModel:self.registerDoorInputViewBaseStyleModelMutArr[i]];//进数据
        [self addSubview:inputViewBaseStyle];
        inputViewBaseStyle.size = CGSizeMake(self.width - RegisterBtnWidth - 40, ThingsHeight);
        inputViewBaseStyle.centerX = self.titleLab.centerX;
        if (i == 0) {
            inputViewBaseStyle.top = self.titleLab.bottom + 20;//20是偏移量
        }else{
            JobsAppDoorInputViewBaseStyle_3 *lastObj = (JobsAppDoorInputViewBaseStyle_3 *)self.registerDoorInputViewBaseStyleMutArr[i - 1];
            inputViewBaseStyle.top = lastObj.bottom + InputViewOffset;
        }
        inputViewBaseStyle.layer.cornerRadius = ThingsHeight / 2;
        
    }
}
#pragma mark —— lazyLoad
-(UIButton *)backToLoginBtn{
    if (!_backToLoginBtn) {
        _backToLoginBtn = UIButton.new;
        _backToLoginBtn.titleLabel.numberOfLines = 0;
        _backToLoginBtn.backgroundColor = kBlackColor;
        _backToLoginBtn.alpha = 0.7f;
        _backToLoginBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        [_backToLoginBtn setTitle:btnTitle1
                        forState:UIControlStateNormal];
        [_backToLoginBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                         imageTitleSpace:8];
        [_backToLoginBtn setImage:KIMG(@"用户名称")
                         forState:UIControlStateNormal];
        @weakify(self)
        [[_backToLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            NSLog(@"返回登录");
            @strongify(self)
            [self endEditing:YES];
            if (self.registerContentViewBlock) {
                self.registerContentViewBlock(x);
            }
        }];
        [self addSubview:_backToLoginBtn];
        [_backToLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.width.mas_equalTo(btnWidth);
        }];
        [_backToLoginBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                         imageTitleSpace:8];
    }return _backToLoginBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"登录";
        _titleLab.textColor = kWhiteColor;
        _titleLab.font = [UIFont systemFontOfSize:20
                                           weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        _titleLab.centerX = (self.width + self.backToLoginBtn.width) / 2;
        _titleLab.top = 20;
    }return _titleLab;
}

-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = UIButton.new;
        [_sendBtn setTitle:@"注册"
                   forState:UIControlStateNormal];
        _sendBtn.backgroundColor = [KSystemPinkColor colorWithAlphaComponent:0.7];
        [_sendBtn setTitleColor:kWhiteColor
                        forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:15
                                                     weight:UIFontWeightSemibold];
        [_sendBtn.titleLabel sizeToFit];
        @weakify(self)
        [[_sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
        }];
        [self addSubview:_sendBtn];
        _sendBtn.x = self.backToLoginBtn.width + 20;
        _sendBtn.size = CGSizeMake(self.width - self.backToLoginBtn.width - 40, ThingsHeight);
        _sendBtn.bottom = JobsAppDoorContentViewLeftHeight - 20;
        [UIView cornerCutToCircleWithView:_sendBtn andCornerRadius:_sendBtn.height / 2];
    }return _sendBtn;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyleModel *> *)registerDoorInputViewBaseStyleModelMutArr{
    if (!_registerDoorInputViewBaseStyleModelMutArr) {
        _registerDoorInputViewBaseStyleModelMutArr = NSMutableArray.array;
        
        JobsAppDoorInputViewBaseStyleModel *用户名 = JobsAppDoorInputViewBaseStyleModel.new;
        用户名.leftViewIMG = KIMG(@"用户名称");
        用户名.placeHolderStr = @"用户名";
        用户名.isShowDelBtn = YES;
        用户名.isShowSecurityBtn = NO;
        用户名.returnKeyType = UIReturnKeyDone;
        用户名.keyboardAppearance = UIKeyboardAppearanceAlert;
        用户名.leftViewMode = UITextFieldViewModeAlways;
        [_registerDoorInputViewBaseStyleModelMutArr addObject:用户名];
        
        JobsAppDoorInputViewBaseStyleModel *密码 = JobsAppDoorInputViewBaseStyleModel.new;
        密码.leftViewIMG = KIMG(@"Lock");
        密码.placeHolderStr = @"密码";
        密码.isShowDelBtn = YES;
        密码.isShowSecurityBtn = YES;
        密码.returnKeyType = UIReturnKeyDone;
        密码.keyboardAppearance = UIKeyboardAppearanceAlert;
        密码.selectedSecurityBtnIMG = KIMG(@"codeEncode");//闭眼
        密码.unSelectedSecurityBtnIMG = KIMG(@"codeDecode");//开眼
        密码.leftViewMode = UITextFieldViewModeAlways;
        [_registerDoorInputViewBaseStyleModelMutArr addObject:密码];
        
        JobsAppDoorInputViewBaseStyleModel *确认密码 = JobsAppDoorInputViewBaseStyleModel.new;
        确认密码.leftViewIMG = KIMG(@"Lock");
        确认密码.placeHolderStr = @"确认密码";
        确认密码.isShowDelBtn = YES;
        确认密码.isShowSecurityBtn = YES;
        确认密码.returnKeyType = UIReturnKeyDone;
        确认密码.keyboardAppearance = UIKeyboardAppearanceAlert;
        确认密码.selectedSecurityBtnIMG = KIMG(@"codeEncode");//闭眼
        确认密码.unSelectedSecurityBtnIMG =KIMG(@"codeDecode");//开眼
        确认密码.leftViewMode = UITextFieldViewModeAlways;
        [_registerDoorInputViewBaseStyleModelMutArr addObject:确认密码];
        
        JobsAppDoorInputViewBaseStyleModel *推广码 = JobsAppDoorInputViewBaseStyleModel.new;
        推广码.leftViewIMG = KIMG(@"推广码");
        推广码.placeHolderStr = @"手机验证码";
        推广码.isShowDelBtn = YES;
        推广码.isShowSecurityBtn = NO;
        推广码.returnKeyType = UIReturnKeyDone;
        推广码.keyboardAppearance = UIKeyboardAppearanceAlert;
        推广码.leftViewMode = UITextFieldViewModeAlways;
        [_registerDoorInputViewBaseStyleModelMutArr addObject:推广码];
        
        JobsAppDoorInputViewBaseStyleModel *图形验证码 = JobsAppDoorInputViewBaseStyleModel.new;
        图形验证码.leftViewIMG = KIMG(@"验证ICON");
        图形验证码.placeHolderStr = @"图形验证码";
        图形验证码.isShowDelBtn = YES;
        图形验证码.isShowSecurityBtn = NO;
        图形验证码.returnKeyType = UIReturnKeyDone;
        图形验证码.keyboardAppearance = UIKeyboardAppearanceAlert;
        图形验证码.leftViewMode = UITextFieldViewModeAlways;
        [_registerDoorInputViewBaseStyleModelMutArr addObject:图形验证码];
        
    }return _registerDoorInputViewBaseStyleModelMutArr;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyle *> *)registerDoorInputViewBaseStyleMutArr{
    if (!_registerDoorInputViewBaseStyleMutArr) {
        _registerDoorInputViewBaseStyleMutArr = NSMutableArray.array;
    }return _registerDoorInputViewBaseStyleMutArr;
}

@end
