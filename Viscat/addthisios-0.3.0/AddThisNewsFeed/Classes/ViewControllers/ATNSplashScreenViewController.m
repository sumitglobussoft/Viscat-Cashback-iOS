//
//  ATNSplashScreenViewController.m
//  AddThisNewsFeed
//
//  Created by Jithin Roy on 02/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATNSplashScreenViewController.h"
#import "ATNFeedsListViewController.h"
#import "ATNConstants.h"

@implementation ATNSplashScreenViewController
@synthesize label = label_;

- (void) viewDidLoad {
	[super viewDidLoad];
	self.navigationController.navigationBarHidden = YES;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		label_.frame = CGRectMake(LABEL_FRAME);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	
	return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	ATNFeedsListViewController *feedsViewController = [[ATNFeedsListViewController alloc]initWithNibName:@"ATNFeedsList"
																								  bundle:nil];
	[self.navigationController pushViewController:feedsViewController animated:YES];
	[feedsViewController release];
	
}

- (void)dealloc {
	[label_ release];
    [super dealloc];
}
 
@end
