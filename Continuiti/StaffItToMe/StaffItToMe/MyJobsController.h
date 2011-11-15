//
//  MyJobsController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneOfMyJobs.h"
#import "JobHistoryController.h"
#import "ManualTimeJobEntry.h"
#import "CheckOutEntry.h"
@protocol MyJobControllerProtocol <NSObject>
-(void)goToJobHistory:(int)the_position;
-(void)goToManualTimeEntry:(int)the_position;
-(void)goToCheckoutScreen:(int)the_position;
@end

@interface MyJobsController : UIViewController <OneOfMyJobsProtocol, ManualTimeJobEntryProtocol, JobHistoryControllerProtocol, UITableViewDelegate, UITableViewDataSource ,CheckOutEntryProtocol> {
	NSMutableArray *my_array_of_jobs;
	int current_job;
	UIImageView *top_arrow;
	UIImageView *bottom_arrow;
    UITableView *my_table_view;
}
@property (nonatomic, retain) id <MyJobControllerProtocol> my_delegate;
@end
