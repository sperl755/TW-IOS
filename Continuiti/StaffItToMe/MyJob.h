//
//  MyJob.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 This data model represents an Job that the user
 has applied for and is currently a part of.
 */

@interface MyJob : NSObject {
    
}
/*
 Information about the job.
 */
@property (nonatomic, assign) int status;
@property (nonatomic, assign) NSString *checked_in_out;
@property (nonatomic, assign) NSString *title;
@property (nonatomic, assign) NSString *start_time;
@property (nonatomic, assign) NSString *start_date_time;
@property (nonatomic, assign) NSString *job_duration;
@property (nonatomic, assign) NSString *rate;
@property (nonatomic, assign) NSString *time_clock;
@property (nonatomic, assign) NSString *notes;
@property (nonatomic, assign) NSString *company;
@property (nonatomic, assign) NSString *job_details;
@property (nonatomic, assign) NSString *distance_from_user;
@property (nonatomic, assign) NSString *my_job_id;
@property (nonatomic, assign) NSString *my_checkin_chekcout_status;
//An array of job billing history objects.
@property (nonatomic, assign) NSMutableArray *job_history;

-(id)initWithCoder:(NSCoder*)aDecoder;
-(void)encodeWithCoder:(NSCoder*)aCoder;
@end
