//
//  CashWithdrawViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 17/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "CashWithdrawViewController.h"
#import "SingletonClass.h"

@interface CashWithdrawViewController ()
{
    UILabel * balance;
    NSString * payment_methodStr,*payment_idStr,*detailStr;
    NSMutableArray * payment_id,* paymentMethod,* details;
    CGFloat height;
    UILabel  * info,*titleLbl,*passLbl;
    UITextView * detailTxtView;
    NSString * amount;
    UIImageView * alertView;
}
@end

@implementation CashWithdrawViewController


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

     self.view.backgroundColor=[UIColor whiteColor];
       windowSize =[UIScreen mainScreen].bounds.size;
    pickerViewData=[NSArray arrayWithObjects:@"PayPal",@"Wire Transfer", nil];
    // Do any additional setup after loading the view from its nib.
    payment_id=[[NSMutableArray alloc]init];
    paymentMethod=[[NSMutableArray alloc]init];
    details=[[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadUI) name:@"cashWithdraw" object:nil];
    
    [alertView removeFromSuperview];
    self.activityLoad=[[UIActivityIndicatorView alloc]init];
    self.activityLoad.frame=CGRectMake(windowSize.width/2-20, windowSize.height/2-100, 40, 40);
    self.activityLoad.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    self.activityLoad.alpha=1.0f;
    self.activityLoad.color=[UIColor blackColor];
    [self.view addSubview:self.activityLoad];
    [self.activityLoad startAnimating];
    [self loadUI];
    
}


-(void)loadUI{
    [alertView removeFromSuperview];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];
    [balance removeFromSuperview];
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {
                [self checkAvailableBalance];
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
            if (paymentMethod.count>0) {
                [self createUI];
            }
            else{
                if (titleLbl) {
                    [titleLbl removeFromSuperview];
                    titleLbl=nil;
                }
                titleLbl=[[UILabel alloc]init];
                titleLbl.frame=CGRectMake(20, 0, 60, 30);
                titleLbl.text=@"현금 인출";
                titleLbl.font=[UIFont systemFontOfSize:14];
                [self.view addSubview:titleLbl];
                
                 balance=[[UILabel alloc]initWithFrame:CGRectMake(40, windowSize.height/2-80, windowSize.width-80, 50)];
                balance.font=[UIFont systemFontOfSize:15];
                balance.text=@" 죄송하지만, 회원님은 그렇게 많은 금액을 가지고 계시지 않습니다. 요청하실수 있는 최소 총금액은 다음과 같습니다 ₩10,000.";
                balance.numberOfLines=0;
                balance.lineBreakMode=NSLineBreakByWordWrapping;
                balance.textColor=[UIColor blackColor];
                balance.textAlignment=NSTextAlignmentCenter;
                [self.view addSubview:balance];
                
               /* UILabel*   bottomLbl1=[[UILabel alloc]init];
                bottomLbl1.frame=CGRectMake(20, windowSize.height-130, windowSize.width-40,30);
                bottomLbl1.textColor=[UIColor lightGrayColor];
                bottomLbl1.font=[UIFont systemFontOfSize:10];
                bottomLbl1.textAlignment=NSTextAlignmentCenter;
                bottomLbl1.text=@"회사소개 / 뉴스 / 규정&조건 / 개인정보보호 / 연락하기";
                [self.view addSubview:bottomLbl1];
                
                UILabel * copyRight=[[UILabel alloc]init];
                copyRight.frame=CGRectMake(20, windowSize.height-110, windowSize.width-40,30);
                copyRight.textColor=[UIColor lightGrayColor];
                copyRight.font=[UIFont systemFontOfSize:10];
                copyRight.textAlignment=NSTextAlignmentCenter;
                copyRight.text=@"2014년비스켓캐시백";
                [self.view addSubview:copyRight];*/

            }
        });
    });
}
-(void)createUI{
    if (titleLbl) {
        [titleLbl removeFromSuperview];
        titleLbl=nil;
    }
    titleLbl=[[UILabel alloc]init];
    titleLbl.frame=CGRectMake(20, 0, 60, 30);
    titleLbl.text=@"현금 인출";
    titleLbl.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:titleLbl];
    
    if (topLabel) {
        [topLabel removeFromSuperview];
        topLabel=nil;
    }
    topLabel=[[UILabel alloc]init];
    topLabel.frame=CGRectMake(windowSize.width/2-140, 30, 278, 30);
    topLabel.backgroundColor=[UIColor colorWithRed:(CGFloat)92/255 green:(CGFloat)92/255 blue:(CGFloat)92/255 alpha:1.0];
    topLabel.hidden=YES;
    
    [self.view addSubview:topLabel];
    
    if (self.userText) {
        [self.userText removeFromSuperview];
        self.userText=nil;
    }
    self.userText=[[UITextField alloc]init];
    self.userText.frame=CGRectMake(windowSize.width/2-40, 80, 163, 27);
    self.userText.delegate=self;
    self.userText.layer.cornerRadius=7;
     [self.userText setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    self.userText.clipsToBounds=YES;
    
    self.userText.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.userText];
    if ([amount length]==0) {
        self.userText.placeholder=@"\u20A9 3,000.00";
    }
    else{
        self.userText.text=amount;
    }
    
    if (userName) {
        [userName removeFromSuperview];
        userName=nil;
    }
    userName=[[UILabel alloc]init];
    userName.frame=CGRectMake(40,80, 50, 25);
    userName.text=@"총액";
    userName.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:userName];
    
    
    if (self.passwordbtn) {
        [self.passwordbtn removeFromSuperview];
        self.passwordbtn=nil;
    }
    self.passwordbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.passwordbtn.frame=CGRectMake(windowSize.width/2-40, 130, 163, 27);
   
    self.passwordbtn.layer.cornerRadius=7;
    self.passwordbtn.clipsToBounds=YES;
    //[self.passwordText setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    self.passwordbtn.backgroundColor=[UIColor colorWithRed:(CGFloat)237/255 green:(CGFloat)237/255 blue:(CGFloat)237/255 alpha:1.0];
    self.passwordbtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.passwordbtn.layer.borderWidth=0.7f;
    self.passwordbtn.layer.cornerRadius=7;
    [self.passwordbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.passwordbtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [self.passwordbtn addTarget:self action:@selector(createPickerView) forControlEvents:UIControlEventTouchUpInside];
    self.passwordbtn.clipsToBounds=YES;
    if (!defaultStr) {
        defaultStr=@"--지불방법을선택하세요--";
        [self.passwordbtn setTitle:defaultStr forState:UIControlStateNormal];
    }
    else{
        [self.passwordbtn setTitle:payment_methodStr forState:UIControlStateNormal];
    }
    
    [self.view addSubview:self.passwordbtn];
    
    if (passLbl) {
        [passLbl removeFromSuperview];
        passLbl=nil;
    }
     passLbl=[[UILabel alloc]init];
    passLbl.frame=CGRectMake(40,130, 50, 25);
    passLbl.text=@"지불방법";
    passLbl.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:passLbl];
    
    if (imgView) {
        [imgView removeFromSuperview];
        imgView=nil;
    }
    imgView=[[UIImageView alloc]init];
   
    imgView.image=[UIImage imageNamed:@"divider.png"];
    [self.view addSubview:imgView];
    
    
    if (self.loginButton) {
        [self.loginButton removeFromSuperview];
        self.loginButton=nil;
    }
    self.loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
 
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"withdraw_btn.png"] forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius=7;
    [self.loginButton addTarget:self action:@selector(cashWithdrawalMethod) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.clipsToBounds=YES;
    
    [self.view addSubview:self.loginButton];
    
    UILabel*   bottomLbl1=[[UILabel alloc]init];
    bottomLbl1.frame=CGRectMake(20, windowSize.height-130, windowSize.width-40,30);
    bottomLbl1.textColor=[UIColor lightGrayColor];
    bottomLbl1.font=[UIFont systemFontOfSize:10];
    bottomLbl1.textAlignment=NSTextAlignmentCenter;
    bottomLbl1.text=@"회사소개 / 뉴스 / 규정&조건 / 개인정보보호 / 연락하기";
    [self.view addSubview:bottomLbl1];
    
    UILabel * copyRight=[[UILabel alloc]init];
    copyRight.frame=CGRectMake(20, windowSize.height-110, windowSize.width-40,30);
    copyRight.textColor=[UIColor lightGrayColor];
    copyRight.font=[UIFont systemFontOfSize:10];
    copyRight.textAlignment=NSTextAlignmentCenter;
    copyRight.text=@"2014년비스켓캐시백";
    [self.view addSubview:copyRight];
    
    
    
    
    if (self.isPayMethodSelected) {
        self.isPayMethodSelected=NO;
        info=[[UILabel alloc]initWithFrame:CGRectMake(20, 160, windowSize.width-40, height)];
        info.text=detailStr;
        info.numberOfLines=0;
        info.font=[UIFont systemFontOfSize:10];
        info.lineBreakMode=NSLineBreakByWordWrapping;
        [self.view addSubview:info];
        
         detailTxtView=[[UITextView alloc]initWithFrame:CGRectMake(windowSize.width/2-40,160+height-10, 165, 67)];
        detailTxtView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"accounts_details.png"]];
        [self.view addSubview:detailTxtView];
        imgView.frame=CGRectMake(20, windowSize.height/2+height-20,windowSize.width-40 , 1);
        self.loginButton.frame=CGRectMake(windowSize.width-80, windowSize.height/2+height-10, 42, 26);
    }
    else{
        [info removeFromSuperview];
        [detailTxtView removeFromSuperview];
        info=nil;
        detailTxtView=nil;
         imgView.frame=CGRectMake(20, windowSize.height/2-20,windowSize.width-40 , 1);
           self.loginButton.frame=CGRectMake(windowSize.width-80, windowSize.height/2-20, 42, 26);
    }
   
    
    
  //  [self layutSetting];
}





#pragma mark- pricker View
-(void)createPickerView{
    if ([self.userText.text length]!=0) {
        amount=self.userText.text;
    }
    [self.userText endEditing:YES];
    self.pickerView=[[UIPickerView alloc]init];
    self.pickerView.frame=CGRectMake(0, windowSize.height/2+20, windowSize.width, (windowSize.height/2));
    self.pickerView.backgroundColor=[UIColor whiteColor];
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    [self.view addSubview:self.pickerView];
    self.pickerView.layer.cornerRadius=5;
    
    
}
#pragma  mark- layOut setting 

-(void)layutSetting{
    if ([UIScreen mainScreen].bounds.size.height==480) {
        topLabel.frame=CGRectMake(windowSize.width/2-140, windowSize.height/2-200, 278, 30);
        
        self.userText.frame=CGRectMake(windowSize.width/2-40, windowSize.height/2-130, 163, 27);
        userName.frame=CGRectMake(40,windowSize.height/2-130, 50, 25);
        self.passwordbtn.frame=CGRectMake(windowSize.width/2-40, windowSize.height/2-90, 163, 27);
        
        imgView.frame=CGRectMake(20, windowSize.height/2,windowSize.width-40 , 1);
        
        
        self.loginButton.frame=CGRectMake(windowSize.width-80, windowSize.height/2+20, 42, 26);
        bottomLbl.frame=CGRectMake(windowSize.width/2-100, windowSize.height-130, windowSize.width-100,30);
        self.pickerView.frame=CGRectMake(0, windowSize.height/2+20, windowSize.width, windowSize.height/2);
    }
    
}

#pragma mark- TextField Delegate Methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if([self.userText.text length]!=0)
    {
        amount=self.userText.text;
    }
    [self.pickerView removeFromSuperview];
    self.pickerView=nil;
    
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([self.userText.text length]!=0)
    {
       amount=self.userText.text;
    }
   
    [textField resignFirstResponder];
    return YES;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text length]>=200) {
        return NO;
    }
    return YES;
}

#pragma mark- PickerView delegate method

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40.0f;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [paymentMethod objectAtIndex:row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return paymentMethod.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.passwordbtn setTitle:[paymentMethod objectAtIndex:row] forState:UIControlStateNormal];
      payment_methodStr=[paymentMethod objectAtIndex:row];
      payment_idStr=[payment_id objectAtIndex:row];
     detailStr=[details objectAtIndex:row];
    
    height=[self findHeight:detailStr andwidth:163];
    [self removeAllUI];
    [self.pickerView removeFromSuperview];
}

-(void)removeAllUI{
    
    [self.userText removeFromSuperview];
    [self.passwordbtn removeFromSuperview];
    self.userText=nil;
    self.passwordbtn=nil;
    [self.loginButton removeFromSuperview];
    self.loginButton=nil;
    [info removeFromSuperview];
    info=nil;
    [detailTxtView removeFromSuperview];
    detailTxtView=nil;
    [imgView removeFromSuperview];
    imgView=nil;
    self.isPayMethodSelected=YES;
    detailStr=[detailStr stringByReplacingOccurrencesOfString:@"<br />"
                                                   withString:@" "];
   

    [self createUI];
}

-(CGFloat)findHeight :(NSString *)text andwidth:(CGFloat)width{
    
    UITextView *textView = [[UITextView alloc] init];
    textView.text=text;
    CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-

-(void)checkAvailableBalance{
    
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSString * urlStr=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=mybalance&user_id=%@",[SingletonClass sharedSingleton].login_userId];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * ulr=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:ulr cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
   // NSLog(@"Balance response %@",json);
    if ([[json objectForKey:@"status"]isEqualToString:@"1"]) {
      
       NSString* available=[json objectForKey:@"Available Balance"];
        available=[available substringFromIndex:1];
        int availBalance=[available intValue];
        if (availBalance>=30000) {
            [self getPaymentMethods];
        }
       
    }

}


-(void)getPaymentMethods{
    
    [details removeAllObjects];
    [paymentMethod removeAllObjects];
    [payment_id removeAllObjects];
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSURL * ulr=[NSURL URLWithString:@"http://www.biscash.com/windex.php?method=paymentmethods"];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:ulr cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
   // NSLog(@"payment methods response %@",json);
    if ([[json objectForKey:@"status"]isEqualToString:@"1"]) {
        
        NSArray * result=[json objectForKey:@"result"];
        for (int i=0; i<result.count; i++) {
            NSMutableDictionary * dict=[result objectAtIndex:i];
            [payment_id addObject:[dict objectForKey:@"pmethod_id"]];
            [paymentMethod addObject:[dict objectForKey:@"pmethod_title"]];
            [details addObject:[dict objectForKey:@"pmethod_details"]];

        }
    }
}



-(void)cashWithdrawalMethod{
    NSError * error;
    NSURLResponse * urlResponse;
    NSString * urlStr=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=withdrawl&user_id=%@&payment_method=%@&payment_details=%@&amount=%@",[SingletonClass sharedSingleton].login_userId,payment_idStr,detailTxtView.text,amount];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * getUrl=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:getUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if ([[json objectForKey:@"status"] isEqualToString:@"1"]) {
        NSLog(@"DONE");
        NSLog(@"%@",json);
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"트랜잭션 성공" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else{
        NSLog(@"Fail");
         NSLog(@"%@",json);
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"트랜잭션 실패" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    }
   
}



-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch view] != self.pickerView)
    {
       self.pickerView.hidden=YES;
    
    self.view.userInteractionEnabled=YES;
    }
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
