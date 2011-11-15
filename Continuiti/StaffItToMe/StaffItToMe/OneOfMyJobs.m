//
//  OneOfMyJobs.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OneOfMyJobs.h"
#import "StaffItToMeAppDelegate.h"


@implementation OneOfMyJobs
@synthesize job_delegate;
- (id)initWithFrame:(CGRect)frame andPositionInArray:(int)the_position
{
    self = [super initWithFrame:frame];
    if (self) {
        position = the_position;
        StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        NSMutableString *job_info_string = [[NSMutableString alloc] initWithString:[[delegate.user_state_information.my_jobs objectAtIndex:the_position] title]];
        [job_info_string appendString:@", "];
        [job_info_string appendString:[[delegate.user_state_information.my_jobs objectAtIndex:the_position] start_time]];
        [job_info_string appendString:@", \n"];
        [job_info_string appendString:[[delegate.user_state_information.my_jobs objectAtIndex:the_position] job_duration]];
        [job_info_string appendString:@", "];
        [job_info_string appendString:[[delegate.user_state_information.my_jobs objectAtIndex:the_position] rate]];
        job_info = [[UITextView alloc] initWithFrame:CGRectMake(20, 0, 280, 60)];
        job_info.text = job_info_string;
        job_info.userInteractionEnabled = NO;
        [self addSubview:job_info];
		
		
		
		//Create check in out button
		check_in_out_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		check_in_out_btn.frame = CGRectMake(0, job_info.frame.origin.y + job_info.frame.size.height, 320, 50);
		[check_in_out_btn setTitle:@"Checked In/Out" forState:UIControlStateNormal];
        [check_in_out_btn addTarget:self action:@selector(checkoutFunction) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:check_in_out_btn];
        
		//Create manual time entry button
		manual_time_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		manual_time_btn.frame = CGRectMake(0, check_in_out_btn.frame.origin.y + check_in_out_btn.frame.size.height, 160, 50);
        [manual_time_btn addTarget:self action:@selector(enterManual) forControlEvents:UIControlEventTouchUpInside];
		[manual_time_btn setTitle:@"Manual Time" forState:UIControlStateNormal];
		[self addSubview:manual_time_btn];
        
		//Create check in out button
		history_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		history_btn.frame = CGRectMake(manual_time_btn.frame.origin.x + manual_time_btn.frame.size.width, check_in_out_btn.frame.origin.y + check_in_out_btn.frame.size.height, 160, 50);
		[history_btn setTitle:@"History" forState:UIControlStateNormal];
        [history_btn addTarget:self action:@selector(displayJobsHistory) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:history_btn];
		
		
    }
    return self;
}
-(void)displayJobsHistory
{
    [job_delegate displayJobHistory:position];
}
-(void)enterManual
{
    [job_delegate enterManualTime:position];
}
-(void)checkoutFunction
{
    [job_delegate goToCheckout:position];
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
	[job_info release];
    [check_in_out_btn release];
    [manual_time_btn release];
    [history_btn release];
    [super dealloc];
}

@end
