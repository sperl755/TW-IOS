//
//  StaffOutProposalPage.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASTableView.h"
#import "ASIFormDataRequest.h"
#import "ASSLider.h"
#import "FindRightSpotArrows.h"

@interface StaffOutProposalPage : UIViewController <UITextViewDelegate, UITextFieldDelegate, ASSliderProtocol, FindRightSpotArrowProtocol, UIPickerViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>
{
    BOOL getting_information;
    IBOutlet ASTableView *my_table_view;
    NSArray *module_array;
    //Data
    NSString *pay_type;
    int per_hr;
    NSString *capability;
    
    //Capability assets
    UILabel *category;
    UILabel *capability_lbl;
    UILabel *capability_txt;
    UIImageView *capability_arrow;
    UIPickerView *capability_picker_view;
    UIActionSheet *menu;
    
    //Rate Assets
    UILabel *rate_txt;
    UIImageView *rate_arrow;
    ASSLider *rate_slider;
    UIImageView *my_value_display;
    UILabel *my_value_display_text;
    UIPickerView *rate_picker_view;
    int min_slider_value;
    int max_slider_value;
    
    //UISlider *rate_slider;
    
    //Email Assets
    UILabel *subject_email_lbl;
    UITextField *email_text;
    /**Odd variable. Basically detects whether this is the first 
     time the person has touched this text so that the text
     that was there before can act like a place holder.
     This is the same for all bools with this naming convention.
     */
    BOOL email_text_touched;
    
    //SUbject assets
    UILabel *email_lbl;
    UITextField *subject_txt;
    BOOL subject_text_touched;
    //Message Assets
    UITextView *message_txt;
    BOOL message_text_touched;
    
    LoadingView *load_view;
    /**Testing
     */
    FindRightSpotArrows *positioning_arrows;
}
-(id)getHeader;
-(id)getCapabilityDropDown;
-(id)getRateCell;
-(id)getEmailCell;
-(id)getSubjectCell;
-(id)getMessageCell;
-(id)getStaffOutButtonCell;
@end
