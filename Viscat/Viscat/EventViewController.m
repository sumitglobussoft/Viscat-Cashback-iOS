//
//  EventViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 05/06/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "EventViewController.h"
#import "UIImageView+WebCache.h"
#import "SingletonClass.h"

@interface EventViewController ()
{
    NSURL * imgUrl;
}
@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    windowSize=[UIScreen mainScreen].bounds.size;
    [self loadUi];
    // Do any additional setup after loading the view.
}

-(void)createUI{
    if (eventImgView) {
        [eventImgView removeFromSuperview];
        eventImgView=nil;
    }
    eventImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, windowSize.width, windowSize.height-65)];
    [eventImgView sd_setImageWithURL:imgUrl];
    [self.view addSubview:eventImgView];
}


-(void)loadUi{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
         if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {
             [self callServiceForEvent];
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
             return ;
         }
        dispatch_async(dispatch_get_main_queue(),^{
            [self createUI];
        });
    });
}

-(void)callServiceForEvent{
    
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSURL * url=[NSURL URLWithString:@"http://www.biscash.com/windex.php?method=event"];
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    NSMutableDictionary * dict=[NSMutableDictionary dictionary];
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if ([[json objectForKey:@"status"] isEqualToString:@"1"]) {
        dict=[json objectForKey:@"result"];
        imgUrl=[dict objectForKey:@"image"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
