//
//  WebViewViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 21/04/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "WebViewViewController.h"
#import "SingletonClass.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    windowSize=[UIScreen mainScreen].bounds.size;
    UIButton * back=[UIButton buttonWithType:UIButtonTypeCustom];
    back.frame=CGRectMake(15, 25, 50, 25);
    [back setTitle:@"Back" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    back.titleLabel.font=[UIFont systemFontOfSize:12];
    [back addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    UILabel * titleLabel=[[UILabel alloc]init];
    titleLabel.frame=CGRectMake(windowSize.width/2-20, 25, 150, 25);
    titleLabel.text=@"Store";
    titleLabel.font=[UIFont boldSystemFontOfSize:15];
    titleLabel.textColor=[UIColor blueColor];
    [self.view addSubview:titleLabel];
    
    [self createWebView];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeHeaderTitle" object:@"Store"];
}
#pragma mark- creat web view

-(void)createWebView{
    
    NSString * url=[SingletonClass sharedSingleton].webUrl;
    url=[url stringByReplacingOccurrencesOfString:@"{USERID}" withString:[SingletonClass sharedSingleton].login_userId];
    
    webView=[[UIWebView alloc]init];
    webView.frame=CGRectMake(0, 55, windowSize.width, windowSize.height-55);
    [webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- back button action

-(void)backButtonAction{
    [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
