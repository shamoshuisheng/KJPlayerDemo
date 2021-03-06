//
//  KJPlayerViewConfiguration.h
//  KJPlayerDemo
//
//  Created by 杨科军 on 2019/7/23.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJPlayerDemo

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KJPlayerType.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJPlayerViewConfiguration : NSObject
/* 主色调 */
@property (nonatomic,strong) UIColor *mainColor;
/* 设置自动隐藏面板时间，默认5秒，为0时表示关闭自动隐藏功能 */
@property (nonatomic,assign) CGFloat autoHideTime;
/* 设置播放类型，默认 KJPlayerPlayTypeReplay 重复播放 */
@property (nonatomic,assign) KJPlayerPlayType playType;
/* 视频的显示模式，默认按原视频比例显示多余两边留黑 AVLayerVideoGravityResizeAspect */
@property (nonatomic,assign) AVLayerVideoGravity videoGravity;
/* 返回标题文字，默认正在播放 */
@property (nonatomic,strong) NSString *backString;
/* 是否用视频第一帧显示为占位背景，默认NO */
@property (nonatomic,assign) BOOL haveFristImage;
/* 是否使用手势控制音量和亮度，默认yes */
@property (nonatomic,assign) BOOL enableVolumeGesture;
/* 是否使用手势控制播放进度，默认yes */
@property (nonatomic,assign) BOOL playProgressGesture;
/* 是否允许横竖屏，默认yes */
@property (nonatomic,assign) BOOL canHorizontalOrVerticalScreen;
/* 是否打开重力感应，默认yes */
@property (nonatomic,assign) BOOL openGravitySensing;
/* 手势滑动触发的最小距离，默认3 */
@property (nonatomic,assign) CGFloat gestureSliderMinX;
/* 是否使用默认的清晰度面板，默认yes */
@property (nonatomic,assign) BOOL useCustomDefinition;
/* 进入后台是否停止播放，默认yes */
@property (nonatomic,assign) BOOL stopWhenAppEnterBackground;
/* 后台返回继续播放功能，默认yes */
@property (nonatomic,assign) BOOL continuePlayWhenAppReception;
/* 播放速度 */
@property (nonatomic,assign) CGFloat speed;

#pragma mark - 内部只读数据
@property (nonatomic,assign) KJPlayerState state;//播放器状态
@property (nonatomic,assign) CGFloat totalTime;//视频总时间
@property (nonatomic,assign) CGFloat currentTime;//视频当前播放时间
@property (nonatomic,strong) id url;//视频地址
@property (nonatomic,strong) UIImage *videoImage;//视频第一帧图片
@property (nonatomic,assign) BOOL fullScreen;//判断当前的状态是否显示为全屏
@property (nonatomic,assign) BOOL hasMoved;//用来判断手势是否移动过
@property (nonatomic,assign) CGPoint touchBeginPoint;//记录touch开始的点
@property (nonatomic,assign) CGFloat touchBeginVoiceValue;//记录触摸开始的音量
@property (nonatomic,assign) KJPlayerGestureType gestureType;//手势控制类型

@end

NS_ASSUME_NONNULL_END
