//
//  AllJobBillingHistories.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobBillingHistoryView.h"

@interface AllJobBillingHistories : UIView {
	int start_y;
	int distance_y;
	int y_position;
	UILabel *job_billing_lbl;
	NSMutableArray *job_history;
}

@end
