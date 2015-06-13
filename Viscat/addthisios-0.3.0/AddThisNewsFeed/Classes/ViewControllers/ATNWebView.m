//
//  ATNWebView.m
//  AddThisNewsFeed
//
//  Created by Jithin Roy on 04/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#include "AddThis.h"
#import "ATNWebView.h"
#import "ATNetworkActivity.h"
#import "ATNConstants.h"

@implementation ATNWebView
@synthesize webView		= webView_;
@synthesize urlString	= urlString_;
@synthesize activityIndicatorView = activityIndicatorView_;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Article";

	// Checks whether device is an iPad.
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		activityIndicatorView_.frame = CGRectMake(IPAD_ACTIVITYINDICATOR_FRAME);


	//configure addthis -- (this step is optional)
	[AddThisSDK setNavigationBarColor:[UIColor lightGrayColor]];
	[AddThisSDK setToolBarColor:[UIColor lightGrayColor]];
	[AddThisSDK setSearchBarColor:[UIColor lightGrayColor]];
	[AddThisSDK setModalPresentationStyle:UIModalPresentationFormSheet];
	
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
	
	
	//URL object.
	NSURL *url = [NSURL URLWithString:urlString_];
	
	//URL Requst Object
	NSURLRequest *requestObject = [NSURLRequest requestWithURL:url];
	
	//Load the request in the UIWebView.
	[webView_ loadRequest:requestObject];
	[activityIndicatorView_ setHidden:NO];
	[activityIndicatorView_ startAnimating];
	
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	
	return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[ATNetworkActivity popNetworkActivity];
	[super viewWillDisappear:animated];
}

- (void)dealloc {
	webView_.delegate = nil;
	[urlString_ release];
	[activityIndicatorView_ release];
	[webView_ release];
    [super dealloc];
}

-(IBAction)clickedShareButton:(id)sender{
	[AddThisSDK presentAddThisMenuForURL:urlString_
							   withTitle:nil
							 description:nil];
}

#pragma mark -
#pragma mark UIWebView delegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[ATNetworkActivity popNetworkActivity];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[ATNetworkActivity pushNetworkActivity];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[ATNetworkActivity popNetworkActivity];
	[activityIndicatorView_ setHidden:YES];
	[activityIndicatorView_ stopAnimating];
}


@end
