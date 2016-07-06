//
//  AWPlayer.h
//  AwPlayerDemo
//
//  Created by yelin on 16/3/10.
//  Copyright © 2016年 yelin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Simulator 1
/** 全屏通知 */
extern NSString *const fullScreenNotification;
/** 关闭按钮通知 */
extern NSString *const closeBtnNotification;

@import MediaPlayer;
@import AVFoundation;
@class BottomView,AWSlider;
@interface AWPlayer : UIView

/**
 *  播放器player
 */
@property(nonatomic,strong)AVPlayer *player;
/**
 *playerLayer,可以修改frame
 */
@property(nonatomic,strong)AVPlayerLayer *playerLayer;
/* playItem */
@property (nonatomic, strong) AVPlayerItem *currentItem;
/**
 *  底部操作工具栏
 */
@property(nonatomic,weak)BottomView *bottomView;

@property(nonatomic,copy) NSString *videoURLStr;
/**
 *  BOOL值判断当前的状态
 */
@property(nonatomic,assign)BOOL isFullscreen;

/**
 *  关闭按钮
 */
@property(nonatomic,retain)UIButton *closeBtn;

/**
 *  初始化WMPlayer的方法
 *
 *  @param frame       frame
 *  @param videoURLStr URL字符串，包括网络的和本地的URL
 *
 *  @return id类型，实际上就是WMPlayer的一个对象
 */
- (id)initWithFrame:(CGRect)frame videoURLStr:(NSString *)videoURLStr;
/**
 *  安全释放
 */
-(void)removeAll;

@end

@interface ForwardView : UIView
@property (nonatomic, assign) BOOL isForward;
@property (nonatomic, weak) UILabel *progressLabel;
@property (nonatomic, weak) UIProgressView *progressView;
@end

@interface BottomView : UIView
@property (nonatomic, weak) UIButton *playBtn;
@property (nonatomic, weak) UIButton *fullScreenBtn;
@property (nonatomic, weak) AWSlider *awslider;
@end

@interface AWSlider : UIView
/** 加载标题 */
@property(weak)UILabel *loadTimeLabel;
/** 持续标题 */
@property(weak)UILabel *durationLabel;
/** 播放进度滑块 */
@property(weak)UISlider *playSlider;
/** 缓存进度 */
@property(weak)UIProgressView *cacheView;
@end