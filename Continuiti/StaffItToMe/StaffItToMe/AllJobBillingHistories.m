//
//  AllJobBillingHistories.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AllJobBillingHistories.h"


@implementation AllJobBillingHistories


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		job_history = [[NSMutableArray alloc] initWithCapacity:11];
		y_position = 10;
		job_billing_lbl = [[UILabel alloc] initWithFrame:CGRectMake(120, y_position, 100, 40)];
		job_billing_lbl.text = @"Job Billing History";
		[self addSubview:job_billing_lbl];
		for (int i = 0; i < 4; i++)
		{
			JobBillingHistoryView *job_view = [[JobBillingHistoryView alloc] initWithFrame:CGRectMake(0, job_billing_lbl.frame.origin.y + job_billing_lbl.frame.size.height + (i * 50), 300, 70) andDate:@"12/02/2" statusNotes:@"Here are notes" time:@"1pm"];
			[job_view disableTextView];
			[job_history addObject:job_view];
			[self addSubview:job_view];
			[job_view release];
		}
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *the_touch = [touches anyObject];
	CGPoint touch_point = [the_touch locationInView:self];  
	start_y = touch_point.y;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([[job_history objectAtIndex:job_history.count-1] frame].origin.y + [[job_history objectAtIndex:job_history.count-1] frame].size.height < self.frame.size.height)
	{
		job_billing_lbl.center = CGPointMake(job_billing_lbl.center.x, job_billing_lbl.center.y + 10);
		for (int i = 0; i < job_history.count; i++)
		{
			[[job_history objectAtIndex:i] setFrame:CGRectMake([[job_history objectAtIndex:i] frame].origin.x, [[job_history objectAtIndex:i] frame].origin.y +10, 300, 70)];
		}
		return;
	}
	
	
	UITouch *the_touch = [touches anyObject];
	CGPoint touch_point = [the_touch locationInView:self];  
	distance_y = touch_point.y;
	int total = start_y - distance_y;
	start_y = distance_y;
	
	job_billing_lbl.center = CGPointMake(job_billing_lbl.center.x, job_billing_lbl.center.y - total);
	for (int i = 0; i < job_history.count; i++)
	{
		[[job_history objectAtIndex:i] setFrame:CGRectMake([[job_history objectAtIndex:i] frame].origin.x, [[job_history objectAtIndex:i] frame].origin.y - total, 300, 70)];
	}
	
	if (job_billing_lbl.frame.origin.y > 0)
	{
		[job_billing_lbl setFrame:CGRectMake(120, 10, 100, 40)];
		for (int i = 0; i < job_history.count; i++)
		{
			[[job_history objectAtIndex:i] setFrame:CGRectMake([[job_history objectAtIndex:i] frame].origin.x, job_billing_lbl.frame.origin.y + job_billing_lbl.frame.size.height +(i*50), 300, 70)];
		}
	}
}
-(void)dealloc 
{
	[job_billing_lbl release];
	[job_history release];
    [super dealloc];
}


@end
