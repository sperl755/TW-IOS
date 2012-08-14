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

@synthesize request_success_function;
@synthesize request_failed_function;
@synthesize delegate;

/**
	Creates a new feed on the server. Dictionary values are 
 session_key
 feed
 feed_filter
 share_to_career_team
 share_to_friend
 url_title
 url_address
 url_description
 
	@param the_values The dictioanry of values to post on the request.
 */
-(void)postNewFeedWithDictionary:(NSDictionary *)the_values {
    
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSURL *url = [[NSURL alloc] initWithString:[[URLLibrary sharedInstance] getCreateFeedURL]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:30];
    [request setDelegate:delegate];
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
	Gets the users feed subscriptions from the site.
 */
-(void)getUsersFeedSubscriptions
{
    StaffItToMeAppDelegate *app_delegate    = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *url_string = [[URLLibrary sharedInstance] getUsersFeedSubscriptionsUrlWithSessionKey:app_delegate.user_state_information.sessionKey];
    NSURL *url                              = [[NSURL alloc] initWithString:url_string];
    ASIFormDataRequest *request             = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"GET"];
    [request setDidFailSelector:@selector(requestFail:)];
    [request setDidFinishSelector:@selector(requestSucceed:)];
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
    
}
-(void)requestFail:(ASIHTTPRequest*)the_request
{
    [delegate performSelector:request_failed_function withObject:[the_request retain]];
}
-(void)requestSucceed:(ASIHTTPRequest*)the_request
{
    [delegate performSelector:request_success_function withObject:[the_request retain]];
}
@end
