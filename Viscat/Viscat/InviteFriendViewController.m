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

@end

@implementation InviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    windowSize =[UIScreen mainScreen].bounds.size;
  
    [self createUI];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    
    scorllView=[[UIScrollView alloc]init];
    scorllView.frame=CGRectMake(0, 0, windowSize.width, windowSize.height);
    [self.view addSubview:scorllView];
    scorllView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.2);
    
    tellFriend=[[UILabel alloc]init];
    tellFriend.frame=CGRectMake(windowSize.width/2-140, windowSize.height/2-280, 150, 30);
    tellFriend.text=@"친구에게 소개하기";
    tellFriend.font=[UIFont boldSystemFontOfSize:14];
    [scorllView addSubview:tellFriend];
    
   _imageView=[[UIImageView alloc]init];
    _imageView.frame=CGRectMake(0, windowSize.height/2-250, windowSize.width, 1);
    _imageView.image=[UIImage imageNamed:@"divider.png"];
    [scorllView addSubview:_imageView];
    
    ruleOne=[[UILabel alloc]init];
    ruleOne.frame=CGRectMake(20, windowSize.height/2-245, windowSize.width/2+100, 20);
    ruleOne.text=@"친구에게비스켓 캐시백을소개하고5천원을받아보세요!";
    ruleOne.font=[UIFont systemFontOfSize:10];
    [scorllView addSubview:ruleOne];
   
    ruleTwo=[[UILabel alloc]init];
    ruleTwo.frame=CGRectMake(20, windowSize.height/2-225, windowSize.width/2+100, 20);
    ruleTwo.text=@"이메일을 입력하여친구나가족을다섯 명까지초대할수있습니다.";
    ruleTwo.font=[UIFont systemFontOfSize:10];
    [scorllView addSubview:ruleTwo];
    
    ruleThree=[[UILabel alloc]init];
    ruleThree.frame=CGRectMake(20, windowSize.height/2-205, windowSize.width/2+100, 40);
    ruleThree.text=@"초대하신분이가입을하게되면,회원님께한사람당 5천원의적립금 을드립니다 다섯명이 모두 가입하면??";
    ruleThree.font=[UIFont systemFontOfSize:10];
    ruleThree.numberOfLines=0;
    ruleThree.lineBreakMode=NSLineBreakByCharWrapping;
    [scorllView addSubview:ruleThree];
    
    UILabel * ruleFour=[[UILabel alloc]init];
    ruleFour.frame=CGRectMake(20, windowSize.height/2-185, windowSize.width/2+100, 20);
    ruleFour.text=@"";
    ruleFour.font=[UIFont systemFontOfSize:10];
    [scorllView addSubview:ruleFour];
    
    layer = [CALayer layer];
    layer.frame = CGRectMake(20, windowSize.height/2-150, windowSize.width-40, 320);
    layer.backgroundColor = [UIColor colorWithRed:(CGFloat)237/255 green:(CGFloat)248/255 blue:(CGFloat)252/255 alpha:1.0].CGColor;
    layer.borderWidth = 0.7;
    layer.borderColor = [UIColor colorWithRed:(CGFloat)237/255 green:(CGFloat)248/255 blue:(CGFloat)252/255 alpha:1.0].CGColor;
    [scorllView.layer insertSublayer:layer atIndex:0];
    
    requiredLbl1=[[UILabel alloc]init];
    requiredLbl1.frame=CGRectMake(windowSize.width/2-100, windowSize.height/2-130, 30, 20);
    requiredLbl1.text=@"이름";
    requiredLbl1.font=[UIFont systemFontOfSize:10];
    [scorllView addSubview:requiredLbl1];
   
    requiredLbl2=[[UILabel alloc]init];
    requiredLbl2.frame=CGRectMake(windowSize.width/2+20, windowSize.height/2-130, 60, 20);
    requiredLbl2.text=@"이메일주소";
    requiredLbl2.font=[UIFont systemFontOfSize:10];
    [scorllView addSubview:requiredLbl2];
    
    self.txt1=[[UITextField alloc]init];
    self.txt1.frame=CGRectMake(windowSize.width/2-120, windowSize.height/2-100, 93, 26);
    self.txt1.backgroundColor=[UIColor whiteColor];
    self.txt1.layer.cornerRadius=7;
    self.txt1.clipsToBounds=YES;
   [self.txt1 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];    [scorllView addSubview:self.txt1];
    
    self.txt2=[[UITextField alloc]init];
    self.txt2.frame=CGRectMake(windowSize.width/2-120, windowSize.height/2-70, 93, 26);
    self.txt2.backgroundColor=[UIColor whiteColor];
    self.txt2.layer.cornerRadius=7;
    self.txt2.clipsToBounds=YES;
    [self.txt2 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt2];

    
    self.txt3=[[UITextField alloc]init];
    self.txt3.frame=CGRectMake(windowSize.width/2-120, windowSize.height/2-40, 93, 26);
    self.txt3.backgroundColor=[UIColor whiteColor];
    self.txt3.layer.cornerRadius=7;
    self.txt3.clipsToBounds=YES;
    [self.txt3 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt3];

    
    self.txt4=[[UITextField alloc]init];
    self.txt4.frame=CGRectMake(windowSize.width/2-120, windowSize.height/2-10, 93, 26);
    self.txt4.backgroundColor=[UIColor whiteColor];
    self.txt4.layer.cornerRadius=7;
    self.txt4.clipsToBounds=YES;
   [self.txt4 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt4];
    
    self.txt5=[[UITextField alloc]init];
    self.txt5.frame=CGRectMake(windowSize.width/2-120, windowSize.height/2+20, 93, 26);
    self.txt5.backgroundColor=[UIColor whiteColor];
    self.txt5.layer.cornerRadius=7;
    self.txt5.clipsToBounds=YES;
   [self.txt5 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt5];

    
    
    
    // right side textFields
    
    
    self.txt6=[[UITextField alloc]init];
    self.txt6.frame=CGRectMake(windowSize.width/2, windowSize.height/2-100, 130, 25);
    self.txt6.backgroundColor=[UIColor whiteColor];
    self.txt6.layer.cornerRadius=7;
    self.txt6.clipsToBounds=YES;
    [self.txt6 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt6];

    
    self.txt7=[[UITextField alloc]init];
    self.txt7.frame=CGRectMake(windowSize.width/2, windowSize.height/2-70, 130, 25);
    self.txt7.backgroundColor=[UIColor whiteColor];
    self.txt7.layer.cornerRadius=7;
    self.txt7.clipsToBounds=YES;
    [self.txt7 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt7];

    
    self.txt8=[[UITextField alloc]init];
    self.txt8.frame=CGRectMake(windowSize.width/2, windowSize.height/2-40, 130, 25);
    self.txt8.backgroundColor=[UIColor whiteColor];
    self.txt8.layer.cornerRadius=7;
    self.txt8.clipsToBounds=YES;
    [self.txt8 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt8];

    
    self.txt9=[[UITextField alloc]init];
    self.txt9.frame=CGRectMake(windowSize.width/2, windowSize.height/2-10,130, 25);
    self.txt9.backgroundColor=[UIColor whiteColor];
    self.txt9.layer.cornerRadius=7;
    self.txt9.clipsToBounds=YES;
    [self.txt9 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];    [scorllView addSubview:self.txt9];

    
    self.txt10=[[UITextField alloc]init];
    self.txt10.frame=CGRectMake(windowSize.width/2 , windowSize.height/2+20, 130, 25);
    self.txt10.backgroundColor=[UIColor whiteColor];
    self.txt10.layer.cornerRadius=7;
    self.txt10.clipsToBounds=YES;
    [self.txt10 setBackground:[UIImage imageNamed:@"frnds_email_fill.png"]];
    [scorllView addSubview:self.txt10];
    
    self.textView=[[UITextView alloc]init];
    self.textView.frame=CGRectMake(windowSize.width/2-120, windowSize.height/2+90, 253, 60);
   // self.textView.backgroundColor=[UIColor redColor];
     self.textView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"textarea_fill.png"]];
    [scorllView addSubview:self.textView];
    
    self.button=[UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame=CGRectMake(windowSize.width-100, windowSize.height/2+190, 80, 30);
    [self.button setBackgroundImage:[UIImage imageNamed:@"invite_btn.png"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(inviteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [scorllView addSubview:self.button];
    
    bottomLbl=[[UILabel alloc]init];
    bottomLbl.frame=CGRectMake(scorllView.frame.size.width/2-100, scorllView.frame.size.height, scorllView.frame.size.width-100,30);
    bottomLbl.textColor=[UIColor lightGrayColor];
    bottomLbl.font=[UIFont systemFontOfSize:10];
    bottomLbl.text=@"회사소개 / 뉴스 / 규정&조건 / 개인정보보호 / 연락하기";
    [scorllView addSubview:bottomLbl];

    [self layOutSetting];

}

-(void)layOutSetting{
    if ([UIScreen mainScreen].bounds.size.height==480) {
        
        scorllView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.3);
        
        tellFriend.frame=CGRectMake(windowSize.width/2-140, windowSize.height/2-240, 150, 30);
        _imageView.frame=CGRectMake(0, windowSize.height/2-210, windowSize.width, 1);
        ruleOne.frame=CGRectMake(20, windowSize.height/2-205, windowSize.width/2+100, 20);
        ruleTwo.frame=CGRectMake(20, windowSize.height/2-185, windowSize.width/2+100, 20);
        ruleThree.frame=CGRectMake(20, windowSize.height/2-165, windowSize.width/2+100, 40);
        
        layer.frame = CGRectMake(20, windowSize.height/2-100, windowSize.width-40, 320);
        
        requiredLbl1.frame=CGRectMake(windowSize.width/2-100, windowSize.height/2-70, 30, 20);
        requiredLbl2.frame=CGRectMake(windowSize.width/2+20, windowSize.height/2-70, 60, 20);
        
        self.txt1.frame=CGRectMake(windowSize.width/2-120, windowSize.height/2-50, 93, 26);
        self.txt2.frame=CGRectMake(windowSize.width/2-120, windowSize.height/2-10, 93, 26);
        self.txt3.frame=CGRectMake(windowSize.width/2-120, windowSize.height/2+30, 93, 26);
        self.txt4.frame=CGRectMake(windowSize.width/2-120, windowSize.height/2+70, 93, 26);
        self.txt5.frame=CGRectMake(windowSize.width/2-120, windowSize.height/2+110, 93, 26);
        self.txt6.frame=CGRectMake(windowSize.width/2, windowSize.height/2-50, 130, 25);
        self.txt7.frame=CGRectMake(windowSize.width/2, windowSize.height/2-10, 130, 25);
        self.txt8.frame=CGRectMake(windowSize.width/2, windowSize.height/2+30, 130, 25);
        self.txt9.frame=CGRectMake(windowSize.width/2, windowSize.height/2+70,130, 25);
        self.txt10.frame=CGRectMake(windowSize.width/2 , windowSize.height/2+110, 130, 25);
        
        self.textView.frame=CGRectMake(windowSize.width/2-120, windowSize.height/2+150, 253, 60);
        self.button.frame=CGRectMake(windowSize.width-100, windowSize.height/2+240, 80, 30);
        
        bottomLbl.frame=CGRectMake(scorllView.frame.size.width/2-100, scorllView.frame.size.height+30, scorllView.frame.size.width-100,30);
    }
    
}

#pragma mark- invite Action here
#pragma mark-

-(void)inviteButtonAction:(UIButton *)sender{
    NSMutableString * friendList=[[NSMutableString alloc]init];
    if (self.txt1.text) {
        [friendList appendString:self.txt1.text];
    }
    if (self.txt2.text) {
        [friendList appendFormat:[NSString stringWithFormat:@",%@",self.txt2.text]];
    }
    if (self.txt3.text) {
        [friendList appendFormat:[NSString stringWithFormat:@",%@",self.txt3.text]];
    }
    if (self.txt4.text) {
        [friendList appendFormat:[NSString stringWithFormat:@",%@",self.txt4.text]];
    }
    if (self.txt5.text) {
         [friendList appendFormat:[NSString stringWithFormat:@",%@",self.txt5.text]];
    }
    
    NSMutableString * friendemail=[[NSMutableString alloc]init];
    if (self.txt6.text) {
        [friendemail appendString:self.txt6.text];
    }
    if (self.txt7.text) {
        [friendemail appendFormat:[NSString stringWithFormat:@",%@",self.txt7.text]];
    }
    if (self.txt8.text) {
        [friendemail appendFormat:[NSString stringWithFormat:@",%@",self.txt8.text]];
    }
    if (self.txt9.text) {
        [friendemail appendFormat:[NSString stringWithFormat:@",%@",self.txt9.text]];
    }
    if (self.txt10.text) {
        [friendemail appendFormat:[NSString stringWithFormat:@",%@",self.txt10.text]];
    }
    
    if (!self.textView.text) {
        self.textView.text=@"";
    }

    
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSURL * urlPost=[NSURL URLWithString:[NSString  stringWithFormat:@"http://www.biscash.com/windex.php?method=referafriend&user_id=%@&fname=%@&frname=%@&fremail=%@&umessage=%@",[SingletonClass sharedSingleton].login_userId,[SingletonClass sharedSingleton].fname,friendList,friendemail,self.textView.text]];
    
    NSMutableURLRequest * request =[[NSMutableURLRequest alloc]initWithURL:urlPost cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id  response=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"Reffer Friend %@",response);

}

-(void)cancelButtonAction:(UIButton*)sender{
   [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
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
