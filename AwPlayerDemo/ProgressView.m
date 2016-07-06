//
//  ProgressView.m
//  AwPlayerDemo
//
//  Created by yelin on 16/3/22.
//  Copyright © 2016年 yelin. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UISlider *slider=[[UISlider alloc]init];
        [self addSubview:slider];
        
        [slider setThumbImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        [slider setMinimumTrackTintColor:[UIColor blueColor]];
        [slider setMaximumTrackTintColor:[UIColor clearColor]];
        [slider setContinuous:YES];
        [slider setHighlighted:YES];
        
        // create a UIView that u can access and make it the shadow of your slider
        UIProgressView *cacheView=[[UIProgressView alloc]init];
        cacheView.progress=0.0;
        cacheView.progressTintColor=[UIColor redColor];
        cacheView.trackTintColor=[UIColor lightGrayColor];
        [slider addSubview:cacheView];
        self.playSlider=slider;
        self.cacheView=cacheView;
        
        NSString *sh=@"|-0-[slider]-0-|";
        NSString *sv=@"V:|-0-[slider]-0-|";
        NSArray *shh=[NSLayoutConstraint constraintsWithVisualFormat:sh options:0 metrics:nil views:@{@"slider":slider}];
        NSArray *svv=[NSLayoutConstraint constraintsWithVisualFormat:sv options:0 metrics:nil views:@{@"slider":slider}];
        [self addConstraints:shh];
        [self addConstraints:svv];
        
    }
    return self;
}

@end
