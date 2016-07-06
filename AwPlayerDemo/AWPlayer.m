//
<<<<<<< HEAD
//  AWPlayer.m
//  AwPlayerDemo
//
//  Created by yelin on 16/3/10.
//  Copyright © 2016年 yelin. All rights reserved.
//

#import "AWPlayer.h"
#import <AudioToolbox/AudioToolbox.h>
=======
//  AWPlayer.h
//  WMPlayer
//
//  Created by yelin on 16/3/4.
//  Copyright © 2016年 Alenw. All rights reserved.
//

#import "AWPlayer.h"
#import "ForwardView.h"
#import "BottomView.h"
#if awbug
#else
#import "Masonry.h"
#endif
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45

NSString *const fullScreenNotification=@"fullScreenNotification";
NSString *const closeBtnNotification=@"closeBtnNotification";

@interface AWPlayer ()
{
    UISlider *systemSlider;
}
@property (nonatomic,assign)CGPoint firstPoint;
@property (nonatomic,assign)CGPoint secondPoint;
@property (nonatomic, retain) NSTimer *durationTimer;
@property (nonatomic, retain) NSTimer *autoDismissTimer;
@property (nonatomic, retain)NSDateFormatter *dateFormatter;
@property(nonatomic,assign)float videoAvailable;
@property (nonatomic, weak) ForwardView *forwardView;
@property (nonatomic, assign) double forwardTime;
/** 标记是否快进 */
@property (nonatomic, assign) BOOL isMoved;
@property (nonatomic, assign) BOOL isVolume;
<<<<<<< HEAD
=======
@property (nonatomic, assign) BOOL sliding;

/*******************/
@property (nonatomic, copy) NSArray *cb2;
@property (nonatomic, copy) NSArray *cb3;

/*************/
@property (nonatomic, copy) NSArray *tt;
@property (nonatomic, copy) NSArray *hh;
@property (nonatomic, copy) NSArray *ftt;
@property (nonatomic, copy) NSArray *fhh;

@property (nonatomic, strong) NSLayoutConstraint *cs1;
@property (nonatomic, strong) NSLayoutConstraint *cs2;
@property (nonatomic, copy) NSArray *cs3;
@property (nonatomic, copy) NSArray *cs4;
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45

@end

@implementation AWPlayer
-(AVPlayerItem *)getPlayItemWithURLString:(NSString *)urlString{
    if ([urlString containsString:@"http"]) {
        AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        return playerItem;
    }else{
        AVAsset *movieAsset  = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:urlString] options:nil];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        return playerItem;
    }
    
}
- (instancetype)initWithFrame:(CGRect)frame videoURLStr:(NSString *)videoURLStr{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor blackColor];
        self.currentItem = [self getPlayItemWithURLString:videoURLStr];
<<<<<<< HEAD
        //AVPlayer
        self.player = [AVPlayer playerWithPlayerItem:self.currentItem];
        //AVPlayerLayer
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame = self.layer.bounds;
        //        self.playerLayer.videoGravity = AVLayerVideoGravityResize;
=======
        self.player = [AVPlayer playerWithPlayerItem:self.currentItem];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame = self.layer.bounds;
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
        [self.layer addSublayer:_playerLayer];
        
#pragma mark -  init BottomView
        [self creatUI];
        
<<<<<<< HEAD
        [self addTouchAction];
        
        [self initTimer];
        
        [self.bottomView.awslider.playSlider addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame videoURLStrAll:(NSString *)videoURLStr{
    self=[super init];
    if (self) {
        
#pragma mark -  init BottomView
        [self creatUI];
        
        [self addTouchAction];
        
        [self initTimer];
        
        [self.bottomView.awslider.playSlider addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
=======
        [self addContextAction];
        
        [self initTimer];
        self.autoresizingMask=UIViewAutoresizingNone;
#pragma mark - 屏幕单双击事件
        // 单击的 Recognizer
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
        singleTap.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:singleTap];
        
        // 双击的 Recognizer
        UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap)];
        doubleTap.numberOfTapsRequired = 2; // 双击
        [self addGestureRecognizer:doubleTap];
        
        [self.bottomView.playSlider addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self.bottomView.fullScreenBtn addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    }
    return self;
}
-(void)creatUI{
<<<<<<< HEAD
    ForwardView *forwardView=[[ForwardView alloc]init];
    [self addSubview:forwardView];
    self.forwardView=forwardView;
    [forwardView setTranslatesAutoresizingMaskIntoConstraints:NO];
  
    NSString *widthF=@"[forwardView(120)]";
    NSString *heightF=@"V:[forwardView(70)]";
    NSArray *cs3=[NSLayoutConstraint constraintsWithVisualFormat:widthF options:0 metrics:nil views:@{@"forwardView":forwardView}];
    NSArray *cs4=[NSLayoutConstraint constraintsWithVisualFormat:heightF options:0 metrics:nil views:@{@"forwardView":forwardView}];
    NSLayoutConstraint *cs1=[NSLayoutConstraint constraintWithItem:forwardView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *cs2=[NSLayoutConstraint constraintWithItem:forwardView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [self addConstraints:cs3];
    [self addConstraints:cs4];
    [self addConstraint:cs1];
    [self addConstraint:cs2];
    
////    [forwardView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerX.centerY.equalTo(weakSelf);
////    }];
    [self sendSubviewToBack:forwardView];
    
    //bottomView
    BottomView *bottomView= [[BottomView alloc]init];
    [bottomView.playBtn addTarget:self action:@selector(isPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    [self.bottomView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSString *vflB=@"V:|-(>=0)-[bottomView]-0-|";
=======
#warning 这个位置初始化ForwardView不是最好的时机
    [self initForwardView];
    //bottomView
    BottomView *bottomView= [[BottomView alloc]init];
    [self addSubview:bottomView];
    self.bottomView = bottomView;
    
    __weak typeof(self) weakSelf = self;
#if awbug
    [self.bottomView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSString *vflB=@"V:|-(>=0)-[bottomView(40)]-0-|";
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    NSString *hflB=@"|-0-[bottomView]-0-|";
    NSArray *cb2=[NSLayoutConstraint constraintsWithVisualFormat:vflB options:0 metrics:nil views:@{@"bottomView":bottomView}];
    NSArray *cb3=[NSLayoutConstraint constraintsWithVisualFormat:hflB options:0 metrics:nil views:@{@"bottomView":bottomView}];
    [self addConstraints:cb2];
    [self addConstraints:cb3];
<<<<<<< HEAD
 
=======
    self.cb2=cb2;
    self.cb3=cb3;
#else  
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@40);
    }];
#endif
    [self.bottomView.playBtn addTarget:self action:@selector(isPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.playSlider addTarget:self action:@selector(slideOut:) forControlEvents:UIControlEventValueChanged];
    [self.bottomView.playSlider addTarget:self action:@selector(sliding:) forControlEvents:UIControlEventTouchDragInside];
    self.bottomView.playSlider.continuous=NO;
    
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    MPVolumeView *volumeView = [[MPVolumeView alloc]init];
    [self addSubview:volumeView];
    [volumeView sizeToFit];

    for (UIControl *view in volumeView.subviews) {
        if ([view.superclass isSubclassOfClass:[UISlider class]]) {
<<<<<<< HEAD
            NSLog(@"1");
=======
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
            systemSlider = (UISlider *)view;
        }
    }
    systemSlider.autoresizesSubviews = NO;
    systemSlider.autoresizingMask = UIViewAutoresizingNone;
<<<<<<< HEAD
//    [self addSubview:systemSlider];
=======
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    systemSlider.hidden = YES;
    
    [self bringSubviewToFront:self.bottomView];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.showsTouchWhenHighlighted = YES;
    [closeBtn addTarget:self action:@selector(colseTheVideo:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateSelected];
    closeBtn.layer.cornerRadius = 30/2;
    [self addSubview:closeBtn];
    self.closeBtn=closeBtn;
<<<<<<< HEAD
=======
#if awbug
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    [closeBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSString *cbw=@"V:|-5-[closeBtn(30)]-(>=0)-|";
    NSString *cbh=@"|-5-[closeBtn(30)]-(>=0)-|";
    NSArray *cbww=[NSLayoutConstraint constraintsWithVisualFormat:cbw options:0 metrics:nil views:@{@"closeBtn":closeBtn}];
    NSArray *cbhh=[NSLayoutConstraint constraintsWithVisualFormat:cbh options:0 metrics:nil views:@{@"closeBtn":closeBtn}];
    [self addConstraints:cbww];
    [self addConstraints:cbhh];
<<<<<<< HEAD
}
-(void)addTouchAction{
#pragma mark - 屏幕单双击事件
    // 单击的 Recognizer
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    singleTap.numberOfTapsRequired = 1; // 单击
    [self addGestureRecognizer:singleTap];
    
    // 双击的 Recognizer
    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap)];
    doubleTap.numberOfTapsRequired = 2; // 双击
    [self addGestureRecognizer:doubleTap];
    
=======
#else
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf).offset(5);
        make.width.height.equalTo(@30);
    }];
#endif
}
-(void)sliding:(UISlider *)slider{
#if awbug
    NSLog(@"sliding-%.f",slider.value);
#endif
    [self bringSubviewToFront:self.forwardView];
    if (self.bottomView.playSlider.value>=[self duration]) {
        self.forwardView.progressView.progress=1;
        self.bottomView.loadTimeLabel.text=[self convertTime:[self duration]];
        self.forwardView.progressLabel.text=[NSString stringWithFormat:@"%@/%@",self.bottomView.loadTimeLabel.text,self.bottomView.durationLabel.text];
    }else{
        self.forwardView.progressView.progress=self.bottomView.playSlider.value/[self duration];
        self.bottomView.loadTimeLabel.text=[self convertTime:self.bottomView.playSlider.value];
        self.forwardView.progressLabel.text=[NSString stringWithFormat:@"%@/%@",self.bottomView.loadTimeLabel.text,self.bottomView.durationLabel.text];
    }
    self.sliding=YES;
    
}
-(void)slideOut:(UISlider *)slider{
#if awbug
    NSLog(@"sliderOut");
#endif
    self.sliding=NO;
    [self sendSubviewToBack:self.forwardView];
    [self updateProgress:self.bottomView.playSlider];
}
-(void)initForwardView{
    ForwardView *forwardView=[[ForwardView alloc]init];
    [self addSubview:forwardView];
    self.forwardView=forwardView;
   __weak typeof(self) weakSelf = self;
    
#if awbug
    [forwardView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSString *widthF=@"[forwardView(120)]";
    NSString *heightF=@"V:[forwardView(70)]";
    NSArray *cs3=[NSLayoutConstraint constraintsWithVisualFormat:widthF options:0 metrics:nil views:@{@"forwardView":forwardView}];
    NSArray *cs4=[NSLayoutConstraint constraintsWithVisualFormat:heightF options:0 metrics:nil views:@{@"forwardView":forwardView}];
    NSLayoutConstraint *cs1=[NSLayoutConstraint constraintWithItem:forwardView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *cs2=[NSLayoutConstraint constraintWithItem:forwardView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    
    [self addConstraints:cs3];
    [self addConstraints:cs4];
    [self addConstraint:cs1];
    [self addConstraint:cs2];
    
    self.cs1=cs1;
    self.cs2=cs2;
    self.cs3=cs3;
    self.cs4=cs4;
#else
    [forwardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(weakSelf);
        make.width.equalTo(@120);
        make.height.equalTo(@70);
    }];
#endif
    
    [self sendSubviewToBack:forwardView];
}
-(void)addContextAction{
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
#pragma mark - 监听播放事件
    [self.currentItem addObserver:self
                       forKeyPath:@"status"
                          options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                          context:nil];
    [self.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
<<<<<<< HEAD
    
}

- (void)updateSystemVolumeValue:(UISlider *)slider{
    systemSlider.value = slider.value;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}

#pragma mark
#pragma mark - fullScreenAction
-(void)colseTheVideo:(UIButton *)sender{
    [self isPlay:self.bottomView.playBtn];
    [[NSNotificationCenter defaultCenter] postNotificationName:closeBtnNotification object:sender];
}
=======
}
#pragma mark
#pragma mark - 单击手势方法
- (void)handleSingleTap{
    [UIView animateWithDuration:0.5 animations:^{
        if (self.bottomView.alpha == 0.0) {
            self.bottomView.alpha = 1.0;
            self.closeBtn.alpha = 1.0;
        }else{
            self.bottomView.alpha = 0.0;
            self.closeBtn.alpha = 0.0;
        }
    } completion:^(BOOL finish){
        [self sendSubviewToBack:self.forwardView];
        if (self.player.rate==0.0&&self.isMoved) {
            [self updateProgress:self.bottomView.playSlider];
            [self isPlay:self.bottomView.playBtn];
        }
        self.isMoved=NO;
        self.isVolume=NO;
    }];
}
#pragma mark
#pragma mark - 双击手势方法
- (void)handleDoubleTap{
    //    self.bottomView.playBtn.selected = !self.bottomView.playBtn.selected;
    [self isPlay:self.bottomView.playBtn];
    //    if (self.player.rate != 1.f) {
    //        if ([self currentTime] == self.duration)
    //            [self setCurrentTime:0.f];
    //        [self isPlay:self.bottomView.playBtn];
    //    } else {
    //        [self.player pause];
    //    }
}
#pragma mark
#pragma mark - fullScreenAction
-(void)colseTheVideo:(UIButton *)sender{
    [self.player pause];
    [[NSNotificationCenter defaultCenter] postNotificationName:closeBtnNotification object:sender];
}
- (void)updateSystemVolumeValue:(UISlider *)slider{
    systemSlider.value = slider.value;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45

/**
 *  播放器跳转到指定时间
 *
 *  @param time 时间(秒)
 */
- (void)setCurrentTime:(double)time{
    [[self player] seekToTime:CMTimeMakeWithSeconds(time, 1)];
}
#pragma mark
#pragma mark - PlayOrPause
<<<<<<< HEAD
=======
-(void)pause{
    if (self.player.rate==1.0) {
        [self isPlay:self.bottomView.playBtn];
    }
}
-(void)play{
    if (self.player.rate!=1.0) {
        [self isPlay:self.bottomView.playBtn];
    }
}
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
- (void)isPlay:(UIButton *)sender{
    if (self.durationTimer==nil) {
        self.durationTimer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(finishedPlay) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
    }
    sender.selected = !sender.selected;
    if (!sender.selected&&[self currentTime] != [self duration]) {
        [self.player play];
    } else {
        [self.player pause];
    }
    
    //    CMTime time = [self.player currentTime];
}
<<<<<<< HEAD
#pragma mark finishedPlay
/**
 *  播放结束回调，发送通知 @"finishedPlay"
 */
- (void)finishedPlay{
    if (self.currentTime == self.duration&&self.player.rate==.0f) {
        self.bottomView.playBtn.selected = YES;
        //播放完成后的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedPlay" object:self.durationTimer];
        [self.durationTimer invalidate];
        self.durationTimer = nil;
    }
}
=======

>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
#pragma mark

#pragma mark - 设置播放的视频
- (void)setVideoURLStr:(NSString *)videoURLStr
{
    _videoURLStr = videoURLStr;
    
    if (self.currentItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_currentItem];
        [self.currentItem removeObserver:self forKeyPath:@"status"];
        [self.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        self.currentItem=nil;
    }
    
    self.currentItem = [self getPlayItemWithURLString:videoURLStr];
    
<<<<<<< HEAD
    [self.currentItem addObserver:self
                       forKeyPath:@"status"
                          options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                          context:nil];
    [self.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
=======
    [self addContextAction];
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    [self.player replaceCurrentItemWithPlayerItem:self.currentItem];
    
    
    // 添加视频播放结束通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_currentItem];
    
}
- (void)moviePlayDidEnd:(NSNotification *)notification {
    __weak typeof(self) weakSelf = self;
<<<<<<< HEAD
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [weakSelf.bottomView.awslider.playSlider setValue:0.0 animated:YES];
=======
#if awbug
    NSLog(@"moviePlayerDidEnd -- Texting");
#endif
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [weakSelf.bottomView.playSlider setValue:0.0 animated:YES];
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
        weakSelf.bottomView.playBtn.selected = NO;
    }];
}
#pragma mark - 播放进度
- (void)updateProgress:(UISlider *)slider{
    [self.player seekToTime:CMTimeMakeWithSeconds(slider.value, NSEC_PER_SEC)];
}
<<<<<<< HEAD

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
=======
/**
 *  更新缓存进度
 */
-(void)updateVideoAvailable {
    CMTime playerDuration = [self playerItemDuration];
    double duration = CMTimeGetSeconds(playerDuration);
    //    self.bottomView.awslider.playSlider.value = ;// this is a UIProgressView
    self.bottomView.cacheView.progress=_videoAvailable/duration;
    //    NSLog(@"%f-%f",_videoAvailable/duration,duration);
    //    NSLog(@"%f-%f",self.bottomView.awslider.playSlider.value,self.bottomView.awslider.cacheView.progress);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
#if awbug
    NSLog(@"context -- Texting");
#endif
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    /* AVPlayerItem "status" property value observer. */
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
//        NSLog(@"loadedTimeRanges");
        AVPlayerItem* playerItem = (AVPlayerItem*)object;
        NSArray* times = playerItem.loadedTimeRanges;
        NSValue* value=nil;
        if (times.count>0) {
            // there is only ever one NSValue in the array
            value = [times objectAtIndex:0];
        }
        
        CMTimeRange range;
        [value getValue:&range];
        float start = CMTimeGetSeconds(range.start);
        float duration = CMTimeGetSeconds(range.duration);
        
        _videoAvailable = start + duration; // this is a float property of my VC
        [self performSelectorOnMainThread:@selector(updateVideoAvailable) withObject:nil waitUntilDone:NO];

    }else if ([keyPath isEqualToString:@"status"])
    {
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status)
        {
                /* Indicates that the status of the player is not yet known because
                 it has not tried to load new media resources for playback */
            case AVPlayerStatusUnknown:
                
                break;
            case AVPlayerStatusReadyToPlay:
            {
                /* Once the AVPlayerItem becomes ready to play, i.e.
                 [playerItem status] == AVPlayerItemStatusReadyToPlay,
                 its duration can be fetched from the item. */
                if (CMTimeGetSeconds(self.player.currentItem.duration)) {
<<<<<<< HEAD
                    self.bottomView.awslider.playSlider.maximumValue = CMTimeGetSeconds(self.player.currentItem.duration);
=======
                    self.bottomView.playSlider.maximumValue = CMTimeGetSeconds(self.player.currentItem.duration);
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
                }
                
                [self initTimer];
                if (self.durationTimer==nil) {
                    self.durationTimer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(finishedPlay) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
                }
                //5s dismiss bottomView
                if (self.autoDismissTimer==nil) {
                    self.autoDismissTimer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(autoDismissBottomView:) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop] addTimer:self.autoDismissTimer forMode:NSDefaultRunLoopMode];
                }
            }
                break;
            case AVPlayerStatusFailed:
                break;
        }
    }else if ([keyPath isEqualToString:@"value"]){
<<<<<<< HEAD
        if (self.bottomView.awslider.playSlider.value>=[self duration]) {
            self.forwardView.progressView.progress=1;
            self.bottomView.awslider.loadTimeLabel.text=[self convertTime:[self duration]];
            self.forwardView.progressLabel.text=[NSString stringWithFormat:@"%@/%@",self.bottomView.awslider.loadTimeLabel.text,self.bottomView.awslider.durationLabel.text];
        }else{
            self.forwardView.progressView.progress=self.bottomView.awslider.playSlider.value/[self duration];
            self.bottomView.awslider.loadTimeLabel.text=[self convertTime:self.bottomView.awslider.playSlider.value];
            self.forwardView.progressLabel.text=[NSString stringWithFormat:@"%@/%@",self.bottomView.awslider.loadTimeLabel.text,self.bottomView.awslider.durationLabel.text];
        }
    }
    
}
#pragma mark
#pragma mark - 单击手势方法
- (void)handleSingleTap{
    NSLog(@"handleSingleTap");

    [UIView animateWithDuration:0.5 animations:^{
        if (self.bottomView.alpha == 0.0) {
            self.bottomView.alpha = 1.0;
            self.closeBtn.alpha = 1.0;
        }else{
            self.bottomView.alpha = 0.0;
            self.closeBtn.alpha = 0.0;
        }
    } completion:^(BOOL finish){
        [self sendSubviewToBack:self.forwardView];
        if (self.player.rate==0.0&&self.isMoved) {
            [self updateProgress:self.bottomView.awslider.playSlider];
            [self isPlay:self.bottomView.playBtn];
        }
        self.isMoved=NO;
        self.isVolume=NO;
    }];
}
#pragma mark
#pragma mark - 双击手势方法
- (void)handleDoubleTap{
    NSLog(@"handleDoubleTap");
//    self.bottomView.playBtn.selected = !self.bottomView.playBtn.selected;
    [self isPlay:self.bottomView.playBtn];
//    if (self.player.rate != 1.f) {
//        if ([self currentTime] == self.duration)
//            [self setCurrentTime:0.f];
//        [self isPlay:self.bottomView.playBtn];
//    } else {
//        [self.player pause];
//    }
=======

        if (self.bottomView.playSlider.value>=[self duration]) {
            self.forwardView.progressView.progress=1;
            self.bottomView.loadTimeLabel.text=[self convertTime:[self duration]];
            self.forwardView.progressLabel.text=[NSString stringWithFormat:@"%@/%@",self.bottomView.loadTimeLabel.text,self.bottomView.durationLabel.text];
        }else{
            self.forwardView.progressView.progress=self.bottomView.playSlider.value/[self duration];
            self.bottomView.loadTimeLabel.text=[self convertTime:self.bottomView.playSlider.value];
            self.forwardView.progressLabel.text=[NSString stringWithFormat:@"%@/%@",self.bottomView.loadTimeLabel.text,self.bottomView.durationLabel.text];
        }
    }else if ([keyPath isEqualToString:@"selected"]){
        __weak typeof(self) weakSelf = self;
        
        if (self.bottomView.fullScreenBtn.selected) {
            if (!self.isFullscreen) return;
#if awbug
            [self.bottomView removeConstraints:self.cb2];
            [self.bottomView removeConstraints:self.cb3];
            
            if (self.tt.count) {
                [self addConstraints:self.tt];
                [self addConstraints:self.hh];
                [self addConstraints:self.ftt];
                [self addConstraints:self.fhh];
                return;
            }
            
            UIView *bottomView=self.bottomView;
            NSDictionary *mb=@{@"mariginb":@(weakSelf.frame.size.width-40),@"width":@((weakSelf.frame.size.width-120)/2),@"height":@((weakSelf.frame.size.height-120)/2),@"hh":@(weakSelf.frame.size.height)};
            NSString *t=@"V:|-mariginb-[bottomView]-0-|";
            NSString *h=@"|-0-[bottomView(hh)]-0@750-|";
            NSArray *tt=[NSLayoutConstraint constraintsWithVisualFormat:t options:0 metrics:mb views:@{@"bottomView":bottomView}];
            NSArray *hh=[NSLayoutConstraint constraintsWithVisualFormat:h options:0 metrics:mb views:@{@"bottomView":bottomView}];
            [self addConstraints:tt];
            [self addConstraints:hh];

            UIView *forwardView=self.forwardView;
            NSString *ft=@"V:|-width-[forwardView]-width-|";
            NSString *fh=@"|-height-[forwardView]-height-|";
            NSArray *ftt=[NSLayoutConstraint constraintsWithVisualFormat:ft options:0 metrics:mb views:@{@"forwardView":forwardView}];
            NSArray *fhh=[NSLayoutConstraint constraintsWithVisualFormat:fh options:0 metrics:mb views:@{@"forwardView":forwardView}];
            [self addConstraints:ftt];
            [self addConstraints:fhh];
            
            self.tt=tt;
            self.hh=hh;
            self.ftt=ftt;
            self.fhh=fhh;
#else
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(weakSelf.frame.size.width-40);
                make.left.equalTo(weakSelf.mas_top);
//                make.right.equalTo(weakSelf.mas_top);
                make.width.mas_equalTo(weakSelf.frame.size.height);
                make.height.equalTo(@40);
            }];
            [self.forwardView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(weakSelf.mas_left).offset((weakSelf.frame.size.height-120)/2);
                make.top.mas_equalTo(weakSelf.mas_top).offset((weakSelf.frame.size.width-120)/2);
                make.width.equalTo(@120);
                make.height.equalTo(@70);
            }];
#endif
        }else {

#if awbug
            if (self.tt.count) {
                [self removeConstraints:self.tt];
                [self removeConstraints:self.hh];
                [self removeConstraints:self.ftt];
                [self removeConstraints:self.fhh];
            }
            //添加bottomview约束
            [self addConstraints:self.cb2];
            [self addConstraints:self.cb3];
            //添加forwardview约束
            [self addConstraint:self.cs1];
            [self addConstraint:self.cs2];
            [self addConstraints:self.cs3];
            [self addConstraints:self.cs4];
            
#else
            [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(weakSelf);
                make.height.equalTo(@40);
                make.bottom.equalTo(weakSelf.mas_bottom);
            }];
            [self.forwardView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.centerY.equalTo(weakSelf);
            }];
#endif
        }
    }
}

#pragma mark finishedPlay
/**
 *  播放结束回调，发送通知 @"finishedPlay"
 */
- (void)finishedPlay{
#if awbug
        NSLog(@"finishedPlay -- Texting");
#endif
    if (self.currentTime == self.duration&&self.player.rate==.0f) {
        if (self.bottomView.playSlider.value != self.bottomView.playSlider.maximumValue) {
            [self updateProgress:self.bottomView.playSlider];
        }
        self.bottomView.playBtn.selected = YES;
        //播放完成后的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedPlay" object:self.durationTimer];
        [self.durationTimer invalidate];
        self.durationTimer = nil;
    }
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
}

#pragma mark
#pragma mark autoDismissBottomView
-(void)autoDismissBottomView:(NSTimer *)timer{
<<<<<<< HEAD
    
=======
#if awbug
    NSLog(@"autoDismissBottomView");
#endif
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    if (self.player.rate==.0f&&self.currentTime != self.duration) {//暂停状态
        //        if (self.bottomView.alpha == 0.0) {
        //
        //        }else{
        //            self.bottomView.alpha = 1.0;
        //        }
    }else if(self.player.rate==1.0f){
        if (self.bottomView.alpha==1.0) {
            [UIView animateWithDuration:0.5 animations:^{
                self.bottomView.alpha = 0.0;
                self.closeBtn.alpha = 0.0;
            } completion:^(BOOL finish){
                
            }];
        }
    }
}
#pragma  maik - 定时器
/**
<<<<<<< HEAD
 *  定时器，定时修改awslider播放工具栏的值
 */
-(void)initTimer{
    double interval = .1f;
    
=======
 *  定时器，定时修改slider播放工具栏的值
 */
-(void)initTimer{
    double interval = .1f;
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration))
    {
        return;
    }
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration))
    {
<<<<<<< HEAD
        CGFloat width = CGRectGetWidth([self.bottomView.awslider bounds]);
        interval = 0.5f * duration / width;
    }
    NSLog(@"interva === %f",interval);
    
    __weak typeof(self) weakSelf = self;
    
    [weakSelf.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(interval, NSEC_PER_SEC)  queue:NULL /* If you pass NULL, the main queue is used. */ usingBlock:^(CMTime time){
=======
        CGFloat width = CGRectGetWidth([self.bottomView bounds]);
        interval = 0.5f * duration / width;
    }
    __weak typeof(self) weakSelf = self;
    
    [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(interval, NSEC_PER_SEC)  queue:NULL /* If you pass NULL, the main queue is used. */ usingBlock:^(CMTime time){
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
        [weakSelf syncScrubber];
    }];
    
}
/**
<<<<<<< HEAD
 *  修改awslider的属性（播放时间、持续时间，播放进度）
 */
- (void)syncScrubber{
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration)){
        self.bottomView.awslider.playSlider.minimumValue = 0.0;
=======
 *  修改slider的属性（播放时间、持续时间，播放进度）
 */
- (void)syncScrubber{
#if awbug
    NSLog(@"syncScrubber");
#endif
    if (self.sliding) {
        return;
    }
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration)){
        self.bottomView.playSlider.minimumValue = 0.0;
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
        return;
    }
    
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration)){
<<<<<<< HEAD
        float minValue = [self.bottomView.awslider.playSlider minimumValue];
        float maxValue = [self.bottomView.awslider.playSlider maximumValue];
        double time = CMTimeGetSeconds([self.player currentTime]);
        self.bottomView.awslider.loadTimeLabel.text = [self convertTime:time];
        self.bottomView.awslider.durationLabel.text = [self convertTime:duration];
        //        NSLog(@"时间 :: %f",(maxValue - minValue) * time / duration + minValue);
        [self.bottomView.awslider.playSlider setValue:(maxValue - minValue) * time / duration + minValue];
=======
        float minValue = [self.bottomView.playSlider minimumValue];
        float maxValue = [self.bottomView.playSlider maximumValue];
        double time = CMTimeGetSeconds([self.player currentTime]);
        self.bottomView.loadTimeLabel.text = [self convertTime:time];
        self.bottomView.durationLabel.text = [self convertTime:duration];
        //        NSLog(@"时间 :: %f",(maxValue - minValue) * time / duration + minValue);
        [self.bottomView.playSlider setValue:(maxValue - minValue) * time / duration + minValue];
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    }
}
/**
 *  @return 返回当前播放item持续时间(秒)
 */
- (double)duration{
    AVPlayerItem *playerItem = self.player.currentItem;
    if (playerItem.status == AVPlayerItemStatusReadyToPlay){
        return CMTimeGetSeconds([[playerItem asset] duration]);
    }
    else{
        return 0.f;
    }
}
/**
 *  @return  返回当前播放时间（秒）
 */
- (double)currentTime{
    return CMTimeGetSeconds([[self player] currentTime]);
}
/**
 *  @return 返回当前播放item的持续时间
 */
- (CMTime)playerItemDuration{
    AVPlayerItem *playerItem = [self.player currentItem];
    //    NSLog(@"%ld",playerItem.status);
    if (playerItem.status == AVPlayerItemStatusReadyToPlay){
        return([playerItem duration]);
    }
    return(kCMTimeInvalid);
}
/**
 *  时间转换
 *
 *  @param second 秒
 *
 *  @return 把秒转换成字符串
 */
- (NSString *)convertTime:(double)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *newTime = [[self dateFormatter] stringFromDate:d];
    return newTime;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}
<<<<<<< HEAD

=======
/** 手势监听事件 */
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in event.allTouches) {
        self.firstPoint = [touch locationInView:self];
        
    }
<<<<<<< HEAD
//    UISlider *volumeSlider = (UISlider *)[self viewWithTag:1000];
//    volumeSlider.value = systemSlider.value;
=======
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in event.allTouches) {
        self.secondPoint = [touch locationInView:self];
    }
    if (fabs(self.firstPoint.y - self.secondPoint.y)>5 && self.isMoved==NO) {
<<<<<<< HEAD
        NSLog(@"y>5,声音调整");
=======
//        NSLog(@"y>5,声音调整");
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
        systemSlider.value += (self.firstPoint.y - self.secondPoint.y)/500.0;
        self.isVolume=YES;
    }else if(!self.isVolume){
        /* 监听播放状态，如果正在播放－－>>暂停 */
        if (!self.bottomView.playBtn.selected) {
            [self isPlay:self.bottomView.playBtn];
        }
        self.isMoved=YES;
<<<<<<< HEAD
        NSLog(@"进度调整");
        [self bringSubviewToFront:self.forwardView];
        self.forwardView.isForward=self.secondPoint.x>self.firstPoint.x? YES:NO;
        self.forwardTime=self.secondPoint.x-self.firstPoint.x;
        self.bottomView.awslider.playSlider.value+=self.forwardTime;
        NSLog(@"%f",self.forwardTime);
    }
    
    
//    UISlider *volumeSlider = (UISlider *)[self viewWithTag:1000];
//    volumeSlider.value = systemSlider.value;
//    if (fabs(self.firstPoint.x-self.secondPoint.x)) {
//        NSLog(@"x====%f",fabs(self.firstPoint.x-self.secondPoint.x));
//    }
=======
//        NSLog(@"进度调整");
        [self bringSubviewToFront:self.forwardView];
        self.forwardView.isForward=self.secondPoint.x>self.firstPoint.x? YES:NO;
        self.forwardTime=self.secondPoint.x-self.firstPoint.x;
        self.bottomView.playSlider.value+=self.forwardTime;
    }
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    self.firstPoint = self.secondPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.firstPoint = self.secondPoint = CGPointZero;
    [self sendSubviewToBack:self.forwardView];
    if (self.isMoved) {
<<<<<<< HEAD
        [self updateProgress:self.bottomView.awslider.playSlider];
=======
        [self updateProgress:self.bottomView.playSlider];
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
        [self isPlay:self.bottomView.playBtn];
    }
    self.isMoved=NO;
    self.isVolume=NO;
}
<<<<<<< HEAD

=======
/**
 *  移除所有事件
 */
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
-(void)removeAll{
    [self.player pause];
    [self.player cancelPendingPrerolls];
    [self.currentItem.asset cancelLoading];
<<<<<<< HEAD
    [self.player removeTimeObserver:self];
    self.autoDismissTimer = nil;
    self.durationTimer = nil;
    [self.currentItem removeObserver:self forKeyPath:@"status"];
    [self.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.bottomView.awslider.playSlider removeObserver:self forKeyPath:@"value"];
=======
//    [self.player removeTimeObserver:self];
    if (self.autoDismissTimer) {
        [self.autoDismissTimer invalidate];
        self.autoDismissTimer = nil;
    }
    if (self.durationTimer) {
        [self.durationTimer invalidate];
        self.durationTimer = nil;
    }
    [self.currentItem removeObserver:self forKeyPath:@"status"];
    [self.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.bottomView.playSlider removeObserver:self forKeyPath:@"value"];
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    self.currentItem=nil;
    self.player = nil;
}
-(void)dealloc{
<<<<<<< HEAD
    NSLog(@"dealloc");
    [self removeAll];
}

-(void)updateVideoAvailable {
    CMTime playerDuration = [self playerItemDuration];
    double duration = CMTimeGetSeconds(playerDuration);
//    self.bottomView.awslider.playSlider.value = ;// this is a UIProgressView
    self.bottomView.awslider.cacheView.progress=_videoAvailable/duration;
    NSLog(@"%f-%f",_videoAvailable/duration,duration);
//    NSLog(@"%f-%f",self.bottomView.awslider.playSlider.value,self.bottomView.awslider.cacheView.progress);
}


@end


=======
    [self removeAll];
}
@end

>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
@implementation BottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //_playBtn
        UIButton *playBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        playBtn.showsTouchWhenHighlighted = YES;
<<<<<<< HEAD
//        [playBtn addTarget:self action:@selector(isPlay:) forControlEvents:UIControlEventTouchUpInside];
=======
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
        [playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateSelected];
        [self addSubview:playBtn];
        self.playBtn =playBtn;
<<<<<<< HEAD

        AWSlider *awslider=[[AWSlider alloc]init];
        [self addSubview:awslider];
        [playBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [awslider setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSString *cpbV=@"V:|-0-[playBtn(40)]-0-|";
        NSArray *cpbv1=[NSLayoutConstraint constraintsWithVisualFormat:cpbV options:0 metrics:nil views:@{@"playBtn":playBtn}];
        [self addConstraints:cpbv1];
        
        NSString *awV=@"V:|-0-[awslider]-0-|";
        NSArray *awV1=[NSLayoutConstraint constraintsWithVisualFormat:awV options:0 metrics:nil views:@{@"awslider":awslider}];
        [self addConstraints:awV1];
        
        self.awslider=awslider;
        [self.awslider.playSlider addTarget:self action:@selector(updateProgress:) forControlEvents:UIControlEventTouchUpInside];
        
        //_fullScreenBtn
        UIButton *fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fullScreenBtn.showsTouchWhenHighlighted = YES;
        [fullScreenBtn setImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
        [fullScreenBtn setImage:[UIImage imageNamed:@"nonfullscreen"] forState:UIControlStateSelected];
        [fullScreenBtn addTarget:self action:@selector(fullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fullScreenBtn];
        self.fullScreenBtn=fullScreenBtn;
        [fullScreenBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSString *fsbV=@"V:|-0-[fullScreenBtn]-0-|";
        NSArray *fsbVV=[NSLayoutConstraint constraintsWithVisualFormat:fsbV options:0 metrics:nil views:@{@"fullScreenBtn":fullScreenBtn}];
        [self addConstraints:fsbVV];
        
        NSString *awh=@"|-0-[playBtn(40)]-0-[awslider]-[fullScreenBtn(45)]-0-|";
        NSArray *awhh=[NSLayoutConstraint constraintsWithVisualFormat:awh options:0 metrics:nil views:@{@"playBtn":playBtn,@"awslider":awslider,@"fullScreenBtn":fullScreenBtn}];
        [self addConstraints:awhh];
    }
    return self;
}

-(void)fullScreenAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    //用通知的形式把点击全屏的时间发送到app的任何地方，方便处理其他逻辑
    [[NSNotificationCenter defaultCenter] postNotificationName:fullScreenNotification object:sender];
}

@end

@implementation AWSlider

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
=======
        
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
        UILabel *loadTime=[[UILabel alloc]init];
        UILabel *duration=[[UILabel alloc]init];
        [self addSubview:loadTime];
        [self addSubview:duration];
        loadTime.textAlignment = NSTextAlignmentRight;
        duration.textAlignment = NSTextAlignmentRight;
        loadTime.textColor =[UIColor whiteColor];
        duration.textColor=[UIColor whiteColor];
        loadTime.font = [UIFont systemFontOfSize:11];
        duration.font = [UIFont systemFontOfSize:11];
<<<<<<< HEAD
=======
        loadTime.text=@"00:00";
        duration.text=@"00:00";
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
        
        UISlider *slider=[[UISlider alloc]init];
        [self addSubview:slider];
        
<<<<<<< HEAD
        loadTime.text=@"00:00";
        duration.text=@"00:00";
        self.loadTimeLabel=loadTime;
        self.durationLabel=duration;
        self.playSlider=slider;
        slider.value=0.0;
        [slider setThumbImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        [slider setMinimumTrackTintColor:[UIColor colorWithRed:62/255.0 green:115/255.0 blue:251/255.0 alpha:0.8]];
        [slider setMaximumTrackTintColor:[UIColor clearColor]];
        [slider setContinuous:YES];
        [slider setHighlighted:YES];
  
        // create a UIView that u can access and make it the shadow of your slider
        UIProgressView *cacheView=[[UIProgressView alloc]init];
        cacheView.progress=0.0;
        cacheView.progressTintColor=[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
//        cacheView.progressTintColor=[UIColor redColor];
        cacheView.trackTintColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [slider addSubview:cacheView];
        //        [slider sendSubviewToBack:cacheView];
        self.cacheView=cacheView;
        // 3
       
        
    }
    return self;
}
-(void)updateSliderWith:(float) currentTime durationTime:(float)duration {
    
    static float i=0;
    i=i+0.1;
    currentTime=i;
    duration=i+0.2;
    if (currentTime>=1) {
        currentTime=1;
    }
    if (duration>=1) {
        duration=1;
    }
    NSLog(@"%.2f,%.2f",currentTime,duration);
    // Update the slider about the music time
    self.playSlider.value=currentTime;
    self.cacheView.progress=duration;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width=self.frame.size.width;
    CGFloat height=self.frame.size.height;
    self.loadTimeLabel.frame=CGRectMake(0, 0, 40, height);
    self.playSlider.frame=CGRectMake(40, 0, width-80, height);
    self.durationLabel.frame=CGRectMake(width-40, 0, 40, height);
    self.cacheView.frame=CGRectMake(2, 19,width-95, height);
}

=======
        slider.value=0.0;
        [slider setThumbImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        [slider setMinimumTrackTintColor:[UIColor colorWithRed:134/255.0 green:200/255.0 blue:250/255.0 alpha:1.0]];
        [slider setMaximumTrackTintColor:[UIColor clearColor]];
        [slider setContinuous:YES];
        [slider setHighlighted:YES];
        
        // create a UIView that u can access and make it the shadow of your slider
        UIProgressView *cacheView=[[UIProgressView alloc]init];
        cacheView.progress=0.0;
        cacheView.progressTintColor=[UIColor lightGrayColor];
        cacheView.trackTintColor=[UIColor lightTextColor];
        [slider addSubview:cacheView];
        //        [slider sendSubviewToBack:cacheView];
        [cacheView setTranslatesAutoresizingMaskIntoConstraints:NO];
        //        [cacheView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.right.top.bottom.equalTo(slider);
        //        }];
        NSString *ch=@"|-0-[cacheView]-0-|";
        NSString *cv=@"V:|-20-[cacheView(2)]-(>=0)-|";
        NSArray *chh=[NSLayoutConstraint constraintsWithVisualFormat:ch options:0 metrics:nil views:@{@"cacheView":cacheView}];
        NSArray *cvv=[NSLayoutConstraint constraintsWithVisualFormat:cv options:0 metrics:nil views:@{@"cacheView":cacheView}];
        [slider addConstraints:chh];
        [slider addConstraints:cvv];
        
        //_fullScreenBtn
        UIButton *fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fullScreenBtn.showsTouchWhenHighlighted = YES;
        [fullScreenBtn setImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
        [fullScreenBtn setImage:[UIImage imageNamed:@"nonfullscreen"] forState:UIControlStateSelected];
        [fullScreenBtn addTarget:self action:@selector(fullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fullScreenBtn];
        
        [playBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [loadTime setTranslatesAutoresizingMaskIntoConstraints:NO];
        [slider setTranslatesAutoresizingMaskIntoConstraints:NO];
        [duration setTranslatesAutoresizingMaskIntoConstraints:NO];
        [fullScreenBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSString *bh=@"|-0-[playBtn(40)]-0-[loadTime(40)]-5-[slider]-0-[duration(40)]-0-[fullScreenBtn(45)]-0-|";
        
        NSString *bpv=@"V:|-0-[playBtn]-0-|";
        NSString *blv=@"V:|-0-[loadTime]-0-|";
        NSString *bsv=@"V:|-0-[slider]-0-|";
        NSString *bdv=@"V:|-0-[duration]-0-|";
        NSString *fsbV=@"V:|-0-[fullScreenBtn]-0-|";
        NSArray *bp=[NSLayoutConstraint constraintsWithVisualFormat:bpv options:0 metrics:nil views:@{@"playBtn":playBtn}];
        NSArray *bl=[NSLayoutConstraint constraintsWithVisualFormat:blv options:0 metrics:nil views:@{@"loadTime":loadTime}];
        NSArray *bs=[NSLayoutConstraint constraintsWithVisualFormat:bsv options:0 metrics:nil views:@{@"slider":slider}];
        NSArray *bd=[NSLayoutConstraint constraintsWithVisualFormat:bdv options:0 metrics:nil views:@{@"duration":duration}];
        NSArray *fsbVV=[NSLayoutConstraint constraintsWithVisualFormat:fsbV options:0 metrics:nil views:@{@"fullScreenBtn":fullScreenBtn}];
        
        NSArray *awhh=[NSLayoutConstraint constraintsWithVisualFormat:bh options:0 metrics:nil views:@{@"playBtn":playBtn,@"loadTime":loadTime,@"slider":slider,@"duration":duration,@"fullScreenBtn":fullScreenBtn}];
        [self addConstraints:bp];
        [self addConstraints:bl];
        [self addConstraints:bs];
        [self addConstraints:bd];
        [self addConstraints:fsbVV];
        [self addConstraints:awhh];
        
        self.loadTimeLabel=loadTime;
        self.durationLabel=duration;
        self.playSlider=slider;
        self.cacheView=cacheView;
        self.fullScreenBtn=fullScreenBtn;
    }
    return self;
}
-(void)fullScreenAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    //用通知的形式把点击全屏的时间发送到app的任何地方，方便处理其他逻辑
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fullScreenNotification" object:sender];
}
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
@end

@interface ForwardView ()
@property (nonatomic, weak) UILabel *forwardLabel;
@end

@implementation ForwardView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UILabel *forwardLabel=[[UILabel alloc]init];
<<<<<<< HEAD
        forwardLabel.textColor=[UIColor whiteColor];
        forwardLabel.textAlignment=NSTextAlignmentCenter;
=======
        forwardLabel.textAlignment=NSTextAlignmentCenter;
        forwardLabel.textColor=[UIColor whiteColor];
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
        [self addSubview:forwardLabel];
        UILabel *label=[[UILabel alloc]init];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:12.0];
        label.textColor=[UIColor whiteColor];
        [self addSubview:label];
        
        self.forwardLabel=forwardLabel;
        self.progressLabel=label;
        
        UIProgressView *progressView=[[UIProgressView alloc]init];
        [self addSubview:progressView];
        self.progressView=progressView;
<<<<<<< HEAD
        
        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
=======
        self.alpha=0.6;
        self.backgroundColor=[UIColor blackColor];
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
        self.frame=CGRectMake(0, 0, 120, 70);
        self.layer.cornerRadius=5;
        
        [forwardLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        [progressView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
<<<<<<< HEAD
        NSString *ft=@"V:|-10-[forwardLabel]-0-[label]-0-[progressView]-10-|";
=======
        NSString *ft=@"V:|-10-[forwardLabel]-[label]-[progressView(2)]-10-|";
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
        NSString *fh=@"|-0-[forwardLabel]-0-|";
        NSString *ph=@"|-0-[label]-0-|";
        NSString *pvh=@"|-0-[progressView]-0-|";
        NSArray *ftt=[NSLayoutConstraint constraintsWithVisualFormat:ft options:0 metrics:nil views:@{@"forwardLabel":forwardLabel,@"label":label,@"progressView":progressView}];
        
        NSArray *fhh=[NSLayoutConstraint constraintsWithVisualFormat:fh options:0 metrics:nil views:@{@"forwardLabel":forwardLabel}];
        NSArray *phh=[NSLayoutConstraint constraintsWithVisualFormat:ph options:0 metrics:nil views:@{@"label":label}];
        NSArray *pvhh=[NSLayoutConstraint constraintsWithVisualFormat:pvh options:0 metrics:nil views:@{@"progressView":progressView}];
        
        [self addConstraints:ftt];
        [self addConstraints:fhh];
        [self addConstraints:phh];
        [self addConstraints:pvhh];
    }
    return self;
}
-(void)setIsForward:(BOOL)isForward{
    _isForward=isForward;
    if (isForward) {
        self.forwardLabel.text=@">>";
    }else{
        self.forwardLabel.text=@"<<";
    }
}
<<<<<<< HEAD
@end
=======
@end

>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
