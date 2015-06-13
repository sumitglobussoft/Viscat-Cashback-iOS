//
//  DetailPageViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 03/04/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "DetailPageViewController.h"
#import "CustomCollectionCell.h"
#import "SingletonClass.h"
#import "WebViewViewController.h"
#import "AppDelegate.h"
#import "CustomTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"


static NSString *const menuCellIdentifier = @"rotationCell";

@interface DetailPageViewController ()
{
    UIScrollView * scrollView;
    WebViewViewController * webviewVC;
    UIButton * topRightLabel;
    BOOL isTable,israte;
    NSMutableArray * storeImg,*storeDesc,* storeCashBack,*storeTitle,*favourite_id,*sortedRetailer_id;
    NSArray * ListValues;
    UITableView * rateList;
    UIButton * rateApp;
    NSArray * rateArr,*rateArrVal;
    UITextField * titleTxt;
    UITextView * messageTxt;
    LoginViewController * loginVc;
    UIView * backView;
    UIAlertView * rateAlert;
    NSString * rateVal;
    NSString * Char;
    UILabel * name;
    UIImageView * alertView;
}
@end

@implementation DetailPageViewController

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
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeHeaderTitle" object:@"Detail Page"];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(returnHome) name:@"removeHome" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    windowSize=[UIScreen mainScreen].bounds.size;
    
     self.view.backgroundColor=[UIColor whiteColor];
    [name removeFromSuperview];
     storeImg=[[NSMutableArray alloc]init];
     storeDesc=[[NSMutableArray alloc]init];
     storeUrl=[[NSMutableArray alloc]init];
     storeCashBack=[[NSMutableArray alloc]init];
     storeTitle=[[NSMutableArray alloc]init];
     favourite_id=[[NSMutableArray alloc]init];
    sortedRetailer_id=[[NSMutableArray alloc]init];
    ListValues=[NSArray arrayWithObjects:@"0-9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    rateArr=[NSArray arrayWithObjects:@"★★★★★ - 최고 우수",@"★★★★ - 아주 좋음",@"★★★ - 좋음",@"★★ - 적당함",@"★ - 부족함", nil];
    rateArrVal=[NSArray arrayWithObjects:@"5",@"4",@"3",@"2",@"1", nil];
    if ([SingletonClass sharedSingleton].isFromHome==YES) {
        [SingletonClass sharedSingleton].isFromHome=NO;
    }
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
    
    // Do any additional setup after loading the view from its nib.
}

-(void)backButtonAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



-(void)returnHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark- textfield delegate methods


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([textView.text length]==100) {
        return NO;
    }
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [titleTxt endEditing:YES];
    return YES;
}

#pragma  mark- create UI of detail page

-(void)createUI{
     [alertView removeFromSuperview];
    //[[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadViewController" object:nil];
    dispatch_async(dispatch_get_main_queue(),^{
       [self recomendedService];
    });
    
    [self.listTable removeFromSuperview];
    
    if (scrollView) {
        [scrollView removeFromSuperview];
        scrollView=nil;
    }
    scrollView=[[UIScrollView alloc]init];
    scrollView.frame=CGRectMake(0, 0, windowSize.width, windowSize.height);
    scrollView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:scrollView];
    scrollView.showsVerticalScrollIndicator=NO;
    if(windowSize.height>500){
        if (windowSize.height==736) {
            scrollView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.2);
        }
        else{
            scrollView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.6);
        }
    }
    else{
        scrollView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.8);
    }
    [scrollView setNeedsDisplay];
    
    // Top Labels
    UILabel * topLeftLabel=[[UILabel alloc]init];// I will add attribute text here
    topLeftLabel.frame=CGRectMake(20, 0, 60, 30);
    topLeftLabel.font=[UIFont systemFontOfSize:14];
    topLeftLabel.text=[SingletonClass sharedSingleton].topTitle;
    [scrollView addSubview:topLeftLabel];
    [topLeftLabel setNeedsDisplay];
    
    NSString * cashBackStr1=[SingletonClass sharedSingleton].cashBackStr;

    UILabel * topCashBackLbl=[[UILabel alloc]init];
    topCashBackLbl.frame=CGRectMake(100, 0, 100, 30);
    topCashBackLbl.font=[UIFont systemFontOfSize:15];
    topCashBackLbl.textColor=[UIColor redColor];
    topCashBackLbl.text=[SingletonClass sharedSingleton].cashBackStr;
    [scrollView addSubview:topCashBackLbl];
    [topCashBackLbl setNeedsDisplay];
    
    
    topRightLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    topRightLabel.frame=CGRectMake(windowSize.width-100,10, 15, 15);
    //[topRightLabel setTitle:@"menu" forState:UIControlStateNormal];
    [topRightLabel setImage:[UIImage imageNamed:@"dropper_icon_new.png"] forState:UIControlStateNormal];
    [topRightLabel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [topRightLabel addTarget:self action:@selector(createDropDownMenu) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:topRightLabel];
    
    
   ///////////////////////////////////////////
    
    UIView * topView=[[UIView alloc]init];
    topView.frame=CGRectMake(20, 40, windowSize.width-40, 159);
    topView.clipsToBounds=YES;
  
    [scrollView addSubview:topView];
    
    [topView setNeedsDisplay];
    
    UIImageView * topViewImage=[[UIImageView alloc]init];
    topViewImage.frame=CGRectMake(0, 0, topView.frame.size.width, topView.frame.size.height);
    topViewImage.image=[UIImage imageNamed:@"product_detailbox_star.png"];
    [topView addSubview:topViewImage];
    
    
    UILabel * couponLbl=[[UILabel alloc]init];
    couponLbl.frame=CGRectMake(windowSize.width/2-125, 0, 20, 20);
    couponLbl.font=[UIFont boldSystemFontOfSize:8];
    couponLbl.textColor=[UIColor blueColor];
    couponLbl.text=@"쿠폰";
    [topView addSubview:couponLbl];
    [couponLbl setNeedsDisplay];
    
    UILabel * coupondata=[[UILabel alloc]init];
    coupondata.frame=CGRectMake(windowSize.width/2-110, 0, 25, 20);
    coupondata.font=[UIFont boldSystemFontOfSize:8];
    coupondata.textColor=[UIColor grayColor];
    coupondata.text=[SingletonClass sharedSingleton].coupns;
    [topView addSubview:coupondata];
    [coupondata setNeedsDisplay];
    
    UILabel * reviewLbl=[[UILabel alloc]init];
    reviewLbl.frame=CGRectMake(windowSize.width/2-90, 0, 15, 20);
    reviewLbl.font=[UIFont boldSystemFontOfSize:8];
    reviewLbl.textColor=[UIColor blueColor];
    reviewLbl.text=@"후기";
    [topView addSubview:reviewLbl];
    [reviewLbl setNeedsDisplay];
    
    UILabel * reviewdata=[[UILabel alloc]init];
    reviewdata.frame=CGRectMake(windowSize.width/2-75, 0, 25, 20);
    reviewdata.font=[UIFont boldSystemFontOfSize:8];
    reviewdata.textColor=[UIColor grayColor];
    reviewdata.text=[SingletonClass sharedSingleton].reviews;
    [topView addSubview:reviewdata];
    [reviewdata setNeedsDisplay];
    
    UILabel * favLbl=[[UILabel alloc]init];
    favLbl.frame=CGRectMake(windowSize.width/2-40, 0, 30, 20);
    favLbl.font=[UIFont boldSystemFontOfSize:8];
    favLbl.textColor=[UIColor blueColor];
    favLbl.text=@"즐겨찾기";
    [topView addSubview:favLbl];
    [favLbl setNeedsDisplay];
    
    UILabel * favdata=[[UILabel alloc]init];
    favdata.frame=CGRectMake(windowSize.width/2-10, 0, 30, 20);
    favdata.font=[UIFont boldSystemFontOfSize:8];
    favdata.textColor=[UIColor grayColor];
    favdata.text=[SingletonClass sharedSingleton].fav;
    [topView addSubview:favdata];
    [favdata setNeedsDisplay];
    
    UILabel * addedLbl=[[UILabel alloc]init];
    addedLbl.frame=CGRectMake(windowSize.width-140, 0, 40, 20);
    addedLbl.font=[UIFont boldSystemFontOfSize:8];
    addedLbl.textColor=[UIColor blueColor];
    addedLbl.text=@"날짜 추가됨";
    [topView addSubview:addedLbl];
    [addedLbl setNeedsDisplay];
    
    
    UILabel * addeddata=[[UILabel alloc]init];
    addeddata.frame=CGRectMake(windowSize.width-100, 0, 45, 20);
    addeddata.font=[UIFont boldSystemFontOfSize:8];
    addeddata.textColor=[UIColor grayColor];
    addeddata.text=[SingletonClass sharedSingleton].added;
    [topView addSubview:addeddata];
    [addeddata setNeedsDisplay];
    
    NSURL * url=[NSURL URLWithString: [SingletonClass sharedSingleton].detailImgUrl];
    NSData * imageData=[NSData dataWithContentsOfURL:url];
    
    UIImageView * detailImgView=[[UIImageView alloc]init];
    detailImgView.frame=CGRectMake(20, 20, 60, 40);
    detailImgView.image=[UIImage imageWithData:imageData];
    [topView addSubview:detailImgView];
    [detailImgView setNeedsDisplay];
    
    UILabel * cashBackLbl=[[UILabel alloc]init];
    cashBackLbl.frame=CGRectMake(100, 30, 100, 30);
    cashBackLbl.font=[UIFont systemFontOfSize:15];
    cashBackLbl.textColor=[UIColor grayColor];
    cashBackLbl.text=[SingletonClass sharedSingleton].cashBackStr;
    [topView addSubview:cashBackLbl];
    [cashBackLbl setNeedsDisplay];
    
    UILabel * descripttion=[[UILabel alloc]init];
    descripttion.frame=CGRectMake(20, 50, topView.frame.size.width-40, 50);
    descripttion.text=[SingletonClass sharedSingleton].detail_description;
    descripttion.font=[UIFont systemFontOfSize:9];
    descripttion.numberOfLines=0;
    descripttion.lineBreakMode=NSLineBreakByWordWrapping;
    descripttion.textColor=[UIColor grayColor];
    [topView addSubview:descripttion];
    [descripttion setNeedsDisplay];
    
    
    UILabel * reviews=[[UILabel alloc]init];
    reviews.frame=CGRectMake(20, 95, 40, 20);
    reviews.text=@"Reviews:";
    reviews.font=[UIFont systemFontOfSize:9];
    reviews.numberOfLines=0;
    reviews.lineBreakMode=NSLineBreakByWordWrapping;
    reviews.textColor=[UIColor blackColor];
    [topView addSubview:reviews];
    
    if ([self.starsCount floatValue]==0.50||[self.starsCount floatValue]==1.0) {
        UIImageView * reviewImg=[[UIImageView alloc]init];
        reviewImg.frame=CGRectMake(70, 100, 58, 11);
        reviewImg.image=[UIImage imageNamed:@"empty_4 star.png"];
        [topView addSubview:reviewImg];
        
        
    }
   else if ([self.starsCount floatValue]==1.50||[self.starsCount floatValue]==2.0) {
        UIImageView * reviewImg=[[UIImageView alloc]init];
        reviewImg.frame=CGRectMake(70, 100, 58, 11);
        reviewImg.image=[UIImage imageNamed:@"empty_3 star.png"];
        [topView addSubview:reviewImg];
        
        
    }
  else  if ([self.starsCount floatValue]==2.50||[self.starsCount floatValue]==3.0) {
        UIImageView * reviewImg=[[UIImageView alloc]init];
        reviewImg.frame=CGRectMake(70, 100, 58, 11);
        reviewImg.image=[UIImage imageNamed:@"empty_2 star.png"];
        [topView addSubview:reviewImg];
        
        
    }
    
   else if ([self.starsCount floatValue]==3.50||[self.starsCount floatValue]==4.0) {
        UIImageView * reviewImg=[[UIImageView alloc]init];
        reviewImg.frame=CGRectMake(70, 100, 58, 11);
        reviewImg.image=[UIImage imageNamed:@"empty_1 star.png"];
        [topView addSubview:reviewImg];
        

    }
   else if ([self.starsCount floatValue]==4.50||[self.starsCount floatValue]==5.0) {
        UIImageView * reviewImg=[[UIImageView alloc]init];
        reviewImg.frame=CGRectMake(70, 100, 58, 11);
        reviewImg.image=[UIImage imageNamed:@"filledstars.png"];
        [topView addSubview:reviewImg];
    }
   else if ([self.starsCount floatValue]==0.0) {
        UIImageView * reviewImg=[[UIImageView alloc]init];
        reviewImg.frame=CGRectMake(70, 100, 58, 11);
        reviewImg.image=[UIImage imageNamed:@"empty_star.png"];
        [topView addSubview:reviewImg];
    }
    
    UIButton * gotoStore=[UIButton buttonWithType:UIButtonTypeCustom];
    gotoStore.frame=CGRectMake(windowSize.width-130, topView.frame.size.height-2, 98, 23);
    [gotoStore setBackgroundImage:[UIImage imageNamed:@"gotostore_btn"] forState:UIControlStateNormal];
        [scrollView addSubview:gotoStore];
    gotoStore.tag=1;
    [gotoStore setNeedsDisplay];
    
    
    UIImageView * flagImgView=[[UIImageView alloc]init];
    flagImgView.frame=CGRectMake(25, topView.frame.size.height+5, 17, 12);
    flagImgView.image=[UIImage imageNamed:@"flag.png"];
    [scrollView addSubview:flagImgView];
    
    
    UIImageView * favouriteStar=[[UIImageView alloc]init];
    favouriteStar.frame=CGRectMake(50, topView.frame.size.height+5, 11, 11);
    favouriteStar.image=[UIImage imageNamed:@"filledstar.png"];
    [scrollView addSubview:favouriteStar];
    
    UIButton * addFavourite=[[UIButton alloc]init];
    addFavourite.frame=CGRectMake(62, topView.frame.size.height, 100, 25);
    [addFavourite setTitle:@"즐겨찾기에 추가하기" forState:UIControlStateNormal];
    [addFavourite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addFavourite.titleLabel.font=[UIFont systemFontOfSize:10];
   
    [scrollView addSubview:addFavourite];
    
    
    UIButton * moreShare=[[UIButton alloc]init];
    moreShare.frame=CGRectMake(windowSize.width-100, 210, 36, 26);
    [moreShare setBackgroundImage:[UIImage imageNamed:@"share_btn.png"] forState:UIControlStateNormal];
    moreShare.tag=2;
    
    [scrollView addSubview:moreShare];

    
   ///////////////////////////
    
    UILabel * lable2=[[UILabel alloc]init];
    lable2.frame=CGRectMake(20, 220, 100, 25);
    lable2.text=@"캐시백 계산기";
    lable2.font=[UIFont boldSystemFontOfSize:10];
    [scrollView addSubview:lable2];
    [lable2 setNeedsDisplay];
    
    CALayer * layer=[CALayer layer];
    layer.frame=CGRectMake(20, 250, windowSize.width-40, 60);
    layer.borderWidth=0.7;
    layer.borderColor=[UIColor lightGrayColor].CGColor;
    layer.cornerRadius=5;
    [scrollView.layer insertSublayer:layer atIndex:0];
    [layer setNeedsDisplay];
    
    UIImageView * verticalLine=[[UIImageView alloc]init];
    verticalLine.frame=CGRectMake(80, 250, 1, 60);
    verticalLine.image=[UIImage imageNamed:@"big_horizontaline.png"];
    [scrollView addSubview:verticalLine];
   
    
    UIImageView * horizintalLine=[[UIImageView alloc]init];
    horizintalLine.frame=CGRectMake(20, 280, windowSize.width-40, 1);
    horizintalLine.image=[UIImage imageNamed:@"divider.png"];
    [scrollView addSubview:horizintalLine];
 
    UILabel * used=[[UILabel alloc]init];
    used.frame=CGRectMake(35, 250, 50, 30);
    used.text=@"사용됨";
    used.font=[UIFont systemFontOfSize:10];
    [scrollView addSubview:used];
    
    UILabel * cashBack=[[UILabel alloc]init];
    cashBack.frame=CGRectMake(35, 280, 50, 30);
    cashBack.text=@"캐시백";
    cashBack.font=[UIFont systemFontOfSize:10];
    [scrollView addSubview:cashBack];
    
    
    UILabel * hundred=[[UILabel alloc]init];
    hundred.frame=CGRectMake(windowSize.width/2-70, 250, 35, 20);
    hundred.text=@"\u20A9 100";
    hundred.font=[UIFont systemFontOfSize:10];
    [scrollView addSubview:hundred];
    
    UILabel * fivehindred=[[UILabel alloc]init];
    fivehindred.frame=CGRectMake(windowSize.width/2, 250, 40, 20);
    fivehindred.text=@"\u20A9 500";
    fivehindred.font=[UIFont systemFontOfSize:10];
    [scrollView addSubview:fivehindred];

    UILabel * thousnd=[[UILabel alloc]init];
    thousnd.frame=CGRectMake(windowSize.width-90, 250, 40, 20);
    thousnd.text=@"\u20A9 1000";
    thousnd.font=[UIFont systemFontOfSize:10];
    [scrollView addSubview:thousnd];
    [thousnd setNeedsDisplay];
    
    NSLog(@"%@",[SingletonClass sharedSingleton].cashBackStr);
   NSString* cashBackStr10=[cashBackStr1 substringToIndex:[cashBackStr1 length] - 5];

    float cashBackInt=[cashBackStr10 floatValue];
    
    cashBackInt=(cashBackInt*1);
    cashBackStr1 =[NSString stringWithFormat:@"\u20A9 %.1f",cashBackInt];
    
    UILabel * hundred1=[[UILabel alloc]init];
    hundred1.frame=CGRectMake(windowSize.width/2-70, 280, 60, 20);
    hundred1.text=cashBackStr1;
    hundred1.font=[UIFont systemFontOfSize:10];
     hundred1.textColor=[UIColor colorWithRed:(CGFloat)79/255 green:(CGFloat)167/255 blue:(CGFloat)229/255 alpha:1];
    [scrollView addSubview:hundred1];
    
    
   
    float cashBackInt1=[cashBackStr10 floatValue];
   cashBackInt1 =(cashBackInt1*5);
  NSString*  cashBackStr2 =[NSString stringWithFormat:@"\u20A9 %.1f",cashBackInt1];
    UILabel * fivehindred1=[[UILabel alloc]init];
    fivehindred1.frame=CGRectMake(windowSize.width/2, 280, 60, 20);
    fivehindred1.text=cashBackStr2;
    fivehindred1.font=[UIFont systemFontOfSize:10];
     fivehindred1.textColor=[UIColor colorWithRed:(CGFloat)79/255 green:(CGFloat)167/255 blue:(CGFloat)229/255 alpha:1];
    [scrollView addSubview:fivehindred1];
    
    float cashBackInt2=[cashBackStr10 floatValue];
    cashBackInt2=(cashBackInt2*10);
   NSString* cashBackStr3 =[NSString stringWithFormat:@"\u20A9 %.1f",cashBackInt2];
    UILabel * thousnd1=[[UILabel alloc]init];
    thousnd1.frame=CGRectMake(windowSize.width-90, 280, 60, 20);
    thousnd1.text=cashBackStr3;
    thousnd1.font=[UIFont systemFontOfSize:10];
    thousnd1.textColor=[UIColor colorWithRed:(CGFloat)79/255 green:(CGFloat)167/255 blue:(CGFloat)229/255 alpha:1];
    [scrollView addSubview:thousnd1];
    [thousnd1 setNeedsDisplay];
//////////////////////////////////////////////////////////

    
    
    
    
    rateApp=[UIButton buttonWithType:UIButtonTypeCustom];
    rateApp.frame=CGRectMake(20,380 , windowSize.width-40, 25);
    [rateApp setTitle:@"- 평점 선택 -" forState:UIControlStateNormal];
    [rateApp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rateApp setBackgroundImage:[UIImage imageNamed:@"detail_btn.png"] forState:UIControlStateNormal];
    [rateApp addTarget:self action:@selector(tableForRateStroe) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:rateApp];

    
    UILabel * lable3=[[UILabel alloc]init];
    lable3.frame=CGRectMake(20, 340, 60, 25);
    lable3.text=@"캐시백후기";
    lable3.font=[UIFont boldSystemFontOfSize:10];
    [scrollView addSubview:lable3];
    [lable3 setNeedsDisplay];
    
    UILabel * lable3sub=[[UILabel alloc]init];
    lable3sub.frame=CGRectMake(70, 340, 160, 25);
    lable3sub.text=@"아직후기가없습니다.첫번째로후기를쓰셔서첫발자국을남겨주세요.";
    lable3sub.font=[UIFont boldSystemFontOfSize:10];
    lable3sub.textColor=[UIColor lightGrayColor];
    [scrollView addSubview:lable3sub];
    [lable3sub setNeedsDisplay];
    
   
    CALayer * layer2=[CALayer layer];
    layer2.frame=CGRectMake(20, 410, windowSize.width-40, 25);
    layer2.borderWidth=0.7;
    layer2.borderColor=[UIColor lightGrayColor].CGColor;
    layer2.cornerRadius=5;
    [scrollView.layer insertSublayer:layer2 atIndex:0];
    [layer2 setNeedsDisplay];
    
    UIImageView * verticalLine2=[[UIImageView alloc]init];
    verticalLine2.frame=CGRectMake(60, 410, 1, 25);
    verticalLine2.image=[UIImage imageNamed:@"small_horizontalline.png"];
    [scrollView addSubview:verticalLine2];
    
    
    UILabel * subject=[[UILabel alloc]init];
    subject.frame=CGRectMake(35, 410, 20, 25);
    subject.text=@"제목";
    subject.font=[UIFont boldSystemFontOfSize:10];
    [scrollView addSubview:subject];
    [subject setNeedsDisplay];

    
    titleTxt=[[UITextField alloc]init];
    titleTxt.frame=CGRectMake(62, 410, layer2.frame.size.width-60, 25);
    titleTxt.textAlignment=NSTextAlignmentCenter;
    titleTxt.font=[UIFont systemFontOfSize:12];
    titleTxt.delegate=self;
    [scrollView addSubview:titleTxt];
    
    
    CALayer * layer3=[CALayer layer];
    layer3.frame=CGRectMake(20, 440, windowSize.width-40, 60);
    layer3.borderWidth=0.7;
    layer3.borderColor=[UIColor lightGrayColor].CGColor;
    layer3.cornerRadius=5;
    [scrollView.layer insertSublayer:layer3 atIndex:0];
    [layer3 setNeedsDisplay];
    
    UIImageView * verticalLine3=[[UIImageView alloc]init];
    verticalLine3.frame=CGRectMake(60, 440, 1, 60);
    verticalLine3.image=[UIImage imageNamed:@"big_horizontaline.png"];
    [scrollView addSubview:verticalLine3];
    
    
    UILabel * message=[[UILabel alloc]init];
    message.frame=CGRectMake(35, 440, 20, 25);
    message.text=@"제목";
    message.font=[UIFont boldSystemFontOfSize:10];
    [scrollView addSubview:message];
    [message setNeedsDisplay];
    
     messageTxt=[[UITextView alloc]init];
     messageTxt.frame=CGRectMake(62, 442, layer3.frame.size.width-45, 56);
     messageTxt.delegate=self;
    [scrollView addSubview:messageTxt];
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(windowSize.width-100, 510, 61, 22);
    [button setBackgroundImage:[UIImage imageNamed:@"review_btn.png"] forState:UIControlStateNormal];
   
    [scrollView addSubview:button];
    [button setNeedsDisplay];
    
    
    
    
    UILabel * recommendation=[[UILabel alloc]init];
    recommendation.frame=CGRectMake(20, 530, 60, 25);
    recommendation.text=@"추천캐시백";
    recommendation.font=[UIFont boldSystemFontOfSize:10];
    [scrollView addSubview:recommendation];
    [recommendation setNeedsDisplay];
    
    UILabel * recommendation1=[[UILabel alloc]init];
    recommendation1.frame=CGRectMake(65, 530, 160, 25);
    recommendation1.text=@"회원님께서좋아하실만한캐시백을추천해드립니다";
    recommendation1.font=[UIFont boldSystemFontOfSize:10];
    recommendation1.textColor=[UIColor lightGrayColor];
    [scrollView addSubview:recommendation1];
    [recommendation1 setNeedsDisplay];
    
    bottomCollectioView=[[UIView alloc]init];
    bottomCollectioView.frame=CGRectMake(20.0, 580.0, windowSize.width-40, 160);
    bottomCollectioView.backgroundColor=[UIColor colorWithRed:(CGFloat)206/255 green:(CGFloat)206/255 blue:(CGFloat)206/255 alpha:(CGFloat)1];
    [scrollView addSubview:bottomCollectioView];
    [bottomCollectioView setNeedsDisplay];
    
    UIButton * moreButton=[UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame=CGRectMake(bottomCollectioView.frame.size.width-40, bottomCollectioView.frame.size.height-20, 40, 20);
    moreButton.backgroundColor=[UIColor clearColor];
    moreButton.titleLabel.font=[UIFont systemFontOfSize:8];
    [moreButton setTitle:@"+ more" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  //  [bottomCollectioView addSubview:moreButton];
    [moreButton setNeedsDisplay];
    
    [self createCollectionView];
    
    

    
   /* UILabel*   bottomLbl=[[UILabel alloc]init];
    bottomLbl.frame=CGRectMake(20, 760, scrollView.frame.size.width-40,30);
    bottomLbl.textColor=[UIColor lightGrayColor];
    bottomLbl.font=[UIFont systemFontOfSize:10];
    bottomLbl.textAlignment=NSTextAlignmentCenter;
    bottomLbl.text=@"회사소개 / 뉴스 / 규정&조건 / 개인정보보호 / 연락하기";
    [scrollView addSubview:bottomLbl];
    
    UILabel * copyRight=[[UILabel alloc]init];
    copyRight.frame=CGRectMake(20, 780, scrollView.frame.size.width-40,30);
    copyRight.textColor=[UIColor lightGrayColor];
    copyRight.font=[UIFont systemFontOfSize:10];
    copyRight.textAlignment=NSTextAlignmentCenter;
    copyRight.text=@"2014년비스켓캐시백";
    [scrollView addSubview:copyRight];*/
    
    [alertView removeFromSuperview];
    ////////////////CHECK NETWORK CHECK ////////////////////
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];
    if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {
        [gotoStore addTarget:self action:@selector(gotoStore:) forControlEvents:UIControlEventTouchUpInside];
        [addFavourite addTarget:self action:@selector(addFavouriteService) forControlEvents:UIControlEventTouchUpInside];
        [moreShare addTarget:self action:@selector(gotoStore:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(reviewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma  mark- goto to store

-(void)gotoStore:(UIButton *)sender{
    if (![SingletonClass sharedSingleton].login_userId) {
        [SingletonClass sharedSingleton].isFromDetailpage=YES;
        if (loginVc) {
            loginVc=nil;
        }
        loginVc=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
    else{
        if (webviewVC) {
            webviewVC=nil;
        }
        webviewVC=[[WebViewViewController alloc]init];
        int tag=(int)[sender tag];
        if (tag==2) {
              webviewVC.retailerID=self.retailId;
        }
       
      
        AppDelegate* appdelegate=[UIApplication sharedApplication].delegate;
        [appdelegate.window addSubview:webviewVC.view];
        //[self.navigationController pushViewController:webviewVC animated:YES];
    }
}


-(void)gotoStoreFromList:(UIButton *)sender{
    if (![SingletonClass sharedSingleton].login_userId) {
        [SingletonClass sharedSingleton].isFromDetailpage=YES;
        if (loginVc) {
            loginVc=nil;
        }
        loginVc=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
    else{
        if (webviewVC) {
            webviewVC=nil;
        }
        webviewVC=[[WebViewViewController alloc]init];
        int tag=(int)[sender tag];
        
        [SingletonClass sharedSingleton].webUrl=[storeUrl objectAtIndex:tag];
        AppDelegate* appdelegate=[UIApplication sharedApplication].delegate;
        [appdelegate.window addSubview:webviewVC.view];
        //[self.navigationController pushViewController:webviewVC animated:YES];
    }
}



-(void)gotoStoreFromListForShare:(UIButton *)sender{
    if (![SingletonClass sharedSingleton].login_userId) {
        [SingletonClass sharedSingleton].isFromDetailpage=YES;
        if (loginVc) {
            loginVc=nil;
        }
        loginVc=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
    else{
        if (webviewVC) {
            webviewVC=nil;
        }
        webviewVC=[[WebViewViewController alloc]init];
        int tag=(int)[sender tag];
       
            webviewVC.retailerID=[sortedRetailer_id  objectAtIndex:tag];
        
       
        AppDelegate* appdelegate=[UIApplication sharedApplication].delegate;
        [appdelegate.window addSubview:webviewVC.view];
        //[self.navigationController pushViewController:webviewVC animated:YES];
    }
}

#pragma mark- table for rate store

-(void)tableForRateStroe{
    if (israte==NO) {
        israte=YES;
    if (backView) {
        backView=nil;
    }
     backView=[[UIView alloc]init];
    backView.frame=CGRectMake(20, 400, rateApp.frame.size.width+6, 192);
    backView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"detail_fill.png"]];
   
    [scrollView insertSubview:backView aboveSubview:scrollView];
    if (rateList) {
        [rateList removeFromSuperview];
        rateList=nil;
    }
    rateList=[[UITableView alloc]init];
    rateList.frame=CGRectMake(5,20, backView.frame.size.width-15, backView.frame.size.height-30);
    rateList.delegate=self;
    rateList.dataSource=self;
    [rateList setShowsVerticalScrollIndicator:NO];
    [backView addSubview:rateList];
    }
    else{
        [backView removeFromSuperview];
        israte=NO;
    }
}

#pragma mark- recommended Serivice

#pragma mark- recomendedService
-(void)recomendedService{
 
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reachability" object:nil];
       if ([SingletonClass sharedSingleton].isActivenetworkConnection==YES) {
    coupnArr=[[NSMutableArray alloc]init];
    addedArr=[[NSMutableArray alloc]init];
    favArr=[[NSMutableArray alloc]init];
    reviewArr=[[NSMutableArray alloc]init];
    retailerId=[[NSMutableArray alloc]init];
    [storeUrl removeAllObjects];
    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
    
    NSString * getUrlStr=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=recomended&retailer_id=%@",self.retailId];
    NSURL * getUrl=[NSURL URLWithString:getUrlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:getUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if ([[json objectForKey:@"status"] isEqualToString:@"1"]) {
        NSArray * results=[json objectForKey:@"result"];
        NSMutableDictionary * dict=[NSMutableDictionary dictionary];
        for (int i=0; i<results.count; i++) {
            dict=[results objectAtIndex:i];
            [[SingletonClass sharedSingleton].imageUrl addObject:[dict objectForKey:@"image"]];
            
            [[SingletonClass sharedSingleton].detail_title addObject:[dict objectForKey:@"title"]];
            
            NSString * description=[dict objectForKey:@"description"];
            description =[description stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
            description=[description stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            description=[description stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            description=[description stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            description=[description stringByReplacingOccurrencesOfString:@"&nbsp" withString:@""];
            description=[description stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSString * cashBack=[NSString stringWithFormat:@"%@ 캐시백",[dict objectForKey:@"cashback"]];
            
            NSString * addedStr=[dict objectForKey:@"added"];
            NSRange  range=NSMakeRange(11, 8);
            addedStr =[addedStr stringByReplacingCharactersInRange:range withString:@""];
            [addedArr addObject:addedStr];
            
           // NSString * favStr=[dict objectForKey:@"fav"];
           // [favArr addObject:favStr];
            
            NSString * couponStr=[dict objectForKey:@"coupons"];
            [coupnArr addObject:couponStr];
            
            NSString *reviewStr=[dict objectForKey:@"reviews"];
            reviewStr=[reviewStr stringByReplacingOccurrencesOfString:@" review" withString:@""];
            [reviewArr addObject:reviewStr];
            
            [retailerId addObject:[dict objectForKey:@"retailer_id"]];
            
            [storeUrl addObject:[dict objectForKey:@"url"]];
            
            [[SingletonClass sharedSingleton].dataArr addObject:cashBack];
            [[SingletonClass sharedSingleton].detailDescription addObject:description];
        }
    }
       }
       else{
           UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"인터넷 연결을 확인하시기 바랍니다" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
           [alert show];
         

       }
    
}


#pragma  mark- create collection UI in bottom View

-(void)createCollectionView{
    
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing=2.0;
    flowLayout.minimumLineSpacing=2.0;
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.mainCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,bottomCollectioView.frame.size.width , bottomCollectioView.frame.size.height-10) collectionViewLayout:flowLayout];
    self.mainCollectionView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    self.mainCollectionView.delegate=self;
    self.mainCollectionView.dataSource=self;
    self.mainCollectionView.backgroundColor=[UIColor clearColor];
    [self.mainCollectionView registerClass:[CustomCollectionCell class] forCellWithReuseIdentifier:@"customCollectionCell"];
    self.mainCollectionView.showsVerticalScrollIndicator=NO;
    [bottomCollectioView addSubview:self.mainCollectionView];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCollectionCell * customCell=(CustomCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"customCollectionCell" forIndexPath:indexPath];
    
    NSURL * url=[NSURL URLWithString:[[SingletonClass sharedSingleton].imageUrl objectAtIndex:indexPath.row]] ;
    NSData * imageData=[NSData dataWithContentsOfURL:url];
    customCell.profileImageView.image=[UIImage imageWithData:imageData];
    NSString * str=[[SingletonClass sharedSingleton].dataArr objectAtIndex:indexPath.row];
    customCell.nameLabel.text=[NSString stringWithFormat:@" %@ ",str];
    
    return  customCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(73,73);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [SingletonClass sharedSingleton].topTitle=[[SingletonClass sharedSingleton].detail_title objectAtIndex:indexPath.row];
    [SingletonClass sharedSingleton].detail_description=[[SingletonClass sharedSingleton].detailDescription objectAtIndex:indexPath.row];
    [SingletonClass sharedSingleton].detailImgUrl=[[SingletonClass sharedSingleton].imageUrl objectAtIndex:indexPath.row];
    [SingletonClass sharedSingleton].cashBackStr=[[SingletonClass sharedSingleton].dataArr objectAtIndex:indexPath.row];
   // [SingletonClass sharedSingleton].fav=[NSString stringWithFormat:@"%@",[favArr objectAtIndex:indexPath.row]];
    [SingletonClass sharedSingleton].coupns=[NSString stringWithFormat:@"%@",[coupnArr objectAtIndex:indexPath.row]];
    [SingletonClass sharedSingleton].added=[NSString stringWithFormat:@"%@",[addedArr objectAtIndex:indexPath.row]];
    [SingletonClass sharedSingleton].reviews =[NSString stringWithFormat:@"%@",[reviewArr objectAtIndex:indexPath.row]];
    
    [SingletonClass sharedSingleton].webUrl=[storeUrl objectAtIndex:indexPath.row];
    [self createUI];
}


#pragma mark - IBAction


-(void)createDropDownMenu{
    if (isTable==NO) {
        
        isTable=YES;
    if (self.contextMenuTableView) {
        self.contextMenuTableView=nil;
    }
    
    self.contextMenuTableView=[[UITableView alloc]initWithFrame:CGRectMake(topRightLabel.frame.origin.x, 20, 40, ListValues.count*15)];
    self.contextMenuTableView.delegate=self;
    self.contextMenuTableView.dataSource=self;
    [self.contextMenuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.contextMenuTableView setShowsVerticalScrollIndicator:NO];
       
    [scrollView insertSubview:self.contextMenuTableView aboveSubview:scrollView];
       // UIView * footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contextMenuTableView.frame.size.width, 10)];
       // footer.backgroundColor=[UIColor whiteColor];
       // self.contextMenuTableView.tableFooterView=footer;
    }
    else{
        [self.contextMenuTableView  removeFromSuperview];
        isTable=NO;
    }
}

-(void)createDropDownMenuOnTable{
    if (isTable==NO) {
        
        isTable=YES;
        if (self.contextMenuTableView) {
            self.contextMenuTableView=nil;
        }
        
        self.contextMenuTableView=[[UITableView alloc]initWithFrame:CGRectMake(topRightLabel.frame.origin.x, 20, 40, ListValues.count*15)];
        self.contextMenuTableView.delegate=self;
        self.contextMenuTableView.dataSource=self;
        [self.contextMenuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.contextMenuTableView setShowsVerticalScrollIndicator:NO];
        [self.view addSubview:self.contextMenuTableView];
       
      // UIView * footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contextMenuTableView.frame.size.width, 10)];
       //  footer.backgroundColor=[UIColor whiteColor];
       // self.contextMenuTableView.tableFooterView=footer;
    }
    else{
        [self.contextMenuTableView  removeFromSuperview];
        isTable=NO;
    }
}


#pragma mark-Table delgate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==self.contextMenuTableView) {
        return ListValues.count;
    }
    else if (tableView==rateList){
        return 5;
    }
    else{
        return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.contextMenuTableView) {
        return 15;
    }
    else if (tableView==rateList){
        return 40;
    }
    else{
        return 160;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (tableView==self.listTable) {
        UIView * sectionFooter=[[UIView alloc]init];
        sectionFooter.frame=CGRectMake(0, 0, windowSize.width, 50);
        sectionFooter.backgroundColor=[UIColor whiteColor];
        
        UIImageView * backImgView=[[UIImageView alloc]init];
        backImgView.frame=CGRectMake(20, 0, windowSize.width-40, 50);
        backImgView.image=[UIImage imageNamed:@"share_bg.png"];
        [sectionFooter addSubview:backImgView];
        
        UIButton * gotoStore=[UIButton buttonWithType:UIButtonTypeCustom];
        gotoStore.frame=CGRectMake(sectionFooter.frame.size.width-120, 13, 98, 23);
        [gotoStore setBackgroundImage:[UIImage imageNamed:@"gotostore_btn.png"] forState:UIControlStateNormal];
        [gotoStore addTarget:self action:@selector(gotoStoreFromList:) forControlEvents:UIControlEventTouchUpInside];
        [sectionFooter addSubview:gotoStore];
        gotoStore.tag=section;
        [gotoStore setNeedsDisplay];
        
        
        UIButton * share=[UIButton buttonWithType:UIButtonTypeCustom];
        share.frame=CGRectMake(sectionFooter.frame.size.width/2-30, 13, 25, 25);
        [share setBackgroundImage:[UIImage imageNamed:@"share_icon.png"] forState:UIControlStateNormal];
       
       [share addTarget:self action:@selector(gotoStoreFromListForShare:) forControlEvents:UIControlEventTouchUpInside];
        [sectionFooter addSubview:share];
        share.tag=section;
        [share setNeedsDisplay];
        
        UIButton * Favstar=[UIButton buttonWithType:UIButtonTypeCustom];
        Favstar.frame=CGRectMake(35, 13, 25, 25);
        [Favstar setBackgroundImage:[UIImage imageNamed:@"fav_icon.png"] forState:UIControlStateNormal];
        [Favstar addTarget:self action:@selector(addFavouriteService) forControlEvents:UIControlEventTouchUpInside];
        [sectionFooter addSubview:Favstar];
        Favstar.tag=section;
        [Favstar setNeedsDisplay];
        
        return  sectionFooter;
    }
   else{
      return nil;
   }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView==self.listTable) {
        return 50;
    }
    return 0;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==self.listTable) {
        return storeImg.count;
    }
      return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.contextMenuTableView)
    {
        
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:nil];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dropDown"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.contentView.backgroundColor=[UIColor colorWithRed:(CGFloat)0/255 green:(CGFloat)138/255 blue:(CGFloat)194/255 alpha:(CGFloat)1];
        UILabel * lbl=[[UILabel alloc]init];
        lbl.frame=CGRectMake(0,0,40,10);
        lbl.text=[ListValues objectAtIndex:indexPath.row];
        lbl.textColor=[UIColor whiteColor];
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.font=[UIFont systemFontOfSize:12];
        [cell.contentView addSubview:lbl];
       
        return  cell;
    }
    else if (tableView==rateList){
        
        UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:nil];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rateStore"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        UILabel * lbl=[[UILabel alloc]init];
        lbl.frame=CGRectMake(10,2,150,30);
        lbl.text=[rateArr objectAtIndex:indexPath.row];
        lbl.textColor=[UIColor lightGrayColor];
        lbl.font=[UIFont systemFontOfSize:12];
        [cell.contentView addSubview:lbl];
        return cell;
    }
    else{
        CustomTableViewCell * cell=(CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"storeList"];
        if (!cell) {
            cell=[[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeList"];
           // cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.storeDescription.font=[UIFont systemFontOfSize:10];
        cell.storeDescription.text=[storeDesc objectAtIndex:indexPath.section];
        [cell.storeLogo sd_setImageWithURL:[storeImg objectAtIndex:indexPath.section] placeholderImage:[UIImage imageNamed:@"noimg.png"]];
        cell.cashBack.text=[storeCashBack objectAtIndex:indexPath.section];
        cell.title.text=[storeTitle objectAtIndex:indexPath.section];
        
        if ([self.starsCount floatValue]==0.50||[self.starsCount floatValue]==1.0) {
          
            cell.ratingStar.image=[UIImage imageNamed:@"empty_4 star.png"];
            
        }
        else if ([self.starsCount floatValue]==1.50||[self.starsCount floatValue]==2.0) {
            cell.ratingStar.image=[UIImage imageNamed:@"empty_3 star.png"];
            
        }
        else  if ([self.starsCount floatValue]==2.50||[self.starsCount floatValue]==3.0) {
          
            cell.ratingStar.image=[UIImage imageNamed:@"empty_2 star.png"];
        
        }
        
        else if ([self.starsCount floatValue]==3.50||[self.starsCount floatValue]==4.0) {
          
            cell.ratingStar.image=[UIImage imageNamed:@"empty_1 star.png"];
         
        }
        else if ([self.starsCount floatValue]==4.50||[self.starsCount floatValue]==5.0) {
            cell.ratingStar.image=[UIImage imageNamed:@"filledstars.png"];
        }
        else if ([self.starsCount floatValue]==0.0) {
            cell.ratingStar.image=[UIImage imageNamed:@"empty_star.png"];
            
            
        }

        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return  cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.contextMenuTableView) {
        [self.contextMenuTableView removeFromSuperview];
       Char=[ListValues objectAtIndex:indexPath.row];
       name.text=[NSString stringWithFormat:@"스토어-%@",Char];
        dispatch_async(dispatch_get_global_queue(0, 0),^{
           
            [self  webServiceForSortedStore:Char];
            dispatch_async(dispatch_get_main_queue(),^{
                [self createTableForSortedStore];
            });
        });
    }
    else if (tableView==rateList)
    {
        [rateApp setTitle:[rateArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
         rateVal=[rateArrVal objectAtIndex:indexPath.row];
        [backView removeFromSuperview];
        [rateList removeFromSuperview];
    }
    else{
        
    }
}

#pragma  mark- createUI Table

-(void)createTableForSortedStore{
    
    topRightLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    topRightLabel.frame=CGRectMake(windowSize.width-100,10, 15, 15);
    [topRightLabel setImage:[UIImage imageNamed:@"dropper_icon_new.png"] forState:UIControlStateNormal];
    [topRightLabel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [topRightLabel addTarget:self action:@selector(createDropDownMenuOnTable) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topRightLabel];
    
    if (name) {
        [name removeFromSuperview];
        name=nil;
    }
     name=[[UILabel alloc]init];
    name.frame=CGRectMake(25, 5, 70, 20);
    name.font=[UIFont boldSystemFontOfSize:16];
    name.text=[NSString stringWithFormat:@"스토어-%@",Char];
    name.textColor=[UIColor blackColor];
    
    [self.view addSubview:name];
    
    
    if (self.listTable) {
        self.listTable=nil;
    }
    
    self.listTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, windowSize.width, windowSize.height-50)];
    self.listTable.delegate=self;
    self.listTable.dataSource=self;
    [self.view addSubview:self.listTable];
    self.listTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    UIView * tableFooter=[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowSize.width, 60)];
    tableFooter.backgroundColor=[UIColor whiteColor];
    self.listTable.tableFooterView=tableFooter;
    
}


-(void)webServiceForSortedStore:(NSString *)Char{
    
    NSError * error;
    NSURLResponse * urlResponse;
    
    [storeUrl removeAllObjects];
    [storeDesc removeAllObjects];
    [storeImg removeAllObjects];
    [storeCashBack removeAllObjects];
    [storeTitle removeAllObjects];
    [sortedRetailer_id removeAllObjects];
        NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=shop&sortby=title&order=asc&letter=%@&pagination=1",Char]];
    //{sortby(title,added,visits,cashback),order(asc,desc),cat,letter},pagination{page,show}
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //[NSURLConnection sendAsynchronousRequest:request queue:NSOperationQueuePriorityNormal completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data==nil) {
            return;
        }
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if ([[json objectForKey:@"status"] isEqualToString:@"1"]) {
            NSArray * result=[json objectForKey:@"result"];
            for (int i=0; i<result.count; i++) {
                NSMutableDictionary * dict=[result objectAtIndex:i];
                [storeImg addObject:[dict objectForKey:@"image"]];
                NSString * description=[dict objectForKey:@"description"];
                description =[description stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
                description=[description stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
                description=[description stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                
                description=[description stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                description=[description stringByReplacingOccurrencesOfString:@"&nbsp" withString:@""];
                description=[description stringByReplacingOccurrencesOfString:@" " withString:@""];
                description=[description stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];

                [storeDesc addObject:description];
                [storeUrl addObject:[dict objectForKey:@"url"]];
                [storeCashBack addObject:[NSString stringWithFormat:@"%@ 캐시백",[dict objectForKey:@"cashback"]]];
                [storeTitle addObject:[dict objectForKey:@"title"]];
                [sortedRetailer_id addObject:[dict objectForKey:@"retailer_id"]];
            }
        }
    [self.contextMenuTableView removeFromSuperview];
    self.contextMenuTableView=nil;
    [scrollView removeFromSuperview];

   // }];
   }

#pragma mark- add favourite service

-(void)addFavouriteService{
    if ([SingletonClass sharedSingleton].login_userId) {
        
    dispatch_async(dispatch_get_global_queue(0, 0),^{
       
        [self callWebServiceForFavourite];
        dispatch_async(dispatch_get_main_queue(),^{
            if ([favourite_id containsObject:self.retailId]) {
                UIAlertView * faveAlert=[[UIAlertView alloc]initWithTitle:@"정말 즐겨찾기에서 이 스토어를 삭제하시겠습니까?" message:nil delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"삭제", nil];
                [faveAlert show];
            }
            else{
                dispatch_async(dispatch_get_global_queue(0, 0),^{
                    [self addFavouriteWebserivce];
                });
            }
        });
    });
    }
    else{
        [SingletonClass sharedSingleton].isFromDetailpage=YES;
        if (loginVc) {
            loginVc=nil;
        }
        loginVc=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==rateAlert) {
        if (buttonIndex==0) {
            [SingletonClass sharedSingleton].isFromDetailpage=YES;
            if (loginVc) {
                loginVc=nil;
            }
            loginVc=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginVc animated:YES];
        }
    }
    else{
        if (buttonIndex==1) {
            dispatch_async(dispatch_get_main_queue(),^{
                [self deleteFavourite];
            });
        }
    }
}

-(void)addFavouriteWebserivce{
    
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSString * urlStr=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=addtofav&user_id=%@&retailer_id=%@",[SingletonClass sharedSingleton].login_userId,self.retailId];
    
    urlStr=[urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        return ;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if ([[json objectForKey:@"status"] isEqualToString:@"1"]) {
        NSLog(@" add Favourite Show successfull message in  hud");
    }
    
}

-(void)deleteFavourite{
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSString * urlStr=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=deletemyfavorites&user_id=%@&retailer_id=%@",[SingletonClass sharedSingleton].login_userId,self.retailId];
    
    urlStr=[urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        return ;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if ([[json objectForKey:@"status"] isEqualToString:@"1"]) {
        NSLog(@" delete Show successfull message in  hud");
    }
}

-(void)callWebServiceForFavourite{
    
    
    [favourite_id removeAllObjects];
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSString * urlStr=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=myfavorites&user_id=%@",[SingletonClass sharedSingleton].login_userId];
    
    urlStr=[urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        return ;
    }
    
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if ([[json objectForKey:@"status"] isEqualToString:@"1"]) {
        NSArray * reslut=[json objectForKey:@"result"];
        NSMutableDictionary * dict=[NSMutableDictionary dictionary];
        for (int i=0; i<reslut.count; i++) {
            dict=[reslut objectAtIndex:i];
            [favourite_id addObject:[dict objectForKey:@"retailer_id"]];
        }
    }
}

#pragma mark- review Action

-(void)reviewButtonAction:(UIButton *)sender{
    [titleTxt endEditing:YES];
    [messageTxt endEditing:YES];
    if([SingletonClass sharedSingleton].login_userId)
    {
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        
        NSError * error;
        NSURLResponse * urlResponse;
        NSString * getUrl=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=reviewsstat&user_id=%@&retailer_id=%@",[SingletonClass sharedSingleton].login_userId,self.retailId];
        getUrl=[getUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * url=[NSURL URLWithString:getUrl];
        
        NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        
        
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if (!data) {
            return ;
        }
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"adFavourite response %@",json);
        if ([[json objectForKey:@"status"] isEqualToString:@"0"]) {
            
        rateAlert=[[UIAlertView alloc]initWithTitle:@"만 검토 할 수 있습니다 한번" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [rateAlert show];
        }
        else{
        
        dispatch_async(dispatch_get_main_queue(),^{
            
        
        
        NSError * error;
        NSURLResponse * urlResponse;
        NSString * getUrl=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=reviews&user_id=%@&retailer_id=%@&review_title=%@&review=%@&rating=%@",[SingletonClass sharedSingleton].login_userId,self.retailId,titleTxt.text,messageTxt.text,rateVal];
        getUrl=[getUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL * url=[NSURL URLWithString:getUrl];
        
        NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        
        
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if (!data) {
            return ;
        }
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"adFavourite response %@",json);
            rateAlert=[[UIAlertView alloc]initWithTitle:@"만 검토 할 수 있습니다 한번" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [rateAlert show];
        });
        }
    });
}
    else
    {
       rateAlert=[[UIAlertView alloc]initWithTitle:@"회원님은 로 후기를 올리기 위하여 로그인 했습니다." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [rateAlert show];
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
