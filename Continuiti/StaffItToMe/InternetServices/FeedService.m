//
//  FeedService.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedService.h"
#import "ASIFormDataRequest.h"
#import "StaffItToMeAppDelegate.h"

@implementation FeedService

static FeedService *shared = NULL;
@synthesize request_success_function;
@synthesize request_failed_function;

-(void)postNewFeedWithDictionary:(NSDictionary *)the_values {
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSURL *url = [[NSURL alloc] initWithString:[[URLLibrary sharedInstance] getCreateFeedURL]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request setDidFailSelector:request_failed_function];
    [request setDidFinishSelector:request_success_function];
    
    [request setPostValue:app_delegate.user_state_information.sessionKey    forKey:@"session_key"];
    [request setPostValue:[the_values objectForKey:@"feed"]                 forKey:@"feed"];
    [request setPostValue:[the_values objectForKey:@"feed_filter"]          forKey:@"feed_filter"];
    [request setPostValue:[the_values objectForKey:@"share_to_career_team"] forKey:@"share_to_career_team"];
    [request setPostValue:[the_values objectForKey:@"share_to_friend"]      forKey:@"share_to_friend"];
    [request setPostValue:[the_values objectForKey:@"url_title"]            forKey:@"url_title"];
    [request setPostValue:[the_values objectForKey:@"url_address"]          forKey:@"url_address"];
    [request setPostValue:[the_values objectForKey:@"url_description"]      forKey:@"url_description"];
    
    [request startAsynchronous];
}

/**
    Gets the global FeedService class.
 
    @returns ApplicationDatabase.
 */
+ (FeedService*) sharedInstance
{	
	// allocate the shared instance, because it hasn't been done yet
	@synchronized( shared ) {
		if ( !shared || shared == NULL ) {
			shared = [[FeedService alloc] init];
		}
	}
	return shared;
}
@end
