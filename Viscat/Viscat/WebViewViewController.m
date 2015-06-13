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
{
    UIImageView * alertView;
    UIView * headerView;
}
@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    windowSize=[UIScreen mainScreen].bounds.size;
    self.view.backgroundColor=[UIColor whiteColor];
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowSize.width , 55)];
    headerView.backgroundColor=[UIColor colorWithRed:(CGFloat)249/255 green:(CGFloat)117/255 blue:(CGFloat)0/255 alpha:1];
    [self.view addSubview:headerView];
    headerView.layer.shadowColor=[UIColor blackColor].CGColor;
    headerView.layer.shadowOffset=CGSizeMake(0, 5);
    headerView.layer.shadowOpacity=0.5;
    headerView.layer.shadowRadius=3;
    headerView.layer.shadowPath=[UIBezierPath bezierPathWithRect:headerView.bounds].CGPath;

    
    UIButton * back=[UIButton buttonWithType:UIButtonTypeCustom]; self.view.backgroundColor=[UIColor whiteColor];
    back.frame=CGRectMake(15, 20, 20, 20);
    [back setBackgroundImage:[UIImage imageNamed:@"reply.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    UILabel * titleLabel=[[UILabel alloc]init];
    titleLabel.frame=CGRectMake(60, 25, windowSize.width-120, 25);
    titleLabel.text=@"비스켓캐쉬백";
    titleLabel.font=[UIFont boldSystemFontOfSize:15];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:titleLabel];

    self.view.backgroundColor=[UIColor whiteColor];
    
    NSMutableAttributedString *text3 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: titleLabel.attributedText];
    
    [text3 addAttribute:NSFontAttributeName
                  value:[UIFont boldSystemFontOfSize:18]
                  range:NSMakeRange(3, 3)];
    [titleLabel setAttributedText: text3];
    [alertView removeFromSuperview];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];
    if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {
         [self createWebView];
    }
    else{
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"인터넷 연결을 확인하시기 바랍니다" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
       
        if (alertView) {
            alertView=nil;
        }
        alertView=[[UIImageView alloc]initWithFrame:CGRectMake(windowSize.width/2-30, 150, 50, 50)];
        alertView.image=[UIImage imageNamed:@"notice480x800.png"];
        [self.view addSubview:alertView];
    }

   
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeHeaderTitle" object:@"Store"];
}
#pragma mark- creat web view

-(void)createWebView{
    NSString * url;
    if (self.retailerID) {
      url  =[NSString stringWithFormat:@"http://www.addthis.com/bookmark.php?url=www.biscash.com/view_retailer.php?id=%@",self.retailerID];

    }
    else{
        url=[SingletonClass sharedSingleton].webUrl;
        url=[url stringByReplacingOccurrencesOfString:@"{USERID}" withString:[SingletonClass sharedSingleton].login_userId];
    }
   
    url =[url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    webView=[[UIWebView alloc]init];
    webView.frame=CGRectMake(0, 60, windowSize.width, windowSize.height-55);
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
