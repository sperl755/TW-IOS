//
//  MessageDetailsController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUserProfileController.h"
@protocol MessageDetailsControllerProtocol <NSObject>
-(void)goToThisNewController:(UIViewController*)the_new_controller;
@end

@interface MessageDetailsController : UIViewController <UITextViewDelegate>
{
    UIImageView *subject_header;
    UILabel *subject_label;
    UIButton *sender_name;
    
    UILabel *name_label;
    UITextView *message_txt;
    /**
     Odd variable that detects whether this text has been touched before.
     It is used to detect whether or not to clear the message_txt so 
     that the text before it can act as a placeholder.
     */
    BOOL message_text_touched;
    UIView *item_holder;
    int current_position;
    LoadingView *load_view;
    
    int looking_at_profile;
}
-(id)initWithPositionInInboxArray:(int)the_position;

-(id)initWithPositionInSentBoxArray:(int)the_position;
@property (nonatomic, retain) id <MessageDetailsControllerProtocol> delegate;
@end
