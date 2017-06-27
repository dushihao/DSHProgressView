//
//  DshProgressView.h
//  ProgressViewTest
//
//  Created by shihao on 17/3/14.
//  Copyright © 2017年 杭州秋溢科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DshProgressView : UIView

@property (strong,nonatomic)CALayer *progressLayer;

@property (nonatomic)CGFloat progress; //进度

+ (instancetype)sharePregressView;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
@end
