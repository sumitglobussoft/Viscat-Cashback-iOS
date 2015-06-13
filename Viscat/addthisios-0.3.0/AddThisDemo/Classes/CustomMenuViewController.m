//
//  CustomMenuViewController.m
//  AddThisDemo
//
//  Created by Jithin Roy on 17/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomMenuViewController.h"
#import "AddThis.h"

@interface CustomMenuViewController (PrivateMethod)

- (void)createMenu;

@end

@implementation CustomMenuViewController
@synthesize scrollView = scrollView_;
@synthesize webView = webView_;


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self createMenu];
}

- (void)createMenu {
	serviceList_ = [[NSArray alloc]initWithArray:[AddThisSDK getAllServices]];
	int numberOfService = [serviceList_ count];
	int xIndex = 15;
	int yIndex = 15;
	if(numberOfService) {
		float scrollViewWidth,scrollViewHeight;
		scrollViewWidth = scrollView_.frame.size.width;
		float xoffset = 40;
		float yoffset = 40;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			NSURL *url = [NSURL URLWithString:@"http://www.addthis.com"];
			NSURLRequest *request = [NSURLRequest requestWithURL:url];
			[webView_ loadRequest:request];
		}
		double numberOfIconInRow = floor((scrollViewWidth -15)/xoffset) +1;
		double numberOfColumns = ceil(numberOfService/numberOfIconInRow) +1;
		scrollViewHeight = numberOfColumns * yoffset + 15 ;
		scrollView_.contentSize = CGSizeMake(scrollViewWidth, scrollViewHeight);
		for(int i = 0 ;i < numberOfService; i++) {
			NSDictionary *service = [serviceList_ objectAtIndex:i];
			UIButton *serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
			serviceButton.tag = i;
			serviceButton.frame = CGRectMake(xIndex, yIndex, 20, 20);
			[serviceButton addTarget:self action:@selector(serviceButtonClicked:)
					forControlEvents:UIControlEventTouchUpInside];
			UIImage *serviceIcon = [UIImage imageWithData:[service valueForKey:@"ImageData"]];
			
			[serviceButton setBackgroundImage:serviceIcon forState:UIControlStateNormal];
			serviceButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
			UIViewAutoresizingFlexibleRightMargin |
			UIViewAutoresizingFlexibleLeftMargin;
			
			if(xIndex == 15) {
				serviceButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | 
												UIViewAutoresizingFlexibleBottomMargin;
			}
			xIndex += xoffset;
			
			if(xIndex >= scrollViewWidth - 20){
				xIndex = 15;
				yIndex += yoffset;
			}
			[scrollView_ addSubview:serviceButton];
		}
	}
}

- (void)dealloc {
   
	[scrollView_ release];
	if(webView_)
		[webView_ release];
    
     [super dealloc];
}

- (IBAction)doneButtonClicked:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {	
	scrollView_.contentSize = CGSizeMake( scrollView_.frame.size.width,  scrollView_.contentSize.height);
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
	
}

- (IBAction)serviceButtonClicked:(id)sender {

	UIButton *button = sender;
	NSDictionary *service = [serviceList_ objectAtIndex:button.tag];
	[AddThisSDK shareURL:@"http://www.addthis.com"
			 withService:[service valueForKey:@"ServiceCode"]
										title:@"AddThis - The #1 Bookmarking & Sharing Service"
								  description:@"AddThis is a free way to boost traffic back to your site by making it easier for visitors to share your content."];
}

@end
