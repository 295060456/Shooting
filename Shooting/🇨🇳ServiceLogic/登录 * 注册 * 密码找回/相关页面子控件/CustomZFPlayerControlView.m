//
//  ZFPlayerControlView.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CustomZFPlayerControlView.h"

@interface CustomZFPlayerControlView ()

@property(nonatomic,copy)MKDataBlock CustomZFPlayerControlViewBlock;

@end

@implementation CustomZFPlayerControlView

- (void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl{
    if (self.CustomZFPlayerControlViewBlock) {
        self.CustomZFPlayerControlViewBlock(@1);
    }
}

-(void)actionCustomZFPlayerControlViewBlock:(MKDataBlock)CustomZFPlayerControlViewBlock{
    _CustomZFPlayerControlViewBlock = CustomZFPlayerControlViewBlock;
}

@end
