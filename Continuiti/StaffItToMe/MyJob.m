//
//  MyJob.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyJob.h"


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
@end
