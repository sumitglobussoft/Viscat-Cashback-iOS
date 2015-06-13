//
//  BalanceViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "BalanceViewController.h"
#import "BalanceCustomCell.h"
#import "SingletonClass.h"

@interface BalanceViewController ()
{
    NSString * lifeTime,*  outStanding,*rejected,* available, * oustandingCashback,* withdrawal;
    UIImageView * alertView;
}
@end

@implementation BalanceViewController

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
    
    windowSize=[UIScreen mainScreen].bounds.size;
    
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor whiteColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadUI) name:@"balanceDetail" object:nil];
   
    [alertView removeFromSuperview];
    self.activityLoad=[[UIActivityIndicatorView alloc]init];
    self.activityLoad.frame=CGRectMake(windowSize.width/2-20, windowSize.height/2-100, 40, 40);
    self.activityLoad.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    self.activityLoad.alpha=1.0f;
    self.activityLoad.color=[UIColor blackColor];
    [self.view addSubview:self.activityLoad];
    [self.activityLoad startAnimating];
    [self loadUI];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)loadUI{
    [alertView removeFromSuperview];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
           if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {
                [self callWebService];
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
}

#pragma mark- CreateUI
-(void)createUI{
    
    UILabel * title=[[UILabel alloc]init];
    title.frame=CGRectMake(20, 0, 60, 30);
    title.text=@"잔고";
    title.textColor=[UIColor blackColor];
    title.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:title];
    
    self.balanceTable=[[UITableView alloc]init];
    self.balanceTable.frame=CGRectMake(0, 55, windowSize.width, windowSize.height-50);
    self.balanceTable.delegate=self;
    self.balanceTable.dataSource=self;
    self.balanceTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.balanceTable.scrollEnabled=NO;

    [self.view addSubview:self.balanceTable];
    
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

#pragma mark-TableView delegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellIdentifier=@"cell";
    BalanceCustomCell * cell=(BalanceCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell=[[BalanceCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.containerView.frame=CGRectMake(cell.contentView.frame.origin.x, 0, windowSize.width, cell.contentView.frame.size.height);
    cell.leftLabel.frame=CGRectMake(15, 5, cell.containerView.frame.size.width/2-10, cell.containerView.frame.size.height);
    cell.rightLabel.frame=CGRectMake(cell.containerView.frame.size.width/2, 5, cell.containerView.frame.size.width/2-10, cell.containerView.frame.size.height);
    
    
    if (indexPath.row==0) {
        cell.leftLabel.text=@"평생 캐쉬백";
        cell.rightLabel.text=lifeTime;
    }
    else if (indexPath.row==1)
    {
        cell.leftLabel.text=@"처리중인 현금";
        cell.rightLabel.text=outStanding;
    }
    else if(indexPath.row==2){
        cell.leftLabel.text=@"거절된 캐쉬백";
        cell.rightLabel.text=rejected;
    }
    else if (indexPath.row==3)
    {
        cell.leftLabel.text=@"가능한 잔고";
        cell.rightLabel.text=available;
    }
    
    else if(indexPath.row==4)
    {
        cell.leftLabel.text=@"처리중인 캐쉬백";
        cell.rightLabel.text=oustandingCashback;
    }
    else
    {
        cell.leftLabel.text=@"요청된 현금인출";
        cell.rightLabel.text=withdrawal;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark- web service

-(void)callWebService{
    
    
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSURL * getUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=mybalance&user_id=%@",[SingletonClass sharedSingleton].login_userId]];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:getUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

    if ([[json objectForKey:@"status"]isEqualToString:@"1"]) {
        lifeTime=[json objectForKey:@" Lifetime cashback"];
        outStanding=[json objectForKey:@" Outstanding cash"];
        rejected=[json objectForKey:@" Rejected cashback"];
         available=[json objectForKey:@"Available Balance"];
     oustandingCashback=[json objectForKey:@"Outstanding cashback"];
        withdrawal=[json objectForKey:@"The requested cash withdrawal"];
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
