//
//  ATNNewsFeedDetails.m
//  AddThisNewsFeed
//
//  Created by Jithin Roy on 03/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATNNewsFeedDetails.h"


@implementation ATNNewsFeedDetails

@synthesize newsFeed	= newsFeed_;
@synthesize newsFeedURL = newsFeedURL_;


- (void) dealloc {
    [newsFeed_ release];
    [newsFeedURL_ release];
    [super dealloc];
}

- (id)initWithNewsFeedName:(NSString *)newName
					   url:(NSString *)newURL {
	
	self = [self init];
    if(self) {
        newsFeed_ = [newName retain];
        newsFeedURL_ = [newURL retain];
	}
	return self;
}

+ (NSString*)returnNewsFeedDetailsPlistPath {
    
	NSString *path = [[NSBundle mainBundle] pathForResource:@"NewsFeedDetails" 
													 ofType:@"plist"];
	return path;
}

+ (NSArray *)fetchAllNewsFeeds {
	
	NSMutableArray *newsFeedDetailsObjectArray = [[NSMutableArray alloc] init];
	NSArray *newsFeedDetailsArray = [[NSArray alloc]
									 initWithContentsOfFile:[ATNNewsFeedDetails returnNewsFeedDetailsPlistPath]];
    
	for (NSDictionary *newsFeedDetailsDictionary in newsFeedDetailsArray) {
		ATNNewsFeedDetails *newsFeedDetails = [[ATNNewsFeedDetails alloc] 
											   initWithNewsFeedName:[newsFeedDetailsDictionary objectForKey:@"newsFeed"] 
											   url:[newsFeedDetailsDictionary objectForKey:@"newsFeedURL"]];
		[newsFeedDetailsObjectArray addObject:newsFeedDetails];
		[newsFeedDetails release];
	}
	[newsFeedDetailsArray release];
	return [newsFeedDetailsObjectArray autorelease];
}

@end
