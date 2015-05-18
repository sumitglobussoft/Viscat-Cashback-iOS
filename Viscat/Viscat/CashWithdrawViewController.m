//
//  CashWithdrawViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 17/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "CashWithdrawViewController.h"

@interface CashWithdrawViewController ()

@end

@implementation CashWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];

       windowSize =[UIScreen mainScreen].bounds.size;
    pickerViewData=[NSArray arrayWithObjects:@"PayPal",@"Wire Transfer", nil];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}

-(void)createUI{
    UILabel * titleLbl=[[UILabel alloc]init];
    titleLbl.frame=CGRectMake(20, 0, 60, 30);
    titleLbl.text=@"현금 인출";
    titleLbl.font=[UIFont boldSystemFontOfSize:16];
    [self.view addSubview:titleLbl];
    
    topLabel=[[UILabel alloc]init];
    topLabel.frame=CGRectMake(windowSize.width/2-140, 30, 278, 30);
    topLabel.backgroundColor=[UIColor colorWithRed:(CGFloat)92/255 green:(CGFloat)92/255 blue:(CGFloat)92/255 alpha:1.0];
    topLabel.hidden=YES;
    
    [self.view addSubview:topLabel];
    
    self.userText=[[UITextField alloc]init];
    self.userText.frame=CGRectMake(windowSize.width/2-40, 80, 163, 27);
    self.userText.delegate=self;
    self.userText.layer.cornerRadius=7;
     [self.userText setBackground:[UIImage imageNamed:@"cash_withdraw_fill.png"]];
    self.userText.clipsToBounds=YES;
    self.userText.placeholder=@"\u20A9 3,000.00";
    self.userText.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.userText];
    
    userName=[[UILabel alloc]init];
    userName.frame=CGRectMake(40,80, 50, 25);
    userName.text=@"총액";
    userName.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:userName];
    
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
        
    }
    
    [self.view addSubview:self.passwordbtn];
    
    
    UILabel * passLbl=[[UILabel alloc]init];
    passLbl.frame=CGRectMake(40,130, 50, 25);
    passLbl.text=@"지불방법";
    passLbl.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:passLbl];
    
    imgView=[[UIImageView alloc]init];
    imgView.frame=CGRectMake(20, windowSize.height/2-30,windowSize.width-40 , 1);
    imgView.image=[UIImage imageNamed:@"divider.png"];
    [self.view addSubview:imgView];
    
    self.loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.frame=CGRectMake(windowSize.width-80, windowSize.height/2-20, 42, 26);
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"withdraw_btn.png"] forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius=7;
    self.loginButton.clipsToBounds=YES;
    [self.view addSubview:self.loginButton];
    
    bottomLbl=[[UILabel alloc]init];
    bottomLbl.frame=CGRectMake(windowSize.width/2-100, windowSize.height-130, windowSize.width-100,30);
    bottomLbl.textColor=[UIColor lightGrayColor];
    bottomLbl.font=[UIFont systemFontOfSize:10];
    bottomLbl.text=@"회사소개 / 뉴스 / 규정&조건 / 개인정보보호 / 연락하기";
    [self.view addSubview:bottomLbl];
    
    
   
    
    
    [self layutSetting];
}


#pragma mark- pricker View
-(void)createPickerView{
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
    [textField resignFirstResponder];
    
    
    return NO;
}

#pragma mark- PickerView delegate method

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40.0f;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerViewData objectAtIndex:row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.passwordbtn setTitle:[pickerViewData objectAtIndex:row] forState:UIControlStateNormal];
    [self.pickerView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
