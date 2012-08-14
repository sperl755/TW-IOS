//
//  ConversationViewController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BubbleMessageView.h"

@interface ConversationViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITableView *table_of_convos;
    NSMutableArray *list_of_messages;
    NSMutableArray *date_of_messages;
    NSMutableArray *bubble_item_array;
    IBOutlet UITextField *the_text;
    IBOutlet UIButton *send_button;
}
@property (nonatomic, retain) IBOutlet UITableView *table_of_convos;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andMessageArray:(NSArray*)the_messages_array andDateArray:(NSArray*)the_dates_array;
@end
