//
//  USERINFORMATIONANDAPPSTATE.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmallJobs.h"
#import "MyJob.h"
#import "JobBillingHistoryObject.h"
#import "JSON.h"
#import "MessageHeaderObject.h"
#import "UserInfo.h"
#import "LocationManager.h"
#import "DataMaker.h"
/**
 This class is everything about the user and is used only
 after login. IT represents the jobs that the user has
 the ones they can get and more.
 */
@interface USERINFORMATIONANDAPPSTATE : NSObject {
    LocationManager *local_manager;
    //BOOL im_available;
    
}
-(id)initWithCoder:(NSCoder*)aDecoder;
-(void)encodeWithCoder:(NSCoder*)aCoder;
-(void)getUserInformation:(NSString*)user_information;
-(void)populateUserCapabilities;
-(void)populateMyJobArrayWithJSONString:(NSString*)the_string;
-(void)populateJobArrayWithJSONString:(NSString *)the_string;
-(void)populateSuggestedJobsArrayWithString:(NSString*)the_string;
-(void)populateMyInboxWithString:(NSString*)the_string;
-(void)startUpdatingUserLocation;
-(void)stopUpdatingUserLocation;
-(void)populateMySentMessagesWithString:(NSString *)the_string;
@property (nonatomic, assign) NSString *currentTabBar;
@property (nonatomic, assign) NSString *userName;
@property (nonatomic, assign) NSString *sessionKey;
@property (nonatomic, retain) NSString *industry_search_type;
@property (nonatomic, retain) NSString *salary_search_type;
@property (nonatomic, retain) NSString *distance_search_type;
@property (nonatomic, assign) NSString *facebook_id;
@property (nonatomic, assign) NSString *picture_url;
@property (nonatomic) BOOL on_my_job;
//Array of SmallJobs objects which is all the small
//jobs that are currently available to them.
//This is used on the job search tab.
@property (nonatomic, assign) NSMutableArray *job_array;
@property (nonatomic, assign) NSUInteger current_job_in_array;
@property (nonatomic, assign) NSUInteger current_suggested_job_in_array;
//Array of MyJob objects which are the jobs that the user
//currently has.
//This is used on the my jobs tab.
@property (nonatomic, assign) NSMutableArray *my_jobs;
//This is used to keep track of all the friends for this user on facebook
@property (nonatomic, assign) NSMutableArray *my_facebook_friends;

//This array hold all of the messages
@property (nonatomic, retain) NSMutableArray *my_inbox_messages;
@property (nonatomic, retain) NSMutableArray *my_sent_messages;

//THis array holds all of the suggested jobs
@property (nonatomic, retain) NSMutableArray *my_suggested_jobs;

//THis holds all information about the logged in user
@property (nonatomic, retain) UserInfo *my_user_info;

@property (nonatomic, assign) CLLocation *my_user_location;
@property BOOL im_available;
@end
