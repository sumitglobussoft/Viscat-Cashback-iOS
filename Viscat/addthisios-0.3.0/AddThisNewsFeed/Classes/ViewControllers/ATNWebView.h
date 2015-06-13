//
//  ATNWebView.h
//  AddThisNewsFeed
//
//  Created by Jithin Roy on 04/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ATNWebView : UIViewController {

	UIWebView				*webView_;
	NSString				*urlString_;
	UIActivityIndicatorView	*activityIndicatorView_;
}


@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString	*urlString;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView	*activityIndicatorView;

-(IBAction)clickedShareButton:(id)sender;

@end
