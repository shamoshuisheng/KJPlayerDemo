//
//  KJPlayerOperationView.h
//  KJPlayerDemo
//
//  Created by 杨科军 on 2021/2/21.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJPlayerDemo
//  顶部和底部操作控制面板

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, KJPlayerOperationViewType) {
    KJPlayerOperationViewTypeTop,/// 顶部控件
    KJPlayerOperationViewTypeBottom,/// 底部
};
@interface KJPlayerOperationView : UIView
@property (nonatomic,strong) UIColor *mainColor;
/* 控件尺寸发生变化 */
@property (nonatomic,copy,readwrite) void (^kVideoOperationViewChanged)(KJPlayerOperationView *view);
/* 初始化 */
- (instancetype)initWithFrame:(CGRect)frame OperationType:(KJPlayerOperationViewType)type;

@end

NS_ASSUME_NONNULL_END
