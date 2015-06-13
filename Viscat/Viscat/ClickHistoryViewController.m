//
//  ClickHistoryViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 18/05/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "ClickHistoryViewController.h"
#import "CustomTableViewCell.h"
#import "SingletonClass.h"
#import "WebViewViewController.h"
#import "AppDelegate.h"

@interface ClickHistoryViewController ()
{
    CGSize windowSize;
    NSMutableArray * title,* visitors,* dateTime,*retailerId;
    WebViewViewController * webviewVC;
    UILabel * titleLbl;
    UIImageView * alertView;
    
}
@end

@implementation ClickHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    title=[[NSMutableArray alloc]init];
    visitors=[[NSMutableArray alloc]init];
    dateTime=[[NSMutableArray alloc]init];
    retailerId=[[NSMutableArray alloc]init];
 self.view.backgroundColor=[UIColor whiteColor];
    windowSize=[UIScreen mainScreen].bounds.size;
    self.activityLoad=[[UIActivityIndicatorView alloc]init];
    self.activityLoad.frame=CGRectMake(windowSize.width/2-20, windowSize.height/2-100, 40, 40);
    self.activityLoad.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    self.activityLoad.alpha=1.0f;
    self.activityLoad.color=[UIColor blackColor];
    [self.view addSubview:self.activityLoad];
    [self.activityLoad startAnimating];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadUI) name:@"clickHistory" object:nil];
    [self loadUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)loadUI{
     [alertView removeFromSuperview];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
         if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {
             [self getClickHistoryData ];
         }
         else{
             UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"인터넷 연결을 확인하시기 바랍니다" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
             [alert show];
             [self.activityLoad stopAnimating];
             if (alertView) {
                 alertView=nil;
             }
             alertView=[[UIImageView alloc]initWithFrame:CGRectMake(windowSize.width/2-30, 150, 50, 50)];
             alertView.image=[UIImage imageNamed:@"notice480x800.png"];
             [self.view addSubview:alertView];
         }
        dispatch_async(dispatch_get_main_queue(),^{
            [self createUI];
        });
    });
}


#pragma mark- createUI

-(void)createUI{
    if (titleLbl) {
        titleLbl=nil;
    }
   titleLbl =[[UILabel alloc]init];
    titleLbl.frame=CGRectMake(20, 0, 60, 30);
    titleLbl.text=@"내역 클릭";
    titleLbl.textColor=[UIColor blackColor];
    titleLbl.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:titleLbl];
   
    if (clickHistory) {
        clickHistory=nil;
    }
    clickHistory=[[UITableView alloc]init];
    clickHistory.frame=CGRectMake(0, 55, windowSize.width, windowSize.height-150);
    clickHistory.delegate=self;
    clickHistory.dataSource=self;
    [self.view addSubview:clickHistory];
    
    UIView * sectionView=[[UIView alloc]init];
    sectionView.frame=CGRectMake(0, 0, clickHistory.frame.size.width, 40);
    sectionView.backgroundColor=[UIColor colorWithRed:(CGFloat)68/255 green:(CGFloat)161/255 blue:(CGFloat) 224/255 alpha:(CGFloat)1.0];
    clickHistory.tableHeaderView=sectionView;
    
    UILabel * dateLbl=[[UILabel alloc]init];
    dateLbl.frame=CGRectMake(25, 5, 50, 30);
    dateLbl.text=@"Store";
    dateLbl.textColor=[UIColor whiteColor];
    dateLbl.textAlignment=NSTextAlignmentCenter;
    dateLbl.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:dateLbl];
    
    UILabel * phoneLbl=[[UILabel alloc]init];
    phoneLbl.frame=CGRectMake(windowSize.width/2-60+10, 5, 50, 30);
    phoneLbl.text=@"Vistors";
    phoneLbl.textColor=[UIColor whiteColor];
    phoneLbl.font=[UIFont systemFontOfSize:10];
     dateLbl.textAlignment=NSTextAlignmentCenter;
    [sectionView addSubview:phoneLbl];
    
    UILabel * Lbl3=[[UILabel alloc]init];
    Lbl3.frame=CGRectMake(windowSize.width/2-60+20+40, 5, 80, 30);
    Lbl3.text=@"Last Visited";
    Lbl3.textColor=[UIColor whiteColor];
    Lbl3.font=[UIFont systemFontOfSize:10];
     dateLbl.textAlignment=NSTextAlignmentCenter;
    [sectionView addSubview:Lbl3];
    
    UILabel * processedLbl=[[UILabel alloc]init];
    processedLbl.frame=CGRectMake(windowSize.width-70, 5, 110, 30);
    processedLbl.text=@"goto store";
    processedLbl.textColor=[UIColor whiteColor];
    processedLbl.font=[UIFont systemFontOfSize:10];
     dateLbl.textAlignment=NSTextAlignmentCenter;
    [sectionView addSubview:processedLbl];
    
    UIView * footer=[[UIView alloc]init];
    footer.frame=CGRectMake(0, 0, windowSize.width, 10);
    footer.backgroundColor=[UIColor clearColor];
    clickHistory.tableFooterView=footer;

    
    ////////////////////////////////////////////////////////////////////
  /*  UILabel*   bottomLbl=[[UILabel alloc]init];
    bottomLbl.frame=CGRectMake(20, windowSize.height-130, windowSize.width-40,30);
    bottomLbl.textColor=[UIColor lightGrayColor];
    bottomLbl.font=[UIFont systemFontOfSize:10];
    bottomLbl.textAlignment=NSTextAlignmentCenter;
    bottomLbl.text=@"회사소개 / 뉴스 / 규정&조건 / 개인정보보호 / 연락하기";
    [self.view addSubview:bottomLbl];
    
    UILabel * copyRight=[[UILabel alloc]init];
    copyRight.frame=CGRectMake(20, windowSize.height-110, windowSize.width-40,30);
    copyRight.textColor=[UIColor lightGrayColor];
    copyRight.font=[UIFont systemFontOfSize:10];
    copyRight.textAlignment=NSTextAlignmentCenter;
    copyRight.text=@"2014년비스켓캐시백";
    [self.view addSubview:copyRight];*/
    
}


#pragma  mark- Table Delegate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return visitors.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell * cell=(CustomTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"clickHistory"];
        [cell.gotoStore addTarget:self action:@selector(gotoStore:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.title.frame=CGRectMake(20, 0, windowSize.width/2-60, cell.contentView.frame.size.height);
    cell.visitorsLbl.frame=CGRectMake(windowSize.width/2-60+20, 5, 20, cell.contentView.frame.size.height);
    cell.DateTimeLbl.frame=CGRectMake(windowSize.width/2-60+20+40, 5, windowSize.width/2-80, cell.contentView.frame.size.height);
    cell.gotoStore.frame=CGRectMake(windowSize.width/2+80, cell.contentView.frame.size.height/2-10, 80, 15);
    if ([UIScreen mainScreen].bounds.size.height==736) {
        cell.DateTimeLbl.frame=CGRectMake(windowSize.width/2-60+20+40, 5, windowSize.width/2-100, cell.contentView.frame.size.height);
        cell.gotoStore.frame=CGRectMake(windowSize.width/2+120, cell.contentView.frame.size.height/2-10, 84, 15);
    }
    cell.title.text=[title objectAtIndex:indexPath.row];
    cell.visitorsLbl.text=[visitors objectAtIndex:indexPath.row];
    cell.DateTimeLbl.text=[dateTime objectAtIndex:indexPath.row];
    cell.gotoStore.tag=indexPath.row;
    return cell;
}


#pragma  mark- goto to store

-(void)gotoStore:(UIButton *)sender{
    
          if (webviewVC) {
            webviewVC=nil;
        }
        webviewVC=[[WebViewViewController alloc]init];
        int tag=(int)[sender tag];
    [SingletonClass sharedSingleton].webUrl=[retailerId objectAtIndex:tag];
            //webviewVC.retailerID=[retailerId objectAtIndex:tag];
    
        
        AppDelegate* appdelegate=[UIApplication sharedApplication].delegate;
        [appdelegate.window addSubview:webviewVC.view];
        //[self.navigationController pushViewController:webviewVC animated:YES];
   }


#pragma  mark- Web service

-(void)getClickHistoryData{
    
    [title removeAllObjects];
    [visitors removeAllObjects];
    [dateTime removeAllObjects];
    [retailerId removeAllObjects];
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSURL * getUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=myclickhistory&user_id=%@",[SingletonClass sharedSingleton].login_userId]];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:getUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    
    id jsonResponse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
     NSLog(@"json response of %@",jsonResponse);
    if([[jsonResponse objectForKey:@"status"]isEqualToString:@"1"])
    {
        NSMutableDictionary * dict=[NSMutableDictionary dictionary];
        NSArray * result=[jsonResponse objectForKey:@"result"];
        for (int i=0; i<result.count;i++) {
            dict=[result objectAtIndex:i];
            [title addObject:[dict objectForKey:@"title"]];
            [visitors addObject:[dict objectForKey:@"visits"]];
            [dateTime addObject:[dict objectForKey:@"last"]];
            [retailerId addObject:[dict objectForKey:@"url"]];
        }
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
