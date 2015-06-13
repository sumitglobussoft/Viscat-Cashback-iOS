//
//  LoginViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 17/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "LoginViewController.h"
#import "InviteFriendViewController.h"
#import "AppDelegate.h"
#import "DetailPageViewController.h"
#import "SingletonClass.h"
#import "HomeViewController.h"
#import "ViewController.h"
#import "SignUpViewController.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <KakaoOpenSDK/KakaoOpenSDK.h>




@interface LoginViewController ()
{
    InviteFriendViewController * inviteVC;
    ViewController * viewVC;
    UIButton *  checkBoxButton1;
    UIImageView *alertView;
}
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeHeaderTitle" object:@"Login"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(returnHome) name:@"removeHome" object:nil];
   
    //self.navigationController.navigationBar.hidden=NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"removeHome" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor whiteColor];
    UIButton * backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10,0,50,25);
    [backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backBar=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=backBar;
    
    windowSize =[UIScreen mainScreen].bounds.size;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(createUI) name:@"signIn" object:nil];
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
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark- back button Action
-(void)backButtonAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden=YES;
}

-(void)loadUI{
    
}


#pragma mark- createUI

-(void)createUI{
     [alertView removeFromSuperview];
    UIScrollView * scrollView=[[UIScrollView alloc]init];
    scrollView.frame=CGRectMake(0, 0, windowSize.width, windowSize.height);
    scrollView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:scrollView];
    scrollView.showsVerticalScrollIndicator=NO;
    if(windowSize.height>500){
//        if (windowSize.height==736) {
//            scrollView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.2);
//        }
        
    }
    else{
        scrollView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.2);
    }

    
    
    loginLbl=[[UILabel alloc]init];
    loginLbl.frame=CGRectMake(windowSize.width/2-140, 30, 50, 30);
    loginLbl.text=@"로그인";
    loginLbl.font=[UIFont systemFontOfSize:14];
    [scrollView addSubview:loginLbl];
    
    warningLbl=[[UILabel alloc]init];
    warningLbl.frame=CGRectMake(windowSize.width/2-140, 60, 278, 30);
    warningLbl.text=@"이메일과 비밀번호를 입력하세요.";
    warningLbl.textAlignment=NSTextAlignmentCenter;
    warningLbl.font=[UIFont systemFontOfSize:13];
    warningLbl.textColor=[UIColor whiteColor];
    warningLbl.backgroundColor=[UIColor colorWithRed:(CGFloat)92/255 green:(CGFloat)92/255 blue:(CGFloat)92/255 alpha:1.0];
    warningLbl.hidden=YES;
    
    [scrollView addSubview:warningLbl];
    
    self.userText=[[UITextField alloc]init];
    self.userText.frame=CGRectMake(windowSize.width/2-20,100, 163, 27);
    self.userText.delegate=self;
    self.userText.layer.cornerRadius=7;
    self.userText.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    self.userText.clipsToBounds=YES;
    self.userText.keyboardType=UIKeyboardTypeEmailAddress;
    self.userText.textAlignment=NSTextAlignmentCenter;
    [scrollView addSubview:self.userText];
    self.userText.font= [UIFont systemFontOfSize:10];
    
   
    self.passwordText=[[UITextField alloc]init];
    self.passwordText.frame=CGRectMake(windowSize.width/2-20, 140, 163, 27);
    self.passwordText.delegate=self;
    self.passwordText.layer.cornerRadius=7;
    self.passwordText.clipsToBounds=YES;
    self.passwordText.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    self.passwordText.secureTextEntry=YES;
    [scrollView addSubview:self.passwordText];
     self.passwordText.textAlignment=NSTextAlignmentCenter;
    self.passwordText.font= [UIFont systemFontOfSize:10];
    
    self.loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame=CGRectMake(windowSize.width/2+80, 180, 61, 25);
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"login_btn.png"] forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius=7;
    self.loginButton.clipsToBounds=YES;
      [scrollView addSubview:self.loginButton];
    
    
    // Label
    emailIdLbl=[[UILabel alloc]init];
    emailIdLbl.frame=CGRectMake(windowSize.width/2-140, 100,90, 30);
    emailIdLbl.text=@"이메일주소";
    emailIdLbl.textAlignment=NSTextAlignmentRight;
    emailIdLbl.font=[UIFont systemFontOfSize:12];
    [scrollView addSubview:emailIdLbl];

     password=[[UILabel alloc]init];
    password.frame=CGRectMake(windowSize.width/2-140, 140, 90, 30);
    password.text=@"비밀번호";
    password.font=[UIFont systemFontOfSize:12];
    password.textAlignment=NSTextAlignmentRight;
    [scrollView addSubview:password];
    
    imageView=[[UIImageView alloc]init];
    imageView.frame=CGRectMake(20, 210, windowSize.width-40, 1);
    imageView.image=[UIImage imageNamed:@"divider.png"];
    [scrollView addSubview:imageView];
    
    forgotPassword=[UIButton buttonWithType:UIButtonTypeCustom];
    forgotPassword.frame=CGRectMake(windowSize.width-120, 220, 100, 30);
    [forgotPassword setTitle:@"비밀번호찾기" forState:UIControlStateNormal];
    [forgotPassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgotPassword.titleLabel.font=[UIFont systemFontOfSize:12];
   
    [scrollView addSubview:forgotPassword];
    
    
    
    UILabel * rememberLbl=[[UILabel alloc]init];
    rememberLbl.frame=CGRectMake(windowSize.width/2+10, 180, 100, 25);
    rememberLbl.text=@" 비밀번호 저장";
    rememberLbl.font=[UIFont systemFontOfSize:10];
    [scrollView addSubview:rememberLbl];
    
      checkBoxButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    checkBoxButton1.frame=CGRectMake(windowSize.width/2-5, 185, 13, 13);
    [checkBoxButton1 setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [checkBoxButton1 setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateSelected];
    checkBoxButton1.tag=1;
    [checkBoxButton1 addTarget:self action:@selector(rememberPassword:) forControlEvents:UIControlEventTouchUpInside];
    [checkBoxButton1 setSelected:NO];
    [scrollView addSubview:checkBoxButton1];
    
    UILabel * forgotPass2=[[UILabel alloc]init];
    forgotPass2.frame=CGRectMake(windowSize.width/2+10, 250, 150, 25);
    forgotPass2.text=@"비회원이신가요? 가입하기!";
    forgotPass2.font=[UIFont systemFontOfSize:12];
    [scrollView addSubview:forgotPass2];
    
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: forgotPass2.attributedText];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(9, 5)];
    [forgotPass2 setAttributedText: text];

    UIButton * fblogin=[UIButton buttonWithType:UIButtonTypeCustom];
    fblogin.frame=CGRectMake(windowSize.width/2-100, 290, 203, 40);
    [fblogin setBackgroundImage:[UIImage imageNamed:@"facebook_login.png"] forState:UIControlStateNormal];
   
    [scrollView addSubview:fblogin];
    
    //Kakao Login
    
    UIButton * kakaoLogin=[UIButton buttonWithType:UIButtonTypeCustom];
      kakaoLogin.frame=  CGRectMake(windowSize.width/2-100, 350, 203, 40);
    [kakaoLogin setBackgroundImage:[UIImage imageNamed:@"kakaologin.png"] forState:UIControlStateNormal];

    [scrollView addSubview:kakaoLogin];
    
    
   /* UILabel*   bottomLbl1=[[UILabel alloc]init];
    bottomLbl1.frame=CGRectMake(20, 420, scrollView.frame.size.width-40,30);
    bottomLbl1.textColor=[UIColor lightGrayColor];
    bottomLbl1.font=[UIFont systemFontOfSize:10];
    bottomLbl1.textAlignment=NSTextAlignmentCenter;
    bottomLbl1.text=@"회사소개 / 뉴스 / 규정&조건 / 개인정보보호 / 연락하기";
    [scrollView addSubview:bottomLbl1];
    
    UILabel * copyRight=[[UILabel alloc]init];
    copyRight.frame=CGRectMake(20, 440, scrollView.frame.size.width-40,30);
    copyRight.textColor=[UIColor lightGrayColor];
    copyRight.font=[UIFont systemFontOfSize:10];
    copyRight.textAlignment=NSTextAlignmentCenter;
    copyRight.text=@"2014년비스켓캐시백";
    [scrollView addSubview:copyRight];
    if ([UIScreen mainScreen].bounds.size.height==736) {
         bottomLbl1.frame=CGRectMake(20, windowSize.height-130,windowSize.width-40,30);
        copyRight.frame=CGRectMake(20, windowSize.height-110, windowSize.width-40,30);
    }*/
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];
    if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {
        [self.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];

         [forgotPassword addTarget:self action:@selector(forgotPassword:) forControlEvents:UIControlEventTouchUpInside];
         [fblogin addTarget:self action:@selector(fbLoginAction:) forControlEvents:UIControlEventTouchUpInside];
        [kakaoLogin addTarget:self action:@selector(invokeKakaoLogin:) forControlEvents:UIControlEventTouchUpInside];
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



#pragma  amrk - remember password

-(void)rememberPassword:(UIButton *)sender{
    if ([self.userText.text length]!=0 && [self.passwordText.text length]!=0) {
        
    
    if (checkBoxButton1.selected==YES) {
        [checkBoxButton1 setSelected:NO];
        
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"email"];
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"password"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else{
        [[NSUserDefaults standardUserDefaults]setObject:self.userText.text  forKey:@"email"];
        [[NSUserDefaults standardUserDefaults]setObject:self.passwordText.text forKey:@"password"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        [checkBoxButton1 setSelected:YES];
    }
        
         }
}

#pragma mark- invite class

-(void)loginButtonAction:(UIButton *)sender
{

        NSLog(@"Successfull");
        NSString * errorMsg=[self validation];
        if (errorMsg) {
            warningLbl.hidden=NO;
            NSLog(@"Showing error message");
        }
        else{
            NSError * error;
            NSURLResponse * urlResponse;
            
            NSString * getUrlStr=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=signin&email=%@&password=%@",self.userText.text,self.passwordText.text];
            
            NSURL * getUrl=[NSURL URLWithString:getUrlStr];
            NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:getUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
            [request setHTTPMethod:@"GET"];
            [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            
            NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
            if (data==nil) {
                return;
            }
            
            id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
          
            if ([[json objectForKey:@"status"]isEqualToString:@"1"])
            {
                
                    
                NSMutableDictionary * dict=[NSMutableDictionary dictionary];
                dict=[json objectForKey:@"UserInfo"];
                [SingletonClass sharedSingleton].login_userId=[dict objectForKey:@"user_id"];
                [SingletonClass sharedSingleton].fname=[dict objectForKey:@"fname"];
                [SingletonClass sharedSingleton].userEmail=[dict objectForKey:@"email"];
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"signIn"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
               

                if([SingletonClass sharedSingleton].isFromDetailpage)
                {
                    [SingletonClass sharedSingleton].isFromDetailpage=NO;
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadmenuTable" object:nil];
                    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadmenuTable" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
              else  if([SingletonClass sharedSingleton].isFromTab)
                {
                    [SingletonClass sharedSingleton].isFromTab=NO;
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadmenuTable" object:nil];
                    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadmenuTable" object:nil];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"HomeScreen" object:nil];
                        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HomeScreen" object:nil];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadmenuTable" object:nil];
                        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadmenuTable" object:nil];
                }
            }
            else
            {
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"잘못된 이메일 / 암호" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
    }
   }


#pragma   mark- Validation

-(NSString *)validation{
    NSString * errorMsg;
    NSString * EmailregexPat=@"[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
    NSRegularExpression *regex=[[NSRegularExpression alloc]initWithPattern:EmailregexPat options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger userTextMatch=[regex numberOfMatchesInString:self.userText.text options:0 range:NSMakeRange(0, [self.userText.text length])];
    if(userTextMatch==0)
    {
        errorMsg=@"유효한 이메일 ID를 입력하십시오.";
    }
    if ([self.passwordText.text length]>5 && [self.passwordText.text length]>21) {
        errorMsg=@"6-20 자 사이의 암호를 입력하십시오";
    }
    
    return errorMsg;
}


#pragma mark- forgot Password

-(NSString *)validationForForgotPass{
    NSString * str;
    
    if ([self.userText.text length]==0) {
        str=@"이메일을 입력하세요.";
    }
    return str;
    
}

-(void)forgotPassword:(UIButton *)sender{
    
    NSString * errmsg=[self validationForForgotPass];
    if (errmsg) {
        UIAlertView  * alertView=[[UIAlertView alloc]initWithTitle:errmsg message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [alertView show];
    }
    else{
        NSError * error;
        NSURLResponse * urlResponse;
    
        NSURL *getUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=forgotpassword&email=%@",self.userText.text]];
        
        NSMutableURLRequest * requestForgot=[[NSMutableURLRequest alloc]initWithURL:getUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        [requestForgot setHTTPMethod:@"GET"];
        [requestForgot addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        NSData * data=[NSURLConnection sendSynchronousRequest:requestForgot returningResponse:&urlResponse error:&error];
        if (data==nil) {
            return;
        }
        
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@" forgot response %@",json);
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"메일을 확인합니다." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

#pragma mark- textField delegate methods
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return  YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)returnHome
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark- Facebook login

-(void)fbLoginAction:(UIButton*)sender{
    NSArray * readPermissions=@[@"public_profile",@"email"];
    FBSDKLoginManager * login=[[FBSDKLoginManager alloc]init];
    [login logInWithReadPermissions:readPermissions handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
        if (error) {
            NSLog(@"ERROR %@",error);
        }
        else if (result.isCancelled)
        {
            NSLog(@"Canceled ");
        }
        else{
            if ([FBSDKAccessToken currentAccessToken]) {
                FBSDKGraphRequest * request=[[FBSDKGraphRequest alloc]initWithGraphPath:@"/me" parameters:nil];
                
                [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    
                    NSLog(@" Result %@ ",result);
                    [SingletonClass sharedSingleton].fbId=[result objectForKey:@"id"];
                    [SingletonClass sharedSingleton].fname=[result objectForKey:@"first_name"];
                    [SingletonClass sharedSingleton].lname=[result objectForKey:@"last_name"];
                    [SingletonClass sharedSingleton].userEmail=[result objectForKey:@"email"];
                    [self FbloginService:result];
                   
                }];
            
            }
        }
        
    }];
}

-(void)FbloginService:(NSMutableDictionary *)result{
    
    NSError * error;
    NSURLResponse * urlResponse;
    
    
    NSURL * getUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=fbsignin&auth_uid=%@",[result objectForKey:@"id"]]];
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:getUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@" Fb sign in response %@",json);
    if ([[json objectForKey:@"status"] isEqualToString:@"0"]) {
        [self fbSignUp];
    }
    else
    {
        if ([[json  objectForKey:@"status"] isEqualToString:@"1"]) {
            NSMutableDictionary * dict=[json objectForKey:@"UserInfo"];
            [SingletonClass sharedSingleton].login_userId=[dict objectForKey:@"user_id"];
            [SingletonClass sharedSingleton].fname=[dict objectForKey:@"fname"];
           
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"signIn"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"HomeScreen" object:nil];
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HomeScreen" object:nil];
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HomeScreen" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadmenuTable" object:nil];
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadmenuTable" object:nil];
        }

    }
    
}


#pragma mark- fbsignUp

-(void)fbSignUp{
    NSError * error;
    NSURLResponse * urlResponse;

    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat: @"http://www.biscash.com/windex.php?method=facebooksignup&auth_provider=facebook&auth_uid=%@&email=%@&fname=%@&lname=%@&country=INDIA",[SingletonClass sharedSingleton].fbId,[SingletonClass sharedSingleton].userEmail,[SingletonClass sharedSingleton].fname,[SingletonClass sharedSingleton].lname]];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"sign up response %@",json);
    if ([[json  objectForKey:@"status"] isEqualToString:@"1"]) {
        NSMutableDictionary * dict=[json objectForKey:@"user_info"];
        [SingletonClass sharedSingleton].login_userId=[dict objectForKey:@"user_id"];
        [SingletonClass sharedSingleton].fname=[dict objectForKey:@"fname"];
        [SingletonClass sharedSingleton].userEmail=[dict objectForKey:@"email"];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"signIn"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HomeScreen" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HomeScreen" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HomeScreen" object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadmenuTable" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadmenuTable" object:nil];
    }
}

#pragma mark- Kakaologin

-(void)invokeKakaoLogin:(UIButton *)sender{
    [[KOSession sharedSession]close];
    [[KOSession sharedSession]openWithCompletionHandler:^(NSError *error) {
        if ([[KOSession sharedSession]isOpen]) {
            NSLog(@"Login ");
            NSLog(@"Access Token %@",[KOSession sharedSession].accessToken);
            
           [KOSessionTask meTaskWithCompletionHandler:^(KOUser* result, NSError *error) {
             if (result) {
                        NSLog(@"KAKAO user Data %@",result);
                 
                 
                 NSError * error;
                 NSURLResponse * urlResponse;
                 
                 
                 NSURL * getUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=fbsignin&auth_uid=%@",result .ID]];
                 NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:getUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
                 [request setHTTPMethod:@"GET"];
                 [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                 
                 NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
                 if (data==nil) {
                     return;
                 }
                 
                 id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                 NSLog(@" Fb sign in response %@",json);
                 if ([[json objectForKey:@"status"] isEqualToString:@"0"]) {
                     [self KakaoSignUp:result];
                 }
                 else
                 {
                     if ([[json  objectForKey:@"status"] isEqualToString:@"1"]) {
                         NSMutableDictionary * dict=[json objectForKey:@"UserInfo"];
                         [SingletonClass sharedSingleton].login_userId=[dict objectForKey:@"user_id"];
                         [SingletonClass sharedSingleton].fname=[dict objectForKey:@"fname"];
                          [SingletonClass sharedSingleton].userEmail=[dict objectForKey:@"email"];
                         [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"signIn"];
                         [[NSUserDefaults standardUserDefaults]synchronize];
                         [[NSNotificationCenter defaultCenter]postNotificationName:@"HomeScreen" object:nil];
                         [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HomeScreen" object:nil];
                         [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HomeScreen" object:nil];
                         [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadmenuTable" object:nil];
                         [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadmenuTable" object:nil];
                     }
                     
                 }

                 
                 
                    } else {
                        NSLog(@"%@", error);
                    }
          }];
        }
        else{
            NSLog(@"Error --===-- %@",error);
        }
    }];
}


-(void)KakaoSignUp:(KOUser* )result{
    NSError * error;
    NSURLResponse * urlResponse;
    NSString* name;
    if ( [[result propertyForKey: @"nickname"] length]==0 ) {
        name=@"";
    }
    else{
        name=[result propertyForKey: @"nickname"];
    }
    
    NSString * lname=@"";
    NSString * countory=@"";
    NSString * email=@"";
    
    
    NSString * urlStr=[NSString stringWithFormat: @"http://www.biscash.com/windex.php?method=facebooksignup&auth_provider=kakao&auth_uid=%@&fname=%@&email=&lname=&country=",result.ID,name];
     urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"sign up response %@",json);
    if ([[json  objectForKey:@"status"] isEqualToString:@"1"]) {
        NSMutableDictionary * dict=[json objectForKey:@"user_info"];
        [SingletonClass sharedSingleton].login_userId=[dict objectForKey:@"user_id"];
        [SingletonClass sharedSingleton].fname=[dict objectForKey:@"fname"];
        [SingletonClass sharedSingleton].userEmail=[dict objectForKey:@"email"];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"signIn"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HomeScreen" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HomeScreen" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HomeScreen" object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadmenuTable" object:nil];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadmenuTable" object:nil];
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
