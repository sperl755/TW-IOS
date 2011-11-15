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
    UIView *item_holder;
    int current_position;
    UIAlertView *load_message;
    
    int looking_at_profile;
}
-(id)initWithPositionInInboxArray:(int)the_position;

-(id)initWithPositionInSentBoxArray:(int)the_position;
@property (nonatomic, retain) id <MessageDetailsControllerProtocol> delegate;
@end
