//
//  YYLogView.m
//  Log
//
//  Created by yyMae on 15/12/23.
//  Copyright (c) 2015年 yyMae. All rights reserved.
//  调试信息可视化(NSLog信息实时显示,可缩放,可挪动)

#import "YYLogView.h"

@interface YYLogView ()<UIGestureRecognizerDelegate>
@property (nonatomic ,strong) UIView *keyView;
@property (nonatomic ,strong) UITextView *logView;
@property (nonatomic ,strong) UIButton *whiteSpotBtn;


@end
@implementation YYLogView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.keyView];
        
    }
    return self;
}





-(UIView *)keyView{
    if (_keyView==nil) {
        self.keyView=[[UIView alloc]initWithFrame:self.bounds];
        self.logView=[[UITextView alloc]initWithFrame:CGRectMake(25, 15, self.keyView.frame.size.width-50, self.keyView.frame.size.height-30)];
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
        closeBtn.frame=CGRectMake(0, 5, 30, 15);
        closeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [closeBtn setTitle:@"❌" forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeLoggerView) forControlEvents:UIControlEventTouchUpInside];
        [self.keyView addSubview:closeBtn];
    }
    return _keyView;
}


//==========缩放 移动 =================
// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
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







@end
