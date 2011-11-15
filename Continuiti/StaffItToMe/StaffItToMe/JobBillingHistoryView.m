//
//  JobBillingHistoryView.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JobBillingHistoryView.h"


@implementation JobBillingHistoryView


- (id)initWithFrame:(CGRect)frame andDate:(NSString*)the_date statusNotes:(NSString*)status_notes time:(NSString*)time
{
    if ((self = [super initWithFrame:frame])) {
        // Setup Date
		date = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, frame.size.height)];
		date.text = the_date;
		[self addSubview:date];
		
		//setup notes
		status_notes_lbl = [[UITextView alloc] initWithFrame:CGRectMake(105, 0, 100, frame.size.height)];
		status_notes_lbl.text = status_notes;
		[self addSubview:status_notes_lbl];
		
        // Setup Time
		time_lbl = [[UILabel alloc] initWithFrame:CGRectMake(205, 0, 100, frame.size.height)];
		time_lbl.text = the_date;
		[self addSubview:time_lbl];
    }
    return self;
}
-(void)disableTextView
{
	status_notes_lbl.userInteractionEnabled = NO;
}

- (void)dealloc {
    [super dealloc];
}


@end
