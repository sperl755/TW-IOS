//
//  URLLibrary.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLLibrary : NSObject
{
    
}
-(NSString*)mainAddress;
-(NSString*)getJobInfoWithId:(int)the_job_id;
-(NSString*)getCreateMessageLink;
-(NSString*)getCreateFeedURL;
-(NSString*)getJobSearchLink;
-(NSString*)getViewMessageLnkWithMessageId:(int)the_message_id;
-(NSString*)getIndustriesListLink;
-(NSString*)getSubmitApplicationLink;
-(NSString*)getViewCompanyLink;
-(NSString*)getJobSuggestionsLink;
-(NSString*)getTermsOfServiceLink;
-(NSString*)getProfileInfoLinkWithId:(int)the_profile_id;
-(NSString*)getCheckinCheckoutLink;
-(NSString*)getMyJobContractsLink;
-(NSString*)getPendingRequestsLinkWithUserId:(int)the_user_id;
-(NSString*)getOutboxUrl;
-(NSString*)getInboxUrl;
-(NSString*)getAppliedJobsUrl;
-(NSString*)getEndorseLinkURL;
-(NSString*)getFacebookLoginURL;
-(NSString*)getCreateProposalUrl;
-(NSString*)getCapabilityUrl;
+ (URLLibrary*) sharedInstance;
@end
