//
//  MessageSystemMain.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InboxOrSentbox.h"
#import "ConversationSelection.h"
#import "MessageDetailsController.h"
#import "SentMessageController.h"

@interface MessageSystemMain : UIViewController <UINavigationControllerDelegate, InboxOrSentboxProtocol, ConversationSelectionProtocol, SentMessageProtocol, MessageDetailsControllerProtocol>
{
    UINavigationController *navigation_controller;
    InboxOrSentbox *in_or_out;
    ConversationSelection *inbox_controller;
    MessageDetailsController *message_detail;
    SentMessageController *sent_message_controller;
}

@end
