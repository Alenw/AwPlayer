//
//  ProgressView.h
//  AwPlayerDemo
//
//  Created by yelin on 16/3/22.
//  Copyright © 2016年 yelin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView
/** 播放进度滑块 */
@property (nonatomic, weak) UISlider *playSlider;
/** 缓存进度 */
@property (nonatomic, weak) UIProgressView *cacheView;
@end
