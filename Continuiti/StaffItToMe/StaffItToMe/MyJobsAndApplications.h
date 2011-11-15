//
//  MyJobsAndApplications.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASSwitch.h"
#import "MyJobsModule.h"
#import "UserInformationHeader.h"
#import "JobApplicationsModule.h"

@protocol JobAndApplicationProtocol <NSObject>
-(void)goToFacebookBroadcast;
-(void)goToManualCheckinWithJobArrayPosition:(int)the_array_position;
-(void)goToCheckinWithJobArrayPosition:(int)the_array_position;
@end

@interface MyJobsAndApplications : UIViewController <UserInfoHeaderProtocol, MyJobsModuleProtocol, UITableViewDelegate, UITableViewDataSource, JobApplicationModuleProtocol>
{
    BOOL im_available;
    UIImageView *background;
    UserInformationHeader *my_header;
    UITableView *my_table_view;
    NSArray *module_array;
    MyJobsModule *my_jobs_module;
}
@property (nonatomic, retain) id <JobAndApplicationProtocol> delegate;
@end
