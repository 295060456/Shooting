//
//  CustomSYSUITabBarController.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "CustomSYSUITabBarController.h"
#import "BaseNavigationVC.h"

#import "ViewController@1.h"
#import "ViewController@2.h"

//#import "ViewController@5.h"
#import "PhotoVC.h"//拍照

#import "ViewController@3.h"
#import "ViewController@4.h"

@interface CustomSYSUITabBarController ()
<
LZBTabBarVCDelegate
>

@property(nonatomic,strong)NSMutableArray<UIImage *> *customUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray<UIImage *> *customSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray<NSString *> *titleStrMutArr;
@property(nonatomic,strong)NSMutableArray<UIViewController *> *viewControllerMutArr;
@property(nonatomic,strong)BaseNavigationVC *customNavigationVC;
@property(nonatomic,strong)NSMutableArray *mutArr;

@end

CGFloat LZB_TABBAR_HEIGHT;

@implementation CustomSYSUITabBarController

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        LZB_TABBAR_HEIGHT = isiPhoneX_series() ? 80 + isiPhoneX_seriesBottom : 49;
    }return self;
}

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setUpAllChildViewController];
}

- (void)p_setUpAllChildViewController {
    self.delegate = self;
    for (int i = 0; i < self.viewControllerMutArr.count; i ++) {
//        self.customNavigationVC = [[BaseNavigationVC alloc]initWithRootViewController:(UIViewController *)self.viewControllerMutArr[i]];
//        self.customNavigationVC.navigationBar.hidden = YES;
//        [self.mutArr addObject:self.customNavigationVC];

        [self.mutArr addObject:self.viewControllerMutArr[i]];
    }
    self.viewControllers = (NSArray *)self.mutArr;
    for (int i = 0; i <self.titleStrMutArr.count; i++) {
        [self p_setupCustomTBCWithViewController:self.viewControllerMutArr[i]
                                           Title:self.titleStrMutArr[i]
                                     SelectImage:(UIImage *)self.customSelectedImgMutArr[i]
                                   NnSelectImage:(UIImage *)self.customUnselectedImgMutArr[i]];
    }
//    self.lzb_tabBar.backgroundColor = kWhiteColor;
    self.isShouldAnimation = YES;
}

-(void)p_setupCustomTBCWithViewController:(UIViewController *)vc
                                  Title:(NSString *)titleStr
                            SelectImage:(UIImage *)selectImage
                          NnSelectImage:(UIImage *)unSelectImage{
    vc.lzb_tabBarItem.selectImage = selectImage;
    vc.lzb_tabBarItem.unSelectImage = unSelectImage;
    vc.lzb_tabBarItem.title = titleStr;//下
    vc.title = titleStr;//上
}
#pragma mark ======== LZBTabBarViewControllerDelegate ======
- (BOOL)lzb_tabBarController:(LZBTabBarVC *)tabBarController
  shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}
//改1
//点击的时候进行确认是否登录
- (void)lzb_tabBarController:(LZBTabBarVC *)tabBarController
     didSelectViewController:(UIViewController *)viewController{
    [NSObject feedbackGenerator];
    if ([viewController isKindOfClass:[ViewController_1 class]]) {
        //        NSLog(@"%ld",self.selectedIndex);
        NSLog(@"1");
    }
    else if ([viewController isKindOfClass:[ViewController_2 class]]){
//        [self presentLoginVC];
        NSLog(@"2");
    }
    else if ([viewController isKindOfClass:[ViewController_3 class]]){
//        [self presentLoginVC];
        NSLog(@"3");
    }
    else if ([viewController isKindOfClass:[ViewController_4 class]]){
//        [self presentLoginVC];
        NSLog(@"4");
    }
    else if ([viewController isKindOfClass:[PhotoVC class]]){
    //        [self presentLoginVC];
        NSLog(@"5");
    }
}
#pragma mark —— lazyLoad
-(NSMutableArray *)mutArr{
    if (!_mutArr) {
        _mutArr = NSMutableArray.array;
    }return _mutArr;
}

-(NSMutableArray<NSString *> *)titleStrMutArr{
    if (!_titleStrMutArr) {
        _titleStrMutArr = NSMutableArray.array;
        [_titleStrMutArr addObject:@"CASINO"];
        [_titleStrMutArr addObject:@"POKER"];
        [_titleStrMutArr addObject:@"Center"];
        [_titleStrMutArr addObject:@"VIET LOTTO"];
        [_titleStrMutArr addObject:@"PROMOTION"];
    }return _titleStrMutArr;
}

-(NSMutableArray<UIImage *> *)customUnselectedImgMutArr{
    if (!_customUnselectedImgMutArr) {
        _customUnselectedImgMutArr = NSMutableArray.array;
        [_customUnselectedImgMutArr addObject:kIMG(@"Home")];
        [_customUnselectedImgMutArr addObject:kIMG(@"MyStore")];
        [_customUnselectedImgMutArr addObject:kIMG(@"摄像机")];
        [_customUnselectedImgMutArr addObject:kIMG(@"ShoppingCart")];
        [_customUnselectedImgMutArr addObject:kIMG(@"My")];
    }return _customUnselectedImgMutArr;
}

-(NSMutableArray<UIImage *> *)customSelectedImgMutArr{
    if (!_customSelectedImgMutArr) {
        _customSelectedImgMutArr = NSMutableArray.array;
        [_customSelectedImgMutArr addObject:kIMG(@"Home")];
        [_customSelectedImgMutArr addObject:kIMG(@"MyStore")];
        [_customSelectedImgMutArr addObject:kIMG(@"摄像机")];
        [_customSelectedImgMutArr addObject:kIMG(@"ShoppingCart")];
        [_customSelectedImgMutArr addObject:kIMG(@"My")];
    }return _customSelectedImgMutArr;
}

-(NSMutableArray<UIViewController *> *)viewControllerMutArr{
    if (!_viewControllerMutArr) {
        _viewControllerMutArr = NSMutableArray.array;
        [_viewControllerMutArr addObject:ViewController_1.new];
        [_viewControllerMutArr addObject:ViewController_2.new];
        [_viewControllerMutArr addObject:PhotoVC.new];
        [_viewControllerMutArr addObject:ViewController_3.new];
        [_viewControllerMutArr addObject:ViewController_4.new];
    }return _viewControllerMutArr;
}

@end
