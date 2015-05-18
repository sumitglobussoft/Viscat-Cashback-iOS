//
//  ProfileEditViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 17/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "ProfileEditViewController.h"
#import "SingletonClass.h"

@interface ProfileEditViewController ()
{
    NSArray * captchArr;
}
@end

@implementation ProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    windowSize =[UIScreen mainScreen].bounds.size;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(createUI) name:@"profileEdit" object:nil];
    
  
    //[self createUI];
    // Do any additional setup after loading the view from its nib.
}



#pragma mark- createUI

-(void)createUI{
    
    [self.scrollView removeFromSuperview];
    self.scrollView=nil;
   
    
    self.scrollView=[[UIScrollView alloc]init];
    self.scrollView.frame=CGRectMake(0,0, windowSize.width, windowSize.height);
    self.scrollView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.2);
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.scrollView];
    
    myProfileEdit=[[UILabel alloc]init];
    myProfileEdit.frame=CGRectMake(10, 10, 150, 30);
    myProfileEdit.text=@"내프로필-개인정보변경";
    myProfileEdit.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:myProfileEdit];
    
    imageView=[[UIImageView alloc]init];
    imageView.frame=CGRectMake(0, 40, self.scrollView.frame.size.width, 1);
    imageView.image=[UIImage imageNamed:@"divider.png"];
    [self.scrollView addSubview:imageView];
    
    requiredLbl=[[UILabel alloc]init];
    requiredLbl.frame=CGRectMake(windowSize.width-105, 42, 80, 20);
    requiredLbl.font=[UIFont systemFontOfSize:10];
    requiredLbl.text=@"**는필수입력사항";
    requiredLbl.textColor=[UIColor redColor];
    [self.scrollView addSubview:requiredLbl];
    
    self.userNameTXt=[[UITextField alloc]init];
    self.userNameTXt.frame=CGRectMake(self.scrollView.frame.size.width/2-20, 60, 145, 26);
    self.userNameTXt.delegate=self;
    self.userNameTXt.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.userNameTXt.layer.borderWidth=0.7;
    self.userNameTXt.layer.cornerRadius=7;
    self.userNameTXt.text=[SingletonClass sharedSingleton].userEmail;
    self.userNameTXt.clipsToBounds=YES;
    self.userNameTXt.textColor=[UIColor lightGrayColor];
    self.userNameTXt.font=[UIFont systemFontOfSize:12];
    self.userNameTXt.userInteractionEnabled=NO;
    [self.scrollView addSubview:self.userNameTXt];
    
    self.nameTxt=[[UITextField alloc]init];
    self.nameTxt.frame=CGRectMake(self.scrollView.frame.size.width/2-20, 100, 145, 26);
    self.nameTxt.delegate=self;
    self.nameTxt.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"text_fill.png"]];
    self.nameTxt.text=[SingletonClass sharedSingleton].fname;
    self.nameTxt.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.nameTxt];
    
       self.emailTxt=[[UITextField alloc]init];
    self.emailTxt.frame=CGRectMake(self.scrollView.frame.size.width/2-20, 140, 145, 26);
    self.emailTxt.delegate=self;
    self.emailTxt.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"text_fill.png"]];
    self.emailTxt.text=[SingletonClass sharedSingleton].userEmail;
    self.emailTxt.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.emailTxt];
    
    self.address=[[UITextField alloc]init];
    self.address.frame=CGRectMake(self.scrollView.frame.size.width/2-20, 180, 145, 26);
    self.address.delegate=self;
    self.address.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"text_fill.png"]];
    self.address.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.address];
    
    self.streeTxt=[[UITextField alloc]init];
    self.streeTxt.frame=CGRectMake(self.scrollView.frame.size.width/2-20, 220, 145, 26);
    self.streeTxt.delegate=self;
    self.streeTxt.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"text_fill.png"]];
    self.streeTxt.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.streeTxt];

    self.postalCode=[[UITextField alloc]init];
    self.postalCode.frame=CGRectMake(self.scrollView.frame.size.width/2-20, 260, 145, 26);
    self.postalCode.delegate=self;
    self.postalCode.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"text_fill.png"]];
    self.postalCode.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.postalCode];

    
    self.phoneNoTxt=[[UITextField alloc]init];
    self.phoneNoTxt.frame=CGRectMake(self.scrollView.frame.size.width/2-20, 300, 145, 26);
    self.phoneNoTxt.delegate=self;
    self.phoneNoTxt.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"text_fill.png"]];
    self.phoneNoTxt.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.phoneNoTxt];
    

    self.oldPasswordTxt=[[UITextField alloc]init];
    self.oldPasswordTxt.frame=CGRectMake(self.scrollView.frame.size.width/2-20, 380, 145, 26);
    self.oldPasswordTxt.delegate=self;
    self.oldPasswordTxt.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"text_fill.png"]];
    self.oldPasswordTxt.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.oldPasswordTxt];

    self.passwordTxt=[[UITextField alloc]init];
    self.passwordTxt.frame=CGRectMake(self.scrollView.frame.size.width/2-20, 420, 145, 26);
    self.passwordTxt.delegate=self;
    self.passwordTxt.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"text_fill.png"]];
    self.passwordTxt.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.passwordTxt];

    self.confimPassTxt=[[UITextField alloc]init];
    self.confimPassTxt.frame=CGRectMake(self.scrollView.frame.size.width/2-20, 460, 145, 26);
    self.confimPassTxt.delegate=self;
    self.confimPassTxt.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"text_fill.png"]];
    self.confimPassTxt.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.confimPassTxt];

    
       //Labels
    
    self.userNameLbl=[[UILabel alloc]init];
    self.userNameLbl.frame=CGRectMake(self.scrollView.frame.size.width/2-145, 60, 100, 26);
    self.userNameLbl.text=@"유저이름";
    self.userNameLbl.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.userNameLbl];
    self.userNameLbl.textAlignment=NSTextAlignmentRight;
    
    self.nameLbl=[[UILabel alloc]init];
    self.nameLbl.frame=CGRectMake(self.scrollView.frame.size.width/2-145, 100, 100, 26);
    self.nameLbl.text=@"* 이름";
    self.nameLbl.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.nameLbl];
     self.nameLbl.textAlignment=NSTextAlignmentRight;
    
    NSMutableAttributedString *text1 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString:self.nameLbl.attributedText];
    
    [text1 addAttribute:NSForegroundColorAttributeName
                  value:[UIColor redColor]
                  range:NSMakeRange(0, 1)];
    [ self.nameLbl setAttributedText: text1];
    

    
    self.emailLbl=[[UILabel alloc]init];
    self.emailLbl.frame=CGRectMake(self.scrollView.frame.size.width/2-145, 140, 100, 26);
    self.emailLbl.text=@"* 이메일주소";
    self.emailLbl.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.emailLbl];
     self.emailLbl.textAlignment=NSTextAlignmentRight;
    
    NSMutableAttributedString *text2 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString:self.emailLbl.attributedText];
    
    [text2 addAttribute:NSForegroundColorAttributeName
                  value:[UIColor redColor]
                  range:NSMakeRange(0, 1)];
    [ self.emailLbl setAttributedText: text2];
    
    self.addressLbl=[[UILabel alloc]init];
    self.addressLbl.frame=CGRectMake(windowSize.width/2-145, 180, 100, 27);
    self.addressLbl.text=@"주소";
    self.addressLbl.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.addressLbl];
     self.addressLbl.textAlignment=NSTextAlignmentRight;
    
    
    self.streeLbl=[[UILabel alloc]init];
    self.streeLbl.frame=CGRectMake(windowSize.width/2-145, 220, 100, 27);
    self.streeLbl.text=@"거리";
    self.streeLbl.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.streeLbl];
     self.streeLbl.textAlignment=NSTextAlignmentRight;

    
    self.postalCodeLbl=[[UILabel alloc]init];
    self.postalCodeLbl.frame=CGRectMake(self.scrollView.frame.size.width/2-145, 260, 100, 26);
    self.postalCodeLbl.text=@"우편번호";
    self.postalCodeLbl.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.postalCodeLbl];
    self.postalCodeLbl.textAlignment=NSTextAlignmentRight;
    
    self.phoneNoLbl=[[UILabel alloc]init];
    self.phoneNoLbl.frame=CGRectMake(windowSize.width/2-145, 300, 100, 27);
    self.phoneNoLbl.text=@"전화번호";
    self.phoneNoLbl.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.phoneNoLbl];
     self.phoneNoLbl.textAlignment=NSTextAlignmentRight;
    
    self.oldPasswordLbl=[[UILabel alloc]init];
    self.oldPasswordLbl.frame=CGRectMake(self.scrollView.frame.size.width/2-145, 380, 100, 26);
    self.oldPasswordLbl.text=@"이전 비밀번호";
    self.oldPasswordLbl.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.oldPasswordLbl];
    self.oldPasswordLbl.textAlignment=NSTextAlignmentRight;
    
    
    self.passwordLbl=[[UILabel alloc]init];
    self.passwordLbl.frame=CGRectMake(self.scrollView.frame.size.width/2-145, 420, 100, 26);
    self.passwordLbl.text=@"새 비밀번호";
    self.passwordLbl.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.passwordLbl];
     self.passwordLbl.textAlignment=NSTextAlignmentRight;
    
    self.confimPassLbl=[[UILabel alloc]init];
    self.confimPassLbl.frame=CGRectMake(self.scrollView.frame.size.width/2-145, 460, 100, 26);
    self.confimPassLbl.text=@"새 비밀번호 확인";
    self.confimPassLbl.font=[UIFont systemFontOfSize:12];
    [self.scrollView addSubview:self.confimPassLbl];
     self.confimPassLbl.textAlignment=NSTextAlignmentRight;

    
    
    cancel1=[UIButton buttonWithType:UIButtonTypeCustom];
    cancel1.frame=CGRectMake(self.scrollView.frame.size.width-70, 340, 38, 26);
     [cancel1 setBackgroundImage:[UIImage imageNamed:@"cancel_btn.png"] forState:UIControlStateNormal];
    [self.scrollView addSubview:cancel1];
    
    updateButton=[UIButton buttonWithType:UIButtonTypeCustom];
    updateButton.frame=CGRectMake(self.scrollView.frame.size.width-150, 340, 64, 26);
    [updateButton setBackgroundImage:[UIImage imageNamed:@"update_btn.png"] forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(profileUpdateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:updateButton];
    
   ///////////////////////////////////////////////
    
   
    

    
    cancel2=[UIButton buttonWithType:UIButtonTypeCustom];
    cancel2.frame=CGRectMake(self.scrollView.frame.size.width-70, 500, 38, 26);
    [cancel2 setBackgroundImage:[UIImage imageNamed:@"cancel_btn.png"] forState:UIControlStateNormal];
    [self.scrollView addSubview:cancel2];
    
    changePass=[UIButton buttonWithType:UIButtonTypeCustom];
    changePass.frame=CGRectMake(self.scrollView.frame.size.width-190, 500, 110, 27);
    [changePass setBackgroundImage:[UIImage imageNamed:@"change_password_btn.png"] forState:UIControlStateNormal];
    [changePass addTarget:self action:@selector(changePassAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:changePass];

    bottomLbl=[[UILabel alloc]init];
    bottomLbl.frame=CGRectMake(self.scrollView.frame.size.width/2-100, self.scrollView.frame.size.height-30, self.scrollView.frame.size.width-100,30);
    bottomLbl.textColor=[UIColor lightGrayColor];
    bottomLbl.font=[UIFont systemFontOfSize:10];
    bottomLbl.text=@"회사소개 / 뉴스 / 규정&조건 / 개인정보보호 / 연락하기";
    [self.scrollView addSubview:bottomLbl];
    
    self.pickerView=[[UIPickerView alloc]init];
    self.pickerView.frame=CGRectMake(0, windowSize.height/2+20, windowSize.width, (windowSize.height/2));
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    self.pickerView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:self.pickerView];
    self.pickerView.hidden=YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- textField Delegate methods
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==self.oldPasswordTxt) {
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.frame=CGRectMake(0, -180, windowSize.width, windowSize.height);
        }];
    }
    
    
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.oldPasswordTxt) {
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.frame=CGRectMake(0, 0, windowSize.width, windowSize.height);
        }];
    }
    [textField resignFirstResponder];
    return YES;
}



#pragma mark-

#pragma mark- pickerView Delegate methods

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 5;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40.0f;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"Profile Edit";
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch view] != self.pickerView){
        self.pickerView.hidden=YES;
    
        self.scrollView.userInteractionEnabled=YES;
    }
}

#pragma mark-
-(void)profileUpdateAction:(UIButton*)sender{
    
    NSString * errmsg=[self validation];
    if (errmsg ) {
        UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:errmsg message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    else{
        NSString * url=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=editprofile&user_id=%@&email=%@&fname=%@",[SingletonClass sharedSingleton].login_userId,self.emailTxt.text,self.nameTxt.text];
        
        if ([self.address.text length]!=0) {
            url=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=editprofile&user_id=%@&email=%@&fname=%@&address=%@",[SingletonClass sharedSingleton].login_userId,self.emailTxt.text,self.nameTxt.text,self.address.text];
        }
        if ([self.postalCode.text length]!=0) {
           url= [NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=editprofile&user_id=%@&email=%@&fname=%@&address=%@&zip=%@",[SingletonClass sharedSingleton].login_userId,self.emailTxt.text,self.nameTxt.text,self.address.text,self.postalCode.text];
        }
        if ([self.streeTxt.text length]!=0) {
          url= [NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=editprofile&user_id=%@&email=%@&fname=%@&address=%@&zip=%@&street=%@",[SingletonClass sharedSingleton].login_userId,self.emailTxt.text,self.nameTxt.text,self.address.text,self.postalCode.text,self.streeTxt.text];
        }
        if ([self.phoneNoTxt.text length]!=0) {
       url= [NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=editprofile&user_id=%@&email=%@&fname=%@&address=%@&zip=%@&street=%@&phone=%@",[SingletonClass sharedSingleton].login_userId,self.emailTxt.text,self.nameTxt.text,self.address.text,self.postalCode.text,self.streeTxt.text,self.phoneNoTxt.text];
        }
        
        NSError * error;
        NSURLResponse * urlResponse;
        
        NSURL * geturl=[NSURL URLWithString:url];
    
        NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:geturl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if (data==nil) {
            return;
        }
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"sign up response %@",json);
    }
    
}

-(NSString*)validation{
    NSString * returnStr;
    if ([self.nameTxt.text length]==0) {
        returnStr= @"Please enter name.";
    }
   else if ([self.emailTxt.text length]==0) {
        returnStr =@"Please enter email-Id.";
    }
    return returnStr;
}



-(void)changePassAction{
    NSString * errmsg=[self passwordValidation];
    if (errmsg) {
        UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:errmsg message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
    else{
        NSError * error;
        NSURLResponse * urlResponse;
    
        NSURL * geturl=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=changepassword&user_id=%@&pwd=%@newpwd=%@&newpwd2=%@",[SingletonClass sharedSingleton].login_userId,self.oldPasswordTxt.text,self.passwordTxt.text,self.confimPassTxt.text]];
   
        NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:geturl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if (data==nil) {
            return;
        }
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"sign up response %@",json);
    }
    
}

-(NSString*)passwordValidation{
    NSString * str;
    
    if ([self.oldPasswordTxt.text length]==0) {
        str=@" Please enter password";
    }
    else if ( [self.passwordTxt.text length]==0){
        str=@" Please enter new password.";
    }
    else if( ![self.passwordTxt.text isEqualToString:self.confimPassTxt.text])
    {
        str=@"pass word is not matching";
    }
    return str;
}

@end
