//
//  ViewController.m
//  Viscat
//
//  Created by Sumit Ghosh on 15/05/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "ViewController.h"

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "CashWithdrawViewController.h"
#import "ClickHistoryViewController.h"
#import "ProfileEditViewController.h"
#import "CustomMenuViewController.h"
#import "InviteFriendViewController.h"
#import "BalanceViewController.h"
#import "PaymentHistoryViewController.h"
#import "HomeViewController.h"
#import "DetailPageViewController.h"
#import "HistoryViewController.h"

#import "AppDelegate.h"

@interface ViewController ()
{
    CustomMenuViewController *customMenuViewController;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self goToHomeView];
    [self loadAllClasses];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)loadAllClasses{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate  goToHomeView];
}





@end
