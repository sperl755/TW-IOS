//
//  ConversationSelection.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InboxCell.h"
#import "CustomCategoryCell.h"
@protocol ConversationSelectionProtocol <NSObject>
-(void)goToConversation:(int)convo_position ;
@end

@interface ConversationSelection : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *my_table;
    UILabel *load_message;
    UIImageView *wait_header;
    UILabel *wait_label;
    
    LoadingView *load_view;
}
-(void)refreshInbox;
@property (nonatomic, retain) IBOutlet UITableView *my_table;
@property (nonatomic, retain) id <ConversationSelectionProtocol> delegate;


@end
