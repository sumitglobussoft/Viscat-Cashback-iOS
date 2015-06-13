//
//  AddThisNewsFeedAppDelegate.m
//  AddThisNewsFeed
//
//  Created by Jithin Roy on 02/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AddThisNewsFeedAppDelegate.h"
#import "ATNSplashScreenViewController.h"


@implementation AddThisNewsFeedAppDelegate

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



- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

