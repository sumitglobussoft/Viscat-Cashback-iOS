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
    UIImageView * alertView;
}
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeHeaderTitle" object:@"가입하기"];
    self.view.backgroundColor=[UIColor whiteColor];
    captchArr = [[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
   
    
    countryName=[NSArray arrayWithObjects:@"Afghanistan",@"Aland Islands",@"Albania",@"Algeria",@"American Samoa",@"Andorra",@"Angola",@"Anguilla",@"Antigua and Barbuda",@"Argentina",@"Armenia",@"Aruba",@"Australia",@"Austria",@"Azerbaijan",@"Bahamas",@"Bahrain",@"Bangladesh",@"Barbados",@"Belarus",@"Belgium",@"Belize",@"Benin",@"Bermuda",@"Bhutan",@"Bolivia", @"Bosnia and Herzegovina",@"Botswana",@"Bouvet Island",@"Brazil",@"British Indian Ocean Territory",@"Brunei Darussalam",@"Bulgaria",@"Burkina Faso",@"Burundi",@"Cambodia",@"Cameroon",@"Canada",@"Cape Verde",@"Cayman Islands",@"Central African Republic",@"Chad",@"Chile",@"China",@"Christmas Island",@"Cocos (Keeling) Islands",@"Colombia",@"Comoros",@"Congo",@"Congo, The Democratic Republic of the",@"Cook Islands",@"Costa Rica",@"Cote D'Ivoire",@"Croatia",@"Cuba",@"Cyprus",@"Czech Republic",@"Denmark",@"Djibouti",@"Dominica", @"Dominican Republic",@"Ecuador",@"Egypt",@"El Salvador",@"Equatorial Guinea",@"Eritrea",@"Estonia",@"Ethiopia",@"Falkland Islands (Malvinas)",@"Faroe Islands",@"Fiji",@"Finland",@"France",@"French Guiana",@"French Polynesia",@"French Southern Territories",@"Gabon",@"Gambia",@"Georgia",@"Germany",@"Ghana",@"Gibraltar",@"Greece",@"Greenland",@"Grenada",@"Guadeloupe", @"Guam",@"Guatemala",@"Guinea",@"Guinea-Bissau",@"Guyana",@"Haiti",@"Heard Island and McDonald Islands",@"Holy See (Vatican City State)",@"Honduras",@"Honduras",@"Hong Kong",@"Hungary",@"Iceland",@"India",@"Indonesia",@"Iran, Islamic Republic of",@"Iraq",@"Ireland",@"Israel",@"Italy",@"Jamaica",@"Japan",@"Jordan",@"Kazakhstan",@"Kenya",@"Kiribati",@"Korea, Democratic People's Republic of",@"Korea, Republic of",@"Kuwait",@"Kyrgyzstan",@"Lao People's Democratic Republic",@"Latvia",@"Lebanon",@"Lesotho",@"Liberia",@"Libyan Arab Jamahiriya",@"Liechtenstein Islands",@"Lithuania",@"Luxembourg",@"Macao",@"Macedonia",@"Madagascar",@"Malawi",@"Malaysia",@"Maldives",@"Mali",@"Malta",@"Marshall Islands",@"Martinique",@"Mauritania",@"Mauritius",@"Mayotte",@"Mexico",@"Micronesia, Federated States of",@"Moldova, Republic of",@"Monaco",@"Mongolia",@"Montenegro",@"Montserrat",@"Morocco",@"Mozambique", @"Myanmar",@"Namibia",@"Nauru",@"Nepal",@"Netherlands",@"Netherlands Antilles",@"New Caledonia",@"New Zealand",@"Nicaragua",@"Niger",@"Nigeria",@"Niue",@"Norfolk Island",@"Northern Mariana Islands",@"Norway",@"Oman",@"Pakistan",@"Palau",@"Palestinian Territory, Occupied",@"Panama",@"Papua New Guinea",@"Paraguay",@"Peru",@"Philippines",@"Pitcairn",@"Poland",@"Portugal",@"Puerto Rico",@"Qatar",@"Reunion",@"Romania",@"Russian Federation",@"Rwanda",@"Saint Helena", @"Saint Kitts and Nevis",@"Saint Lucia",@"Saint Pierre and Miquelon",@"Saint Vincent and the Grenadines",@"Samoa",@"San Marino",@"Sao Tome and Principe",@"Saudi Arabia",@"Senegal",@"Serbia",@"Seychelles",@"Sierra Leone",@"Singapore",@"Slovakia",@"Slovenia",@"Solomon Islands",@"Somalia",@"South Africa",@"South Georgia",@"Spain",@"Sri Lanka",@"Sudan",@"Suriname",@"Svalbard and Jan Mayen",@"Swaziland",@"Sweden", @"Switzerland",@"Syrian Arab Republic",@"Taiwan, Province Of China",@"Tajikistan",@"Tanzania, United Republic of",@"Thailand",@"Timor-Leste",@"Togo",@"Tokelau",@"Tonga",@"Trinidad and Tobago",@"Tunisia",@"Turkey",@"Turkmenistan",@"Turks and Caicos Islands",@"Tuvalu",@"Uganda",@"Ukraine",@"United Arab Emirates",@"United Kingdom",@"United States",@"United States Minor Outlying Islands",@"Uruguay",@"Uzbekistan",@"Vanuatu",@"Venezuela",@"Viet Nam",@"Virgin Islands, British",@"Virgin Islands, British",@"Virgin Islands, U.S.",@"Wallis And Futuna",@"Western Sahara",@"Lebanon",@"Lesotho",@"Yemen",@"Zambia",@"Zimbabwe",nil];
    
   
   
    

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(createUI) name:@"signIn" object:nil];
    windowSize =[UIScreen mainScreen].bounds.size;
    [alertView removeFromSuperview];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];
    if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {
        [self createUI];
        [self loadCaptch];
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
#pragma textField Delgate methods


#pragma mark- createUI

-(void)createUI{
    
     [alertView removeFromSuperview];
    scrollView=[[UIScrollView alloc]init];
    scrollView.frame=CGRectMake(0, 0, windowSize.width, windowSize.height);
    
    [self.view addSubview:scrollView];
    if (windowSize.height==480) {
         scrollView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.3);
    }
    else{
        if ([UIScreen mainScreen].bounds.size.height==736 || [UIScreen mainScreen].bounds.size.height==667) {
            scrollView.contentSize=CGSizeMake(windowSize.width, windowSize.height);
        }
         scrollView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.1);
    }
   
    
    titleLabel=[[UILabel alloc]init];
    titleLabel.frame=CGRectMake(20,0, 150, 30);
    titleLabel.text=@"가입하기";
    titleLabel.font=[UIFont systemFontOfSize:14];
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
    self.fnameTxt.placeholder=@"First name";
    [scrollView addSubview:self.fnameTxt];
   
    
    self.lnametxt=[[UITextField alloc]init];
    self.lnametxt.frame=CGRectMake(windowSize.width/2-20, 120, 163, 27);
    self.lnametxt.delegate=self;
    [self.lnametxt setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    [scrollView addSubview:self.lnametxt];
    self.lnametxt.textAlignment=NSTextAlignmentCenter;
    self.lnametxt.placeholder=@"Last name";
    self.lnametxt.font=[UIFont systemFontOfSize:12];
    

    
    self.emailtxt=[[UITextField alloc]init];
    self.emailtxt.frame=CGRectMake(windowSize.width/2-20, 160, 163, 27);
    self.emailtxt.delegate=self;
    [self.emailtxt setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    [scrollView addSubview:self.emailtxt];
    self.emailtxt.textAlignment=NSTextAlignmentCenter;
     self.emailtxt.placeholder=@"email ";
    self.emailtxt.font=[UIFont systemFontOfSize:12];
    
    
    self.confirmEmailtxt=[[UITextField alloc]init];
    self.confirmEmailtxt.frame=CGRectMake(windowSize.width/2-20, 200, 163, 27);
    self.confirmEmailtxt.delegate=self;
    [self.confirmEmailtxt setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
     self.confirmEmailtxt .placeholder=@"Cinfirm email ";
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
    self.passwordtxt.placeholder=@"Password";
    [scrollView addSubview:self.passwordtxt];
     self.passwordtxt.textAlignment=NSTextAlignmentCenter;
    self.passwordtxt.font=[UIFont systemFontOfSize:12];
    
    
    self.confirmPasstxt6=[[UITextField alloc]init];
    self.confirmPasstxt6.frame=CGRectMake(windowSize.width/2-20, 280, 163, 27);
    self.confirmPasstxt6.delegate=self;
    [self.confirmPasstxt6 setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    self.confirmPasstxt6.secureTextEntry=YES;
    self.confirmPasstxt6.placeholder=@"Confirm password";
    [scrollView addSubview:self.confirmPasstxt6];
     self.confirmPasstxt6.textAlignment=NSTextAlignmentCenter;
    self.confirmPasstxt6.font=[UIFont systemFontOfSize:12];

    
    self.countrytext=[[UITextField alloc]init];
    self.countrytext.frame=CGRectMake(windowSize.width/2-20, 320, 163, 27);
    self.countrytext.delegate=self;
    [self.countrytext setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    [scrollView addSubview:self.countrytext];
    self.countrytext.placeholder=@"Country";
     self.countrytext.textAlignment=NSTextAlignmentCenter;
    self.countrytext.font=[UIFont systemFontOfSize:12];
    
    self.phoneTxt=[[UITextField alloc]init];
    self.phoneTxt.frame=CGRectMake(windowSize.width/2-20, 360, 163, 27);
    self.phoneTxt.delegate=self;
    [self.phoneTxt setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    self.phoneTxt.placeholder=@"Phone number";
    [scrollView addSubview:self.phoneTxt];
     self.phoneTxt.textAlignment=NSTextAlignmentCenter;
    self.phoneTxt.font=[UIFont systemFontOfSize:12];
    
     captcha=[[UILabel alloc]init];
    captcha.frame=CGRectMake(windowSize.width/2-20, 405, 100, 30);
   // captcha.layer.borderColor=[UIColor grayColor].CGColor;
   // captcha.layer.borderWidth=0.5f;
   captcha.textAlignment=NSTextAlignmentCenter;
    [scrollView addSubview:captcha];
    
    CALayer * captchaLayer=[CALayer layer];
    captchaLayer.frame=CGRectMake(windowSize.width/2-20, 405, 163, 30);
    captchaLayer.borderColor=[UIColor grayColor].CGColor;
    [scrollView.layer addSublayer:captchaLayer];
    
    UIButton * refreshButton=[UIButton buttonWithType:UIButtonTypeCustom]
    ;
    refreshButton.frame=CGRectMake(windowSize.width/2+100, 405, 15, 15);
    [refreshButton setBackgroundImage:[UIImage imageNamed:@"refresh_icon.png"] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(loadCaptch) forControlEvents:UIControlEventTouchUpInside];
    //[captcha insertSubview:refreshButton aboveSubview:captcha];
    [scrollView addSubview:refreshButton];
    
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
    self.securitycodeLbl.frame=CGRectMake(windowSize.width/2-135, 450, 80, 27);
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
    [self.checkBoxButton1 setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateSelected];
    [self.checkBoxButton1 addTarget:self action:@selector(rememberPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkBoxButton1 setSelected:NO];
    [scrollView addSubview:self.checkBoxButton1];
    
    
    self.checkBoxButton2=[UIButton buttonWithType:UIButtonTypeCustom];
    self.checkBoxButton2.frame=CGRectMake(windowSize.width/2-145, 500, 13, 13);
    [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [self.checkBoxButton2 setImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateSelected];
    [self.checkBoxButton2 addTarget:self action:@selector(rememberPassword1:) forControlEvents:UIControlEventTouchUpInside];
    [self.checkBoxButton2 setSelected:NO];
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
    self.signUp.frame=CGRectMake(windowSize.width/2+60, 485, 84, 31);
    [self.signUp setBackgroundImage:[UIImage imageNamed:@"signup_btn.png"] forState:UIControlStateNormal];
    [self.signUp addTarget:self action:@selector(signUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.signUp];
    
    
  

   /* UILabel*   bottomLbl=[[UILabel alloc]init];
    bottomLbl.frame=CGRectMake(20, 520, scrollView.frame.size.width-40,30);
    bottomLbl.textColor=[UIColor lightGrayColor];
    bottomLbl.font=[UIFont systemFontOfSize:10];
    bottomLbl.textAlignment=NSTextAlignmentCenter;
    bottomLbl.text=@"회사소개 / 뉴스 / 규정&조건 / 개인정보보호 / 연락하기";
    [scrollView addSubview:bottomLbl];
    
    UILabel * copyRight=[[UILabel alloc]init];
    copyRight.frame=CGRectMake(20, 540, scrollView.frame.size.width-40,30);
    copyRight.textColor=[UIColor lightGrayColor];
    copyRight.font=[UIFont systemFontOfSize:10];
    copyRight.textAlignment=NSTextAlignmentCenter;
    copyRight.text=@"2014년비스켓캐시백";
    [scrollView addSubview:copyRight];*/
}


// Check box selection
-(void)rememberPassword:(UIButton *)sender{
    
        
        if (self.checkBoxButton1.selected==YES) {
            [self.checkBoxButton1 setSelected:NO];
            
            
        }
        else{
            
            [self.checkBoxButton1 setSelected:YES];
        }
}

-(void)rememberPassword1:(UIButton *)sender{
    
    
    if (self.checkBoxButton2.selected==YES) {
        [self.checkBoxButton2 setSelected:NO];
        
    }
    else{
        
        [self.checkBoxButton2 setSelected:YES];
    }
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
    [self.pickerView removeFromSuperview];
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
    return countryName.count;;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    self.countrytext.text=[countryName objectAtIndex:row] ;
    countryNameStr=[countryName objectAtIndex:row] ;
//    countryCodeStr=[countryCode objectAtIndex:row];
    countryCodeStr=[NSString stringWithFormat:@"%ld",(long)row];
    [self.pickerView removeFromSuperview];
}



#pragma  amrk- layout setting 


#pragma mark - sign up action

-(void)signUpAction:(UIButton*)sender
{
   
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];

    if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {

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
           // NSLog(@"sign up response %@",json);
            if ([[json  objectForKey:@"status"] isEqualToString:@"1"]) {
                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"등록 성공" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
                
                [[NSUserDefaults standardUserDefaults]setObject:self.emailtxt.text forKey:@"email"];
                [[NSUserDefaults standardUserDefaults]setObject:self.passwordtxt.text forKey:@"password"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
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
    else
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"인터넷 연결을 확인하시기 바랍니다" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
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
