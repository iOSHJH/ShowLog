//
//  ViewController.m
//  ShowLogView
//
//  Created by 黄俊煌 on 2017/7/10.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "ViewController.h"
#import "JLogView.h"

@interface ViewController ()

@property (nonatomic, assign) int num;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [JLogView saveLog];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerNum) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    JLogView *logView = [[JLogView alloc] initWithFrame:CGRectMake(20, 100, 300, 500)];
    [[UIApplication sharedApplication].keyWindow addSubview:logView];
}

- (void)timerNum {
    self.num++;
    NSLog(@"   %d",self.num);
}

// 摇一摇 显示log
//- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
//    JLogView *logView = [[JLogView alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
//    [[UIApplication sharedApplication].keyWindow addSubview:logView];
//    
//    NSLog(@"开始摇动");
//}
//
//- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
//    NSLog(@"取消摇动");
//}


@end
