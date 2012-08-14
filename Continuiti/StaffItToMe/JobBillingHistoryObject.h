//
//  JobBillingHistoryObject.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 There are job billing history objects
 that are displayed for showing what dates and for
 how long the user worked on a specific job. This is
 the data model which is used in MyJob which holds an
 array of these.
 Status notes are notes about the job from that day they worked on it.
 */

@interface JobBillingHistoryObject : NSObject 
{
    
}
@property (nonatomic, assign) NSString *job_date;
@property (nonatomic, assign) NSString *total_time;
@property (nonatomic, assign) NSString *job_time;
@end
