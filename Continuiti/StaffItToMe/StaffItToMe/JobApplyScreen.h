//
//  JobApplyScreen.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApplyScreenProtocol <NSObject>
@required
-(void)displayApplyKeyboardDoneButton;
-(void)hideApplyKeyboardDoneButton;
@end
@interface JobApplyScreen : UIViewController <UITextViewDelegate, UIActionSheetDelegate, UITextFieldDelegate>
{
    UIButton *apply_btn;
    UILabel *distance_and_price;
	UILabel *rate_lbl;
	UITextField *rate_txt;
	UILabel *rate_hr_lbl;
	UILabel *start_at_lbl;
	UITextView *start_at_txt;
	UIButton *start_at_btn;
	UIDatePicker *date_picker;
	UITextView *description_txt;
    LoadingView *load_view;
}
@property (retain) id <ApplyScreenProtocol> delegate;

@end
