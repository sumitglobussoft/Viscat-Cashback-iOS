//
//  AppDelegate.m
//  Viscat
//
//  Created by Sumit Ghosh on 15/05/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "AppDelegate.h"
#import <KakaoOpenSDK/KakaoOpenSDK.h>
#import "SingletonClass.h"


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

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     [self checkNetworkStatus];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus) name:@"reachability" object:nil];
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    
    // Override point for customization after application launch.
  //  return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  
   if ([KOSession isKakaoAccountLoginCallback:url]) {
       return [KOSession handleOpenURL:url];
   }
    else{
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];
   }

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
     [FBSDKAppEvents activateApp];
     [KOSession handleDidBecomeActive];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma  mark -
// Check Network Status of App
-(void) checkNetworkStatus{
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    
    [self.internetReachability startNotifier];
    
    NetworkStatus a = [self.internetReachability currentReachabilityStatus];
    switch (a) {
        case NotReachable:
            NSLog(@"Not Reachable");
            [SingletonClass sharedSingleton].isActivenetworkConnection = NO;
            break;
        case ReachableViaWiFi:
            NSLog(@"Reachable via WAN");
           [SingletonClass sharedSingleton].isActivenetworkConnection = YES;
            break;
        case ReachableViaWWAN:
            NSLog(@"Reachable Via Wifi");
            [SingletonClass sharedSingleton].isActivenetworkConnection = YES;
            break;
            
        default:
            break;
    }
    
}


-(void)goToHomeView {
    
    // before sign in
    HomeViewController * homeVC=[[HomeViewController alloc]init];
    homeVC.title=@"홈";
   
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    loginVC.title = @"로그인";
    
    SignUpViewController *signupVC= [[SignUpViewController alloc] init];
    signupVC.title = @"가입하기";
    
    /////////////////////////////////////////////////////////////////////
    
//    BalanceViewController* balanceVC=[[BalanceViewController alloc]init];
//    balanceVC.title=@"잔고";
    
    PaymentHistoryViewController * paymentHistoryVC=[[PaymentHistoryViewController alloc]init];
    paymentHistoryVC.title=@"지불 내역";
    
   // HistoryViewController * HistoryVC=[[HistoryViewController alloc]init];
   // HistoryVC.title=@"내역";
    
    ClickHistoryViewController  * clickHistory=[[ClickHistoryViewController alloc]init];
    clickHistory.title=@"내역 클릭";
    
    CashWithdrawViewController *cashWithdrawVC = [[CashWithdrawViewController alloc]init];
    cashWithdrawVC.title = @"현금인출";
    
   // InviteFriendViewController * inviteVC=[[InviteFriendViewController alloc]init];
   // inviteVC.title=@"친구에게 소개하기" ;
    
    ProfileEditViewController * profileEditVC=[[ProfileEditViewController alloc]init];
    profileEditVC.title=@"내 프로필";
    
   

    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeVC];
     homeNavigationController.navigationBar.hidden = YES;

    UINavigationController *paymentHistoryVController = [[UINavigationController alloc] initWithRootViewController:paymentHistoryVC];
    homeNavigationController.navigationBar.hidden = YES;
    
    UINavigationController *clickHistoryController = [[UINavigationController alloc] initWithRootViewController:clickHistory];
    clickHistoryController.navigationBar.hidden = YES;

    UINavigationController *cashWithdrawVController = [[UINavigationController alloc] initWithRootViewController:cashWithdrawVC];
    cashWithdrawVController.navigationBar.hidden = YES;

    UINavigationController *profileEditVController = [[UINavigationController alloc] initWithRootViewController:profileEditVC];
    profileEditVController.navigationBar.hidden = YES;

    
    UINavigationController *loginNavigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    loginNavigationController.navigationBar.hidden = YES;
    
    NSString * username=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    NSString * password=[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    if ([username length]!=0 && [password length]!=0) {
        [self loginAction :username andPass:password];
    }
    CustomMenuViewController *customMenuView =[[CustomMenuViewController alloc] init];
    customMenuView.numberOfSections = 1;
    customMenuView.viewControllers = @[homeNavigationController,loginNavigationController,signupVC];
   // customMenuView.signupViewController=@[homeNavigationController,balanceVC,paymentHistoryVC,HistoryVC,clickHistory,cashWithdrawVC,inviteVC,profileEditVC];
    
    customMenuView.signupViewController=@[homeNavigationController,paymentHistoryVController,clickHistoryController,cashWithdrawVController,profileEditVController];

    
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:customMenuView];
    self.window.rootViewController = navigation;
    
    [self.window setRootViewController:customMenuView];
   // return customMenuView;
}

-(void)loginAction :(NSString *)username andPass:(NSString *)pass{
   
        NSError * error;
        NSURLResponse * urlResponse;
        
        NSString * getUrlStr=[NSString stringWithFormat:@"http://www.biscash.com/windex.php?method=signin&email=%@&password=%@",username,pass];
        
        NSURL * getUrl=[NSURL URLWithString:getUrlStr];
        NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:getUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if (data==nil) {
            return;
        }
        
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if ([[json objectForKey:@"status"]isEqualToString:@"1"])
        {
            
            
            NSMutableDictionary * dict=[NSMutableDictionary dictionary];
            dict=[json objectForKey:@"UserInfo"];
            [SingletonClass sharedSingleton].login_userId=[dict objectForKey:@"user_id"];
            [SingletonClass sharedSingleton].fname=[dict objectForKey:@"fname"];
            [SingletonClass sharedSingleton].userEmail=[dict objectForKey:@"email"];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"signIn"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"HomeScreen" object:nil];
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HomeScreen" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadmenuTable" object:nil];
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadmenuTable" object:nil];

        }
        else
        {
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"잘못된 이메일 / 암호" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }


}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.globussoft.Viscat" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Viscat" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Viscat.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
       
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
            abort();
        }
    }
}

@end
