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

-(void)orientationChange{
    UIDeviceOrientation orientationD = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientationD;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationUnknown:
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
    }];
}

@end
