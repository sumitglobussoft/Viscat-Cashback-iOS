    //
//  ATNFeedsListViewController.m
//  AddThisNewsFeed
//
//  Created by Jithin Roy on 02/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATNFeedsListViewController.h"
#import "ATNNewsFeedViewController.h"
#import "ATNNewsFeedDetails.h"
#import "ATNWebServiceContents.h"
#import "ATNConstants.h"
#include "ATNWebView.h"
@implementation ATNFeedsListViewController
@synthesize feedTable = feedTable_;
@synthesize newsfeedArray = newsfeedArray_;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationController.navigationBarHidden = NO;
	self.title = TITLE;
	
	newsfeedArray_ = [[NSArray alloc] initWithArray:[ATNNewsFeedDetails fetchAllNewsFeeds]];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	
	return YES;
}


- (void)dealloc {
	[newsfeedArray_ release];
	[feedTable_ release];
    [super dealloc];
}


#pragma mark  -
#pragma mark Table Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [newsfeedArray_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"FeedTableCellID";
	
	// Try to retrieve from the table view a now-unused cell with the given identifier.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil) {
		// Use the default cell style.
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	// Set up the cell.
	cell.textLabel.text = [[newsfeedArray_ objectAtIndex:indexPath.row] newsFeed];
	return cell;

}

#pragma mark  -
#pragma mark Table Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	ATNNewsFeedViewController *newsFeedViewController = 
	[[ATNNewsFeedViewController alloc]initWithNibName:@"ATNNewsFeedViewController" bundle:nil];
	
	newsFeedViewController.newsFeedServiceName = [[newsfeedArray_ objectAtIndex:indexPath.row] newsFeed];
	newsFeedViewController.newsFeedURL = [[newsfeedArray_ objectAtIndex:indexPath.row] newsFeedURL];
	newsFeedViewController.newsFeedServiceIndex = indexPath.row;
	
	[self.navigationController pushViewController:newsFeedViewController animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[newsFeedViewController release];
	
	
}

@end
