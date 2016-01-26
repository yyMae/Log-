//
//  AppDelegate.m
//  Log
//
//  Created by pxs on 15/12/15.
//  Copyright (c) 2015年 yyMae. All rights reserved.
//

#import "AppDelegate.h"
#import "YYLogView.h"
@interface AppDelegate ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) YYLogView *loggerView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    [self saveLog];
    
    
    self.loggerView=[[YYLogView alloc]initWithFrame:CGRectMake(10, 80, self.window.frame.size.width-20, 200)];
    NSLog(@"调试信息可视化");
    NSLog(@"输出");

    

    
    return YES;
}



-(void)saveLog{
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [path objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"dr.log"];
    NSString *logPath = [document stringByAppendingPathComponent:fileName];
    
    NSFileManager *defaulManager = [NSFileManager defaultManager];
    [defaulManager removeItemAtPath:logPath error:nil];
    
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
}
////摇一摇
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{

    if (motion == UIEventSubtypeMotionShake) {

        [[[UIApplication sharedApplication]keyWindow]addSubview:self.loggerView];
        

    }
}




@end
