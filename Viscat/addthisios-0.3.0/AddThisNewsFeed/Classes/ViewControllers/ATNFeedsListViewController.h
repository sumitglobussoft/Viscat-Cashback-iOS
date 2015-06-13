//
//  ATNFeedsListViewController.h
//  AddThisNewsFeed
//
//  Created by Jithin Roy on 02/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ATNFeedsListViewController : UIViewController {
	UITableView *feedTable_;
	NSArray		*newsfeedArray_;
}

@property (nonatomic, retain) IBOutlet UITableView *feedTable;
@property (nonatomic, retain) NSArray *newsfeedArray;

@end
