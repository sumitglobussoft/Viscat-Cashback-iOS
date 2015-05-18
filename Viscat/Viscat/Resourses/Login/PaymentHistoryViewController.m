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
}
@end

@implementation PaymentHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    windowSize=[UIScreen mainScreen].bounds.size;
    
    date=[[NSMutableArray alloc]init];
     refId=[[NSMutableArray alloc]init];
     confirm=[[NSMutableArray alloc]init];
     process_date=[[NSMutableArray alloc]init];
     amount=[[NSMutableArray alloc]init];
    [[NSNotificationCenter  defaultCenter]addObserver:self selector:@selector(loadUI) name:@"paymentHistory" object:nil];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)loadUI{
    dispatch_async(dispatch_get_global_queue(0, 0),^{
            [self callWebservice];
        dispatch_async(dispatch_get_main_queue(),^{
            [self createUI];
        });
    });
}

#pragma mark- createUI

-(void)createUI{
    
    if (self.paymentHistoryTable) {
        [self.paymentHistoryTable removeFromSuperview];
        self.paymentHistoryTable=nil;
    }
    self.paymentHistoryTable=[[UITableView alloc]init];
    self.paymentHistoryTable.frame=CGRectMake(0, 55, windowSize.width, windowSize.height-50);
    self.paymentHistoryTable.delegate=self;
    self.paymentHistoryTable.dataSource=self;
    [self.view addSubview:self.paymentHistoryTable];
    
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
    phoneLbl.frame=CGRectMake(65, 5, 60, 30);
    phoneLbl.text=@"참고할 아이디";
    phoneLbl.textColor=[UIColor whiteColor];
    phoneLbl.numberOfLines=0;
    phoneLbl.lineBreakMode=NSLineBreakByWordWrapping;
    phoneLbl.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:phoneLbl];
    
    UILabel * Lbl3=[[UILabel alloc]init];
    Lbl3.frame=CGRectMake(135, 5, 40, 30);
    Lbl3.text=@"상태";
    Lbl3.textColor=[UIColor whiteColor];
    Lbl3.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:Lbl3];
    
    UILabel * processedLbl=[[UILabel alloc]init];
    processedLbl.frame=CGRectMake(180, 5, 110, 30);
    processedLbl.text=@"Processed On";
    processedLbl.textColor=[UIColor whiteColor];
    processedLbl.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:processedLbl];
    
    UILabel * valueLbl=[[UILabel alloc]init];
    valueLbl.frame=CGRectMake(280, 5, 30, 30);
    valueLbl.text=@"총액";
    valueLbl.textColor=[UIColor whiteColor];
    valueLbl.font=[UIFont systemFontOfSize:10];
    [sectionView addSubview:valueLbl];
    
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
    cell.dateLabel.frame=CGRectMake(15, 2, 30, 30);
    cell.phoneNo.frame=CGRectMake(cell.containerView.frame.size.width/2-100, 5, 80, 30);
    cell.statusView.frame=CGRectMake(cell.containerView.frame.size.width/2-20, 5, 20, 20);
    cell.processedOn.frame=CGRectMake(cell.containerView.frame.size.width/2+20, 5, 100, 30);
    cell.value.frame=CGRectMake(cell.containerView.frame.size.width/2+100, 5, 50, 30);
    
    cell.dateLabel.text=[date objectAtIndex:indexPath.row];
    cell.phoneNo.text=[refId objectAtIndex:indexPath.row];
    if ([[confirm objectAtIndex:indexPath.row] isEqualToString:@"confirmed"]) {
        cell.statusView.image=[UIImage imageNamed:@"checkmark.png"];
    }
  
    cell.processedOn.text=[process_date objectAtIndex:indexPath.row];
    cell.value.text=[amount objectAtIndex:indexPath.row];
    
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
    
    
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=getstorecashback&user_id=%@",[SingletonClass sharedSingleton].login_userId]];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"History response %@",json);
    if ([[json objectForKey:@"status"]isEqualToString:@"1"]) {
        NSArray * result=[json objectForKey:@"result"];
        for (int i=0; i<result.count;i++) {
            NSMutableDictionary * dict=[result objectAtIndex:i];
            [date addObject:[dict objectForKey:@"date_created"]];
            [refId addObject:[dict objectForKey:@"reference_id"]];
            [confirm addObject:[dict objectForKey:@"status"]];
            
            NSString * dateStr=[dict objectForKey:@"process_date"];
            dateStr=[dateStr substringToIndex:[dateStr length]-9];
            [process_date addObject:dateStr];
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
