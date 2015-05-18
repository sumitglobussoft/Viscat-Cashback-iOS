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

static NSString *const menuCellIdentifier = @"rotationCell";

@interface DetailPageViewController ()
{
    UIScrollView * scrollView;
    WebViewViewController * webviewVC;
    UIButton * topRightLabel;
}
@end

@implementation DetailPageViewController
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
    if ([SingletonClass sharedSingleton].isFromHome==YES) {
        [SingletonClass sharedSingleton].isFromHome=NO;
    }
   
    [self createUI];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)backButtonAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



-(void)returnHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma  mark- create UI of detail page

-(void)createUI{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadViewController" object:nil];
    
     [NSThread detachNewThreadSelector:@selector(recomendedService) toTarget:self withObject:nil];
    if (scrollView) {
        [scrollView removeFromSuperview];
        scrollView=nil;
    }
    scrollView=[[UIScrollView alloc]init];
    scrollView.frame=CGRectMake(0, 0, windowSize.width, windowSize.height);
    scrollView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:scrollView];
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.contentSize=CGSizeMake(windowSize.width, windowSize.height*1.5);
    [scrollView setNeedsDisplay];
    
    // Top Labels
    UILabel * topLeftLabel=[[UILabel alloc]init];// I will add attribute text here
    topLeftLabel.frame=CGRectMake(20, 0, 60, 30);
    topLeftLabel.font=[UIFont systemFontOfSize:14];
    topLeftLabel.text=[SingletonClass sharedSingleton].topTitle;
    [scrollView addSubview:topLeftLabel];
    [topLeftLabel setNeedsDisplay];
    
    UILabel * topCashBackLbl=[[UILabel alloc]init];
    topCashBackLbl.frame=CGRectMake(60, 0, 100, 30);
    topCashBackLbl.font=[UIFont systemFontOfSize:15];
    topCashBackLbl.textColor=[UIColor redColor];
    topCashBackLbl.text=[SingletonClass sharedSingleton].cashBackStr;
    [scrollView addSubview:topCashBackLbl];
    [topCashBackLbl setNeedsDisplay];
    
    
    topRightLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    topRightLabel.frame=CGRectMake(windowSize.width-100,0, 60, 20);
    [topRightLabel setTitle:@"menu" forState:UIControlStateNormal];
    [topRightLabel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [topRightLabel addTarget:self action:@selector(presentMenuButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:topRightLabel];
    
    
   ///////////////////////////////////////////
    
    UIView * topView=[[UIView alloc]init];
    topView.frame=CGRectMake(20, 40, 278, 159);
    topView.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    topView.layer.borderWidth=0.5f;
    topView.layer.cornerRadius=4;
    topView.clipsToBounds=YES;
    topView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"product_detailbox_star.png"]];
    [scrollView addSubview:topView];
    
    [topView setNeedsDisplay];
    
    UILabel * couponLbl=[[UILabel alloc]init];
    couponLbl.frame=CGRectMake(40, 0, 15, 20);
    couponLbl.font=[UIFont systemFontOfSize:6];
    couponLbl.textColor=[UIColor blueColor];
    couponLbl.text=@"쿠폰";
    [topView addSubview:couponLbl];
    [couponLbl setNeedsDisplay];
    
    UILabel * coupondata=[[UILabel alloc]init];
    coupondata.frame=CGRectMake(55, 0, 25, 20);
    coupondata.font=[UIFont systemFontOfSize:6];
    coupondata.textColor=[UIColor grayColor];
    coupondata.text=[SingletonClass sharedSingleton].coupns;
    [topView addSubview:coupondata];
    [coupondata setNeedsDisplay];
    
    UILabel * reviewLbl=[[UILabel alloc]init];
    reviewLbl.frame=CGRectMake(70, 0, 15, 20);
    reviewLbl.font=[UIFont systemFontOfSize:6];
    reviewLbl.textColor=[UIColor blueColor];
    reviewLbl.text=@"후기";
    [topView addSubview:reviewLbl];
    [reviewLbl setNeedsDisplay];
    
    UILabel * reviewdata=[[UILabel alloc]init];
    reviewdata.frame=CGRectMake(85, 0, 25, 20);
    reviewdata.font=[UIFont systemFontOfSize:6];
    reviewdata.textColor=[UIColor grayColor];
    reviewdata.text=[SingletonClass sharedSingleton].reviews;
    [topView addSubview:reviewdata];
    [reviewdata setNeedsDisplay];
    
    UILabel * favLbl=[[UILabel alloc]init];
    favLbl.frame=CGRectMake(120, 0, 30, 20);
    favLbl.font=[UIFont systemFontOfSize:6];
    favLbl.textColor=[UIColor blueColor];
    favLbl.text=@"즐겨찾기";
    [topView addSubview:favLbl];
    [favLbl setNeedsDisplay];
    
    UILabel * favdata=[[UILabel alloc]init];
    favdata.frame=CGRectMake(150, 0, 30, 20);
    favdata.font=[UIFont systemFontOfSize:6];
    favdata.textColor=[UIColor grayColor];
    favdata.text=[SingletonClass sharedSingleton].fav;
    [topView addSubview:favdata];
    [favdata setNeedsDisplay];
    
    UILabel * addedLbl=[[UILabel alloc]init];
    addedLbl.frame=CGRectMake(180, 0, 30, 20);
    addedLbl.font=[UIFont systemFontOfSize:6];
    addedLbl.textColor=[UIColor blueColor];
    addedLbl.text=@"날짜 추가됨";
    [topView addSubview:addedLbl];
    [addedLbl setNeedsDisplay];
    
    
    UILabel * addeddata=[[UILabel alloc]init];
    addeddata.frame=CGRectMake(210, 0, 40, 20);
    addeddata.font=[UIFont systemFontOfSize:6];
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
    descripttion.frame=CGRectMake(20, 50, topView.frame.size.width-40, 40);
    descripttion.text=[SingletonClass sharedSingleton].detail_description;
    descripttion.font=[UIFont systemFontOfSize:8];
    descripttion.numberOfLines=0;
    descripttion.lineBreakMode=NSLineBreakByWordWrapping;
    descripttion.textColor=[UIColor grayColor];
    [topView addSubview:descripttion];
    [descripttion setNeedsDisplay];
    
    UIButton * gotoStore=[UIButton buttonWithType:UIButtonTypeCustom];
    gotoStore.frame=CGRectMake(windowSize.width/2+30, topView.frame.size.height-2, 98, 23);
    [gotoStore setBackgroundImage:[UIImage imageNamed:@"gotostore_btn"] forState:UIControlStateNormal];
    [gotoStore addTarget:self action:@selector(gotoStore:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:gotoStore];
    [gotoStore setNeedsDisplay];
    
   ///////////////////////////
    
    UILabel * lable2=[[UILabel alloc]init];
    lable2.frame=CGRectMake(20, 250, 100, 25);
    lable2.text=@"A";
    lable2.font=[UIFont boldSystemFontOfSize:10];
    [scrollView addSubview:lable2];
    [lable2 setNeedsDisplay];
    
    CALayer * layer=[CALayer layer];
    layer.frame=CGRectMake(20, 280, windowSize.width-40, 60);
    layer.borderWidth=0.7;
    layer.borderColor=[UIColor lightGrayColor].CGColor;
    layer.cornerRadius=5;
    [scrollView.layer insertSublayer:layer atIndex:0];
    [layer setNeedsDisplay];
    
    UIImageView * verticalLine=[[UIImageView alloc]init];
    verticalLine.frame=CGRectMake(80, 280, 1, 60);
    verticalLine.image=[UIImage imageNamed:@"big_horizontaline.png"];
    [scrollView addSubview:verticalLine];
   
    
    UILabel * lable3=[[UILabel alloc]init];
    lable3.frame=CGRectMake(20, 350, 100, 25);
    lable3.text=@"B";
    lable3.font=[UIFont boldSystemFontOfSize:10];
    [scrollView addSubview:lable3];
    [lable3 setNeedsDisplay];
    
    CALayer * layer2=[CALayer layer];
    layer2.frame=CGRectMake(20, 380, windowSize.width-40, 25);
    layer2.borderWidth=0.7;
    layer2.borderColor=[UIColor lightGrayColor].CGColor;
    layer2.cornerRadius=5;
    [scrollView.layer insertSublayer:layer2 atIndex:0];
    [layer2 setNeedsDisplay];
    
    UIImageView * verticalLine2=[[UIImageView alloc]init];
    verticalLine2.frame=CGRectMake(60, 380, 1, 25);
    verticalLine2.image=[UIImage imageNamed:@"small_horizontalline.png"];
    [scrollView addSubview:verticalLine2];
    
    
    CALayer * layer3=[CALayer layer];
    layer3.frame=CGRectMake(20, 410, windowSize.width-40, 60);
    layer3.borderWidth=0.7;
    layer3.borderColor=[UIColor lightGrayColor].CGColor;
    layer3.cornerRadius=5;
    [scrollView.layer insertSublayer:layer3 atIndex:0];
    [layer3 setNeedsDisplay];
    
    UIImageView * verticalLine3=[[UIImageView alloc]init];
    verticalLine3.frame=CGRectMake(60, 410, 1, 60);
    verticalLine3.image=[UIImage imageNamed:@"big_horizontaline.png"];
    [scrollView addSubview:verticalLine3];
    
    
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(windowSize.width/2+80, 480, 61, 22);
    [button setBackgroundImage:[UIImage imageNamed:@"review_btn.png"] forState:UIControlStateNormal];
    [scrollView addSubview:button];
    [button setNeedsDisplay];
    
    UILabel * label4=[[UILabel alloc]init];
    label4.frame=CGRectMake(20, 120, 40, 20);
    label4.font=[UIFont systemFontOfSize:10];
    [scrollView addSubview:label4];
    [label4 setNeedsDisplay];
    
    bottomCollectioView=[[UIView alloc]init];
    bottomCollectioView.frame=CGRectMake(20.0, 550.0, windowSize.width-40, 150);
    bottomCollectioView.backgroundColor=[UIColor lightGrayColor];
    [scrollView addSubview:bottomCollectioView];
    [bottomCollectioView setNeedsDisplay];
    
    UIButton * moreButton=[UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame=CGRectMake(bottomCollectioView.frame.size.width-40, bottomCollectioView.frame.size.height-20, 40, 20);
    moreButton.backgroundColor=[UIColor clearColor];
    moreButton.titleLabel.font=[UIFont systemFontOfSize:8];
    [moreButton setTitle:@"+ more" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomCollectioView addSubview:moreButton];
    [moreButton setNeedsDisplay];
    
    [self createCollectionView];
    
    
}

#pragma  mark- goto to store 

-(void)gotoStore:(UIButton *)sender{
    if (![SingletonClass sharedSingleton].login_userId) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Please singIn to continue shopping" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK" , nil];
        [alert show];
    }
    else{
        if (webviewVC) {
            webviewVC=nil;
        }
        webviewVC=[[WebViewViewController alloc]initWithNibName:@"WebViewViewController" bundle:nil];
       
        AppDelegate* appdelegate=[UIApplication sharedApplication].delegate;
        [appdelegate.window addSubview:webviewVC.view];
        //[self.navigationController pushViewController:webviewVC animated:YES];
    }
}

#pragma mark- recommended Serivice

#pragma mark- recomendedService
-(void)recomendedService{
    
    coupnArr=[[NSMutableArray alloc]init];
    addedArr=[[NSMutableArray alloc]init];
    favArr=[[NSMutableArray alloc]init];
    reviewArr=[[NSMutableArray alloc]init];
    retailerId=[[NSMutableArray alloc]init];
    
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
    NSLog(@"Recommed %@",json);
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


#pragma  mark- create collection UI in bottom View

-(void)createCollectionView{
    
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing=2.0;
    flowLayout.minimumLineSpacing=2.0;
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.mainCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,bottomCollectioView.frame.size.width , bottomCollectioView.frame.size.height-20) collectionViewLayout:flowLayout];
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

- (void)presentMenuButtonTapped:(UIBarButtonItem *)sender {
    // init YALContextMenuTableView tableView
    if (!self.contextMenuTableView) {
        self.contextMenuTableView = [[YALContextMenuTableView alloc]initWithTableViewDelegateDataSource:self];
        self.contextMenuTableView.animationDuration = 0.15;
        //optional - implement custom YALContextMenuTableView custom protocol
        self.contextMenuTableView.yalDelegate = self;
        
        //register nib
        UINib *cellNib = [UINib nibWithNibName:@"ContextMenuCell" bundle:nil];
        [self.contextMenuTableView registerNib:cellNib forCellReuseIdentifier:menuCellIdentifier];
    }
    
    // it is better to use this method only for proper animation
    [self.contextMenuTableView showInView:self.navigationController.view withEdgeInsets:UIEdgeInsetsZero animated:YES];
}

#pragma mark - Local methods

- (void)initiateMenuOptions {
    self.menuTitles = @[@"",
                        @"Send message",
                        @"Like profile",
                        @"Add to friends",
                        @"Add to favourites",
                        @"Block user"];
    
   /* self.menuIcons = @[[UIImage imageNamed:@"Icnclose"],
                       [UIImage imageNamed:@"SendMessageIcn"],
                       [UIImage imageNamed:@"LikeIcn"],
                       [UIImage imageNamed:@"AddToFriendsIcn"],
                       [UIImage imageNamed:@"AddToFavouritesIcn"],
                       [UIImage imageNamed:@"BlockUserIcn"]];*/
}


#pragma mark - YALContextMenuTableViewDelegate

- (void)contextMenuTableView:(YALContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Menu dismissed with indexpath = %@", indexPath);
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)tableView:(YALContextMenuTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView dismisWithIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(YALContextMenuTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContextMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
    
    if (cell) {
        cell.menuTitleLabel.text = [self.menuTitles objectAtIndex:indexPath.row];
       // cell.menuImageView.image = [self.menuIcons objectAtIndex:indexPath.row];
    }
    
    return cell;
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
