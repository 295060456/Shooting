//
//  ViewController@2.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@2.h"

@interface ViewController_2 (){
    
}

@property(nonatomic,strong)FSCustomButton *btn;

@end

@implementation ViewController_2

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
       
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRedColor;
    self.btn.alpha = 1;
}

-(FSCustomButton *)btn{
    if (!_btn) {
        _btn = FSCustomButton.new;
        _btn.backgroundColor = kWhiteColor;
        [_btn setTitle:@"1\n2\n3456" forState:UIControlStateNormal];
        _btn.titleLabel.numberOfLines = 0;
        _btn.buttonImagePosition = FSCustomButtonImagePositionTop;
        [_btn setImage:kIMG(@"播放")
              forState:UIControlStateNormal];
        [self.view addSubview:_btn];
        _btn.frame = CGRectMake(100, 100, 100, 200);
    }return _btn;
}


@end
