//
//  ForgetCodeStep_02.m
//  Shooting
//
//  Created by Jobs on 2020/9/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ForgetCodeStep_02View.h"
#import "DoorInputView.h"

@interface ForgetCodeStep_02View ()

@property(nonatomic,assign)BOOL isOpen;

@property(nonatomic,copy)MKDataBlock forgetCodeStep_02ViewBlock;
@property(nonatomic,copy)MKDataBlock forgetCodeStep_02ViewKeyboardBlock;

@property(nonatomic,strong)NSMutableArray <UIImage *>*headerImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;
@property(nonatomic,strong)NSMutableArray <DoorInputViewStyle_3 *> *inputViewMutArr;

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
    }return self;
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
    if (self.isOpen){
        NSDictionary *userInfo = notification.userInfo;
        CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;
        NSLog(@"KeyboardOffsetY = %f",KeyboardOffsetY);
        NSLog(@"MMM beginFrameY = %f,endFrameY = %f",beginFrame.origin.y,endFrame.origin.y);
        CGFloat offset = 100;
//        if (KeyboardOffsetY > 0) {
//            k = endFrame.origin.y - self.mj_h - offset;
//            [self showLoginContentViewWithOffsetY:k];
//        }else{
//            [self showLoginContentViewWithOffsetY:-k];
//        }
//
//        if (self.loginContentViewKeyboardBlock) {
//            self.loginContentViewKeyboardBlock(@(KeyboardOffsetY));
//        }
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

-(void)actionForgetCodeStep_02ViewBlock:(MKDataBlock)forgetCodeStep_02ViewBlock{
    _forgetCodeStep_02ViewBlock = forgetCodeStep_02ViewBlock;
}

-(void)actionForgetCodeStep_02ViewKeyboardBlock:(MKDataBlock)forgetCodeStep_02ViewKeyboardBlock{
    _forgetCodeStep_02ViewKeyboardBlock = forgetCodeStep_02ViewKeyboardBlock;
}
#pragma mark —— lazyLoad
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
