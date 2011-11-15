//
//  OneOfMyJobs.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobBillingHistoryView.h"
#import "AllJobBillingHistories.h"
@protocol OneOfMyJobsProtocol <NSObject>
@required
-(void)displayJobHistory:(int)the_position;
-(void)enterManualTime:(int)the_position;
-(void)goToCheckout:(int)the_position;
@end
/*
 This class is the view of the MyJob Data model.
 It will be a view that is displayed showing information and
 allowing altering of the current MyJob Data Model that it is representing.
 This view will make up the jobs tab and there will be many of these views as these are scrolled through.
 */

@interface OneOfMyJobs : UIView
{
    UITextView *job_info;
	UIButton *check_in_out_btn;
    UIButton *manual_time_btn;
    UIButton *history_btn;
    int position;
}
- (id)initWithFrame:(CGRect)frame andPositionInArray:(int)the_position;
@property (retain) id <OneOfMyJobsProtocol> job_delegate;

@end
