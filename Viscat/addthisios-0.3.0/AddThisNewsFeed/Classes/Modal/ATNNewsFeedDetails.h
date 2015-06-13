//
//  ATNNewsFeedDetails.h
//  AddThisNewsFeed
//
//  Created by Jithin Roy on 03/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ATNNewsFeedDetails : NSObject {
	
	NSString	*newsFeed_;
	NSString	*newsFeedURL_;

}

@property (nonatomic, retain) NSString *newsFeed, *newsFeedURL;

//+ (NSString*)returnNewsFeedDetailsPlistPath;
+ (NSArray *)fetchAllNewsFeeds;
//
//- (id)initWithNewsFeedIndex:(int)newsFeedIndex;
//- (id)initWithNewsFeedName:(NSString *)newName
//					   url:(NSString *)newURL;

@end
