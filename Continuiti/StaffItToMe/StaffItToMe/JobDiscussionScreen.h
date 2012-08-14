//
//  JobDiscussionScreen.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JobDiscussionScreen : UIViewController <UITextViewDelegate>
{
    UITextView *description_txt; 
    UITextView *your_message_txt;
    UIButton *send_message_btn;
	UIAlertView *load_message;
}
@end
