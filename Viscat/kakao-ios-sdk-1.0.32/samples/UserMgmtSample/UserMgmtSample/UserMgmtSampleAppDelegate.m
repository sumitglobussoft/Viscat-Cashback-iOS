/**
* Copyright 2014 Daum Kakao Corp.
*
* Redistribution and modification in source or binary forms are not permitted without specific prior written permission.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*    http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

#import "UserMgmtSampleAppDelegate.h"
#import "UserMgmtSampleLoginViewController.h"
#import "UserMgmtSampleViewController.h"

#import <KakaoOpenSDK/KakaoOpenSDK.h>

@implementation UserMgmtSampleAppDelegate

- (void)showLoginView {
    UserMgmtSampleLoginViewController *loginViewController = [[UserMgmtSampleLoginViewController alloc] initWithNibName:nil
                                                                                                                 bundle:nil];
    self.window.rootViewController = loginViewController;
    [self.window makeKeyAndVisible];
}

- (void)showMainView {
    UserMgmtSampleViewController *mainViewController = [[UserMgmtSampleViewController alloc] init];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [KOSession handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // 카카오계정의 세션 연결 상태가 변했을 시,
    // Notification 을 kakaoSessionDidChangeWithNotification 메소드에 전달하도록 설정
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(kakaoSessionDidChangeWithNotification:)
                                                 name:KOSessionDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showMainView)
                                                 name:LoginSuccessNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showLoginView)
                                                 name:LogoutSuccessNotification
                                               object:nil];


    if ([[KOSession sharedSession] isOpen]) {
        [self showMainView];
    } else {
        [self showLoginView];
    }

    return YES;
}

- (void)kakaoSessionDidChangeWithNotification:(NSNotification *)notification {
    if ([KOSession sharedSession].state == KOSessionStateNotOpen) {
        [self showLoginView];
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
    [KOSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
