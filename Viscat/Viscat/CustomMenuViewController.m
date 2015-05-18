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


@interface CustomMenuViewController ()
{
    ViewController * viewVC;
    NSArray * menuIcon2,*menuIcon1;
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



#pragma mark -
-(void) setViewControllers:(NSArray *)viewControllers{
    
    _viewControllers = [viewControllers copy];
    
    for (UIViewController *viewController in _viewControllers) {
        [self addChildViewController:viewController];
        viewController.view.frame = CGRectMake(0, 55,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height-55);
        
        [viewController didMoveToParentViewController:self];
    }
    
}
-(void) setSecondSectionViewControllers:(NSArray *)secondSectionViewControllers{
    _secondSectionViewControllers = [secondSectionViewControllers copy];
    
    for (UIViewController *viewController in self.secondSectionViewControllers ) {
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
    
    
    menuIcon2=[NSArray arrayWithObjects:@"home_menuicon.png",@"balance_menuicon.png",@"payment_menuicon.png",@"paymenthistory_menuicon.png",@"cashwithdraw_menuicon.png",@"sharing_friends_menuicon.png",@"profileedit_menuicon.png", nil];
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
    self.headerView.backgroundColor=[UIColor whiteColor];
    [self.mainsubView addSubview:self.headerView];
    NSLog(@"Width menu== %f",self.view.frame.size.width);
    
    self.headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, self.view.frame.size.width-120, 25)];
    self.headerTitleLabel.textColor = [UIColor colorWithRed:(CGFloat)79/255 green:(CGFloat)167/255 blue:(CGFloat)229/255 alpha:1];
    self.headerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.headerTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.headerView addSubview:self.headerTitleLabel];
    
    //============================
    //Add Menu Button
    
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menuButton.frame = frame_b;
    self.menuButton.titleLabel.font = [UIFont systemFontOfSize:9.0f];
    self.menuButton.titleLabel.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    //self.menuButton.titleLabel.layer.
    [self.menuButton addTarget:self action:@selector(menuButtonClciked:) forControlEvents:UIControlEventTouchUpInside];
    self.menuButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"menu.png"]];
    
    [self.headerView addSubview:self.menuButton];
    
    //===================================
    
    self.selectedIndex = 0;
    self.selectedViewController=[self.viewControllers objectAtIndex:0];
   
    
    [self updateViewContainer];
    [self createMenuTableView];
    
    
    self.swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    self.swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.mainsubView addGestureRecognizer:self.swipeGesture];
   
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
            if (indexPath.row==7) {
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
        //Dismiss Menu TableView with Animation
        [UIView animateWithDuration:.5 animations:^{
            
            self.mainsubView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.screen_height);
            
        }completion:^(BOOL finished){
            
            UIViewController *newViewController;
            BOOL signIn=[[NSUserDefaults standardUserDefaults]boolForKey:@"signIn"];
            if (signIn) {
                if (indexPath.row<self.signupViewController.count) {
                newViewController = [self.signupViewController objectAtIndex:indexPath.row];
                _selectedSection = indexPath.section;
                _selectedIndex = indexPath.row;
                
            if (indexPath.row==6) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"profileEdit" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]removeObserver:self name:@"profileEdit" object:nil];
                self.customBar.selectedItem = [self.customBar.items objectAtIndex:6];
            }
                    if (indexPath.row==1) {
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"balanceDetail" object:nil userInfo:nil];
                        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"balanceDetail" object:nil];
                        self.customBar.selectedItem = [self.customBar.items objectAtIndex:1];
                    }
                    if(indexPath.row==2){
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"paymentHistory" object:nil userInfo:nil];
                        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"paymentHistory" object:nil];
                        self.customBar.selectedItem = [self.customBar.items objectAtIndex:2];

                    }
                    if(indexPath.row==3){
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"History" object:nil userInfo:nil];
                        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"History" object:nil];
                        self.customBar.selectedItem = [self.customBar.items objectAtIndex:3];
                        
                    }
        }
            
            if (indexPath.row==7) {
                [self singOutFunction];
                return;
            }
        }
            else{
                
                newViewController = [self.viewControllers objectAtIndex:indexPath.row];
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
    self.headerTitleLabel.text = self.selectedViewController.title;
    [self.contentContainerView addSubview:self.selectedViewController.view];
    NSLog(@"Selected ViewController Title ===%@",self.selectedViewController.title);
}

-(void)changeHeaderTitle:(NSNotification*)notify
{
    self.headerTitleLabel.text=notify.object;
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
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"signIn"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [SingletonClass sharedSingleton].login_userId=nil;
    [SingletonClass sharedSingleton].userEmail=nil;
    [SingletonClass sharedSingleton].fname=nil;
    [self changeToSingin];
    [self.menuTableView reloadData];
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

