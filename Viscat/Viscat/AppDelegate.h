//
//  AppDelegate.h
//  Viscat
//
//  Created by Sumit Ghosh on 15/05/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Reachability.h"
#import "CustomMenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) Reachability *internetReachability;
@property(nonatomic,strong)UITabBarController * tabbarController;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//+(CustomMenuViewController*)goToHomeView;
-(void)goToHomeView;
@end

