//
//  JobBillingHistoryView.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JobBillingHistoryView : UIView {
	UILabel *date;
	UITextView *status_notes_lbl;
	UILabel *time_lbl;
}
- (id)initWithFrame:(CGRect)frame andDate:(NSString*)the_date statusNotes:(NSString*)status_notes time:(NSString*)time;
-(void)disableTextView;
@end
