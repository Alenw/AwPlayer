//
//  AWPlayer.h
<<<<<<< HEAD
//  AwPlayerDemo
//
//  Created by yelin on 16/3/10.
//  Copyright © 2016年 yelin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Simulator 1
=======
//  WMPlayer
//
//  Created by yelin on 16/3/4.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

#define Simulator 1
#define awbug 0 //0表示使用masorny约束，1表示使用系统NSLayoutConstraint约束，并开启log状态
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
/** 全屏通知 */
extern NSString *const fullScreenNotification;
/** 关闭按钮通知 */
extern NSString *const closeBtnNotification;

<<<<<<< HEAD
@import MediaPlayer;
@import AVFoundation;
@class BottomView,AWSlider;
@interface AWPlayer : UIView

=======
@class BottomView;
@interface AWPlayer : UIView
//@property (nonatomic, strong) UIImageView *backgroundImage;
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
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

<<<<<<< HEAD
=======
/*************************************************/
/** 播放进度颜色 */
@property (nonatomic, strong) UIColor *playMinColor;
@property (nonatomic, strong) UIColor *playMaxColor;

/** 缓存进度颜色 */
@property (nonatomic, strong) UIColor *cacheMinColor;
@property (nonatomic, strong) UIColor *cacheMaxColor;

/** 快进背景色 */
@property (nonatomic, strong) UIColor *forwardBgColor;

>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
/**
 *  初始化WMPlayer的方法
 *
 *  @param frame       frame
 *  @param videoURLStr URL字符串，包括网络的和本地的URL
 *
 *  @return id类型，实际上就是WMPlayer的一个对象
 */
- (id)initWithFrame:(CGRect)frame videoURLStr:(NSString *)videoURLStr;
<<<<<<< HEAD
=======
-(void)pause;
-(void)play;
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
/**
 *  安全释放
 */
-(void)removeAll;

@end

<<<<<<< HEAD
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
=======
@interface BottomView : UIView
/** 播放按钮 */
@property (nonatomic, weak) UIButton *playBtn;
/** 全屏按钮 */
@property (nonatomic, weak) UIButton *fullScreenBtn;
/** 加载标题 */
@property (nonatomic, weak) UILabel *loadTimeLabel;
/** 持续标题 */
@property (nonatomic, weak) UILabel *durationLabel;

/** 播放进度滑块 */
@property (nonatomic, weak) UISlider *playSlider;
/** 缓存进度 */
@property (nonatomic, weak) UIProgressView *cacheView;
@end

@interface ForwardView : UIView
/** 是否是快进操作 */
@property (nonatomic, assign) BOOL isForward;
/** 进度label 显示播放时间 */
@property (nonatomic, weak) UILabel *progressLabel;
/** 进度view 显示当前进度 */
@property (nonatomic, weak) UIProgressView *progressView;
@end

>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
