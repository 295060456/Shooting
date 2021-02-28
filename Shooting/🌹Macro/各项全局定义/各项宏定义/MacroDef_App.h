//
//  MacroDef_App.h
//  UBallLive
//
//  Created by Jobs on 2020/10/30.
//

#ifndef MacroDef_App_h
#define MacroDef_App_h

#define categoryTitleViewHeight 50
#define Margin_collectionView 12
#define Margin_itemX 15
#define Margin_itemY 12
#define JXTableHeaderViewHeight 290
#define MatchScheduleDetailTableHeaderViewHeight 250
/// 播放器view的tag，列表中UI控件唯一tag值
#define kPlayerViewTag 189
#define HQAPPSTRING @"itms-services://?action=download-manifest&url=https://bt.5li2v2.com/channel/ios/hqbetgame_201_6215472_202009132133_4712.plist"

//输入原型图上的宽和高，对外输出App对应的移动设备的真实宽高
#define KWidth(width) (SCREEN_WIDTH / 375) * (width) //375 对应原型图的宽
#define KHeight(height) (SCREEN_HEIGHT / 743) * (height) //743 对应原型图的高

#endif /* MacroDef_App_h */
