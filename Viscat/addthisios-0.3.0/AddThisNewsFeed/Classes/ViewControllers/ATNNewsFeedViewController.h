//
//  ATNNewsFeedViewController.h
//  AddThisNewsFeed
//
//  Created by Jithin Roy on 02/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATNWebServiceContents.h"
#import "ATWebServiceAPI.h"

@interface ATNNewsFeedViewController : UIViewController < ATWebserviceDelegate> {

	NSArray					*newsFeedArray_;	
	NSString				*newsFeedServiceName_;
	NSString				*newsFeedURL_;
	UITableView				*newsFeedTable_;
	UIActivityIndicatorView *activityIndicator_;
	
	ATNWebServiceAPI			*webService_;

	int newsFeedServiceIndex;
}
@property (nonatomic, retain) IBOutlet UITableView *newsFeedTable;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSString *newsFeedServiceName, *newsFeedURL;
@property (nonatomic, retain) NSArray *newsFeedArray;

- (void)setNewsFeedServiceIndex:(int)newNewsFeedServiceIndex;

@end
