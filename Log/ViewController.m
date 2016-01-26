//
//  ViewController.m
//  Log
//
//  Created by pxs on 15/12/15.
//  Copyright (c) 2015年 yyMae. All rights reserved.
//

#import "ViewController.h"
//#define logPath @"/Users/pxs/Library/Developer/CoreSimulator/Devices/C9FBE4AE-C884-4254-B077-415CEE6D9FC0/data/Containers/Data/Application/DAC31559-56CE-435A-BDD7-AFCE7155C68A/Documents"
#import "FirstViewController.h"
@interface ViewController ()
@property(nonatomic,strong)UITextView *logView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    

    NSLog(@"%@: %@",NSStringFromSelector(_cmd),self);

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 100, 50);
    btn.center = CGPointMake(self.view.frame.size.width/2, 200);
    [btn setTitle:@"jumpToFVC" forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn];
//
//    UITextView *logView = [[UITextView alloc]initWithFrame:CGRectMake(10, 300, self.view.frame.size.width-20, 200)];
//
//    logView.backgroundColor = [UIColor greenColor];
//    logView.editable = NO;
//    [self.view addSubview:logView];
//    self.logView = logView;
    
    NSLog(@"信息保存了");
    
    
}

-(void)jump{
    FirstViewController *FVC=[[FirstViewController alloc]init];
    [self showDetailViewController:FVC sender:nil];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
