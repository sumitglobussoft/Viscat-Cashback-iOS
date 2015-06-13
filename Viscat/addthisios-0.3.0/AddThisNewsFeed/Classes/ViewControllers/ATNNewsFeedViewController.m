    //
//  ATNNewsFeedViewController.m
//  AddThisNewsFeed
//
//  Created by Jithin Roy on 02/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATNNewsFeedViewController.h"
#import "ATWebServiceAPI.h"
#import "ATNConstants.h"
#import "ATNWebView.h"

@implementation ATNNewsFeedViewController

@synthesize newsFeedTable		= newsFeedTable_;
@synthesize activityIndicator	= activityIndicator_;
@synthesize newsFeedServiceName	= newsFeedServiceName_;
@synthesize newsFeedURL			= newsFeedURL_;
@synthesize newsFeedArray		= newsFeedArray_;

- (void)setNewsFeedServiceIndex:(int)newNewsFeedServiceIndex {
	newsFeedServiceIndex = newNewsFeedServiceIndex;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	
	return YES;
}

- (void)viewDidLoad {
	
	
	self.title = newsFeedServiceName_;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
		activityIndicator_.frame = CGRectMake(IPAD_ACTIVITYINDICATOR_FRAME);
	
	

    webService_ = (ATNWebServiceContents *)[[ATNWebServiceContents alloc] init];
    webService_.delegate = self;
    [(ATNWebServiceContents *)webService_ fetchFeedsFromPath:newsFeedURL_];
	[activityIndicator_ setHidden:NO];
	[activityIndicator_ startAnimating];
	[super viewDidLoad];
	
}

- (void)viewWillDisappear:(BOOL)animated {

	if(webService_.isConnected)
		[webService_ cancelConnection];
	webService_.delegate = nil;
	[super viewWillDisappear:animated];
}


- (void)dealloc {
	if (webService_) {
		[webService_ release];
	}
	if (newsFeedArray_)
		[newsFeedArray_ release];
	[newsFeedServiceName_ release];
	[newsFeedURL_ release];
	[activityIndicator_ release];
	[newsFeedTable_ release];
    [super dealloc];
}

#pragma mark  -
#pragma mark Table Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if (newsFeedArray_) {
		return [newsFeedArray_ count];
	} else {
		return 0;
	}

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"NewsFeedTableCellID";
	
	// Try to retrieve from the table view a now-unused cell with the given identifier.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil) {
		// Use the default cell style.
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	// Set up the cell.
	if (newsFeedArray_)
		cell.textLabel.text = [[newsFeedArray_ objectAtIndex:indexPath.row] objectForKey:@"title"];
	return cell;
	
}

#pragma mark  -
#pragma mark Table Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ATNWebView *viewController = [[ATNWebView alloc] initWithNibName:@"ATNWebView" bundle:nil];
	viewController.urlString = [[newsFeedArray_ objectAtIndex:indexPath.row] objectForKey:@"link"];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark  -
#pragma mark ATWebServiceAPI Delegate

- (void)atConnectionDidFail:(ATNWebServiceAPI *)theConnection {
	[activityIndicator_ stopAnimating];
	[activityIndicator_ setHidden:YES];
	
	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error"
													   message:@"Could not download the news feeds"
													  delegate:nil
											 cancelButtonTitle:@"OK"
											 otherButtonTitles:nil];
	
	[alertView show];
	[alertView release];
	
}

- (void)atConnectionDidFinish:(ATNWebServiceAPI *)theConnection {
	if(newsFeedArray_) {
        [newsFeedArray_ release];
        newsFeedArray_ = nil;
    }
	newsFeedArray_ = [[NSArray alloc] initWithArray:theConnection.feedContentsArray];
	[newsFeedTable_ reloadData];
	[activityIndicator_ stopAnimating];
	[activityIndicator_ setHidden:YES];
	
}	
@end
