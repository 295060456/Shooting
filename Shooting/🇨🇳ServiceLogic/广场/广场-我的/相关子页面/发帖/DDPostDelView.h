//
//  DDPostDelView.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDPostDelView : UIView

-(void)richElementsInCellWithModel:(BOOL)model;
-(void)actionBlockDDPostDelView:(MKDataBlock)postDelViewBlock;

@end

NS_ASSUME_NONNULL_END
