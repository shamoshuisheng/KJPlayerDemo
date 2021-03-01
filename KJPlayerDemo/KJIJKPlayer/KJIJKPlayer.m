//
//  KJIJKPlayer.m
//  KJPlayerDemo
//
//  Created by 杨科军 on 2021/3/1.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJPlayerDemo

#import "KJIJKPlayer.h"

#if __has_include(<IJKMediaFramework/IJKMediaFramework.h>)

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

@interface KJIJKPlayer ()
PLAYER_COMMON_EXTENSION_PROPERTY
@property (nonatomic,strong) IJKFFMoviePlayerController *player;
@property (nonatomic,strong) IJKFFOptions *options;
@property (nonatomic,assign) CGFloat lastVolume;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation KJIJKPlayer
PLAYER_COMMON_FUNCTION_PROPERTY PLAYER_COMMON_UI_PROPERTY


@end

#pragma clang diagnostic pop
#endif
