//
//  SentMessageController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InboxCell.h"
#import "CustomCategoryCell.h"
@protocol SentMessageProtocol <NSObject>
-(void)goToSentMessage:(int)convo_position;
@end

@interface SentMessageController : UIViewController <UITableViewDelegate, UITableViewDataSource> 
{
    IBOutlet UITableView *my_table;
    UILabel *load_message;
    UIImageView *wait_header;
    UILabel *wait_label;
    
}
@property (nonatomic, retain) IBOutlet UITableView *my_table;
@property (nonatomic, retain) id <SentMessageProtocol> delegate;

@end
