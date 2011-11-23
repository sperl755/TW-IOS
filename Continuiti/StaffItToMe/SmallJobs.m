//
//  SmallJobs.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SmallJobs.h"
#define JOB_ID_KEY @"job_id"
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

@implementation SmallJobs
@synthesize job_id;//Encodable
@synthesize job_type_id;//Encodable
@synthesize title;//Encodable
@synthesize job_description;//Encodable
@synthesize private_job_description;//Encodable
@synthesize task_start_date;//Encodable
@synthesize task_end_date;//Encodable
@synthesize time_estimate;//Encodable
@synthesize cost_estimate_per_hour;//Encodable
@synthesize estimated_task_expense;//Encodable
@synthesize total_cost;
@synthesize vehicle_required;
@synthesize action_chosen;
@synthesize make_template;
@synthesize created_at;//Encodable
@synthesize updated_at_date;
@synthesize cost_method_id;
@synthesize time_unit_id;
@synthesize cost_per_time_unit;
@synthesize fixed_cost_amount;
@synthesize average_expected_cost;
@synthesize average_expected_time;
@synthesize custom_quote_factors;
@synthesize skills;//skills
@synthesize user_id;//Encodable
@synthesize category_id;
@synthesize industry_id;
@synthesize company;//Encodable
@synthesize expense_required;
@synthesize task_location_type_id;
@synthesize status;
@synthesize visible_status;
@synthesize video;
@synthesize company_description;
@synthesize compensation;
@synthesize job_duration;//Encodable
@synthesize hours_per_week;//Encodable
@synthesize requirement_list;
@synthesize staffing_position_type_id;
@synthesize staffing_position_category_id;
@synthesize total_paid_amount;
@synthesize task_start_time;//Encodable
@synthesize task_end_time;
@synthesize task_on_date;
@synthesize task_on_time;
@synthesize task_duration_type;
@synthesize longitude;
@synthesize latitude;//Encodable
@synthesize job_city;//Encodable
@synthesize job_state;//Encodable
@synthesize job_distance;//Encodable
@synthesize job_type_title;//Encodable
@synthesize industry_name;//Encodable

-(id)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super init]))
    {
        NSString *job_id_string = [[aDecoder decodeObjectForKey:JOB_ID_KEY] retain];
        job_id = [job_id_string intValue];
        NSString *job_type_id_string = [[aDecoder decodeObjectForKey:JOB_TYPE_ID] retain];
        job_type_id = [job_type_id_string intValue];
        NSString *job_distance_string = [[aDecoder decodeObjectForKey:JOB_DISTANCE_KEY] retain];
        job_distance = [job_distance_string intValue];
        title = [[aDecoder decodeObjectForKey:TITLE_KEY] retain];
        job_description = [[aDecoder decodeObjectForKey:JOB_DESCRIPTION_KEY] retain];
        private_job_description = [[aDecoder decodeObjectForKey:PRIVATE_JOB_DESCRIPTION_KEY] retain];
        task_start_date = [[aDecoder decodeObjectForKey:START_DATE_KEY] retain];
        task_end_date = [[aDecoder decodeObjectForKey:END_DATE_KEY] retain];
        time_estimate = [[aDecoder decodeObjectForKey:TIME_ESTIMATE_KEY] retain];
        cost_estimate_per_hour = [[aDecoder decodeObjectForKey:COST_PER_HR_KEY] retain];
        estimated_task_expense = [[aDecoder decodeObjectForKey:ESTIMATED_EXPENSE_KEY] retain];
        skills = [[aDecoder decodeObjectForKey:SKILLS_KEY] retain];
        job_type_title = [[aDecoder decodeObjectForKey:JOB_TYPE_TITLE_KEY] retain];
        industry_name = [[aDecoder decodeObjectForKey:INDUSTRY_NAME_KEY] retain];
        user_id = [[aDecoder decodeObjectForKey:USER_ID_KEY] retain];
        created_at = [[aDecoder decodeObjectForKey:CREATED_AT_KEY] retain];
        job_city = [[aDecoder decodeObjectForKey:JOB_CITY_KEY] retain];
        job_state = [[aDecoder decodeObjectForKey:JOB_STATE_KEY] retain];
        job_duration = [[aDecoder decodeObjectForKey:JOB_DURATION_KEY] retain];
        hours_per_week = [[aDecoder decodeObjectForKey:JOB_HOURS_PER_WEEK] retain];
        task_start_time = [[aDecoder decodeObjectForKey:JOB_START_TIME_KEY] retain];
        company = [[aDecoder decodeObjectForKey:COMPANY_NAME_KEY] retain];
        company_description = [[aDecoder decodeObjectForKey:COMPANY_DESCRIPTION_KEY] retain];
        compensation = [[aDecoder decodeObjectForKey:COMPENSATION_KEY] retain];
        NSString *lat_string = [[aDecoder decodeObjectForKey:LAT_ID_KEY] retain];
        latitude = [lat_string intValue];
        NSString *long_string = [[aDecoder decodeObjectForKey:LONG_ID_KEY] retain];
        longitude = [long_string intValue];
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder*)aCoder
{
    NSString *job_id_string = [NSString stringWithFormat:@"%d", job_id];
    [aCoder encodeObject:job_id_string forKey:JOB_ID_KEY];
    NSString *job_type_id_string = [NSString stringWithFormat:@"%d", job_type_id];
    [aCoder encodeObject:job_type_id_string forKey:JOB_TYPE_ID];
    NSString *job_distance_string = [NSString stringWithFormat:@"%f", job_distance];
    [aCoder encodeObject:job_distance_string forKey:JOB_DISTANCE_KEY];
    [aCoder encodeObject:title forKey:TITLE_KEY];
    [aCoder encodeObject:job_description forKey:JOB_DESCRIPTION_KEY];
    [aCoder encodeObject:private_job_description forKey:PRIVATE_JOB_DESCRIPTION_KEY];
    [aCoder encodeObject:task_start_date forKey:START_DATE_KEY];
    [aCoder encodeObject:task_end_date forKey:END_DATE_KEY];
    [aCoder encodeObject:time_estimate forKey:TIME_ESTIMATE_KEY];
    [aCoder encodeObject:cost_estimate_per_hour forKey:COST_PER_HR_KEY];
    [aCoder encodeObject:estimated_task_expense forKey:ESTIMATED_EXPENSE_KEY];
    [aCoder encodeObject:total_cost forKey:ESTIMATED_EXPENSE_KEY];
    [aCoder encodeObject:skills forKey:SKILLS_KEY];
    [aCoder encodeObject:job_type_title forKey:JOB_TYPE_TITLE_KEY];
    [aCoder encodeObject:industry_name forKey:INDUSTRY_NAME_KEY];
    [aCoder encodeObject:user_id forKey:USER_ID_KEY];
    [aCoder encodeObject:created_at forKey:CREATED_AT_KEY];
    [aCoder encodeObject:job_city forKey:JOB_CITY_KEY];
    [aCoder encodeObject:job_state forKey:JOB_STATE_KEY];
    [aCoder encodeObject:job_duration forKey:JOB_DURATION_KEY];
    [aCoder encodeObject:hours_per_week forKey:JOB_HOURS_PER_WEEK];
    [aCoder encodeObject:task_start_time forKey:JOB_START_TIME_KEY];
    [aCoder encodeObject:company forKey:COMPANY_NAME_KEY];
    [aCoder encodeObject:company_description forKey:COMPANY_DESCRIPTION_KEY];
    [aCoder encodeObject:compensation forKey:COMPENSATION_KEY];
    NSString *lat_string = [NSString stringWithFormat:@"%d", latitude];
    [aCoder encodeObject:lat_string forKey:LAT_ID_KEY];
    NSString *long_string = [NSString stringWithFormat:@"%d", longitude];
    [aCoder encodeObject:long_string forKey:LONG_ID_KEY];
}

@end
