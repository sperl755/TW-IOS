//
//  InboxController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversationSelection.h"
#import "ConversationViewController.h"

@interface InboxController : UIViewController <ConversationSelectionProtocol>
{
    UINavigationController *nav_control;
    ConversationSelection *conversations;
    ConversationViewController *convo_details;
    UIAlertView *load_message;
}
@end
