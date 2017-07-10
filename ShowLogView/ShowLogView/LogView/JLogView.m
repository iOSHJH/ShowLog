//
//  LogView.m
//  ehome
//
//  Created by 黄俊煌 on 2017/7/6.
//  Copyright © 2017年 hongsui. All rights reserved.
//

#import "JLogView.h"

@interface JLogView ()<UIGestureRecognizerDelegate>

@property (nonatomic ,strong) UIView *keyView;
@property (nonatomic ,strong) UITextView *logView;
@property (nonatomic ,strong) UIButton *whiteSpotBtn;
@property (nonatomic, assign) CGRect rect;

@end
@implementation JLogView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rect = frame;
        [self addSubview:self.keyView];
    }
    return self;
}

-(UIView *)keyView{
    if (_keyView==nil) {
        self.keyView=[[UIView alloc]initWithFrame:self.bounds];
        self.logView=[[UITextView alloc]initWithFrame:CGRectMake(10, 15, self.keyView.frame.size.width - 10, self.keyView.frame.size.height-25)];
        [self.keyView addSubview:self.logView];
        self.keyView.userInteractionEnabled=YES;
        self.keyView.backgroundColor=[UIColor brownColor];
        self.logView.backgroundColor=[UIColor clearColor];
        self.logView.textColor=[UIColor whiteColor];
        self.logView.editable=NO;
        NSArray  *paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *filePath = [docDir stringByAppendingPathComponent:@"dr.log"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
        self.logView.text=result;
        
        [self addGestureRecognizerToView:self];
        [self timerAction];
        
        //添加一个可以关闭的按钮
        UIButton *closeBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        closeBtn.frame=CGRectMake(5, 5, 30, 15);
        closeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [closeBtn setTitle:@"❌" forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeLoggerView) forControlEvents:UIControlEventTouchUpInside];
        [self.keyView addSubview:closeBtn];
        
        // 清空log的按钮
        UIButton *removeBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        removeBtn.frame=CGRectMake(50, 5, 50, 15);
        removeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [removeBtn setTitle:@"清空" forState:UIControlStateNormal];
        [removeBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [removeBtn addTarget:self action:@selector(removeLoggerView) forControlEvents:UIControlEventTouchUpInside];
        [self.keyView addSubview:removeBtn];
        
        // 一边去
        UIButton *narrowBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        narrowBtn.frame=CGRectMake(100, 5, 80, 15);
        narrowBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [narrowBtn setTitle:@"一边去" forState:UIControlStateNormal];
        [narrowBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [narrowBtn addTarget:self action:@selector(narrowLoggerView) forControlEvents:UIControlEventTouchUpInside];
        [self.keyView addSubview:narrowBtn];
        
    }
    return _keyView;
}


//==========缩放 移动 =================
// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    // 单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [view addGestureRecognizer:tap];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}


// 单击手势
- (void)tap:(UITapGestureRecognizer *)tapgr {
    if (tapgr.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = self.rect;
        }];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}




- (void)timerAction{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(readd) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
}

-(void)readd{
    
    NSArray  *paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"dr.log"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    self.logView.text = result;
}


//关闭
-(void)closeLoggerView{
    [self removeFromSuperview];
}

// 清空log的按钮
- (void)removeLoggerView {
    [JLogView saveLog];
    [self readd];
}

// 缩小
- (void)narrowLoggerView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGFloat centerX = window.center.x + width * 0.5 + self.frame.size.width * 0.5 - 20;
    
    CGPoint point = CGPointMake(centerX, window.center.y);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.center = point;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)saveLog {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [path objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"dr.log"];
    NSString *logPath = [document stringByAppendingPathComponent:fileName];
    
    NSFileManager *defaulManager = [NSFileManager defaultManager];
    [defaulManager removeItemAtPath:logPath error:nil];
    
    // 重定向输入输出流
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}


@end
