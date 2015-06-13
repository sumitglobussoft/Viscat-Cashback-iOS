//
//  CustomMenuViewController.h
//  AddThisDemo
//
//  Created by Jithin Roy on 17/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomMenuViewController : UIViewController {
	UIScrollView *scrollView_;
	UIWebView *webView_;
	NSArray *serviceList_;
}
@property (nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain)IBOutlet UIWebView *webView;
- (IBAction)doneButtonClicked:(id)sender;

@end
