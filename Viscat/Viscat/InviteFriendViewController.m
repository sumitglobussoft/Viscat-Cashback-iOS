//
//  InviteFriendViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 23/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "InviteFriendViewController.h"
#import "SingletonClass.h"
@interface InviteFriendViewController ()
{
    UIImageView *alertView;
}
@end

@implementation InviteFriendViewController


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
    windowSize =[UIScreen mainScreen].bounds.size;
   self.view.backgroundColor=[UIColor whiteColor];
    
    [alertView removeFromSuperview];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];
    if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {
        [self createUI];
    }
    else{
        if (alertView) {
            alertView=nil;
        }
        alertView=[[UIImageView alloc]initWithFrame:CGRectMake(windowSize.width/2-30, 150, 50, 50)];
        alertView.image=[UIImage imageNamed:@"notice480x800.png"];
        [self.view addSubview:alertView];
    }

    //[self createUI];
    //[alertView removeFromSuperview];
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    if (scorllView) {
        [scorllView removeFromSuperview];
        scorllView=nil;
    }
    scorllView=[[UIScrollView alloc]init];
    scorllView.frame=CGRectMake(0, -60, windowSize.width, windowSize.height);
    [self.view addSubview:scorllView];
    if (windowSize.height==480) {
        scorllView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.3);
    }
    else{
        scorllView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.1);
    }
    
    tellFriend=[[UILabel alloc]init];
    tellFriend.frame=CGRectMake(20, 60, 150, 30);
    tellFriend.text=@"친구에게 소개하기";
    tellFriend.font=[UIFont boldSystemFontOfSize:14];
    [scorllView addSubview:tellFriend];
    
   _imageView=[[UIImageView alloc]init];
    _imageView.frame=CGRectMake(0, 90, windowSize.width, 1);
    _imageView.image=[UIImage imageNamed:@"divider.png"];
    [scorllView addSubview:_imageView];
    
    ruleOne=[[UILabel alloc]init];
    ruleOne.frame=CGRectMake(20, 95, windowSize.width/2+100, 20);
    ruleOne.text=@"친구에게비스켓 캐시백을소개하고5천원을받아보세요!";
    ruleOne.font=[UIFont systemFontOfSize:10];
    [scorllView addSubview:ruleOne];
   
    ruleTwo=[[UILabel alloc]init];
    ruleTwo.frame=CGRectMake(20, 115, windowSize.width/2+100, 20);
    ruleTwo.text=@"이메일을 입력하여친구나가족을다섯 명까지초대할수있습니다.";
    ruleTwo.font=[UIFont systemFontOfSize:10];
    [scorllView addSubview:ruleTwo];
    
    ruleThree=[[UILabel alloc]init];
    ruleThree.frame=CGRectMake(20, 135, windowSize.width/2+100, 40);
    ruleThree.text=@"초대하신분이가입을하게되면,회원님께한사람당 5천원의적립금 을드립니다 다섯명이 모두 가입하면??";
    ruleThree.font=[UIFont systemFontOfSize:10];
    ruleThree.numberOfLines=0;
    ruleThree.lineBreakMode=NSLineBreakByCharWrapping;
    [scorllView addSubview:ruleThree];
    
    UILabel * ruleFour=[[UILabel alloc]init];
    ruleFour.frame=CGRectMake(20, 155, windowSize.width/2+100, 20);
    ruleFour.text=@"";
    ruleFour.font=[UIFont systemFontOfSize:10];
    [scorllView addSubview:ruleFour];
    
    layer = [CALayer layer];
    layer.frame = CGRectMake(20, 185, windowSize.width-40, 320);
    layer.backgroundColor = [UIColor colorWithRed:(CGFloat)237/255 green:(CGFloat)248/255 blue:(CGFloat)252/255 alpha:1.0].CGColor;
    layer.borderWidth = 0.7;
    layer.borderColor = [UIColor colorWithRed:(CGFloat)237/255 green:(CGFloat)248/255 blue:(CGFloat)252/255 alpha:1.0].CGColor;
    [scorllView.layer insertSublayer:layer atIndex:0];
    
    requiredLbl1=[[UILabel alloc]init];
    requiredLbl1.frame=CGRectMake(windowSize.width/2-100, 205, 30, 20);
    requiredLbl1.text=@"*이름";
    requiredLbl1.font=[UIFont systemFontOfSize:10];
    [scorllView addSubview:requiredLbl1];
    
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: requiredLbl1.attributedText];
    
    [text addAttribute:NSForegroundColorAttributeName
                  value:[UIColor redColor]
                  range:NSMakeRange(0, 1)];
    [requiredLbl1 setAttributedText: text];

   
    requiredLbl2=[[UILabel alloc]init];
    requiredLbl2.frame=CGRectMake(windowSize.width/2+20, 205, 60, 20);
    requiredLbl2.text=@"*이메일주소";
    requiredLbl2.font=[UIFont systemFontOfSize:10];
    [scorllView addSubview:requiredLbl2];
    
    NSMutableAttributedString *text1 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: requiredLbl2.attributedText];
    
    [text1 addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(0, 1)];
    [requiredLbl2 setAttributedText: text1];

    
    self.txt1=[[UITextField alloc]init];
    self.txt1.frame=CGRectMake(windowSize.width/2-120, 235, 93, 26);
    self.txt1.backgroundColor=[UIColor whiteColor];
    self.txt1.layer.cornerRadius=7;
    self.txt1.clipsToBounds=YES;
    self.txt1.font=[UIFont systemFontOfSize:10];
    self.txt1.delegate=self;
    self.txt1.textAlignment=NSTextAlignmentCenter;
   [self.txt1 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];    [scorllView addSubview:self.txt1];
    
    self.txt2=[[UITextField alloc]init];
    self.txt2.frame=CGRectMake(windowSize.width/2-120, 265, 93, 26);
    self.txt2.backgroundColor=[UIColor whiteColor];
    self.txt2.layer.cornerRadius=7;
    self.txt2.clipsToBounds=YES;
    self.txt2.delegate=self;
    self.txt2.font=[UIFont systemFontOfSize:10];
    [self.txt2 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt2];

    
    self.txt3=[[UITextField alloc]init];
    self.txt3.frame=CGRectMake(windowSize.width/2-120, 295, 93, 26);
    self.txt3.backgroundColor=[UIColor whiteColor];
    self.txt3.layer.cornerRadius=7;
    self.txt3.clipsToBounds=YES;
    self.txt3.font=[UIFont systemFontOfSize:10];
    self.txt3.textAlignment=NSTextAlignmentCenter;
    self.txt3.delegate=self;
    [self.txt3 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt3];

    
    self.txt4=[[UITextField alloc]init];
    self.txt4.frame=CGRectMake(windowSize.width/2-120, 325, 93, 26);
    self.txt4.backgroundColor=[UIColor whiteColor];
    self.txt4.layer.cornerRadius=7;
    self.txt4.clipsToBounds=YES;
    self.txt4.font=[UIFont systemFontOfSize:10];
    self.txt4.textAlignment=NSTextAlignmentCenter;
    self.txt4.delegate=self;
   [self.txt4 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt4];
    
    self.txt5=[[UITextField alloc]init];
    self.txt5.frame=CGRectMake(windowSize.width/2-120, 355, 93, 26);
    self.txt5.backgroundColor=[UIColor whiteColor];
    self.txt5.layer.cornerRadius=7;
    self.txt5.clipsToBounds=YES;
    self.txt5.font=[UIFont systemFontOfSize:10];
    self.txt5.textAlignment=NSTextAlignmentCenter;
    self.txt5.delegate=self;
   [self.txt5 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt5];

    
    
    
    // right side textFields
    
    
    self.txt6=[[UITextField alloc]init];
    self.txt6.frame=CGRectMake(windowSize.width/2, 235, 130, 25);
    self.txt6.backgroundColor=[UIColor whiteColor];
    self.txt6.layer.cornerRadius=7;
    self.txt6.clipsToBounds=YES;
    self.txt6.font=[UIFont systemFontOfSize:10];
    self.txt6.textAlignment=NSTextAlignmentCenter;
    self.txt6.delegate=self;
    [self.txt6 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt6];

    
    self.txt7=[[UITextField alloc]init];
    self.txt7.frame=CGRectMake(windowSize.width/2, 265, 130, 25);
    self.txt7.backgroundColor=[UIColor whiteColor];
    self.txt7.layer.cornerRadius=7;
    self.txt7.clipsToBounds=YES;
    self.txt7.font=[UIFont systemFontOfSize:10];
    self.txt7.textAlignment=NSTextAlignmentCenter;
    self.txt7.delegate=self;
    [self.txt7 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt7];

    
    self.txt8=[[UITextField alloc]init];
    self.txt8.frame=CGRectMake(windowSize.width/2, 295, 130, 25);
    self.txt8.backgroundColor=[UIColor whiteColor];
    self.txt8.layer.cornerRadius=7;
    self.txt8.clipsToBounds=YES;
    self.txt8.font=[UIFont systemFontOfSize:10];
    self.txt8.textAlignment=NSTextAlignmentCenter;
    self.txt8.delegate=self;
    [self.txt8 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt8];

    
    self.txt9=[[UITextField alloc]init];
    self.txt9.frame=CGRectMake(windowSize.width/2, 325,130, 25);
    self.txt9.backgroundColor=[UIColor whiteColor];
    self.txt9.layer.cornerRadius=7;
    self.txt9.clipsToBounds=YES;
    self.txt9.font=[UIFont systemFontOfSize:10];
    self.txt9.textAlignment=NSTextAlignmentCenter;
    self.txt9.delegate=self;
    [self.txt9 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];    [scorllView addSubview:self.txt9];

    
    self.txt10=[[UITextField alloc]init];
    self.txt10.frame=CGRectMake(windowSize.width/2 , 355, 130, 25);
    self.txt10.backgroundColor=[UIColor whiteColor];
    self.txt10.layer.cornerRadius=7;
    self.txt10.clipsToBounds=YES;
    self.txt10.font=[UIFont systemFontOfSize:10];
    self.txt10.textAlignment=NSTextAlignmentCenter;
    self.txt10.delegate=self;
    [self.txt10 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt10];
    
    self.textView=[[UITextView alloc]init];
    self.textView.frame=CGRectMake(windowSize.width/2-120, 405, 253, 60);
   // self.textView.backgroundColor=[UIColor redColor];
     self.textView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"textarea_fill.png"]];
    [scorllView addSubview:self.textView];
    
    self.button=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame=CGRectMake(windowSize.width-100, 515, 80, 30);
    [self.button setBackgroundImage:[UIImage imageNamed:@"invite_btn.png"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(inviteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [scorllView addSubview:self.button];
    
    
    
//    UILabel*   bottomLbl1=[[UILabel alloc]init];
//    bottomLbl1.frame=CGRectMake(20, windowSize.height/2+270, scorllView.frame.size.width-40,30);
//    bottomLbl1.textColor=[UIColor lightGrayColor];
//    bottomLbl1.font=[UIFont systemFontOfSize:10];
//    bottomLbl1.textAlignment=NSTextAlignmentCenter;
//    bottomLbl1.text=@"회사소개 / 뉴스 / 규정&조건 / 개인정보보호 / 연락하기";
//    [scorllView addSubview:bottomLbl1];
//    
//    UILabel * copyRight=[[UILabel alloc]init];
//    copyRight.frame=CGRectMake(20, windowSize.height/2+290, scorllView.frame.size.width-40,30);
//    copyRight.textColor=[UIColor lightGrayColor];
//    copyRight.font=[UIFont systemFontOfSize:10];
//    copyRight.textAlignment=NSTextAlignmentCenter;
//    copyRight.text=@"2014년비스켓캐시백";
//    [scorllView addSubview:copyRight];

    
    
  /*  UILabel*   bottomLbl1=[[UILabel alloc]init];
    bottomLbl1.frame=CGRectMake(20, 550, scorllView.frame.size.width-40,30);
    bottomLbl1.textColor=[UIColor lightGrayColor];
    bottomLbl1.font=[UIFont systemFontOfSize:10];
    bottomLbl1.textAlignment=NSTextAlignmentCenter;
    bottomLbl1.text=@"회사소개 / 뉴스 / 규정&조건 / 개인정보보호 / 연락하기";
    [scorllView addSubview:bottomLbl1];
    
    UILabel * copyRight=[[UILabel alloc]init];
    copyRight.frame=CGRectMake(20,570, scorllView.frame.size.width-40,30);
    copyRight.textColor=[UIColor lightGrayColor];
    copyRight.font=[UIFont systemFontOfSize:10];
    copyRight.textAlignment=NSTextAlignmentCenter;
    copyRight.text=@"2014년비스켓캐시백";
    [scorllView addSubview:copyRight];*/
}


#pragma mark- textView and textField delegate methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text length]>=200) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"당신은 200 문자를 입력 할 수 있습니다." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        return NO;
    }
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark- invite Action here
#pragma mark-

-(void)inviteButtonAction:(UIButton *)sender{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];
     if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {
         NSString *errormsg=[self validation];
         NSMutableString * friendList=[[NSMutableString alloc]init];
         if (errormsg) {
             UIAlertView * alert=[[UIAlertView alloc]initWithTitle:errormsg message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
             [alert show];
         }
    else{
        if ([self.txt1.text length]!=0) {
            [friendList appendString:self.txt1.text];
        }
        if ([self.txt2.text length]!=0) {
            [friendList appendFormat:[NSString stringWithFormat:@",%@",self.txt2.text]];
        }
        if ([self.txt3.text length]!=0) {
            [friendList appendFormat:[NSString stringWithFormat:@",%@",self.txt3.text]];
        }
        if ([self.txt4.text length]!=0) {
            [friendList appendFormat:[NSString stringWithFormat:@",%@",self.txt4.text]];
        }
        if ([self.txt5.text length]!=0) {
            [friendList appendFormat:[NSString stringWithFormat:@",%@",self.txt5.text]];
        }
    
        NSMutableString * friendemail=[[NSMutableString alloc]init];
        if ([self.txt6.text length]!=0) {
            [friendemail appendString:self.txt6.text];
        }
        if ([self.txt7.text length]!=0) {
            [friendemail appendFormat:[NSString stringWithFormat:@",%@",self.txt7.text]];
        }
        if ([self.txt8.text length]!=0) {
            [friendemail appendFormat:[NSString stringWithFormat:@",%@",self.txt8.text]];
        }
        if ([self.txt9.text length]!=0) {
            [friendemail appendFormat:[NSString stringWithFormat:@",%@",self.txt9.text]];
        }
        if ([self.txt10.text length]!=0) {
            [friendemail appendFormat:[NSString stringWithFormat:@",%@",self.txt10.text]];
        }
    
        if ([self.textView.text length]==0) {
            self.textView.text=@"";
        }

    
    NSError * error;
    NSURLResponse * urlResponse;
        NSString * infoText=self.textView.text;
    NSString * url=[NSString  stringWithFormat:@"http://www.biscash.com/windex.php?method=referafriend&user_id=%@&fname=%@&frname=%@&fremail=%@&umessage=%@",[SingletonClass sharedSingleton].login_userId,[SingletonClass sharedSingleton].fname,friendList,friendemail,infoText];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * urlPost=[[NSURL alloc]initWithString:url];
     
        
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:urlPost cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id  response=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"Reffer Friend %@",response);
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"감사합니다. 메시지가 친구에게 보내졌습니다." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        }
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
    
}

-(void)cancelButtonAction:(UIButton*)sender{
   [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
}



-(NSString *)validation{
    NSString * errmsg;
    if ([self.txt1.text length]!=0 ){
        if ([self.txt6.text length]==0) {
             errmsg=@"친구의 이름과 이메일 주소가 이상 입력하십시오.";
        }
}
    if ([self.txt2.text length]!=0 ){
        if ([self.txt7.text length]==0) {
            errmsg=@"친구의 이름과 이메일 주소가 이상 입력하십시오.";
        }
    }

    if ([self.txt3.text length]!=0 ){
        if ([self.txt8.text length]==0) {
            errmsg=@"친구의 이름과 이메일 주소가 이상 입력하십시오.";
        }
    }

    if ([self.txt4.text length]!=0 ){
        if ([self.txt9.text length]==0) {
            errmsg=@"친구의 이름과 이메일 주소가 이상 입력하십시오.";
        }
    }
    if ([self.txt5.text length]!=0 ){
        if ([self.txt10.text length]==0) {
            errmsg=@"친구의 이름과 이메일 주소가 이상 입력하십시오.";
        }
    }
    return  errmsg;
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
