//
//  WGradientProgress.m
//  WGradientProgressDemo
//
//  Created by zilin_weng on 15/7/19.
//  Copyright (c) 2015年 Weng-Zilin. All rights reserved.
//

#import "WGradientProgress.h"
#import "UIView+Frame.h"
#import "GlobalCommon.h"

@interface WGradientProgress ()

@property(nonatomic,strong)CAGradientLayer *gradLayer;
@property(nonatomic,strong)CALayer *mask;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIView *parentView;

@end

@implementation WGradientProgress

-(instancetype)init{
    if (self = [super init]) {
        self.progress = 0;
        [self setupTimer];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }return self;
}

- (void)showOnParent:(UIView *)parentView{
    self.parentView = parentView;
    self.frame = CGRectMake(parentView.mj_x,
                            parentView.mj_y,
                            parentView.mj_w,
                            1);
    [parentView addSubview:self];
    [self initBottomLayer];
    [self startTimer];
    [self simulateProgress];
}

- (void)hide{
    [self pauseTimer];
    if ([self superview]) {
        [self removeFromSuperview];
    }
    self.parentView = nil;
}

#pragma mark -- setter / getter
- (void)setProgress:(CGFloat)progress{
    if (progress < 0) {
        progress = 0;
    }
    if (progress > 1) {
        progress = 1;
    }
    _progress = progress;
    CGFloat maskWidth = progress * self.width;
    self.mask.frame = CGRectMake(0, 0, maskWidth, self.height);
}

- (void)initBottomLayer{
    if (self.gradLayer == nil) {
        self.gradLayer = [CAGradientLayer layer];
        self.gradLayer.frame = self.bounds;
    }
    self.gradLayer.startPoint = CGPointMake(0, 0.5);
    self.gradLayer.endPoint = CGPointMake(1, 0.5);
    
    //create colors, important section
    NSMutableArray *colors = [NSMutableArray array];
    for (NSInteger deg = 0; deg <= 360; deg += 5) {
        
        UIColor *color;
        color = [UIColor colorWithHue:1.0 * deg / 360.0
                           saturation:1.0
                           brightness:1.0
                                alpha:1.0];
        [colors addObject:(id)[color CGColor]];
    }
    [self.gradLayer setColors:[NSArray arrayWithArray:colors]];
    self.mask = [CALayer layer];
    [self.mask setFrame:CGRectMake(self.gradLayer.frame.origin.x, self.gradLayer.frame.origin.y,
                                   self.progress * self.width, self.height)];
    self.mask.borderColor = [[UIColor blueColor] CGColor];
    self.mask.borderWidth = 2;
    [self.gradLayer setMask:self.mask];
    [self.layer addSublayer:self.gradLayer];
}

- (void)setupTimer{
    CGFloat interval = 0.03;
    if (self.timer == nil) {
         self.timer = [NSTimer timerWithTimeInterval:interval target:self
                                            selector:@selector(timerFunc)
                                            userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}


- (void)startTimer{
    //start timer
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self.timer setFireDate:[NSDate date]];
}

- (void)pauseTimer{
    [self.timer setFireDate:[NSDate distantFuture]];
}
//
- (void)timerFunc{
    CAGradientLayer *gradLayer = self.gradLayer;
    NSMutableArray *copyArray = [NSMutableArray arrayWithArray:[gradLayer colors]];
    UIColor *lastColor = [copyArray lastObject];
    [copyArray removeLastObject];
    if (lastColor) {
        [copyArray insertObject:lastColor atIndex:0];
    }
    [self.gradLayer setColors:copyArray];
}

- (void)simulateProgress{
    if (self.progress == 0) {
        CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
        CGFloat progress  = [self progress] + increment;
        [self setProgress:progress];
    }
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    @weakify(self)
    dispatch_after(popTime,
                   dispatch_get_main_queue(),
                   ^(void){
        @strongify(self)
        CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
        CGFloat progress  = self.progress + increment;
        NSLog(@"progress:%@", @(progress));
        self.progress = progress;
        if (progress < 1.0) {
            [self simulateProgress];
        }
    });
}

@end
