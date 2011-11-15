//
//  Menu.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"


@implementation Menu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Create logo and message container
        logo_message = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoAndMessage.png"]];
        [logo_message setFrame:CGRectMake(0, -30, logo_message.frame.size.width, logo_message.frame.size.height)];
        [self addSubview:logo_message];
        //create View and Apply for jobs btn
        view_and_apply_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [view_and_apply_btn setTitle:@"View and Apply For Jobs" forState:UIControlStateNormal];
        view_and_apply_btn.frame = CGRectMake(54, 140, 208, 50);
        [view_and_apply_btn addTarget:self action:@selector(viewAndApplyForJobs) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:view_and_apply_btn];
        //create Check In to my jobs btn
        check_into_jobs_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [check_into_jobs_btn setTitle:@"Check In To My Jobs" forState:UIControlStateNormal];
        check_into_jobs_btn.frame = CGRectMake(54, 190, 208, 50);
        [check_into_jobs_btn addTarget:self action:@selector(checkIntoMyJobs) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:check_into_jobs_btn];
        box1 = [[Checkbox alloc] initWithFrame:CGRectMake(24, 248, [UIImage imageNamed:@"CheckOn.png"].size.width, [UIImage imageNamed:@"CheckOn.png"].size.height)];
        box1.userInteractionEnabled = YES;
        [self addSubview:box1];
        sort_by_from_me = [[UILabel alloc] initWithFrame:CGRectMake(70, 248, 200, 50)];
        sort_by_from_me.text = @"Sort by distance from me";
        [self addSubview:sort_by_from_me];  
    }
    return self;
}
-(void)viewAndApplyForJobs
{
    printf("I just got all the jobs in the world");
}
-(void)checkIntoMyJobs
{
    printf("I ran errands for ms potts!");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [logo_message release];
    [view_and_apply_btn release];
    [check_into_jobs_btn release];
    [box1 release];
    [super dealloc];
}

@end
