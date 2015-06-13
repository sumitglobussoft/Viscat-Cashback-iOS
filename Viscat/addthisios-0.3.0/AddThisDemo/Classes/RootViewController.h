//
//  RootViewController.h
//  AddThisDemo
//
//  Created by Jithin Roy on 31/08/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {
	UIButton *addThisButton;
	UIWebView *webView;
	
}
@property (nonatomic,retain) IBOutlet UIWebView *webView;

- (IBAction)shareButtonClicked:(id)sender;
- (IBAction)twitterButtonClicked:(id)sender;
- (IBAction)facebookButtonClicked:(id)sender;
- (IBAction)mySpaceButtonClicked:(id)sender;
- (IBAction)stumbleUponButtonClicked:(id)sender;
- (IBAction)diggButtonClicked:(id)sender;
- (IBAction)googleButtonClicked:(id)sender;
- (IBAction)emailButtonClicked:(id)sender;

- (IBAction)imageSharingButtonClicked:(id)sender;
- (IBAction)createMenuButtonClicked:(id)sender;

@end
