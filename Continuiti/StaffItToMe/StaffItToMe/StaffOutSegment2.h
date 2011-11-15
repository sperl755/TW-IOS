//
//  StaffOutSegment2.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StaffOutSegment2 <NSObject>
-(void)didSubmitProposal;
@property (nonatomic, retain) NSString *service_description;
@property (nonatomic, retain) NSString *rate_type;
@property (nonatomic, retain) NSString *rate;
@property (nonatomic, retain) NSString *items_included;
@property (nonatomic, retain) NSString *items_not_included;
@property (nonatomic, retain) NSString *start_date;
@property (nonatomic, retain) NSString *end_date;
@end

@interface StaffOutSegment2 : UIViewController <UIActionSheetDelegate, UITextViewDelegate, UITextFieldDelegate> {
    IBOutlet UITextView *service_description;
    IBOutlet UITextField *rate_type;
    IBOutlet UITextField *rate;
    IBOutlet UITextField *items_included;
    IBOutlet UITextField *items_not_included;
    IBOutlet UITextField *start_date;
    IBOutlet UITextField *end_date;
    int start_or_end;
    IBOutlet UISwitch *rate_type_switch;
    IBOutlet UILabel *rate_type_label;
    
}
-(void)displayDatePicker;
-(IBAction)submitProposal;
@property (retain) id <StaffOutSegment2> delegate;
@end
