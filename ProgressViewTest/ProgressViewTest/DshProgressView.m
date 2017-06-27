
//
//  DshProgressView.m
//  ProgressViewTest
//
//  Created by shihao on 17/3/14.
//  Copyright © 2017年 杭州秋溢科技有限公司. All rights reserved.
//

#import "DshProgressView.h"
#import <QuartzCore/QuartzCore.h>


#define bgWidth 250
#define bgHeight 37
#define progressHeight 13-0.5

@implementation DshProgressView
{
    NSArray *_animationLayers; // 动画数组
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)sharePregressView{
    return [[UINib nibWithNibName:@"DshProgressView" bundle:nil] instantiateWithOwner:nil options:nil][0];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       // self.contentMode = UIViewContentModeScaleAspectFit;
        [self _commonInit];
    }
    return self;
}

//初始化layer
- (void)_commonInit{
        
    //进度条背景
    self.progress = 0;
    CALayer *bcLayer = [[CALayer alloc]init];
    UIImage *image = [UIImage imageNamed:@"进度条底"];
    bcLayer.contents = (__bridge id)image.CGImage;
    bcLayer.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    bcLayer.bounds = CGRectMake(0, 0, bgWidth, bgHeight);
  
    [self.layer addSublayer:bcLayer];
    
    //创建进度条
    self.progressLayer.frame = CGRectMake(13, (bgHeight-progressHeight)/2, 10, progressHeight);
    self.progressLayer.backgroundColor = [UIColor colorWithRed:252/255.0 green:204/255.0 blue:89/255.0 alpha:1].CGColor;
   // self.progressLayer.backgroundColor = [UIColor redColor].CGColor;
    self.progressLayer.cornerRadius = 8;
    [bcLayer addSublayer:self.progressLayer];
    
    //创建虚线进度条 添加到ptogressLayer
    CALayer *xuxianLayer1 = [[CALayer alloc]init];
    xuxianLayer1.contents = (__bridge id)[UIImage imageNamed:@"1"].CGImage;
    xuxianLayer1.frame = CGRectMake(0, 0, bgWidth, progressHeight);
    [self.progressLayer addSublayer:xuxianLayer1];
    
    CALayer *xuxianLayer2 = [[CALayer alloc]init];
    xuxianLayer2.contents = (__bridge id)[UIImage imageNamed:@"1"].CGImage;
    xuxianLayer2.frame = CGRectMake(0 - bgWidth, 0, bgWidth, progressHeight);
    [self.progressLayer addSublayer:xuxianLayer2];
    _animationLayers = [NSArray arrayWithObjects:xuxianLayer1,xuxianLayer2, nil];
    self.progressLayer.masksToBounds = YES;
    
    // 添加滚动动画
    [self xuxianAnimation];
    
}

- (void)xuxianAnimation{
    
    CALayer  *layer1 = _animationLayers[0];
    CALayer  *layer2 = _animationLayers[1];
    
    CABasicAnimation * animaiton = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animaiton.removedOnCompletion = NO;
    animaiton.fillMode = kCAFillModeForwards;
    animaiton.duration = 6;
    animaiton.beginTime = CACurrentMediaTime();
    animaiton.repeatCount = MAXFLOAT;
    animaiton.toValue = @(bgWidth+bgWidth/2);
    [layer1 addAnimation:animaiton forKey:nil];
    
    CABasicAnimation * animaiton2 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    animaiton2.removedOnCompletion = NO;
    animaiton2.fillMode = kCAFillModeForwards;
    animaiton2.duration = 6;
    animaiton2.beginTime = CACurrentMediaTime();
    animaiton2.repeatCount = MAXFLOAT;
    animaiton2.toValue = @(bgWidth/2);
    [layer2 addAnimation:animaiton2 forKey:nil];
  
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    
    [self.progressLayer removeAnimationForKey:@"progress"];
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
        animation.duration = fabs(self.progress - pinnedProgress) + 0.1f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.fromValue = [NSNumber numberWithFloat:self.progress];
        animation.toValue = [NSNumber numberWithFloat:pinnedProgress];
        [self.progressLayer addAnimation:animation forKey:@"progress"];
    }
    else {
        [self.progressLayer setNeedsDisplay];
    }
    NSLog(@"progress....%f",self.progress);
    
    self.progress = pinnedProgress;
}

#pragma mark = getter or setter

- (CALayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [[CALayer alloc]init];
    }
    return _progressLayer;
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    _progressLayer.frame = CGRectMake(13, (bgHeight-progressHeight)/2, (bgWidth-13-13)*_progress, progressHeight);
}


@end
