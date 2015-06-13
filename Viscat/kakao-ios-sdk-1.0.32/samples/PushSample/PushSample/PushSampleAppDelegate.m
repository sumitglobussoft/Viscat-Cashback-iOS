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

#import "PushSampleAppDelegate.h"
#import "PushSampleViewController.h"
#import "PushSampleLoginViewController.h"
#import <KakaoOpenSDK/KakaoOpenSDK.h>

@implementation PushSampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // 카카오계정의 세션 연결 상태가 변했을 시,
    // Notification 을 kakaoSessionDidChangeWithNotification 메소드에 전달하도록 설정
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(kakaoSessionDidChangeWithNotification:)
                                                 name:KOSessionDidChangeNotification
                                               object:nil];

    [self showMainView];

    if (![[KOSession sharedSession] isOpen]) {
        [self showLoginView];
    }

    // Push Device Token 요청
    UIApplication *sharedApplication = [UIApplication sharedApplication];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f) {
        [sharedApplication registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIRemoteNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil]];
        [sharedApplication registerForRemoteNotifications];
    } else {
        [sharedApplication registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }

    return YES;
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    [KOSession handleDidBecomeActive];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - more app delegates

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [KOSession handleOpenURL:url];
}

#pragma mark - custom methods

- (void)showLoginView {

    PushSampleLoginViewController *loginViewController = [[PushSampleLoginViewController alloc] init];

    loginViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    loginViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    [self.window.rootViewController presentViewController:loginViewController
                                                 animated:NO
                                               completion:^(void) {
                                               }];

}

- (void)showMainView {
    PushSampleViewController *mainViewController = [[PushSampleViewController alloc] init];

    self.window.rootViewController = mainViewController;
    [self.window makeKeyAndVisible];
}

- (void)kakaoSessionDidChangeWithNotification:(NSNotification *)notification {
    if ([KOSession sharedSession].state == KOSessionStateNotOpen) {
        [self showLoginView];
    }
}

#pragma mark - push

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    _deviceToken = deviceToken;

    NSLog(@"[INFO] Device Token for Push Notification: %@", deviceToken);

}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"[WARN] Failed to get the device token from APNS: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Push 수신"
                                                    message:[userInfo description]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];

    [alert show];

}


@end
