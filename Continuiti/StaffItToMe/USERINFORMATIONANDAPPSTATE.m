//
//  USERINFORMATIONANDAPPSTATE.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "USERINFORMATIONANDAPPSTATE.h"
#import "ASIFormDataRequest.h"
#import "StaffItToMeAppDelegate.h"
#import "Capability.h"
#define CURRENT_TAB_BAR_KEY @"current_tab_bar"
#define USER_NAME_KEY @"User_Name"
#define SESSION_KEY_KEY @"SessionKey"
#define INDUSTRY_SEARCH_KEY @"IndustrySearchType"
#define SALARY_SEARCH_KEY @"Salary_Search_type"
#define FACEBOOK_ID_KEY @"FacebookKEY"
#define DISTANCE_SEARCH_KEY @"Salary_Search_type"
#define JOB_ARRAY_KEY @"jobArray"
#define MY_JOB_ARRAY_KEY @"MYJOBARRAY"
#define MY_JOB_SUGGESTED_ARRAY_KEY @"SuggestedJOBS"
#define MY_FACEBOOK_FRIENDS_KEY @"Facebookfriendarraykey"
#define MY_INBOX_MESSAGES_KEY   @"MYinboxarraykey"
#define MY_SENT_MESSAGES_KEY    @"MYsentMessagesKey"
#define PICTURE_URL_KEY    @"MYPICTUREURLKEY"
#define MY_USER_INFORMATION_KEY @"MYUSERInFORMATION"
#define MY_USER_LOCAL_KEY @"my-user-location"
#define MY_APPLIED_TO_JOBS_KEY @"MyAppliedTojObs"

@implementation USERINFORMATIONANDAPPSTATE
@synthesize currentTabBar;
@synthesize userName;
@synthesize sessionKey;
@synthesize job_array;
@synthesize current_job_in_array;
@synthesize my_jobs;
@synthesize my_facebook_friends;
@synthesize facebook_id;
@synthesize my_inbox_messages;
@synthesize my_user_info;
@synthesize my_user_location;
@synthesize im_available;
@synthesize industry_search_type;
@synthesize salary_search_type;
@synthesize distance_search_type;
@synthesize my_suggested_jobs;
@synthesize my_sent_messages;
@synthesize on_my_job;
@synthesize picture_url;
@synthesize my_applied_to_jobs;
@synthesize current_suggested_job_in_array;
@synthesize my_capabilities_array;
static NSString *user_locale_address = @"https://hydrogen.xen.exoware.net:3000/apis/available";

/**
 This method will cause itself to be re insantiated from when it is serialized with coder.
 It recreates the application state that was there before the person left the app.
 */
-(id)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super init]))
    {
        currentTabBar = [[aDecoder decodeObjectForKey:CURRENT_TAB_BAR_KEY] retain];   
        userName = [[aDecoder decodeObjectForKey:USER_NAME_KEY] retain];
        facebook_id = [[aDecoder decodeObjectForKey:FACEBOOK_ID_KEY] retain];
        sessionKey = [[aDecoder decodeObjectForKey:SESSION_KEY_KEY] retain];
        industry_search_type = [[aDecoder decodeObjectForKey:INDUSTRY_SEARCH_KEY] retain];
        salary_search_type = [[aDecoder decodeObjectForKey:SALARY_SEARCH_KEY] retain];
        picture_url = [[aDecoder decodeObjectForKey:PICTURE_URL_KEY] retain];
        distance_search_type = [[aDecoder decodeObjectForKey:DISTANCE_SEARCH_KEY] retain];
        my_user_info = [[aDecoder decodeObjectForKey:MY_USER_INFORMATION_KEY] retain];
        my_user_location = [[aDecoder decodeObjectForKey:MY_USER_LOCAL_KEY] retain];
        if ([aDecoder decodeObjectForKey:JOB_ARRAY_KEY] != nil){
            job_array = [[aDecoder decodeObjectForKey:JOB_ARRAY_KEY] retain];
        }else{
        }
        if ([aDecoder decodeObjectForKey:MY_JOB_SUGGESTED_ARRAY_KEY] != nil){
            my_suggested_jobs = [[aDecoder decodeObjectForKey:MY_JOB_SUGGESTED_ARRAY_KEY] retain];
        }else{
        }
        if ([aDecoder decodeObjectForKey:MY_JOB_ARRAY_KEY] != nil){
            my_jobs = [[aDecoder decodeObjectForKey:MY_JOB_ARRAY_KEY] retain];
        }else{
        }
        
        my_facebook_friends = [[NSMutableArray alloc] initWithCapacity:300];
        
        /*if ([aDecoder decodeObjectForKey:MY_FACEBOOK_FRIENDS_KEY] != nil){
            my_facebook_friends = [[aDecoder decodeObjectForKey:MY_FACEBOOK_FRIENDS_KEY] retain];
        }else{
        }*/
        if ([aDecoder decodeObjectForKey:MY_INBOX_MESSAGES_KEY] != nil){
            my_inbox_messages = [[aDecoder decodeObjectForKey:MY_INBOX_MESSAGES_KEY] retain];
        }else{
        }
        if ([aDecoder decodeObjectForKey:MY_SENT_MESSAGES_KEY] != nil){
            my_sent_messages = [[aDecoder decodeObjectForKey:MY_SENT_MESSAGES_KEY] retain];
        }else{
        }
        if ([aDecoder decodeObjectForKey:MY_APPLIED_TO_JOBS_KEY] != nil){
            my_applied_to_jobs = [[aDecoder decodeObjectForKey:MY_APPLIED_TO_JOBS_KEY] retain];
        }else{
        }
        local_manager           = [[LocationManager alloc] init];
        local_manager.delegate  = self;
        im_available            = YES;
    }
    return self;
}
/**
 This will encode the current state of the data to a backup file that will later be read
 and reinstantiate this object.
 */
-(void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeObject:currentTabBar forKey:CURRENT_TAB_BAR_KEY];
    [aCoder encodeObject:userName forKey:USER_NAME_KEY];
    [aCoder encodeObject:sessionKey forKey:SESSION_KEY_KEY];
    [aCoder encodeObject:facebook_id forKey:FACEBOOK_ID_KEY];
    [aCoder encodeObject:industry_search_type forKey:INDUSTRY_SEARCH_KEY];
    [aCoder encodeObject:salary_search_type forKey:SALARY_SEARCH_KEY];
    [aCoder encodeObject:distance_search_type forKey:DISTANCE_SEARCH_KEY];
    [aCoder encodeObject:picture_url forKey:PICTURE_URL_KEY];
    [aCoder encodeObject:my_user_info forKey:MY_USER_INFORMATION_KEY];
    [aCoder encodeObject:my_user_location forKey:MY_USER_LOCAL_KEY];
    if (job_array != nil){
        [aCoder encodeObject:job_array forKey:JOB_ARRAY_KEY];
    }else{
    }
    if (my_suggested_jobs != nil){
        [aCoder encodeObject:my_suggested_jobs forKey:MY_JOB_SUGGESTED_ARRAY_KEY];
    }else{
    }
    if (my_jobs != nil){
        [aCoder encodeObject:my_jobs forKey:MY_JOB_ARRAY_KEY];
    }else{
    }
    /*if (my_facebook_friends != nil){
        [aCoder encodeObject:my_facebook_friends forKey:MY_FACEBOOK_FRIENDS_KEY];
    }else{
    }*/
    if (my_inbox_messages != nil){
        [aCoder encodeObject:my_inbox_messages forKey:MY_INBOX_MESSAGES_KEY];
    }else{
    }
    if (my_sent_messages != nil){
        [aCoder encodeObject:my_sent_messages forKey:MY_SENT_MESSAGES_KEY];
    }else{
    }
    if (my_applied_to_jobs != nil){
        [aCoder encodeObject:my_sent_messages forKey:MY_APPLIED_TO_JOBS_KEY];
    }else{
    }
}
-(id)init
{
    if ((self = [super init]))
    {
        on_my_job               = NO;
        currentTabBar           = [[NSString alloc] init];
        userName                = [[NSString alloc] init];
        sessionKey              = [[NSString alloc] init];
        industry_search_type    = [[NSString alloc] initWithString:@""];
        salary_search_type      = [[NSString alloc] initWithString:@""];
        distance_search_type    = [[NSString alloc] initWithString:@""];
        job_array               = [[NSMutableArray alloc] initWithCapacity:20];
        my_jobs                 = [[NSMutableArray alloc] initWithCapacity:20];
        my_facebook_friends     = [[NSMutableArray alloc] initWithCapacity:100];
        my_inbox_messages       = [[NSMutableArray alloc] initWithCapacity:100];
        my_suggested_jobs       = [[NSMutableArray alloc] initWithCapacity:100];
        my_sent_messages        = [[NSMutableArray alloc] initWithCapacity:100];
        my_applied_to_jobs      = [[NSMutableArray alloc] initWithCapacity:100];
        my_capabilities_array      = [[NSMutableArray alloc] initWithCapacity:100];
        my_user_info            = [[UserInfo alloc] init];
        local_manager           = [[LocationManager alloc] init];
        [self startUpdatingUserLocation];
        local_manager.delegate  = self;
        im_available            = YES;
    }
    return self;
}
-(void)populateMyAppliedToJobsWithString:(NSString *)the_information
{
    [my_applied_to_jobs removeAllObjects];
    NSArray *applied_to_jobs = [the_information JSONValue];
    for (int i = 0; i < applied_to_jobs.count; i++)
    {
        MyJob *temp = [[MyJob alloc] init];
        if ([[applied_to_jobs objectAtIndex:i] objectForKey:@"title"] == [NSNull null] || [[applied_to_jobs objectAtIndex:i] objectForKey:@"title"] == nil)
        {
            temp.title = @"";
        } else {
            temp.title = [[[applied_to_jobs objectAtIndex:i] objectForKey:@"title"] retain];
        }
        if ([[applied_to_jobs objectAtIndex:i] objectForKey:@"company_name"] == [NSNull null] || [[applied_to_jobs objectAtIndex:i] objectForKey:@"company_name"] == nil)
        {
            temp.company = @"";
        } else {
            temp.company = [[[applied_to_jobs objectAtIndex:i] objectForKey:@"company_name"] retain];
        }
        [my_applied_to_jobs addObject:temp];
        [temp release];
    }
}
-(void)populateJobArrayWithJSONString:(NSString *)the_string
{
    [job_array removeAllObjects];
   if (the_string.length < 5) {
       // return;
    }
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"JSONFILE" ofType:@"json"];
	NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath]; 
	
	//NSString *chocolate = [the_string substringWithRange:NSMakeRange(1,the_string.length -2)];
    NSDictionary *dictionary = [the_string JSONValue];
    NSArray *array_thing = [dictionary objectForKey:@"jobs"];
    for (int i = 0; i < array_thing.count;i++)
    {
        SmallJobs *temp_small_job = [[SmallJobs alloc] init];
        if ([[array_thing objectAtIndex:i] objectForKey:@"title"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"title"] == nil)
        {
            temp_small_job.title = @"";
        } else {
            temp_small_job.title = [[[array_thing objectAtIndex:i] objectForKey:@"title"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"skills"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"skills"] == nil) {
            temp_small_job.skills = @"";
        } else {
            temp_small_job.skills = [[[array_thing objectAtIndex:i] objectForKey:@"skills"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"id"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"id"] == nil) {
            temp_small_job.job_id = -99;
        } else {
            temp_small_job.job_id = [[[array_thing objectAtIndex:i] objectForKey:@"id"] intValue];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"description"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"description"] == nil) {
            temp_small_job.job_description = @"";
        } else {
            temp_small_job.job_description = [[[array_thing objectAtIndex:i] objectForKey:@"description"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"job_type_title"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"job_type_title"] == nil) {
            temp_small_job.job_type_title = @"";
        } else {
            temp_small_job.job_type_title = [[[array_thing objectAtIndex:i] objectForKey:@"job_type_title"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"industry_name"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"industry_name"] == nil) {
            temp_small_job.industry_name = @"";
        } else {
            temp_small_job.industry_name = [[[array_thing objectAtIndex:i] objectForKey:@"industry_name"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"user_id"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"user_id"] == nil) {
            temp_small_job.user_id = @"";
        } else {
            temp_small_job.user_id = [[[array_thing objectAtIndex:i] objectForKey:@"user_id"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"created_at"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"created_at"] == nil) {
            temp_small_job.created_at = @"";
        } else {
            temp_small_job.created_at = [[[array_thing objectAtIndex:i] objectForKey:@"created_at"] retain];
        }
        if ([[[[array_thing objectAtIndex:i] objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"city"] == [NSNull null] || [[[[array_thing objectAtIndex:i] objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"city"] == nil) {
            temp_small_job.job_city = @"";
        } else {
            temp_small_job.job_city = [[[[[array_thing objectAtIndex:i] objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"city"] retain];
        }
        if ([[[[array_thing objectAtIndex:i] objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"state"] == [NSNull null] || [[[[array_thing objectAtIndex:i] objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"state"] == nil) {
            temp_small_job.job_state = @"";
        } else {
            temp_small_job.job_state = [[[[[array_thing objectAtIndex:i] objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"state"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"duration"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"duration"] == nil) {
            temp_small_job.job_duration = @"";
        } else {
            temp_small_job.job_duration = [[[array_thing objectAtIndex:i] objectForKey:@"duration"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"hours_per_week"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"hours_per_week"] == nil) {
            temp_small_job.hours_per_week = @"";
        } else {
            NSString *temp = [NSString stringWithFormat:@"%d",[[array_thing objectAtIndex:i] objectForKey:@"hours_per_week"] ]; 
            temp_small_job.hours_per_week = [temp retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"task_start_date"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"task_start_date"] == nil) {
            temp_small_job.task_start_date = @"";
        } else {
            temp_small_job.task_start_date = [[[array_thing objectAtIndex:i] objectForKey:@"task_start_date"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"task_start_time"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"task_start_time"] == nil) {
            temp_small_job.task_start_time = @"";
        } else {
            temp_small_job.task_start_time = [[[array_thing objectAtIndex:i] objectForKey:@"task_start_time"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"company_name"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"company_name"] == nil) {
            temp_small_job.company = @"";
        } else {
            temp_small_job.company = [[[array_thing objectAtIndex:i] objectForKey:@"company_name"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"company_description"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"company_description"] == nil) {
            temp_small_job.company_description = @"";
        } else {
            temp_small_job.company_description = [[[array_thing objectAtIndex:i] objectForKey:@"company_description"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"compensation"]  == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"compensation"] == nil) {
            temp_small_job.compensation = @"";
        } else {
            temp_small_job.compensation = [[[array_thing objectAtIndex:i] objectForKey:@"compensation"] retain];
        }
        if ([[array_thing objectAtIndex:i]  objectForKey:@"latitude"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"latitude"] == nil) {
            temp_small_job.latitude = 0;
        } else {
            temp_small_job.latitude = [[[array_thing objectAtIndex:i] objectForKey:@"latitude"] doubleValue];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"longitude"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"longitude"] == nil) {
            temp_small_job.longitude = 0;
        } else {
            temp_small_job.longitude = [[[array_thing objectAtIndex:i] objectForKey:@"longitude"] doubleValue];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"distance"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"distance"] == nil) {
            temp_small_job.job_distance = 0;
        } else {
            temp_small_job.job_distance = [[[array_thing objectAtIndex:i] objectForKey:@"distance"] doubleValue];
        }
        [job_array addObject:temp_small_job];
        [temp_small_job release];
    }
    
    
}
-(void)populateMyJobArrayWithJSONString:(NSString *)the_string
{
	[my_jobs removeAllObjects];
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"JSONFILEMYJOBS" ofType:@"json"];
	NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath]; 
	
    NSArray *data_array = [the_string JSONValue];
    for (int i = 0; i < data_array.count; i++)
    {
        MyJob *temp_small_job = [[MyJob alloc] init];
        if ([[data_array objectAtIndex:i] objectForKey:@"title"] == [NSNull null])
        {
            temp_small_job.title = @"";
        } else {
            temp_small_job.title = [[[data_array objectAtIndex:i] objectForKey:@"title"] retain];
        }
        if ([[data_array objectAtIndex:i] objectForKey:@"duration"] == [NSNull null]) {
            temp_small_job.job_duration = @"";
        } else {
            temp_small_job.job_duration = [[[data_array objectAtIndex:i] objectForKey:@"duration"] retain];
        }
        if ([[data_array objectAtIndex:i] objectForKey:@"company"] == [NSNull null]) {
            temp_small_job.company = @"";
        } else {
            temp_small_job.company = [[[data_array objectAtIndex:i] objectForKey:@"company"] retain];
        }
        if ([[data_array objectAtIndex:i] objectForKey:@"start_time"] == [NSNull null]) {
            temp_small_job.start_time = @"";
        } else {
            temp_small_job.start_time = [[[data_array objectAtIndex:i] objectForKey:@"start_time"] retain];
        }
        if ([[data_array objectAtIndex:i] objectForKey:@"notes"] == [NSNull null]) {
            temp_small_job.notes = @"";
        } else {
            temp_small_job.notes = [[[data_array objectAtIndex:i] objectForKey:@"notes"] retain];
        }
        if ([[data_array objectAtIndex:i] objectForKey:@"rate"] == [NSNull null]) {
            temp_small_job.rate = @"";
        } else {
            temp_small_job.rate = [[[data_array objectAtIndex:i] objectForKey:@"rate"] retain];
        }
        if ([[data_array objectAtIndex:i] objectForKey:@"start_datetime"] == [NSNull null]) {
            temp_small_job.start_date_time = @"";
        } else {
            temp_small_job.start_date_time = [[[data_array objectAtIndex:i] objectForKey:@"start_datetime"] retain];
        }
        if ([[data_array objectAtIndex:i] objectForKey:@"contract_id"] == [NSNull null]) {
            temp_small_job.my_job_id = @"";
        } else {
            int job_id = [[[data_array objectAtIndex:i] objectForKey:@"contract_id"] intValue];
            temp_small_job.my_job_id = [[NSString stringWithFormat:@"%d", job_id] retain];
        }
        if ([[data_array objectAtIndex:i] objectForKey:@"checkin_checkout_status"] == [NSNull null]) {
            temp_small_job.my_checkin_chekcout_status = @"null";
        } else {
            temp_small_job.my_checkin_chekcout_status = [[[data_array objectAtIndex:i] objectForKey:@"checkin_checkout_status"] retain];
        }
        
        NSDictionary *billing_history = [[data_array objectAtIndex:i] objectForKey:@"job_billing_history"];
        NSString *currentPosition;
        NSEnumerator *history_enum = [[[data_array objectAtIndex:i] objectForKey:@"job_billing_history"] keyEnumerator];
        currentPosition = [history_enum nextObject];
        do {
            
            JobBillingHistoryObject *history_object = [[JobBillingHistoryObject alloc] init];
            if ([[billing_history objectForKey:history_enum] objectForKey:@"job_date"] == [NSNull null]) {
                history_object.job_date = [@"" retain];
            } else {
                history_object.job_date = [[[billing_history objectForKey:history_enum] objectForKey:@"job_date"] retain];
            }
            if ([[billing_history objectForKey:history_enum] objectForKey:@"total_time"] == [NSNull null]) {
                history_object.total_time = [@"" retain];
            } else {
                history_object.total_time = [[[billing_history objectForKey:history_enum] objectForKey:@"total_time"] retain];
            }
            if ([[billing_history objectForKey:history_enum] objectForKey:@"time"] == [NSNull null]) {
                history_object.job_time = [@"" retain];
            } else {
                history_object.job_time = [[[billing_history objectForKey:history_enum] objectForKey:@"time"] retain];
            }
            [temp_small_job.job_history addObject:history_object];
            history_object.job_date = [@"" retain];
            history_object.job_time = [@"" retain];
            history_object.total_time = [@"" retain];
            [history_object release];
        } while ((currentPosition = [history_enum nextObject]) != nil);
        
        [my_jobs addObject:temp_small_job];
        [temp_small_job release];
        
    }
}

/**
 So this method takes in the string that is queried for the messages
 then it goes through and gets that information from the string
 created the objects and puts them in the array. When the objects are created
 they start querying the server for their convo information.
 */
-(void)populateMyInboxWithString:(NSString *)the_string
{
    [my_inbox_messages removeAllObjects];
    NSArray *data = [the_string JSONValue];
    for (int i = 0; i < data.count; i++)
    {
        @try {
            int message_id = [[[data objectAtIndex:i] objectForKey:@"messageable_id"] intValue];
            int sender_id = [[[data objectAtIndex:i] objectForKey:@"id"] intValue];
            //allocate an MessageHeaderObject
            MessageHeaderObject *message_header = [[MessageHeaderObject alloc] initWithDate:[[data objectAtIndex:i] objectForKey:@"created_at"] body:[[data objectAtIndex:i] objectForKey:@"body"] subject:
                                                   [[data objectAtIndex:i] objectForKey:@"subject"] recipient_id:@"" sender_id:[NSString stringWithFormat:@"%d", sender_id] sender_name:
                                                   [[data objectAtIndex:i] objectForKey:@"sender_name"] recipient_name:@"" message_id:[NSString stringWithFormat:@"%d", message_id]];
            [my_inbox_messages addObject:message_header];
            
            [message_header release];
        }
        @catch (NSException *exception) {
        }
    }
}
-(void)populateMySentMessagesWithString:(NSString *)the_string
{
    [my_sent_messages removeAllObjects];
    NSArray *data = [the_string JSONValue];
    for (int i = 0; i < data.count; i++)
    {
        int message_id = [[[data objectAtIndex:i] objectForKey:@"id"] intValue];
        //allocate an MessageHeaderObject
        MessageHeaderObject *message_header = [[MessageHeaderObject alloc] initWithDate:[[data objectAtIndex:i] objectForKey:@"created_at"] body:[[data objectAtIndex:i] objectForKey:@"body"] subject:
                                               [[data objectAtIndex:i] objectForKey:@"subject"] recipient_id:@"" sender_id:[[NSString stringWithFormat:@"%d", message_id] retain] sender_name:
                                               [[data objectAtIndex:i] objectForKey:@"sender_name"] recipient_name:@"" message_id:[NSString stringWithFormat:@"%d", message_id]];
        [my_sent_messages addObject:message_header];
        
        [message_header release];
    }
}
/**
	Takes in an NSArray of NSDictionary holding values and populates the my_capabilities_array with Capability objects.
 NSDIctionaryValues:
 description
 title
 capability_id
 
	@param the_values NSArray the array of NSDictionaries.
 */
-(void)populateMyCapabilities:(NSArray *)the_values
{
    [my_capabilities_array removeAllObjects];
    for (int i = 0; i  < the_values.count; i++)
    {
        Capability *temp    = [[Capability alloc] init];
        temp.title          = [[the_values objectAtIndex:i] objectForKey:@"title"];
        temp.description    = [[the_values objectAtIndex:i] objectForKey:@"description"];
        int temp_id         = [[[the_values objectAtIndex:i] objectForKey:@"capability_id"] intValue];
        temp.title          = [NSString stringWithFormat:@"%d", temp_id];
        
        [my_capabilities_array addObject:temp];
        [temp release];
    }
}
-(void)getUserInformation:(NSString *)user_information
{
    NSDictionary *user_date = [user_information JSONValue];
    int user_id = [[user_date objectForKey:@"user_id"] intValue];
    NSString *user_id_string = [NSString stringWithFormat:@"%d", user_id];
    
    NSMutableDictionary *user_information_dictionary = [[NSMutableDictionary alloc] initWithCapacity:14];
    [user_information_dictionary setObject:[user_date objectForKey:@"name"] forKey:@"name"];
    [user_information_dictionary setObject:[user_date objectForKey:@"facebook_friends_count"] forKey:@"facebook_friend_count"];
    [user_information_dictionary setObject:[user_date objectForKey:@"session_key"] forKey:@"session_key"];
    [user_information_dictionary setObject:[user_date objectForKey:@"facebook_uid"] forKey:@"facebook_uid"];
    [user_information_dictionary setObject:[user_date objectForKey:@"avatar"] forKey:@"avatar"];
    [user_information_dictionary setObject:[user_date objectForKey:@"gender"] forKey:@"gender"];
    [user_information_dictionary setObject:user_id_string forKey:@"user_id"];
    [user_information_dictionary setObject:[user_date objectForKey:@"avatar_thumb"] forKey:@"avatar_thumb"];
    [user_information_dictionary setObject:[user_date objectForKey:@"facebook_session_key"] forKey:@"facebook_session_key"];
    [user_information_dictionary setObject:[user_date objectForKey:@"birthday"] forKey:@"birthday"];
    [user_information_dictionary setObject:[user_date objectForKey:@"last_name"] forKey:@"last_name"];
    [user_information_dictionary setObject:[user_date objectForKey:@"locale"] forKey:@"locale"];
    [user_information_dictionary setObject:[user_date objectForKey:@"first_name"] forKey:@"first_name"];
    [user_information_dictionary setObject:[user_date objectForKey:@"email"] forKey:@"email"];
    
    [[ApplicationDatabase sharedInstance] insertOrUpdateUserInformationWithDictionary:user_information_dictionary];
    
    [self loadUserInfoFromDatabase];
    
    DataMaker *message_Creation = [[DataMaker alloc] initWithNibName:@"DataMaker" bundle:nil];
}
-(void)loadUserInfoFromDatabase
{
    NSDictionary *get_user_information_dictionary = [[ApplicationDatabase sharedInstance] getUserInformationFromDatabase];
    sessionKey              = [[get_user_information_dictionary objectForKey:@"session_key"] retain];
    my_user_info.full_name  = [[get_user_information_dictionary objectForKey:@"name"] retain];
    facebook_id             = [[get_user_information_dictionary objectForKey:@"facebook_uid"] retain];
    int user_id = [[get_user_information_dictionary objectForKey:@"user_id"] intValue];
    my_user_info.user_id    = user_id;
    picture_url             = [[get_user_information_dictionary objectForKey:@"avatar"] retain];
    
    
}
-(void)loadUserLocationFromDatabase
{
    NSDictionary *get_user_location_dictionary = [[ApplicationDatabase sharedInstance] getUserLocationInformationFromDatabase];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[[get_user_location_dictionary objectForKey:@"latitude"] floatValue] longitude:[[get_user_location_dictionary objectForKey:@"longitude"] floatValue]];
    my_user_location = [location copy];
}
-(void)loadUsersFacebookFriendsFromDatabase
{
    NSMutableArray *get_facebook_friends = [[ApplicationDatabase sharedInstance] getFacebookFriendFromDatabase];
    for (int i = 0; i < get_facebook_friends.count; i++)
    {
        NSDictionary *friend = [get_facebook_friends objectAtIndex:i];
        
        FacebookFriend *friend_class    = [[FacebookFriend alloc] init];
        friend_class.friend_id          = [friend objectForKey:@"friend_id"];
        friend_class.name               = [friend objectForKey:@"friend_name"];
        
        [my_facebook_friends addObject:friend_class];
    }
}
-(void)setUserLocation:(CLLocation*)the_location
{
    [local_manager.manager stopUpdatingLocation];
    my_user_location = [the_location copy];
    
    NSMutableDictionary *coordinate_dict = [[NSMutableDictionary alloc] initWithCapacity:2];
    [coordinate_dict setObject:[NSString stringWithFormat:@"%f", the_location.coordinate.latitude] forKey:@"latitude"];
    [coordinate_dict setObject:[NSString stringWithFormat:@"%f", the_location.coordinate.longitude] forKey:@"longitude"];
    
    [[ApplicationDatabase sharedInstance] insertOrUpdateUserLocationInformationWithDictionary:coordinate_dict];
    
    
    
    NSURL *url = [NSURL URLWithString:user_locale_address];
    //tell the servers i am here and avialable
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:sessionKey forKey:@"session_key"];
    [request_ror setPostValue:[NSString stringWithFormat:@"%d", my_user_location.coordinate.latitude] forKey:@"lat"];
    [request_ror setPostValue:[NSString stringWithFormat:@"%d", my_user_location.coordinate.longitude] forKey:@"long"];
    [request_ror setPostValue:@"1" forKey:@"is_available"];
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror startAsynchronous];
   // if (im_available)
   // {
        [local_manager.manager performSelector:@selector(startUpdatingLocation) withObject:nil afterDelay:100];
   // }
}
-(void)stopUpdatingUserLocation {
    
    [local_manager.manager stopUpdatingLocation];
    
    NSURL *url = [NSURL URLWithString:user_locale_address];
    
    //tell the servers i am here and not avaialable
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    
    [request_ror setRequestMethod:@"POST"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:sessionKey forKey:@"session_key"];
    
    [request_ror setPostValue:[NSString stringWithFormat:@"%d", my_user_location.coordinate.latitude] forKey:@"lat"];
    [request_ror setPostValue:[NSString stringWithFormat:@"%d", my_user_location.coordinate.longitude] forKey:@"long"];
    [request_ror setPostValue:@"0" forKey:@"is_available"];
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror startAsynchronous];
    im_available = NO;
    
    StaffItToMeAppDelegate *app_delegate    = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    [app_delegate                           updateAvailableSwitches];
}
-(void)startUpdatingUserLocation {
    
    [local_manager.manager startUpdatingLocation];
    
    NSURL *url = [NSURL URLWithString:user_locale_address];
    
    //tell the servers i am here and not avaialable
    ASIFormDataRequest *request_ror     = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:sessionKey forKey:@"session_key"];
    
    [request_ror setPostValue:[NSString stringWithFormat:@"%d", my_user_location.coordinate.latitude] forKey:@"lat"];
    [request_ror setPostValue:[NSString stringWithFormat:@"%d", my_user_location.coordinate.longitude] forKey:@"long"];
    [request_ror setPostValue:@"1" forKey:@"is_available"];
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror startAsynchronous];
    im_available = YES;
    
    StaffItToMeAppDelegate *app_delegate    = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    [app_delegate                           updateAvailableSwitches];
    
}
-(void)populateSuggestedJobsArrayWithString:(NSString*)the_string
{
    if (the_string.length < 20)
    {
        return;
    }
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SuggestedJobs" ofType:@"json"];
	NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath]; 
	    //Create a dicionary based off of the JSON String.
    NSDictionary *data = [the_string JSONValue];
    
    NSArray *array_thing;
    @try
    {
        array_thing = [data objectForKey:@"jobs"];
    }
    @catch (NSException *exception) 
    {
        return;
    }
    
    for (int i = 0; i < array_thing.count; i++)
    {
        SmallJobs *temp_small_job = [[SmallJobs alloc] init];
        if ([[array_thing objectAtIndex:i] objectForKey:@"title"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"title"] == nil)
        {
            temp_small_job.title = @"";
        } else {
            temp_small_job.title = [[[array_thing objectAtIndex:i] objectForKey:@"title"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"skills"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"skills"] == nil) {
            temp_small_job.skills = @"";
        } else {
            temp_small_job.skills = [[[array_thing objectAtIndex:i] objectForKey:@"skills"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"id"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"id"] == nil) {
            temp_small_job.job_id = -99;
        } else {
            temp_small_job.job_id = [[[array_thing objectAtIndex:i] objectForKey:@"id"] intValue];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"description"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"description"] == nil) {
            temp_small_job.job_description = @"";
        } else {
            temp_small_job.job_description = [[[array_thing objectAtIndex:i] objectForKey:@"description"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"job_type_title"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"job_type_title"] == nil) {
            temp_small_job.job_type_title = @"";
        } else {
            temp_small_job.job_type_title = [[[array_thing objectAtIndex:i] objectForKey:@"job_type_title"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"industry_name"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"industry_name"] == nil) {
            temp_small_job.industry_name = @"";
        } else {
            temp_small_job.industry_name = [[[array_thing objectAtIndex:i] objectForKey:@"industry_name"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"user_id"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"user_id"] == nil) {
            temp_small_job.user_id = @"";
        } else {
            temp_small_job.user_id = [[[array_thing objectAtIndex:i] objectForKey:@"user_id"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"created_at"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"created_at"] == nil) {
            temp_small_job.created_at = @"";
        } else {
            temp_small_job.created_at = [[[array_thing objectAtIndex:i] objectForKey:@"created_at"] retain];
        }
        if ([[[[array_thing objectAtIndex:i] objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"city"] == [NSNull null] || [[[[array_thing objectAtIndex:i] objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"city"] == nil) {
            temp_small_job.job_city = @"";
        } else {
            temp_small_job.job_city = [[[[[array_thing objectAtIndex:i] objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"city"] retain];
        }
        if ([[[[array_thing objectAtIndex:i] objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"state"] == [NSNull null] || [[[[array_thing objectAtIndex:i] objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"state"] == nil) {
            temp_small_job.job_state = @"";
        } else {
            temp_small_job.job_state = [[[[[array_thing objectAtIndex:i] objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"state"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"duration"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"duration"] == nil) {
            temp_small_job.job_duration = @"";
        } else {
            temp_small_job.job_duration = [[[array_thing objectAtIndex:i] objectForKey:@"duration"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"hours_per_week"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"hours_per_week"] == nil) {
            temp_small_job.hours_per_week = @"";
        } else {
            NSString *temp = [NSString stringWithFormat:@"%d",[[array_thing objectAtIndex:i] objectForKey:@"hours_per_week"] ]; 
            temp_small_job.hours_per_week = [temp retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"task_start_date"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"task_start_date"] == nil) {
            temp_small_job.task_start_date = @"";
        } else {
            temp_small_job.task_start_date = [[[array_thing objectAtIndex:i] objectForKey:@"task_start_date"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"task_start_time"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"task_start_time"] == nil) {
            temp_small_job.task_start_time = @"";
        } else {
            temp_small_job.task_start_time = [[[array_thing objectAtIndex:i] objectForKey:@"task_start_time"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"company_name"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"company_name"] == nil) {
            temp_small_job.company = @"";
        } else {
            temp_small_job.company = [[[array_thing objectAtIndex:i] objectForKey:@"company_name"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"company_description"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"company_description"] == nil) {
            temp_small_job.company_description = @"";
        } else {
            temp_small_job.company_description = [[[array_thing objectAtIndex:i] objectForKey:@"company_description"] retain];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"compensation"]  == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"compensation"] == nil) {
            temp_small_job.compensation = @"";
        } else {
            temp_small_job.compensation = [[[array_thing objectAtIndex:i] objectForKey:@"compensation"] retain];
        }
        if ([[array_thing objectAtIndex:i]  objectForKey:@"latitude"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"latitude"] == nil) {
            temp_small_job.latitude = 0;
        } else {
            temp_small_job.latitude = [[[array_thing objectAtIndex:i] objectForKey:@"latitude"] doubleValue];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"longitude"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"longitude"] == nil) {
            temp_small_job.longitude = 0;
        } else {
            temp_small_job.longitude = [[[array_thing objectAtIndex:i] objectForKey:@"longitude"] doubleValue];
        }
        if ([[array_thing objectAtIndex:i] objectForKey:@"distance"] == [NSNull null] || [[array_thing objectAtIndex:i] objectForKey:@"distance"] == nil) {
            temp_small_job.job_distance = 0;
        } else {
            temp_small_job.job_distance = [[[array_thing objectAtIndex:i] objectForKey:@"distance"] doubleValue];
        }
        [my_suggested_jobs addObject:temp_small_job];
        [temp_small_job release];
    }
}
-(void)dealloc
{
    
    [local_manager release];
    [super dealloc];
}
@end
