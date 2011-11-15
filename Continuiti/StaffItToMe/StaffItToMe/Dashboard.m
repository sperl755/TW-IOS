//
//  Dashboard.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "StaffItToMeAppDelegate.h"
#import "Dashboard.h"


@implementation Dashboard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Create logo and message container
        logo_message = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoAndMessage.png"]];
        [logo_message setFrame:CGRectMake(0, 0, logo_message.frame.size.width, logo_message.frame.size.height)];
        [self addSubview:logo_message];
        //create find btn
        home_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [home_btn setTitle:@"Dashboard" forState:UIControlStateNormal];
        home_btn.frame = CGRectMake(5, 120, 305, 44);
        home_btn.tag = 0;
        [home_btn addTarget:self action:@selector(setSelectedTabBar:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:home_btn];
        //create find btn
        find_work_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [find_work_btn setTitle:@"Find Work" forState:UIControlStateNormal];
        find_work_btn.frame = CGRectMake(5, home_btn.frame.origin.y + 60, 305, 44);
        find_work_btn.tag = 1;
        [find_work_btn addTarget:self action:@selector(setSelectedTabBar:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:find_work_btn];
        //create my jobs btn
        my_jobs_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [my_jobs_btn setTitle:@"My Jobs and Check-in" forState:UIControlStateNormal];
        my_jobs_btn.frame = CGRectMake(5, find_work_btn.frame.origin.y + 60, 305, 44);
        my_jobs_btn.tag = 2;
        [my_jobs_btn addTarget:self action:@selector(setSelectedTabBar:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:my_jobs_btn];
        //create I am available btn
        im_available_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [im_available_btn setTitle:@"Profile" forState:UIControlStateNormal];
        im_available_btn.frame = CGRectMake(5, my_jobs_btn.frame.origin.y + 60, 305, 44);
        im_available_btn.tag = 3;
        [im_available_btn addTarget:self action:@selector(setSelectedTabBar:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:im_available_btn];
        //create I am available btn
        inbox_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [inbox_btn setTitle:@"Inbox" forState:UIControlStateNormal];
        inbox_btn.frame = CGRectMake(5, im_available_btn.frame.origin.y + 60, 305, 44);
        inbox_btn.tag = 4;
        [inbox_btn addTarget:self action:@selector(setSelectedTabBar:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:inbox_btn];
    }
    return self;
}
-(void)setSelectedTabBar:(UIButton*)the_btn
{
    StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    switch ([the_btn tag]) {
        case 0:
            delegate.user_state_information.currentTabBar = @"Home";
            break;
        case 1:
            delegate.user_state_information.currentTabBar = @"FindWork";
            break;
        case 2:
            delegate.user_state_information.currentTabBar = @"MyJobs";
            break;
        case 3:
            delegate.user_state_information.currentTabBar = @"Profile";
            break;
        case 4:
            delegate.user_state_information.currentTabBar = @"Inbox";
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tearDashboard" object:nil];
}

- (void)dealloc
{
    [logo_message release];
    [find_work_btn release];
    [my_jobs_btn release];
    [im_available_btn release];
    [home_btn release];
    [inbox_btn release];
    [super dealloc];
}

@end
