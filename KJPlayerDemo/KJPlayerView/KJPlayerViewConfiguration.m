//
//  KJPlayerViewConfiguration.m
//  KJPlayerDemo
//
//  Created by 杨科军 on 2019/7/23.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJPlayerDemo

#import "KJPlayerViewConfiguration.h"

@implementation KJPlayerViewConfiguration

- (instancetype)init{
    if (self = [super init]) {
        self.mainColor = PLAYER_UIColorFromHEXA(0xFF1437, 1);
        self.haveFristImage = NO;
        self.enableVolumeGesture = YES;
        self.videoGravity = AVLayerVideoGravityResizeAspect;
        self.autoHideTime = 5.0;
        self.playType = KJPlayerPlayTypeReplay;
        self.backString = @"正在播放";
        self.canHorizontalOrVerticalScreen = YES;
        self.openGravitySensing = YES;
        self.playProgressGesture = YES;
        self.gestureSliderMinX = 3;
        self.useCustomDefinition = YES;
        self.stopWhenAppEnterBackground = YES;
        self.continuePlayWhenAppReception = YES;
        self.hasMoved = NO;
        self.currentTime = 0.0;
        self.speed = 1.;
    }
    return self;
}

@end
