//
//  ViewController.m
//  ProgressViewTest
//
//  Created by shihao on 17/3/14.
//  Copyright © 2017年 杭州秋溢科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "DshProgressView.h"

@interface ViewController ()

@property (nonatomic)CGFloat progress;

@property (nonatomic,strong)DshProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addView];
}

- (void)addView{
    self.progressView = [[DshProgressView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.progressView];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.progress +=0.2;
    if (self.progress >1.0) {
        self.progress = 0;
    }
    [self.progressView setProgress:self.progress animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
