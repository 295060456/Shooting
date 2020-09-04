//
//  DoorInputViewStyle_3.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorInputViewStyle_3.h"

@interface DoorInputViewStyle_3 ()
<
UITextFieldDelegate
,CJTextFieldDeleteDelegate
>

@property(nonatomic,strong)UIButton *btn;

@end

@implementation DoorInputViewStyle_3

-(instancetype)init{
    if (self = [super init]) {
        [UIView cornerCutToCircleWithView:self
                          AndCornerRadius:self.mj_h / 2];
        self.backgroundColor = COLOR_RGB(39,
                                         37,
                                         37,
                                         1);
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.tf.alpha = 1;
}

-(void)clickBtnEvent:(UIButton *)sender{
    sender.selected = !sender.selected;
    
}

#pragma mark —— CJTextFieldDeleteDelegate
- (void)cjTextFieldDeleteBackward:(CJTextField *)textField{
    
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
//告诉委托人在指定的文本字段中开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}
//询问委托人是否应在指定的文本字段中停止编辑
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{

}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason;
//询问委托人是否应该更改指定的文本
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
#pragma mark —— lazyLoad
-(ZYTextField *)tf{
    if (!_tf) {
        _tf = ZYTextField.new;
        _tf.delegate = self;
        _tf.cj_delegate = self;
        [self addSubview:_tf];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.width.mas_equalTo(self.inputViewWidth * 0.86);
        }];
    }return _tf;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = UIButton.new;
        [_btn addTarget:self
                 action:@selector(clickBtnEvent:)
       forControlEvents:UIControlEventTouchUpInside];
        [_btn setImage:self.btnSelectedIMG
              forState:UIControlStateSelected];
        [_btn setImage:self.btnUnSelectedIMG
              forState:UIControlStateNormal];
        [self addSubview:_btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.centerY.equalTo(self);
            make.left.equalTo(self.tf.mas_right);
        }];
    }return _btn;
}




@end
