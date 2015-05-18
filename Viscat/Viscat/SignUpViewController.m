//
//  SignUpViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 17/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "SignUpViewController.h"
#import "SingletonClass.h"

@interface SignUpViewController ()
{
    NSArray * captchArr;
    UILabel * captcha;
}
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeHeaderTitle" object:@"가입하기"];
    self.view.backgroundColor=[UIColor whiteColor];
    captchArr = [[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
   
    
    countryName=[NSArray arrayWithObjects:@"Afghanistan",@"Aland Islands",@"Albania",@"Algeria",@"American Samoa",@"Andorra",@"Angola",@"Anguilla",@"Antigua and Barbuda",@"Argentina",@"Armenia",@"Aruba",@"Australia",@"Austria",@"Azerbaijan",@"Bahamas",@"Bahrain",@"Bangladesh",@"Barbados",@"Belarus",@"Belgium",@"Belize",@"Benin",@"Bermuda",@"Bhutan",@"Bolivia", @"Bosnia and Herzegovina",@"Botswana",@"Bouvet Island",@"Brazil",@"British Indian Ocean Territory",@"Brunei Darussalam",@"Bulgaria",@"Burkina Faso",@"Burundi",@"Cambodia",@"Cameroon",@"Canada",@"Cape Verde",@"Cayman Islands",@"Central African Republic",@"Chad",@"Chile",@"China",@"Christmas Island",@"Cocos (Keeling) Islands",@"Colombia",@"Comoros",@"Congo",@"Congo, The Democratic Republic of the",@"Cook Islands",@"Costa Rica",@"Cote D'Ivoire",@"Croatia",@"Cuba",@"Cyprus",@"Czech Republic",@"Denmark",@"Djibouti",@"Dominica",nil];
    
    countryCode=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",@"60", nil];
    windowSize =[UIScreen mainScreen].bounds.size;
        [self createUI];
        [self loadCaptch];
    // Do any additional setup after loading the view from its nib.
}
#pragma textField Delgate methods


#pragma mark- createUI

-(void)createUI{
    
    
    scrollView=[[UIScrollView alloc]init];
    scrollView.frame=CGRectMake(0, 0, windowSize.width, windowSize.height);
    
    [self.view addSubview:scrollView];
    
    scrollView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.2);
    
    titleLabel=[[UILabel alloc]init];
    titleLabel.frame=CGRectMake(20,0, 150, 30);
    titleLabel.text=@"가입하기";
    titleLabel.font=[UIFont boldSystemFontOfSize:14];
    [scrollView addSubview:titleLabel];
    
    imageView=[[UIImageView alloc]init];
    imageView.frame=CGRectMake(0, 30, windowSize.width, 1);
    imageView.image=[UIImage imageNamed:@"divider.png"];
    [scrollView addSubview:imageView];
    
    requiredLabel=[[UILabel alloc]init];
    requiredLabel.frame=CGRectMake(windowSize.width-90, 40, 100, 20);
    requiredLabel.font=[UIFont systemFontOfSize:10];
    requiredLabel.text=@"**는필수입력사항";
    requiredLabel.textColor=[UIColor redColor];
    [scrollView addSubview:requiredLabel];
    
    self.fnameTxt=[[UITextField alloc]init];
    self.fnameTxt.frame=CGRectMake(windowSize.width/2-20,80, 163, 27);
    self.fnameTxt.delegate=self;
    [self.fnameTxt setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    self.fnameTxt.font=[UIFont systemFontOfSize:12];
    self.fnameTxt.textAlignment=NSTextAlignmentCenter;
    [scrollView addSubview:self.fnameTxt];
   
    
    self.lnametxt=[[UITextField alloc]init];
    self.lnametxt.frame=CGRectMake(windowSize.width/2-20, 120, 163, 27);
    self.lnametxt.delegate=self;
    [self.lnametxt setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    [scrollView addSubview:self.lnametxt];
    self.lnametxt.textAlignment=NSTextAlignmentCenter;
    self.lnametxt.font=[UIFont systemFontOfSize:12];
    

    
    self.emailtxt=[[UITextField alloc]init];
    self.emailtxt.frame=CGRectMake(windowSize.width/2-20, 160, 163, 27);
    self.emailtxt.delegate=self;
    [self.emailtxt setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    [scrollView addSubview:self.emailtxt];
    self.emailtxt.textAlignment=NSTextAlignmentCenter;
    self.emailtxt.font=[UIFont systemFontOfSize:12];
    
    
    self.confirmEmailtxt=[[UITextField alloc]init];
    self.confirmEmailtxt.frame=CGRectMake(windowSize.width/2-20, 200, 163, 27);
    self.confirmEmailtxt.delegate=self;
    [self.confirmEmailtxt setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    [scrollView addSubview:self.confirmEmailtxt];
    self.confirmEmailtxt.textAlignment=NSTextAlignmentCenter;
    self.confirmEmailtxt.font=[UIFont systemFontOfSize:12];
    
    if ([SingletonClass sharedSingleton].fbId) {
        self.fnameTxt.text=[SingletonClass sharedSingleton].fname;
        self.lnametxt.text=[SingletonClass sharedSingleton].lname;
        self.emailtxt.text=[SingletonClass sharedSingleton].userEmail;
        self.confirmEmailtxt.text=[SingletonClass sharedSingleton].userEmail;
    }
    
    
    self.passwordtxt=[[UITextField alloc]init];
    self.passwordtxt.frame=CGRectMake(windowSize.width/2-20, 240, 163, 27);
    self.passwordtxt.delegate=self;
    [self.passwordtxt setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    self.passwordtxt.secureTextEntry=YES;
    [scrollView addSubview:self.passwordtxt];
     self.passwordtxt.textAlignment=NSTextAlignmentCenter;
    self.passwordtxt.font=[UIFont systemFontOfSize:12];
    
    
    self.confirmPasstxt6=[[UITextField alloc]init];
    self.confirmPasstxt6.frame=CGRectMake(windowSize.width/2-20, 280, 163, 27);
    self.confirmPasstxt6.delegate=self;
    [self.confirmPasstxt6 setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    self.confirmPasstxt6.secureTextEntry=YES;
    [scrollView addSubview:self.confirmPasstxt6];
     self.confirmPasstxt6.textAlignment=NSTextAlignmentCenter;
    self.confirmPasstxt6.font=[UIFont systemFontOfSize:12];

    
    self.countrytext=[[UITextField alloc]init];
    self.countrytext.frame=CGRectMake(windowSize.width/2-20, 320, 163, 27);
    self.countrytext.delegate=self;
    [self.countrytext setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    [scrollView addSubview:self.countrytext];
     self.countrytext.textAlignment=NSTextAlignmentCenter;
    self.countrytext.font=[UIFont systemFontOfSize:12];
    
    self.phoneTxt=[[UITextField alloc]init];
    self.phoneTxt.frame=CGRectMake(windowSize.width/2-20, 360, 163, 27);
    self.phoneTxt.delegate=self;
    [self.phoneTxt setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    [scrollView addSubview:self.phoneTxt];
     self.phoneTxt.textAlignment=NSTextAlignmentCenter;
    self.phoneTxt.font=[UIFont systemFontOfSize:12];
    
     captcha=[[UILabel alloc]init];
    captcha.frame=CGRectMake(windowSize.width/2-20, 405, 163, 30);
    captcha.layer.borderColor=[UIColor grayColor].CGColor;
    captcha.layer.borderWidth=0.5f;
    captcha.textAlignment=NSTextAlignmentCenter;
    [scrollView addSubview:captcha];
    
    UIButton * refreshButton=[UIButton buttonWithType:UIButtonTypeCustom]
    ;
    refreshButton.frame=CGRectMake(captcha.frame.size.width-20, 0, 15, 15);
    [refreshButton setBackgroundImage:[UIImage imageNamed:@"refresh_icon.png"] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(loadCaptch) forControlEvents:UIControlEventTouchUpInside];
    [captcha insertSubview:refreshButton aboveSubview:captcha];
    
    self.securCodetxt=[[UITextField alloc]init];
    self.securCodetxt.frame=CGRectMake(windowSize.width/2-20, 450, 163, 27);
    self.securCodetxt.delegate=self;
    [self.securCodetxt setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    [scrollView addSubview:self.securCodetxt];
     self.securCodetxt.textAlignment=NSTextAlignmentCenter;
     self.securCodetxt.font=[UIFont systemFontOfSize:12];
    
    //Labels
    
    self.signupnameLbl=[[UILabel alloc]init];
    self.signupnameLbl.frame=CGRectMake(windowSize.width/2-135, 80, 100, 27);
    self.signupnameLbl.text=@"*이름";
    self.signupnameLbl.font=[UIFont systemFontOfSize:12];
    [scrollView addSubview:self.signupnameLbl];
    
    NSMutableAttributedString *text8 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.signupnameLbl.attributedText];
    
    [text8 addAttribute:NSForegroundColorAttributeName
                  value:[UIColor redColor]
                  range:NSMakeRange(0, 1)];
    [ self.signupnameLbl setAttributedText: text8];
    
    self.sexLbl=[[UILabel alloc]init];
    self.sexLbl.frame=CGRectMake(windowSize.width/2-135, 120, 100, 27);
    self.sexLbl.text=@"*성";
    self.sexLbl.font=[UIFont systemFontOfSize:12];
    [scrollView addSubview:self.sexLbl];
    
    NSMutableAttributedString *text7 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString:self.sexLbl.attributedText];
    
    [text7 addAttribute:NSForegroundColorAttributeName
                  value:[UIColor redColor]
                  range:NSMakeRange(0, 1)];
    [ self.sexLbl setAttributedText: text7];
    
    self.emailLabel=[[UILabel alloc]init];
    self.emailLabel.frame=CGRectMake(windowSize.width/2-135, 160, 100, 27);
    self.emailLabel.text=@"*이메일 주소";
    self.emailLabel.font=[UIFont systemFontOfSize:12];
    [scrollView addSubview:self.emailLabel];
    
    NSMutableAttributedString *text6 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.emailLabel.attributedText];
    
    [text6 addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(0, 1)];
    [ self.emailLabel setAttributedText: text6];
    
    self.emailconfirmLbl=[[UILabel alloc]init];
    self.emailconfirmLbl.frame=CGRectMake(windowSize.width/2-135, 200, 100, 27);
    self.emailconfirmLbl.text=@"*이메일 컨펌하기";
    self.emailconfirmLbl.font=[UIFont systemFontOfSize:12];
    [scrollView addSubview:self.emailconfirmLbl];
    
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.emailconfirmLbl.attributedText];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(0, 1)];
    [ self.emailconfirmLbl setAttributedText: text];
    
    self.passwordLbl=[[UILabel alloc]init];
    self.passwordLbl.frame=CGRectMake(windowSize.width/2-135, 240, 100, 27);
    self.passwordLbl.text=@"*비밀번호";
    self.passwordLbl.font=[UIFont systemFontOfSize:12];
    [scrollView addSubview:self.passwordLbl];
    
    NSMutableAttributedString *text1 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.passwordLbl.attributedText];
    
    [text1 addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(0, 1)];
    [self.passwordLbl setAttributedText: text1];
    
    self.confirmpasswordLbl=[[UILabel alloc]init];
    self.confirmpasswordLbl.frame=CGRectMake(windowSize.width/2-135, 280, 100, 27);
    self.confirmpasswordLbl.text=@"*비밀번호 확인";
    self.confirmpasswordLbl.font=[UIFont systemFontOfSize:12];
    [scrollView addSubview:self.confirmpasswordLbl];
    
    NSMutableAttributedString *text9 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.confirmpasswordLbl.attributedText];
    
    [text9 addAttribute:NSForegroundColorAttributeName
                  value:[UIColor redColor]
                  range:NSMakeRange(0, 1)];
    [self.confirmpasswordLbl setAttributedText: text9];
    
    
    self.countryLbl=[[UILabel alloc]init];
    self.countryLbl.frame=CGRectMake(windowSize.width/2-135, 320, 100, 27);
    self.countryLbl.text=@"*국가";
    self.countryLbl.font=[UIFont systemFontOfSize:12];
    [scrollView addSubview:self.countryLbl];
    
    NSMutableAttributedString *text2 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.countryLbl.attributedText];
    
    [text2 addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(0, 1)];
    [self.countryLbl setAttributedText: text2];
    
    self.phonenumberLbl=[[UILabel alloc]init];
    self.phonenumberLbl.frame=CGRectMake(windowSize.width/2-135, 360, 100, 27);
    self.phonenumberLbl.text=@"*전화번호";
    self.phonenumberLbl.font=[UIFont systemFontOfSize:12];
    [scrollView addSubview:self.phonenumberLbl];
    
    NSMutableAttributedString *text3 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.phonenumberLbl.attributedText];
    
    [text3 addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(0, 1)];
    [self.phonenumberLbl setAttributedText: text3];
    
    self.securitycodeLbl=[[UILabel alloc]init];
    self.securitycodeLbl.frame=CGRectMake(windowSize.width/2-135, 450, 100, 27);
    self.securitycodeLbl.text=@"*보안코드";
    self.securitycodeLbl.font=[UIFont systemFontOfSize:12];
    [scrollView addSubview:self.securitycodeLbl];
    
    
    NSMutableAttributedString *text4 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.securitycodeLbl.attributedText];
    
    [text4 addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(0, 1)];
    [self.securitycodeLbl setAttributedText: text4];
    
    //Buttons
    
    self.checkBoxButton1=[UIButton buttonWithType:UIButtonTypeCustom];
    self.checkBoxButton1.frame=CGRectMake(windowSize.width/2-145, 480, 13, 13);
    [self.checkBoxButton1 setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [self.checkBoxButton1 setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [scrollView addSubview:self.checkBoxButton1];
    
    
    self.checkBoxButton2=[UIButton buttonWithType:UIButtonTypeCustom];
    self.checkBoxButton2.frame=CGRectMake(windowSize.width/2-145, 500, 13, 13);
    [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    [scrollView addSubview:self.checkBoxButton2];
    
    
    // Check box labels
    
    self.chk1Lbl=[[UILabel alloc]init];
    self.chk1Lbl.frame=CGRectMake(windowSize.width/2-130,480, windowSize.width/2+20, 13);
    self.chk1Lbl.text=@"앞으로 뉴스레터를 받아보겠습니다";
    self.chk1Lbl.font=[UIFont systemFontOfSize:11];
    [scrollView addSubview:self.chk1Lbl];
    
   
    NSMutableAttributedString * attributedString=[[NSMutableAttributedString alloc]initWithString:@"다음 사항에 동의합니다."];
    
    [attributedString addAttribute:NSLinkAttributeName value:[UIColor lightGrayColor] range:[[attributedString string] rangeOfString:@"규약조건"]];
    
    self.chk2lbl=[[UILabel alloc]init];
    self.chk2lbl.frame=CGRectMake(windowSize.width/2-130, 500, windowSize.width/2, 13);
    self.chk2lbl.text=@"다음 사항에 동의합니다.규약조건";
    self.chk2lbl.font=[UIFont systemFontOfSize:11];
    [scrollView addSubview:self.chk2lbl];
    
    NSMutableAttributedString *text5 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.chk2lbl.attributedText];
    
    [text5 addAttribute:NSForegroundColorAttributeName
                 value:[UIColor lightGrayColor]
                 range:NSMakeRange(13, 4)];
    [self.chk2lbl setAttributedText: text5];
    
    
    self.signUp=[UIButton buttonWithType:UIButtonTypeCustom];
    self.signUp.frame=CGRectMake(windowSize.width-100, 485, 84, 31);
    [self.signUp setBackgroundImage:[UIImage imageNamed:@"signup_btn.png"] forState:UIControlStateNormal];
    [self.signUp addTarget:self action:@selector(signUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.signUp];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==self.countrytext) {
        [textField resignFirstResponder];
        [self selectCountoryName];
        return NO;
    }
    if (textField==self.phoneTxt) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame=CGRectMake(0, -100, windowSize.width, windowSize.height);
        }];
    }
    if (textField==self.securCodetxt) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame=CGRectMake(0, -200, windowSize.width, windowSize.height);
        }];
    }
    return  YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField==self.phoneTxt) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame=CGRectMake(0, 0, windowSize.width, windowSize.height);
        }];
    }
    if (textField==self.securCodetxt) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.frame=CGRectMake(0, 0, windowSize.width, windowSize.height);
        }];
    }
    return  YES;
}

#pragma mark- selectCountoryName

-(void)selectCountoryName{
    
    self.pickerView=[[UIPickerView alloc]init];
    self.pickerView.frame=CGRectMake(0, windowSize.height/2+15, windowSize.width, windowSize.height/2);
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    self.pickerView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.pickerView];
}


#pragma  mark- picker view delegate methods
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 25.0f;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [countryName objectAtIndex:row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return countryCode.count;;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    self.countrytext.text=[countryName objectAtIndex:row] ;
    countryCodeStr=[countryCode objectAtIndex:row];
    
    [self.pickerView removeFromSuperview];
}



#pragma  amrk- layout setting 


#pragma mark - sign up action

-(void)signUpAction:(UIButton*)sender
{
   

        
        NSString * error=[self validation];
        if (error && ![error isEqualToString:@""]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Error message" message:error delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        else{
            NSError *  error;
            NSURLResponse * urlResponse;
        
            NSURL * url=[NSURL URLWithString:[NSString stringWithFormat: @"http://www.biscash.com/windex.php?method=signup&email=%@&password=%@&fname=%@&country=%@&lname=%@&phone=%@",self.emailtxt.text,self.passwordtxt.text,self.fnameTxt.text,countryCodeStr,self.lnametxt.text,self.phoneTxt.text]];
        
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
    }

-(NSString *)validation{
    if ([self.fnameTxt.text length]==0) {
        return @"Please enter name.";
    }
    else if([self.lnametxt.text length]==0){
        return @"Please enter last name.";
    }
    else if ([self.emailtxt.text length]==0){
        return @"Please enter email-Id.";
    }
    else if(![self.emailtxt.text isEqualToString:self.confirmEmailtxt.text]){
        return @"Please confirm email-Id.";
    }
    else if ([self.passwordtxt.text length]==0){
        return @"Please enter password.";
    }
    else if(![self.confirmPasstxt6.text isEqualToString:self.passwordtxt.text]){
        return @"Please confirm password.";
    }
    else if (![captcha.text isEqualToString:self.securCodetxt.text])
    {
        [self loadCaptch];
        return @"Captch code not matched.";
        
    }
    return @"";
}


-(void)loadCaptch{
    @try {
        
        
        i1 = arc4random() % [captchArr count];
        
        NSLog(@"RANDOM INDEX:%lu ",(unsigned long)i1);
        
        i2= arc4random() % [captchArr count];
        
        NSLog(@"RANDOM INDEX:%lu ",(unsigned long)i2);
        i3 = arc4random() % [captchArr count];
        
        NSLog(@"RANDOM INDEX:%lu ",(unsigned long)i3);
        
        i4 = arc4random() % [captchArr count];
        
        NSLog(@"RANDOM INDEX:%lu ",(unsigned long)i4);
        
        i5 = arc4random() % [captchArr count];
        
        NSLog(@"RANDOM INDEX:%lu ",(unsigned long)i5);
        
        Captcha_string = [NSString stringWithFormat:@"%@%@%@%@%@",[captchArr objectAtIndex:i1-1],[captchArr objectAtIndex:i2-1],[captchArr objectAtIndex:i3-1],[captchArr objectAtIndex:i4-1],[captchArr objectAtIndex:i5-1]];
        
        NSLog(@" Captcha String : %@",Captcha_string);
        
        captcha.text = Captcha_string;
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
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
