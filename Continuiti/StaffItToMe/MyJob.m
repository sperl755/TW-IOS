//
//  MyJob.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyJob.h"
#define STATUS_KEY @"status"
#define JOB_TYPE_ID @"job_type_id"
#define JOB_DISTANCE_KEY @"job_distance"
#define TITLE_KEY @"title"
#define JOB_DESCRIPTION_KEY @"job_description"
#define PRIVATE_JOB_DESCRIPTION_KEY @"PrivateJobDescription"
#define START_DATE_KEY @"StartDate"
#define END_DATE_KEY @"ENDDate"
#define TIME_ESTIMATE_KEY @"TIMEESTIMATEKEY"
#define COST_PER_HR_KEY @"CostPerHourEstimate"
#define ESTIMATED_EXPENSE_KEY @"EstimatedExpense"
#define SKILLS_KEY  @"SKILLSKEYY"
#define JOB_TYPE_TITLE_KEY  @"JOB_TYPE_TTIEL"
#define INDUSTRY_NAME_KEY   @"IndustryNameKey"
#define USER_ID_KEY @"USERIDKEY"
#define CREATED_AT_KEY @"CreatedAtKey"
#define JOB_CITY_KEY @"JOBCITY"
#define JOB_STATE_KEY   @"JOBSTATE"
#define JOB_DURATION_KEY @"JOBDURATION"
#define JOB_HOURS_PER_WEEK @"JOBHOURSPERWEEK"
#define JOB_START_TIME_KEY @"JOBSTARTTIME"
#define COMPANY_NAME_KEY    @"COMPANY"
#define COMPANY_DESCRIPTION_KEY @"COMPANY_DESCRIPTION_KEY"
#define COMPENSATION_KEY    @"COMpensationKEY"
#define LAT_ID_KEY  @"Latitude"
#define LONG_ID_KEY @"Longitude"
#define CHECKIN_OUT_KEY @"CHECKEDINOUT"
#define JOB_START_DATE_TIME @"STARTDATETIME"
#define JOB_RATE_KEY    @"JOBRATE"
#define TIME_CLOCK_KEY  @"TIMECLOCKKEY"
#define NOTES_KEY   @"NOTESKEY"
#define DETAILS_KEY @"DetailsKey"
#define USER_DISTANCE_KEY   @"USERDISTANCEKEY"
#define MY_JOB_ID_KEY   @"MYJOBID"
#define MY_CHECKING_CHECKOUT_STATUS @"CHECKINGOUTINSTATUSTHING"


@implementation MyJob
@synthesize status;
@synthesize checked_in_out;
@synthesize title;
@synthesize start_time;
@synthesize start_date_time;
@synthesize job_duration;
@synthesize rate;
@synthesize time_clock;
@synthesize notes;
@synthesize job_history;
@synthesize company;
@synthesize job_details;
@synthesize distance_from_user;
@synthesize my_job_id;
@synthesize my_checkin_chekcout_status;
-(id)init
{
    if ((self = [super init]))
    {
        job_history = [[NSMutableArray alloc] initWithCapacity:11];
    }
    return self;
}
-(id)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super init]))
    {
        NSString *status_string = [[aDecoder decodeObjectForKey:STATUS_KEY] retain];
        status = [status_string intValue];
        job_duration = [[aDecoder decodeObjectForKey:JOB_DURATION_KEY] retain];
        company = [[aDecoder decodeObjectForKey:COMPANY_NAME_KEY] retain];
        checked_in_out = [[aDecoder decodeObjectForKey:CHECKIN_OUT_KEY] retain];
        title = [[aDecoder decodeObjectForKey:TITLE_KEY] retain];
        start_time = [[aDecoder decodeObjectForKey:JOB_START_TIME_KEY] retain];
        start_date_time = [[aDecoder decodeObjectForKey:JOB_START_DATE_TIME] retain];
        rate = [[aDecoder decodeObjectForKey:JOB_RATE_KEY] retain];
        time_clock = [[aDecoder decodeObjectForKey:TIME_CLOCK_KEY] retain];
        notes = [[aDecoder decodeObjectForKey:NOTES_KEY] retain];
        job_details = [[aDecoder decodeObjectForKey:DETAILS_KEY] retain];
        distance_from_user = [[aDecoder decodeObjectForKey:USER_DISTANCE_KEY] retain];
        my_job_id = [[aDecoder decodeObjectForKey:MY_JOB_ID_KEY] retain];
        my_checkin_chekcout_status = [[aDecoder decodeObjectForKey:MY_CHECKING_CHECKOUT_STATUS] retain];
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder*)aCoder
{
    NSString *status_string = [NSString stringWithFormat:@"%d", status];
    [aCoder encodeObject:status_string forKey:STATUS_KEY];
    [aCoder encodeObject:job_duration forKey:JOB_DURATION_KEY];
    [aCoder encodeObject:company forKey:COMPANY_NAME_KEY];
    [aCoder encodeObject:checked_in_out forKey:CHECKIN_OUT_KEY];
    [aCoder encodeObject:title forKey:TITLE_KEY];
    [aCoder encodeObject:start_time forKey:JOB_START_TIME_KEY];
    [aCoder encodeObject:start_date_time forKey:JOB_START_DATE_TIME];
    [aCoder encodeObject:rate forKey:JOB_RATE_KEY];
    [aCoder encodeObject:time_clock forKey:TIME_CLOCK_KEY];
    [aCoder encodeObject:notes forKey:NOTES_KEY];
    [aCoder encodeObject:job_details forKey:DETAILS_KEY];
    [aCoder encodeObject:distance_from_user forKey:USER_DISTANCE_KEY];
    [aCoder encodeObject:my_job_id forKey:MY_JOB_ID_KEY];
    [aCoder encodeObject:my_checkin_chekcout_status forKey:MY_CHECKING_CHECKOUT_STATUS];
}

@end
