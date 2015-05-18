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
#import "SharingWithFriendViewController.h"
#import "CustomMenuViewController.h"
#import "InviteFriendViewController.h"
#import "BalanceViewController.h"
#import "PaymentHistoryViewController.h"
#import "HomeViewController.h"
#import "DetailPageViewController.h"
#import "HistoryViewController.h"

@interface ViewController ()
{
    CustomMenuViewController *customMenuViewController;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self goToHomeView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)goToHomeView {
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginVC.title = @"로그인";
    
    SignUpViewController *signupVC= [[SignUpViewController alloc] init];
    signupVC.title = @"가입하기";
    
    
    CashWithdrawViewController *cashWithdrawVC = [[CashWithdrawViewController alloc] initWithNibName:@"CashWithdrawViewController" bundle:nil];
    cashWithdrawVC.title = @"현금인출";
    
    ProfileEditViewController * profileEditVC=[[ProfileEditViewController alloc]initWithNibName:@"ProfileEditViewController" bundle:nil];
    profileEditVC.title=@"내 프로필";
    
    InviteFriendViewController * inviteVC=[[InviteFriendViewController alloc]initWithNibName:@"InviteFriendViewController" bundle:nil];
    inviteVC.title=@"친구에게 소개하기" ;
    
    BalanceViewController* balanceVC=[[BalanceViewController alloc]initWithNibName:@"InviteFriendViewController" bundle:nil];
    balanceVC.title=@"잔고";
    
    PaymentHistoryViewController * paymentHistoryVC=[[PaymentHistoryViewController alloc]initWithNibName:@"PaymentHistoryViewController" bundle:nil];
    paymentHistoryVC.title=@"지불 내역";
    
    HistoryViewController * HistoryVC=[[HistoryViewController alloc]initWithNibName:@"HistoryViewController" bundle:nil];
    HistoryVC.title=@"내역";

    
    HomeViewController * homeVC=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    homeVC.title=@"홈";
    
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeNavigationController.navigationBar.hidden = YES;
    
    
    UINavigationController *loginNavigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    loginNavigationController.navigationBar.hidden = YES;
    if (customMenuViewController) {
        [customMenuViewController removeFromParentViewController];
        customMenuViewController=nil;
    }
    customMenuViewController = [[CustomMenuViewController alloc] init];
    
    
    customMenuViewController.numberOfSections = 1;
    customMenuViewController.viewControllers = @[homeNavigationController,loginNavigationController,signupVC];
    customMenuViewController.signupViewController=@[homeNavigationController,balanceVC,paymentHistoryVC,HistoryVC,cashWithdrawVC,inviteVC,profileEditVC];
    
    
    
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:customMenuViewController];
    navi.navigationBar.hidden = YES;
    customMenuViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navi animated:YES completion:nil];
}



@end
