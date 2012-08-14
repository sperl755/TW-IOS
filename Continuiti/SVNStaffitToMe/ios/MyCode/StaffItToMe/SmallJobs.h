//
//  SmallJobs.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskLocation.h"
/*
 NOTE CHECK THAT YOU CAN MAKE THE NSMUTABLE ARRAYS INTO
 NSARRAYS SO THAT WAY YOU CAN SAVE DATA. REASON FOR MUTABLE NOW IS
 NOTHING IS SET IN STONE AS FAR AS ALTERATION OF SAVING OF DATA.
 */

@interface SmallJobs : NSObject {
}
@property (nonatomic, assign) int job_id;
@property (nonatomic, assign) int job_type_id;
@property (nonatomic, assign) NSString *job_title;
@property (nonatomic, assign) NSString *job_desctiption;
@property (nonatomic, assign) NSString *private_job_description;
@property (nonatomic, assign) NSString *task_start_date;
@property (nonatomic, assign) NSString *task_end_date;
@property (nonatomic, assign) NSString *time_estimate;
@property (nonatomic, assign) NSString *cost_estimate_per_hour;
@property (nonatomic, assign) NSString *estimated_task_expense;
@property (nonatomic, assign) NSString *total_cost;
@property (nonatomic, assign) BOOL vehicle_required;
@property (nonatomic, assign) NSString *action_chosen;
@property (nonatomic, assign) NSString *make_template;
@property (nonatomic, assign) NSString *created_at_date;
@property (nonatomic, assign) NSString *updated_at_date;
@property (nonatomic, assign) NSString *cost_method_id;
@property (nonatomic, assign) NSString *time_unit_id;
@property (nonatomic, assign) NSString *cost_per_time_unit;
@property (nonatomic, assign) NSString *fixed_cost_amount;
@property (nonatomic, assign) NSString *average_expected_cost;
@property (nonatomic, assign) NSString *average_expected_time;
@property (nonatomic, assign) NSString *custom_quote_factors;
@property (nonatomic, assign) NSString *skills;
@property (nonatomic, assign) NSString *user_id;
@property (nonatomic, assign) NSString *category_id;
@property (nonatomic, assign) NSString *industry_id;
@property (nonatomic, assign) NSString *company;
@property (nonatomic, assign) NSString *expense_required;
@property (nonatomic, assign) NSString *task_location_type_id;
@property (nonatomic, assign) NSString *status;
@property (nonatomic, assign) NSString *visible_status;
@property (nonatomic, assign) NSString *video;
@property (nonatomic, assign) NSString *company_description;
@property (nonatomic, assign) NSString *compensation;
@property (nonatomic, assign) NSString *duration;
@property (nonatomic, assign) NSString *hours_per_week;
@property (nonatomic, assign) NSString *requirement_list;
@property (nonatomic, assign) NSString *staffing_position_type_id;
@property (nonatomic, assign) NSString *staffing_position_category_id;
@property (nonatomic, assign) NSString *total_paid_amount;
@property (nonatomic, assign) NSString *task_start_time;
@property (nonatomic, assign) NSString *task_end_time;
@property (nonatomic, assign) NSString *task_on_date;
@property (nonatomic, assign) NSString *task_on_time;
@property (nonatomic, assign) NSString *task_duration_type;
@property (nonatomic, assign) NSString *longitude;
@property (nonatomic, assign) NSStream *latitude;

@end
