//
//  RootViewController.m
//  AddThisDemo
//
//  Created by Jithin Roy on 31/08/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "AddThis.h"
#import "CustomMenuViewController.h"

@implementation RootViewController


@synthesize webView;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBar.hidden = YES;
	
	//Load the webview with http://www.addthis.com
	NSURL *url = [NSURL URLWithString:@"http://www.addthis.com"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[webView loadRequest:request];
	
	//configure addthis -- (this step is optional)
	[AddThisSDK setNavigationBarColor:[UIColor lightGrayColor]];
	[AddThisSDK setToolBarColor:[UIColor lightGrayColor]];
	[AddThisSDK setSearchBarColor:[UIColor lightGrayColor]];
	
	//Facebook connect settings
	//CHANGE THIS FACEBOOK API KEY TO YOUR OWN!!
	[AddThisSDK setFacebookAPIKey:@"147862618648627"];
	[AddThisSDK setFacebookAuthenticationMode:ATFacebookAuthenticationTypeFBConnect];
	
	//CHANGE THIS TWITTER API KEYS TO YOUR OWN!!
	[AddThisSDK setTwitterConsumerKey:@"LGv5u6rSHT5apS5pQZFDw"];
	[AddThisSDK setTwitterConsumerSecret:@"BPyxJc0plzxm3Z5io4CDsTKK8tO2AJq00rocEukX6I"];
	[AddThisSDK setTwitterCallBackURL:@"http://addthis.com/mobilesdk/twittertesting"];
	
    [AddThisSDK setTwitPicAPIKey:@"45149651ec391a4e2b8135b43a63346b"];
    [AddThisSDK setTwitterAuthenticationMode:ATTwitterAuthenticationTypeOAuth];
    
	
	//Display addthis button 
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		addThisButton = [AddThisSDK showAddThisButtonInView:self.view
								  withFrame:CGRectMake(80, 640, 161, 50) 
									 forURL:@"http://www.addthis.com"
								  withTitle:@"AddThis - The #1 Bookmarking & Sharing Service"
								description:@"AddThis is a free way to boost traffic back to your site by making it easier for visitors to share your content."];
	}
	else {
		addThisButton = [AddThisSDK showAddThisButtonInView:self.view
												  withFrame:CGRectMake(20, 327, 70, 25)
													 forURL:@"http://www.addthis.com/"
												  withTitle:@"AddThis - The #1 Bookmarking & Sharing Service"
												description:@"AddThis is a free way to boost traffic back to your site by making it easier for visitors to share your content."];
	}
	
	addThisButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | 
									 UIViewAutoresizingFlexibleTopMargin;
	[AddThisSDK canUserEditServiceMenu:YES];
	[AddThisSDK canUserReOrderServiceMenu:YES];
	[AddThisSDK setDelegate:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation ==UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark User Interactions

- (IBAction)createMenuButtonClicked:(id)sender {
	NSString *nibNameForDevice;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		nibNameForDevice = @"CustomMenuView-iPad";
	}
	else {
		nibNameForDevice = @"CustomMenuView";
	}
	
	CustomMenuViewController *customViewController = [[CustomMenuViewController alloc]initWithNibName:nibNameForDevice
																							   bundle:nil];
	[self presentModalViewController:customViewController animated:YES];
	[customViewController release];
}

- (IBAction)shareButtonClicked:(id)sender {
	
	//Show addthis menu
	UIButton *button = sender;
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	if (!window) {
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
	[AddThisSDK presentAddThisMenuInPopoverForURL: @"http://www.addthis.com" 
										 fromRect:[self.view convertRect:button.frame toView:window]
									 withTitle:@"AddThis - The #1 Bookmarking & Sharing Service" 
									description:@"AddThis is a free way to boost traffic back to your site by making it easier for visitors to share your content."];

}


- (IBAction)imageSharingButtonClicked:(id)sender {
	
	[AddThisSDK presentAddThisMenuInPopoverForImage:[UIImage imageNamed:@"Icon-72.png"]
										   fromRect:CGRectNull
										  withTitle:@"AddThis - The #1 Bookmarking & Sharing Service" 
										description:@"AddThis is a free way to boost traffic back to your site by making it easier for visitors to share your content."];
}

- (IBAction)twitterButtonClicked:(id)sender {
	//share to twitter
	[AddThisSDK shareURL:@"http://www.addthis.com"
			 withService:@"twitter"
				   title:@"AddThis - The #1 Bookmarking & Sharing Service"
			 description:@"AddThis is a free way to boost traffic back to your site by making it easier for visitors to share your content."];
}

- (IBAction)facebookButtonClicked:(id)sender {
	//share to facebook
	[AddThisSDK shareURL:@"http://www.addthis.com"
			 withService:@"facebook"
				   title:@"AddThis - The #1 Bookmarking & Sharing Service"
			 description:@"AddThis is a free way to boost traffic back to your site by making it easier for visitors to share your content."];


}

- (IBAction)mySpaceButtonClicked:(id)sender{
	//share to myspace
	[AddThisSDK shareURL:@"http://www.addthis.com"
			 withService:@"myspace"
				   title:@"AddThis - The #1 Bookmarking & Sharing Service"
			 description:@"AddThis is a free way to boost traffic back to your site by making it easier for visitors to share your content."];
}
- (IBAction)stumbleUponButtonClicked:(id)sender{
	//share to stumbleupon
	[AddThisSDK shareURL:@"http://www.addthis.com"
			 withService:@"stumbleupon"
				   title:@"AddThis - The #1 Bookmarking & Sharing Service"
			 description:@"AddThis is a free way to boost traffic back to your site by making it easier for visitors to share your content."];
}
- (IBAction)diggButtonClicked:(id)sender{
	//share to digg
	[AddThisSDK shareURL:@"http://www.addthis.com"
			 withService:@"digg"
				   title:@"AddThis - The #1 Bookmarking & Sharing Service"
			 description:@"AddThis is a free way to boost traffic back to your site by making it easier for visitors to share your content."];
}

- (IBAction)googleButtonClicked:(id)sender{
	//share to google bookmarks
	[AddThisSDK shareURL:@"http://www.addthis.com"
			 withService:@"google"
				   title:@"AddThis - The #1 Bookmarking & Sharing Service"
			 description:@"AddThis is a free way to boost traffic back to your site by making it easier for visitors to share your content."];
}

- (IBAction)emailButtonClicked:(id)sender{
	//share to native email
	[AddThisSDK shareURL:@"http://www.addthis.com"
			 withService:@"mailto"
				   title:@"AddThis - The #1 Bookmarking & Sharing Service"
			 description:@"AddThis is a free way to boost traffic back to your site by making it easier for visitors to share your content."];
}

#pragma mark -
#pragma mark AddThisSDK Delegate

- (void)didInitiateShareForService:(NSString *)serviceCode {
	NSLog(@"Share started for service - %@",serviceCode);
}

#pragma mark -
#pragma mark Memory management


- (void)dealloc {
	[addThisButton release];
	[webView release];
    [super dealloc];
	
}

@end

