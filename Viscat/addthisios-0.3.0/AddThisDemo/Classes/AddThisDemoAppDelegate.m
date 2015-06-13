//
//  AddThisDemoAppDelegate.m
//  AddThisDemo
//
//  Created by Jithin Roy on 31/08/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AddThisDemoAppDelegate.h"
#import "RootViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation AddThisDemoAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	// Add the navigation controller's view to the window and display.
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application 
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication 
         annotation:(id)annotation 
{
    return [FBSession.activeSession handleOpenURL:url]; 
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

