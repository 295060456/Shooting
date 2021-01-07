//
//  DDCollectionViewCell_Style5.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/28.
//

#import "DDCollectionViewCell_Style5.h"

@interface DDCollectionViewCell_Style5 ()
// UI
@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;
// Data
@property(nonatomic,copy)MKDataBlock collectionViewCell_Style5Block;

@end

@implementation DDCollectionViewCell_Style5

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        [UIView makeTargetShadowview:self
//                           superView:nil
//                     shadowDirection:ShadowDirection_rightDown
//                   shadowWithOffsetX:5
//                             offsetY:5
//                        cornerRadius:10
//                        shadowOffset:defaultSize
//                       shadowOpacity:0.5
//                    layerShadowColor:defaultObj
//                   layerShadowRadius:defaultValue];
        self.backgroundColor = kWhiteColor;
        [UIView cornerCutToCircleWithView:self
                          andCornerRadius:6];
    }return self;
}

-(void)actionBlockCollectionViewCell_Style5:(MKDataBlock)collectionViewCell_Style5Block{
    self.collectionViewCell_Style5Block = collectionViewCell_Style5Block;
}

-(void)richElementsInCellWithModel:(UIImage * _Nullable)model{
    [self.player.currentPlayerManager play];
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(SCREEN_WIDTH - 12 * 2,130);
}
#pragma mark —— lazyLoad
-(ZFPlayerController *)player{
    if (!_player) {
        @weakify(self)
        _player = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager
                                                      containerView:self.contentView];
        _player.controlView = self.customPlayerControlView;
//        ZFPlayer_DoorVC = _player;
        [_player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            @strongify(self)
            [self.playerManager replay];//设置循环播放
        }];
    }return _player;
}

-(ZFAVPlayerManager *)playerManager{
    if (!_playerManager) {
        _playerManager = ZFAVPlayerManager.new;
        _playerManager.shouldAutoPlay = YES;

        if (isiPhoneX_series()) {
            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"welcome_video"
                                                                                             ofType:@"mp4"]];
        }else{
            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"welcome_video"
                                                                                             ofType:@"mp4"]];
        }
    }return _playerManager;
}

-(CustomZFPlayerControlView *)customPlayerControlView{
    if (!_customPlayerControlView) {
        _customPlayerControlView = CustomZFPlayerControlView.new;
        @weakify(self)
        [_customPlayerControlView actionCustomZFPlayerControlViewBlock:^(id data, id data2) {
            @strongify(self)
        }];
    }return _customPlayerControlView;
}

@end
