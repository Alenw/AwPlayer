//
//  Pslider.m
//  AwPlayerDemo
//
//  Created by yelin on 16/3/22.
//  Copyright © 2016年 yelin. All rights reserved.
//

#import "Pslider.h"

@implementation Pslider

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UISlider *cacheSlider=[[UISlider alloc]init];
        cacheSlider.thumbTintColor=[UIColor orangeColor];
        cacheSlider.minimumTrackTintColor=[UIColor redColor];
        cacheSlider.maximumTrackTintColor=[UIColor blueColor];
        cacheSlider.minimumValue=0;
        cacheSlider.maximumValue=1.0;
        [self addSubview:cacheSlider];
        self.cacheSlider=cacheSlider;
//        [self sendSubviewToBack:cacheSlider];
        UISlider *normalSlider=[[UISlider alloc]init];
        [self addSubview:normalSlider];
        self.normalSlider=normalSlider;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.cacheSlider.frame=self.bounds;
    self.normalSlider.frame=self.bounds;
}

@end
