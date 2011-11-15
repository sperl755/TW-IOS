//
//  JobSearchController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMapMenuController.h"
#import "JobDetailScreen.h"
#import "JobDiscussionScreen.h"
#import "JobApplyScreen.h"
#import "IndustrySearchController.h"
#import "SalarySearchController.h"
#import "DistanceSearchController.h"
#import "CompanyInformationScreen.h"

@interface JobSearchController : UIViewController <UINavigationControllerDelegate, ApplyScreenProtocol, IndustrySearchProtocol, SalarySearchProtocol, DistanceSearchProtocol, JobDetailScreenProtocol>
{
    UIAlertView *load_message;
    GMapMenuController *gmap_menu;
    JobDetailScreen *job_detail_screen;
    JobDiscussionScreen *job_discussion_screen;
    JobApplyScreen *job_apply_screen;
    BOOL at_detail_screen;
}
@property (nonatomic, retain) UINavigationController *navigation_controller;

-(void)properlyPopViewController;
-(void)properlyToRootViewController;
@end
