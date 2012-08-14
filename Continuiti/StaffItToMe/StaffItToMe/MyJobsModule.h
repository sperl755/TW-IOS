//
//  MyJobsModule.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoInformationCell.h"
#import "MyJobDisplayCell.h"
@protocol MyJobsModuleProtocol <NSObject>
-(void)manualButtonPressedOnJobInArrayPosition:(int)the_array_position;
-(void)checkinButtonPressedOnJobInArrayPosition:(int)the_array_position;
-(void)getApplications;
@end

@interface MyJobsModule : UIView <MyJobDisplayCellProtocol>
{
    UIImageView *module_header_background;
    UILabel *my_jobs_label;
    UILabel *my_job_count_label;
    int height;
}
@property (nonatomic, retain) id <MyJobsModuleProtocol> delegate;

@end
