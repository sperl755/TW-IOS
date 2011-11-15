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

@interface StaffOutProposalPage : UIViewController <UITextViewDelegate, UITextFieldDelegate, ASSliderProtocol, FindRightSpotArrowProtocol>
{
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
    
    //Rate Assets
    UILabel *rate_txt;
    UIImageView *rate_arrow;
    ASSLider *rate_slider;
    UIImageView *my_value_display;
    UILabel *my_value_display_text;
    
    //UISlider *rate_slider;
    
    //Email Assets
    UILabel *subject_email_lbl;
    UITextField *email_text;
    
    //SUbject assets
    UILabel *email_lbl;
    UITextField *subject_txt;
    //Message Assets
    UITextView *message_txt;
    
    UIAlertView *load_message;
    
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
