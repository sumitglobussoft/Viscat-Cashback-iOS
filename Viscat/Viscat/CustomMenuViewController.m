//
//  CusttomMenuViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 17/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "CustomMenuViewController.h"
#import <objc/runtime.h>
#import "AppDelegate.h"
#import "InviteFriendViewController.h"
#import "LoginViewController.h"
#import "SingletonClass.h"
#import "ViewController.h"

#import "HomeViewController.h"
#import "BalanceViewController.h"
#import "ClickHistoryViewController.h"
#import "ProfileEditViewController.h"
#import "HistoryViewController.h"
#import "EventViewController.h"


@interface CustomMenuViewController ()
{
    ViewController * viewVC;
    NSArray * menuIcon2,*menuIcon1;
    LoginViewController * loginVc;
    AppDelegate * appdeledate;
    UITabBarItem * home;
}
@end

@implementation CustomMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(AppDelegate*)appdelegate{
    return [UIApplication sharedApplication].delegate;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.hidden=YES;
    
}


#pragma mark -
-(void) setViewControllers:(NSArray *)viewControllers{
    
    _viewControllers = [viewControllers copy];
    
    for (UIViewController *viewController in _viewControllers) {
        [self addChildViewController:viewController];
        viewController.view.frame = CGRectMake(0, 55,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height-55);
        
        [viewController didMoveToParentViewController:self];
    }
    
}
-(void)setSignupViewController:(NSArray*)signupViewController
{
    _signupViewController = [signupViewController copy];
    
    for (UIViewController *viewController in _signupViewController) {
        [self addChildViewController:viewController];
        viewController.view.frame = CGRectMake(0, 55,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height-55);
        
        [viewController didMoveToParentViewController:self];
    }

}

-(void) setSelectedViewController:(UIViewController *)selectedViewController{
    _selectedViewController = selectedViewController;
}

-(void) setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
}

-(NSArray *) getAllViewControllers{
    return self.viewControllers;
}
-(void) setSelectedSection:(NSInteger)selectedSection{
    _selectedSection = selectedSection;
}
#pragma  mark- reload Table
-(void)reloadTable{
    self.customBar.selectedItem=home;
    BOOL signIn=[[NSUserDefaults standardUserDefaults]boolForKey:@"signIn"];
    if (signIn) {
        self.selectedIndex=0;
        self.selectedViewController = [self.signupViewController objectAtIndex:0];
    }
    [self updateViewContainer];
    [self.menuTableView reloadData];
    
}

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
       self.screen_height = [UIScreen mainScreen].bounds.size.height;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeHeaderTitle:) name:@"ChangeHeaderTitle" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTable) name:@"reloadmenuTable" object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afterSignIn) name:@"HomeScreen" object:nil];
    
    
    menuIcon2=[NSArray arrayWithObjects:@"home_menuicon.png",@"payment_menuicon.png",@"clickhistory_menuicon.png",@"cashwithdraw_menuicon.png",@"profileedit_menuicon.png", nil];
    menuIcon1=[NSArray arrayWithObjects:@"home_menuicon.png",@"login_menuicon.png",@"signup_menuicon.png", nil];
    
    //Add View SubView;
    
    self.mainsubView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.mainsubView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainsubView];
    
    
    //Add Header View
    CGFloat hh;
    CGRect frame_b;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        hh = 75;
        frame_b = CGRectMake(10, 30, 30, 25);
    }
    else{
        hh = 55;
        frame_b = CGRectMake(15, 25, 25, 25);
    }
    //=======================================
    // Add Container View
    CGRect frame = CGRectMake(0, hh, self.view.frame.size.width, self.screen_height-hh);
    self.contentContainerView = [[UIView alloc] initWithFrame:frame];
    self.contentContainerView.backgroundColor = [UIColor grayColor];
    self.contentContainerView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    frame = CGRectMake(0, 0, self.view.frame.size.width, hh);
    
    [self.mainsubView addSubview:self.contentContainerView];
    self.headerView = [[UIView alloc] initWithFrame:frame];
    self.headerView.backgroundColor=[UIColor colorWithRed:(CGFloat)249/255 green:(CGFloat)117/255 blue:(CGFloat)0/255 alpha:1];
    [self.mainsubView addSubview:self.headerView];
    self.headerView.layer.shadowColor=[UIColor blackColor].CGColor;
    self.headerView.layer.shadowOffset=CGSizeMake(0, 5);
    self.headerView.layer.shadowOpacity=0.5;
    self.headerView.layer.shadowRadius=3;
    self.headerView.layer.shadowPath=[UIBezierPath bezierPathWithRect:self.headerView.bounds].CGPath;
    
    NSLog(@"Width menu== %f",self.view.frame.size.width);
    
    self.headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, self.view.frame.size.width-120, 25)];
    //self.headerTitleLabel.textColor = [UIColor colorWithRed:(CGFloat)79/255 green:(CGFloat)167/255 blue:(CGFloat)229/255 alpha:1];
    self.headerTitleLabel.textColor = [UIColor whiteColor];
    self.headerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.headerTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.headerTitleLabel.text= @"비스켓캐쉬백";
    [self.headerView addSubview:self.headerTitleLabel];
    
    //============================
    //Add Menu Button
    
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menuButton.frame = frame_b;
    self.menuButton.titleLabel.font = [UIFont systemFontOfSize:9.0f];
    self.menuButton.titleLabel.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    //self.menuButton.titleLabel.layer.
    [self.menuButton addTarget:self action:@selector(menuButtonClciked:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuButton setBackgroundImage:[UIImage imageNamed:@"menu_new.png"] forState:UIControlStateNormal];
    [self.headerView addSubview:self.menuButton];
    
    
   
    //===================================
    
    self.selectedIndex = 0;
    self.selectedViewController=[self.viewControllers objectAtIndex:0];
   
    
    [self updateViewContainer];
    [self createMenuTableView];
    
    
    self.swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    self.swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.mainsubView addGestureRecognizer:self.swipeGesture];
 
    
    
    //==================================
    
    //Add tabbar
    
     home=[[UITabBarItem alloc]initWithTitle:@"홈"image:[UIImage imageNamed:@"home_menuicon.png"] selectedImage:[UIImage imageNamed:@"home_active_menuicon.png"]];
    home.tag=0;
    
    
    UITabBarItem * Balance=[[UITabBarItem alloc]initWithTitle:@"내역" image:[UIImage imageNamed:@"bigsafe_icon.png"] selectedImage:[UIImage imageNamed:@"bigsafe_active_icon.png"]];
    Balance.tag=2;
    
    UITabBarItem * History=[[UITabBarItem alloc]initWithTitle:@"잔고" image:[UIImage imageNamed:@"history_menuicon"] selectedImage:[UIImage imageNamed:@"history_active_menuicon.png"]];
    History.tag=1;
    
    UITabBarItem * Invite=[[UITabBarItem alloc]initWithTitle:@"친구에게 소개하기" image:[UIImage imageNamed:@"user_icon.png"] selectedImage:[UIImage imageNamed:@"user_icon_active.png"]];
    Invite.tag=3;
    
    UITabBarItem * event=[[UITabBarItem alloc]initWithTitle:@"행사" image:[UIImage imageNamed:@"calendar_icon.png"] selectedImage:[UIImage imageNamed:@"calendar_active_icon.png"]];
    event.tag=4;
    
    
    self.customBar.items = @[home,History,Balance,Invite,event];
    self.customBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-45, self.view.frame.size.width, 50)];
    self.customBar.delegate = self;
    self.customBar.items = @[home,History,Balance, Invite,event];
    self.customBar.selectedItem = home;
    self.customBar.barTintColor = [UIColor colorWithRed:(CGFloat)170/255 green:(CGFloat)173/255 blue:(CGFloat)173/255 alpha:1.0];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:(CGFloat)249/255 green:(CGFloat)117/255 blue:(CGFloat)0/255 alpha:1.0]];
    [self.mainsubView addSubview:self.customBar];
    
    
    HomeViewController * homeVC=[[HomeViewController alloc]init];
    homeVC.title=@"홈";
    [self addChildViewController:homeVC];
    
    HistoryViewController * HistoryVC=[[HistoryViewController alloc]init];
    HistoryVC.title=@"내역";
     [self addChildViewController:HistoryVC];
    
    BalanceViewController* balanceVC=[[BalanceViewController alloc]init];
    balanceVC.title=@"잔고";
    [self addChildViewController:balanceVC];
    
    
    InviteFriendViewController * inviteVC=[[InviteFriendViewController alloc]init];
    inviteVC.title=@"친구에게 소개하기" ;
    [self addChildViewController:inviteVC];
    
    EventViewController * eventVC=[[EventViewController alloc]init];
    eventVC.title=@"행사" ;
    [self addChildViewController:eventVC];

    
     loginVc=[[LoginViewController alloc]init];
     [self addChildViewController:loginVc];
    
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeNavi.navigationBar.hidden = YES;
       UINavigationController *HistoryVCNavi = [[UINavigationController alloc] initWithRootViewController:HistoryVC];
    HistoryVCNavi.navigationBar.hidden = YES;
    UINavigationController *balanceVCNavi = [[UINavigationController alloc] initWithRootViewController:balanceVC];
    balanceVCNavi.navigationBar.hidden = YES;
    UINavigationController *inviteVCNavi = [[UINavigationController alloc] initWithRootViewController:inviteVC];
    inviteVCNavi.navigationBar.hidden = YES;
    UINavigationController *eventVCNavi = [[UINavigationController alloc] initWithRootViewController:eventVC];
    eventVCNavi.navigationBar.hidden = YES;

    NSArray *tabBarArray = @[homeNavi,HistoryVCNavi,balanceVCNavi,inviteVCNavi,eventVCNavi];
    tabArr=[tabBarArray copy];
    
    loginArr=@[loginVc];
    
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
  
    BOOL signIn=[[NSUserDefaults standardUserDefaults]boolForKey:@"signIn"];
    if (!signIn) {
        if (item.tag==0) {
            UIViewController *newViewController = [tabArr objectAtIndex:0];
            [self getSelectedViewControllers:newViewController];
        }
        else{
            [SingletonClass sharedSingleton].isFromTab=YES;
            UIViewController *newViewController = [loginArr objectAtIndex:0];
            [self getSelectedViewControllers:newViewController];
            }
    }
    else{
        UIViewController *newViewController = [tabArr objectAtIndex:item.tag];
        [self getSelectedViewControllers:newViewController];
    }
    

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) handleSwipeGesture:(UISwipeGestureRecognizer *)swipeGesture{
    
    
    if (self.mainsubView.frame.origin.x>100) {
        
        [UIView animateWithDuration:.5 animations:^{
            self.mainsubView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.screen_height);
        }completion:^(BOOL finish){
            
            
            self.swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
        }];
        
    }
    else{
        [UIView animateWithDuration:.5 animations:^{
            self.mainsubView.frame = CGRectMake(250, 0, self.view.frame.size.width, self.screen_height);
        }completion:^(BOOL finish){
            self.swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        }];
    }
    
    
}
-(void) createMenuTableView{
    if (!self.menuTableView) {
       
    
        self.selectedIndex = 0;
        self.menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, self.screen_height) style:UITableViewStylePlain];
        
        self.menuTableView.backgroundColor =  [UIColor colorWithRed:(CGFloat)39/255 green:(CGFloat)39/255 blue:(CGFloat)41/255 alpha:1];
        
        self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.menuTableView.delegate = self;
        self.menuTableView.dataSource = self;
        self.menuTableView.scrollEnabled=NO;
    }
    else{
        [self.menuTableView reloadData];
    }
    
    [self.view insertSubview:self.menuTableView belowSubview:self.mainsubView];
}

#pragma mark -
-(void) menuButtonClciked:(id)sender{
    

    if (self.mainsubView.frame.origin.x>100 ) {
        
        [UIView animateWithDuration:.5 animations:^{
            self.mainsubView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.screen_height);
        }completion:^(BOOL finish){
            self.swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
            
        }];
        
    }
    else{
        [UIView animateWithDuration:.5 animations:^{
            self.mainsubView.frame = CGRectMake(250, 0, self.view.frame.size.width, self.screen_height);
        }completion:^(BOOL finish){
            
            self.swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
            
        }];
    }
    
    
}

#pragma mark -
#pragma mark TableView Delegate and DataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.numberOfSections;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
         BOOL signIn=[[NSUserDefaults standardUserDefaults]boolForKey:@"signIn"];
        if (signIn) {
            return self.signupViewController.count+1;
        }
        return self.viewControllers.count;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIColor *firstColor =  [UIColor colorWithRed:(CGFloat)39/255 green:(CGFloat)39/255 blue:(CGFloat)41/255 alpha:1];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)48/255 green:(CGFloat)48/255 blue:(CGFloat)50/255 alpha:1];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = cell.contentView.frame;
    layer.colors = [NSArray arrayWithObjects:(id)firstColor.CGColor,(id)secColor.CGColor, nil];
    
    [cell.contentView.layer insertSublayer:layer atIndex:0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //Check Section
    
    if (indexPath.section==0) {
        BOOL signIn=[[NSUserDefaults standardUserDefaults]boolForKey:@"signIn"];
        if (!signIn) {
            if (indexPath.row<self.viewControllers.count) {
                cell.imageView.image=[UIImage imageNamed:[menuIcon1 objectAtIndex:indexPath.row]];
                cell.textLabel.text = [NSString stringWithFormat:@"  %@",[(UIViewController *)[self.viewControllers objectAtIndex:indexPath.row] title]];
            }
        }
        else{
            if (indexPath.row<self.signupViewController.count) {
                cell.imageView.image=[UIImage imageNamed:[menuIcon2 objectAtIndex:indexPath.row]];
                cell.textLabel.text = [NSString stringWithFormat:@"  %@",[(UIViewController *)[self.signupViewController objectAtIndex:indexPath.row] title]];
                
            }
            if (indexPath.row==5) {
                cell.imageView.image=[UIImage imageNamed:@"logout_menuicon.png"];
                cell.textLabel.text=@" 로그 아웃";
            }

        }
       
    
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0)
    {
        
        
    
        [[NSNotificationCenter defaultCenter]postNotificationName:@"removeHome" object:nil];
    
        
        
        //////////////////////////////
        
        
        
        [UIView animateWithDuration:.5 animations:^{
            
           self.mainsubView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.screen_height);
            
        }completion:^(BOOL finished){
            //After completion
            //first check if new selected view controller is equals to previously selected view controller
            
            UIViewController *newViewController;
            BOOL signIn=[[NSUserDefaults standardUserDefaults]boolForKey:@"signIn"];
            if (signIn==YES) {
                if (indexPath.row<self.signupViewController.count) {
                    newViewController = [self.signupViewController objectAtIndex:indexPath.row];
                  
            if ([newViewController isKindOfClass:[UINavigationController class]]) {
                [(UINavigationController *)newViewController popToRootViewControllerAnimated:YES];
            }
            
            if (self.selectedIndex==indexPath.row  && self.selectedSection == indexPath.section) {
               // return;
            }
              
                    if (indexPath.row==0) {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"homeLoad" object:nil];
                        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"homeLoad" object:nil];
                        self.customBar.selectedItem=[self.customBar.items objectAtIndex:0];

                                          }
         //   else if (indexPath.row==1) {
            //       [[NSNotificationCenter defaultCenter]postNotificationName:@"balanceDetail" object:nil];
           //     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"balanceDetail" object:nil];
           //                 }
            else if(indexPath.row==1){
                [[NSNotificationCenter defaultCenter]postNotificationName:@"paymentHistory" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]removeObserver:self name:@"paymentHistory" object:nil];
                 self.customBar.selectedItem=nil;
            }
                    
            else if(indexPath.row==2){
                [[NSNotificationCenter defaultCenter]postNotificationName:@"clickHistory" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]removeObserver:self name:@"clickHistory" object:nil];
                 self.customBar.selectedItem=nil;
            }
           // else if(indexPath.row==4){
           //   [[NSNotificationCenter defaultCenter]postNotificationName:@"clickHistory" object:nil];
           //     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"clickHistory" object:nil];
           // }
            else if(indexPath.row==3){
                [[NSNotificationCenter defaultCenter]postNotificationName:@"cashWithdraw" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]removeObserver:self name:@"cashWithdraw" object:nil];
                 self.customBar.selectedItem=nil;
            }

           
            else  if (indexPath.row==4) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"profileEdit" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]removeObserver:self name:@"profileEdit" object:nil];
                 self.customBar.selectedItem=nil;
            }
           
                   
            _selectedSection = indexPath.section;
            _selectedIndex = indexPath.row;
            
           
                }
                if (indexPath.row==5) {
                    [self singOutFunction];
                    return;
                }
            }
            else{
                newViewController = [self.viewControllers objectAtIndex:indexPath.row];
                if ([newViewController isKindOfClass:[UINavigationController class]]) {
                    [(UINavigationController *)newViewController popToRootViewControllerAnimated:YES];
                }
                
                if (indexPath.row==0) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"homeLoad" object:nil];
                    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"homeLoad" object:nil];
                    self.customBar.selectedItem=[self.customBar.items objectAtIndex:0];
                }
                else if (indexPath.row==1) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"signIn" object:nil];
                    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"signIn" object:nil];
                     self.customBar.selectedItem=nil;
                }
                else if(indexPath.row==2){
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"signUp" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"signUp" object:nil];
                     self.customBar.selectedItem=nil;
                }
                _selectedSection = indexPath.section;
                _selectedIndex = indexPath.row;
            }
             [self getSelectedViewControllers:newViewController];
        }];
        
    }//Index Path 1 End
}

-(void) getSelectedViewControllers:(UIViewController *)newViewController{
    // selected new view controller
    UIViewController *oldViewController = _selectedViewController;
    
    
    if (newViewController != nil) {
        [oldViewController.view removeFromSuperview];
        _selectedViewController = newViewController;
        //Update Container View with selected view controller view
        [self updateViewContainer];
        //Check Delegate assign or not
        
        
    }
}

-(void) updateViewContainer{
    self.selectedViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.selectedViewController.view.frame=self.contentContainerView.bounds;
   // self.headerTitleLabel.text = self.selectedViewController.title;
  
    
    NSMutableAttributedString *text3 =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: self.headerTitleLabel.attributedText];
    
    [text3 addAttribute:NSFontAttributeName
                  value:[UIFont boldSystemFontOfSize:18]
                  range:NSMakeRange(3, 3)];
    [self.headerTitleLabel setAttributedText: text3];

    //self.headerTitleLabel.text=
    [self.contentContainerView addSubview:self.selectedViewController.view];
    NSLog(@"Selected ViewController Title ===%@",self.selectedViewController.title);
}

-(void)changeHeaderTitle:(NSNotification*)notify
{
    //self.headerTitleLabel.text=notify.object;
}

#pragma mark- sign Out functionality

-(void)changeToSingin{
    UIViewController *newViewController = [self.viewControllers objectAtIndex:0];
    [self getSelectedViewControllers:newViewController];
}

-(void)afterSignIn
{
    UIViewController *newViewController = [self.signupViewController objectAtIndex:0];
    [self getSelectedViewControllers:newViewController];
}
-(void)singOutFunction{
    NSError * error;
    NSURLResponse *  urlResponse;
    
    NSURL* getUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=signout&user_id=%@",[SingletonClass sharedSingleton].login_userId]];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:getUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return;
    }
    
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@" sign in response %@",json);
    if ([[json objectForKey:@"status"] isEqualToString:@"1"]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@" 성공적으로 로그 아웃." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"signIn"];
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"email"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"password"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [SingletonClass sharedSingleton].login_userId=nil;
        [SingletonClass sharedSingleton].userEmail=nil;
        [SingletonClass sharedSingleton].fname=nil;
        [self changeToSingin];
        [self.menuTableView reloadData];
    }
  
}



@end


static void * const kMyPropertyAssociatedStorageKey = (void*)&kMyPropertyAssociatedStorageKey;



@implementation UIViewController (CustomMenuViewControllerItem)
@dynamic customMenuViewController;

static char const * const orderedElementKey;

-(void) setCustomMenuViewController:(CustomMenuViewController *)customMenuViewController{
    
    NSLog(@"cc==%@",customMenuViewController.viewControllers);
    
    objc_setAssociatedObject(self, &orderedElementKey, customMenuViewController,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //        objc_setAssociatedObject(self, @selector(customMenuViewController), customMenuViewController,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CustomMenuViewController *) customMenuViewController{
    
    if (objc_getAssociatedObject(self, &orderedElementKey) != nil)
    {
        NSLog(@"Element: %@", objc_getAssociatedObject(self, orderedElementKey));
    }
    
    NSLog(@"Element: %@", objc_getAssociatedObject(self, &orderedElementKey));
    //    return objc_getAssociatedObject(self, @selector(customMenuViewController));
    return objc_getAssociatedObject(self, orderedElementKey);
    //return  self.customMenuViewController;
}


/*
 -(CustomMenuViewController *) customViewController{
 //return objc_getAssociatedObject(self, kMyPropertyAssociatedStorageKey);
 return objc_getAssociatedObject(self, @selector(customMenuViewController));
 }
 -(CustomMenuViewController *)firstAvailableViewController{
 return (CustomMenuViewController*)[self traverseResponderChainforUIViewController];
 }
 
 -(id) traverseResponderChainforUIViewController{
 
 id nextResponse = [self nextResponder];
 
 if ([nextResponse isKindOfClass:[CustomMenuViewController class]]){
 return nextResponse;
 }
 else if ([nextResponse isKindOfClass:[UIViewController class]]) {
 return nextResponse;
 }
 else{
 [self traverseResponderChainforUIViewController];
 }
 return  nil;
 }
 */

@end

