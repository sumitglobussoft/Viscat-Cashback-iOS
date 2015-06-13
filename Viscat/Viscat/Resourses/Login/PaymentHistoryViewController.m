//
//  PaymentHistoryViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "PaymentHistoryViewController.h"
#import "PaymentHistoryCustomCell.h"
#import "SingletonClass.h"

@interface PaymentHistoryViewController ()
{
    NSMutableArray * date,*refId,*confirm,*process_date,*amount;
    UIImageView * alertView;
}
@end

@implementation PaymentHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    windowSize=[UIScreen mainScreen].bounds.size;
     self.view.backgroundColor=[UIColor whiteColor];
    date=[[NSMutableArray alloc]init];
     refId=[[NSMutableArray alloc]init];
     confirm=[[NSMutableArray alloc]init];
     process_date=[[NSMutableArray alloc]init];
     amount=[[NSMutableArray alloc]init];
    [[NSNotificationCenter  defaultCenter]addObserver:self selector:@selector(loadUI) name:@"paymentHistory" object:nil];
    [self loadUI];
    [alertView removeFromSuperview];
    self.activityLoad=[[UIActivityIndicatorView alloc]init];
    self.activityLoad.frame=CGRectMake(windowSize.width/2-20, windowSize.height/2-100, 40, 40);
    self.activityLoad.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    self.activityLoad.alpha=1.0f;
    self.activityLoad.color=[UIColor blackColor];
    [self.view addSubview:self.activityLoad];
    [self.activityLoad startAnimating];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)loadUI{
     [alertView removeFromSuperview];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {
                [self callWebservice];
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
            return ;
        }
        dispatch_async(dispatch_get_main_queue(),^{
            [self.activityLoad stopAnimating];
            [self createUI];
        });
    });
   /* UILabel*   bottomLbl=[[UILabel alloc]init];
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

#pragma mark- createUI

-(void)createUI{
    
    UILabel * title=[[UILabel alloc]init];
    title.frame=CGRectMake(20, 0, 60, 30);
    title.text=@"지불 내역";
    title.textColor=[UIColor blackColor];
    title.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:title];

    
    if (self.paymentHistoryTable) {
        [self.paymentHistoryTable removeFromSuperview];
        self.paymentHistoryTable=nil;
    }
    self.paymentHistoryTable=[[UITableView alloc]init];
    self.paymentHistoryTable.frame=CGRectMake(0, 55, windowSize.width, windowSize.height-150);
    self.paymentHistoryTable.delegate=self;
    self.paymentHistoryTable.dataSource=self;
    [self.view addSubview:self.paymentHistoryTable];
    UIView * footer=[[UIView alloc]init];
    footer.frame=CGRectMake(0, 10, windowSize.width, 10);
    footer.backgroundColor=[UIColor clearColor];
    self.paymentHistoryTable.tableFooterView=footer;
    
    UIView * sectionView=[[UIView alloc]init];
    sectionView.frame=CGRectMake(0, 0, self.paymentHistoryTable.frame.size.width, 40);
    sectionView.backgroundColor=[UIColor colorWithRed:(CGFloat)68/255 green:(CGFloat)161/255 blue:(CGFloat) 224/255 alpha:(CGFloat)1.0];
    self.paymentHistoryTable.tableHeaderView=sectionView;
    
    UILabel * dateLbl=[[UILabel alloc]init];
    dateLbl.frame=CGRectMake(15, 5, 30, 30);
    dateLbl.text=@"날짜";
    dateLbl.textColor=[UIColor whiteColor];
    dateLbl.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:dateLbl];
    
    UILabel * phoneLbl=[[UILabel alloc]init];
    phoneLbl.frame=CGRectMake(windowSize.width/2-95, 5, 60, 30);
    phoneLbl.text=@"참고할 아이디";
    phoneLbl.textColor=[UIColor whiteColor];
    phoneLbl.numberOfLines=0;
    phoneLbl.lineBreakMode=NSLineBreakByWordWrapping;
    phoneLbl.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:phoneLbl];
    
    UILabel * Lbl3=[[UILabel alloc]init];
    Lbl3.frame=CGRectMake(windowSize.width/2-25, 5, 40, 30);
    Lbl3.text=@"상태";
    Lbl3.textColor=[UIColor whiteColor];
    Lbl3.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:Lbl3];
    
    UILabel * processedLbl=[[UILabel alloc]init];
    processedLbl.frame=CGRectMake(windowSize.width/2+20, 5, 110, 30);
    processedLbl.text=@"Processed On";
    processedLbl.textColor=[UIColor whiteColor];
    processedLbl.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:processedLbl];
    
    UILabel * valueLbl=[[UILabel alloc]init];
    valueLbl.frame=CGRectMake(windowSize.width/2+100, 5, 30, 30);
    valueLbl.text=@"총액";
    valueLbl.textColor=[UIColor whiteColor];
    valueLbl.textAlignment=NSTextAlignmentCenter;
    valueLbl.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:valueLbl];
    
    if ([UIScreen mainScreen].bounds.size.height==736) {
        valueLbl.frame=CGRectMake(windowSize.width/2+130, 5, 30, 30);
    }

    
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
    [self.view addSubview:copyRight];
*/
    
}

#pragma mark- table View delegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  amount.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellIdentifier=@"cell";
    
    PaymentHistoryCustomCell * cell=(PaymentHistoryCustomCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[PaymentHistoryCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.containerView.frame=CGRectMake(0, 0, windowSize.width, cell.contentView.frame.size.width);
    cell.dateLabel.frame=CGRectMake(15, 2, 35, 45);
    cell.phoneNo.frame=CGRectMake(cell.containerView.frame.size.width/2-100, 5, 80, 30);
    cell.statusView.frame=CGRectMake(cell.containerView.frame.size.width/2-20, 5, 20, 20);
    cell.processedOn.frame=CGRectMake(cell.containerView.frame.size.width/2+20, 5, 100, 30);
    cell.value.frame=CGRectMake(cell.containerView.frame.size.width/2+100, 5, 50, 30);
    if ([UIScreen mainScreen].bounds.size.height==736) {
        cell.value.frame=CGRectMake(cell.containerView.frame.size.width/-70, 5, 80, 30);
    }
    cell.dateLabel.text=[date objectAtIndex:indexPath.row];
    cell.phoneNo.text=[refId objectAtIndex:indexPath.row];
    if ([[confirm objectAtIndex:indexPath.row] isEqualToString:@"confirmed"]) {
        cell.statusView.image=[UIImage imageNamed:@"checkmark.png"];
    }
  
    cell.processedOn.text=[process_date objectAtIndex:indexPath.row];
    cell.value.text=[amount objectAtIndex:indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}



#pragma mark- Call webservice

-(void)callWebservice
{
    
    [date removeAllObjects];
    [confirm removeAllObjects];
    [refId removeAllObjects];
    [process_date removeAllObjects];
    [amount removeAllObjects];
    
    NSError * error;
    NSURLResponse * urlResponse;
    
    
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=mypayments&user_id=%@",[SingletonClass sharedSingleton].login_userId]];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@" MY Payment History response %@",json);
    if ([[json objectForKey:@"status"]isEqualToString:@"1"]) {
        NSArray * result=[json objectForKey:@"result"];
        for (int i=0; i<result.count;i++) {
            NSMutableDictionary * dict=[result objectAtIndex:i];
            [date addObject:[dict objectForKey:@"date_created"]];
            [refId addObject:[dict objectForKey:@"reference_id"]];
            [confirm addObject:[dict objectForKey:@"status"]];
            
            NSString * dateStr=[dict objectForKey:@"process_date"];
            if (![dateStr isEqual:[NSNull null]]) {
                dateStr=[dateStr substringToIndex:[dateStr length]-9];
                [process_date addObject:[dict objectForKey:@"process_date"]];
            }
            else{
                [process_date addObject:[NSString stringWithFormat:@"------"]];
            }
          
            [amount addObject:[dict objectForKey:@"amount"]];
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
