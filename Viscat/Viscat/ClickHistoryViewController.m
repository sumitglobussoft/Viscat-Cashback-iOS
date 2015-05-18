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

@interface ClickHistoryViewController ()
{
    CGSize windowSize;
}
@end

@implementation ClickHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getClickHistoryData ];
    // Do any additional setup after loading the view from its nib.
}

-(void)loadUI{
    
}


#pragma mark- createUI

-(void)createUI{
    
    clickHistory=[[UITableView alloc]init];
    clickHistory.frame=CGRectMake(0, 55, windowSize.width, windowSize.height-50);
    clickHistory.delegate=self;
    clickHistory.dataSource=self;
    [self.view addSubview:clickHistory];
    
    UIView * sectionView=[[UIView alloc]init];
    sectionView.frame=CGRectMake(0, 0, clickHistory.frame.size.width, 40);
    sectionView.backgroundColor=[UIColor colorWithRed:(CGFloat)68/255 green:(CGFloat)161/255 blue:(CGFloat) 224/255 alpha:(CGFloat)1.0];
    clickHistory.tableHeaderView=sectionView;
    
    UILabel * dateLbl=[[UILabel alloc]init];
    dateLbl.frame=CGRectMake(15, 5, 30, 30);
    dateLbl.text=@"Date";
    dateLbl.textColor=[UIColor whiteColor];
    dateLbl.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:dateLbl];
    
    UILabel * phoneLbl=[[UILabel alloc]init];
    phoneLbl.frame=CGRectMake(65, 5, 30, 30);
    phoneLbl.text=@"Phone";
    phoneLbl.textColor=[UIColor whiteColor];
    phoneLbl.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:phoneLbl];
    
    UILabel * Lbl3=[[UILabel alloc]init];
    Lbl3.frame=CGRectMake(125, 5, 30, 30);
    Lbl3.text=@"Label";
    Lbl3.textColor=[UIColor whiteColor];
    Lbl3.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:Lbl3];
    
    UILabel * processedLbl=[[UILabel alloc]init];
    processedLbl.frame=CGRectMake(180, 5, 110, 30);
    processedLbl.text=@"processed date";
    processedLbl.textColor=[UIColor whiteColor];
    processedLbl.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:processedLbl];
    
    UILabel * valueLbl=[[UILabel alloc]init];
    valueLbl.frame=CGRectMake(280, 5, 30, 30);
    valueLbl.text=@"value";
    valueLbl.textColor=[UIColor whiteColor];
    valueLbl.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:valueLbl];
    
}


#pragma  mark- Table Delegate methods




#pragma  mark- Web service

-(void)getClickHistoryData{
    
    
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
