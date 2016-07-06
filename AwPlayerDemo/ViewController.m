//
//  ViewController.m
//  AwPlayerDemo
//
//  Created by yelin on 16/3/10.
//  Copyright © 2016年 yelin. All rights reserved.
//

#import "ViewController.h"
#import "AWPlayer.h"
#import <CoreMotion/CoreMotion.h>
<<<<<<< HEAD


=======
#import "Masonry.h"
#import "BottomView.h"
#import "Pslider.h"

>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
@interface ViewController ()
@property (nonatomic, weak) AWPlayer *awplayer;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) UIInterfaceOrientation orientationLast;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
    [self.view addSubview:label];
    label.text=@"-------------------label-----------------------";
    
<<<<<<< HEAD
    //http://flv2.bn.netease.com/videolib3/1603/04/CkdJX9654/SD/CkdJX9654-mobile.mp4 
    AWPlayer *awplayer=[[AWPlayer alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), self.view.frame.size.width, self.view.frame.size.width*0.75) videoURLStr:@"http://flv2.bn.netease.com/videolib3/1603/22/MpPhK6538/SD/MpPhK6538-mobile.mp4"];
    [self.view addSubview:awplayer];
    [awplayer.player pause];
    self.awplayer=awplayer;
    self.frame=awplayer.frame;
    awplayer.backgroundColor=[UIColor blackColor];

    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(awplayer.frame), self.view.frame.size.width, 30)];
    [self.view addSubview:label1];
    label1.text=@"-------------------label1-----------------------";
    self.awplayer.transform = CGAffineTransformIdentity;
    
#if Simulator
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenNotification) name:fullScreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeBtnNotification) name:closeBtnNotification object:nil];
#else
    //用于真机监听设备方向
#endif
}

=======
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), self.view.frame.size.width, self.view.frame.size.width*0.75)];
    [self.view addSubview:imageV];
    imageV.image=[UIImage imageNamed:@"mark"];
    imageV.userInteractionEnabled=YES;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [imageV addSubview:btn];
    [btn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"playbtn_bg"] forState:UIControlStateNormal];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(imageV);
        make.width.equalTo(@66);
        make.height.equalTo(@64);
    }];
    
    AWPlayer *awplayer=[[AWPlayer alloc]initWithFrame:imageV.frame videoURLStr:@"http://flv2.bn.netease.com/videolib3/1603/21/ZhrSw3353/SD/ZhrSw3353-mobile.mp4"];
    [self.view addSubview:awplayer];
    self.awplayer=awplayer;
    self.frame=awplayer.frame;
//    awplayer.backgroundColor=[UIColor blackColor];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame), self.view.frame.size.width, 30)];
    [self.view addSubview:label1];
    label1.text=@"-------------------label1-----------------------";
    self.awplayer.transform = CGAffineTransformIdentity;
    [self.view sendSubviewToBack:awplayer];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenNotification) name:fullScreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeBtnNotification) name:closeBtnNotification object:nil];
#if Simulator
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
#else
    [self initializeMotionManager];
#endif
}
/**
 *  用于真机监听设备方向
 */
- (void)initializeMotionManager{
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    self.motionManager.gyroUpdateInterval = .2;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
        if (!error) {
            [self outputAccelertionData:accelerometerData.acceleration];
        }
        else{
#if awbug
            NSLog(@"%@", error);
#endif
        }
    }];
}
- (void)outputAccelertionData:(CMAcceleration)acceleration{
    UIInterfaceOrientation orientationNew;
    if (acceleration.x >= 0.75) {
        orientationNew = UIInterfaceOrientationLandscapeLeft;
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }
    else if (acceleration.x <= -0.75) {
        orientationNew = UIInterfaceOrientationLandscapeRight;
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    }
    else if (acceleration.y <= -0.75) {
        orientationNew = UIInterfaceOrientationPortrait;
        [self toNormal];
    }
    else if (acceleration.y >= 0.75) {
        orientationNew = UIInterfaceOrientationPortraitUpsideDown;
    }
    else {
        // Consider same as last time
        return;
    }
    if (orientationNew == self.orientationLast)
        return;
    self.orientationLast = orientationNew;
}
-(void)play:(UIButton *)btn{
    if (self.awplayer) {
        [self.awplayer play];
        [self.view bringSubviewToFront:self.awplayer];
    }
    
}
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
-(void)orientationChange{
    UIDeviceOrientation orientationD = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientationD;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationUnknown:
<<<<<<< HEAD
=======
            
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
            break;
        case UIInterfaceOrientationPortrait:
            [self toNormal];
            break;
        case UIInterfaceOrientationLandscapeLeft:
            [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
            break;
        case UIInterfaceOrientationLandscapeRight:
            [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
            break;
        default:
            break;
    }
}
-(void)fullScreenNotification{
    if (self.awplayer.isFullscreen==NO) {
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        [self toNormal];
    }
}
-(void)closeBtnNotification{
<<<<<<< HEAD
    NSLog(@"closeBtnNotification--clicked");
    [self toNormal];
}

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation)orientation{
    
    UIDeviceOrientation orientationD = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientationD;
    if (interfaceOrientation!=UIInterfaceOrientationPortrait) {
        self.awplayer.transform = CGAffineTransformIdentity;
        self.awplayer.frame=self.view.frame;
        self.awplayer.bottomView.fullScreenBtn.selected=YES;
        return;
    }
    
    self.awplayer.transform = CGAffineTransformIdentity;
    
    self.awplayer.frame = CGRectMake((self.view.frame.size.width-self.view.frame.size.height)/2, -(self.view.frame.size.width-self.view.frame.size.height)/2, self.view.frame.size.height, self.view.frame.size.width);
    if (orientation==UIInterfaceOrientationLandscapeLeft) {
        self.awplayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
        
    }else if(orientation==UIInterfaceOrientationLandscapeRight){
        self.awplayer.transform = CGAffineTransformMakeRotation(M_PI_2);
        
    }
    
    self.awplayer.isFullscreen = YES;
    self.awplayer.bottomView.fullScreenBtn.selected = YES;
    [self.view bringSubviewToFront:self.awplayer];
    NSLog(@"awplayer .frame=%@\nbottomView.frame=%@",NSStringFromCGRect(self.awplayer.frame),NSStringFromCGRect(self.awplayer.bottomView.frame));
    
}

-(void)toNormal{
    self.awplayer.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.6 animations:^{
        
        self.awplayer.frame=self.frame;
        
    } completion:^(BOOL finished) {
        self.awplayer.isFullscreen=NO;
        self.awplayer.bottomView.fullScreenBtn.selected=NO;
=======
    
    if (!self.awplayer.isFullscreen) {
        [self.awplayer pause];
        [self.view sendSubviewToBack:self.awplayer];
    }else{
        [self toNormal];
    }
}

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation)orientation{
    
    UIDeviceOrientation orientationD = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientationD;
    if (interfaceOrientation!=UIInterfaceOrientationPortrait) {
        self.awplayer.transform = CGAffineTransformIdentity;
        self.awplayer.frame=self.view.frame;
        self.awplayer.playerLayer.frame=self.awplayer.bounds;
        
        __weak typeof(self.awplayer) typeSelf=self.awplayer;
        [self.awplayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(typeSelf);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(typeSelf.mas_bottom);
        }];
        
        [self.awplayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(typeSelf).offset(5);
            make.height.width.mas_equalTo(30);
        }];
        self.awplayer.bottomView.fullScreenBtn.selected=YES;
        return;
    }
    
    self.awplayer.transform = CGAffineTransformIdentity;
    
    if (orientation==UIInterfaceOrientationLandscapeLeft) {
        self.awplayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(orientation==UIInterfaceOrientationLandscapeRight){
        self.awplayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    self.awplayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.awplayer.isFullscreen = YES;
    self.awplayer.bottomView.fullScreenBtn.selected = YES;
    [self.awplayer bringSubviewToFront:self.awplayer.bottomView];
}
-(void)toNormal{
    [UIView animateWithDuration:0.6 animations:^{
        self.awplayer.transform = CGAffineTransformIdentity;
        self.awplayer.frame=self.frame;
        self.awplayer.isFullscreen=NO;
        self.awplayer.bottomView.fullScreenBtn.selected=NO;
    } completion:^(BOOL finished) {
        
>>>>>>> 6e748fc8e8da8eb46903af055442b8cd25247f45
    }];
}

@end
