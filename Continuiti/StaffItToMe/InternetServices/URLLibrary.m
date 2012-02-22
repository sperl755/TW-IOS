//
//  URLLibrary.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "URLLibrary.h"

@implementation URLLibrary
static URLLibrary *shared = NULL;

-(NSString*)mainAddress {
    return @"https://helium.staffittome.com/apis/";
}

-(NSString*)getJobInfoWithId:(int)the_job_id
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:[NSString stringWithFormat:@"%d", the_job_id]];
    [string appendString:@"/job"];
    return string;
}

-(NSString*)getCreateMessageLink
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"create_message"];
    return string;
}

-(NSString*)getCreateFeedURL
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"create_my_feed"];
    return string;
}

-(NSString*)getJobSearchLink
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"search/"];
    return string;
}

-(NSString*)getViewMessageLnkWithMessageId:(int)the_message_id
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:[NSString stringWithFormat:@"%d", the_message_id]];
    [string appendString:@"/view_message"];
    return string;
}

-(NSString*)getIndustriesListLink
{
    return @"https://helium.staffittome.com/moreapis/industries";
}

-(NSString*)getSubmitApplicationLink
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"submit_application"];
    return string;
}

-(NSString*)getViewCompanyLink
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"view_company"];
    return string;
}

-(NSString*)getJobSuggestionsLink
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"job_suggestion"];
    return string;   
}

-(NSString*)getTermsOfServiceLink
{
    return @"https://helium.staffittome.com/about/termsofservice";
}

-(NSString*)getProfileInfoLinkWithId:(int)the_profile_id
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:[NSString stringWithFormat:@"%d", the_profile_id]];
    [string appendString:@"/profile_details"];
    return string;
}

-(NSString*)getCheckinCheckoutLink
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"checkin_checkout"];
    return string;   
}

-(NSString*)getMyJobContractsLink
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"my_job_contracts"];
    return string; 
}

-(NSString*)getPendingRequestsLinkWithUserId:(int)the_user_id
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:[NSString stringWithFormat:@"%d", the_user_id]];
    [string appendString:@"/list_proposal"];
    return string;  
}

-(NSString*)getOutboxUrl
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"sentbox"];
    return string;  
}

-(NSString*)getInboxUrl
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"inbox"];
    return string;  
}

-(NSString*)getAppliedJobsUrl
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"applied_jobs"];
    return string;     
}
-(NSString*)getEndorseLinkURL
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"endorse"];
    return string;  
}

-(NSString*)getFacebookLoginURL
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"fb_login"];
    return string; 
}

-(NSString*)getCreateProposalUrl
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"create_proposal"];
    return string; 
}

-(NSString*)getCapabilityUrl
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:[self mainAddress]];
    [string appendString:@"capability_list"];
    return string;    
}

/**
    Gets the global FeedService class.
 
    @returns ApplicationDatabase.
 */
+ (URLLibrary*) sharedInstance
{	
	// allocate the shared instance, because it hasn't been done yet
	@synchronized( shared ) {
		if ( !shared || shared == NULL ) {
			shared = [[URLLibrary alloc] init];
		}
	}
	return shared;
}
@end
