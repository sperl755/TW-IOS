//
//  InboxOrSentbox.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCategoryCell.h"
@protocol InboxOrSentboxProtocol <NSObject>
-(void)goToInbox;
-(void)goToSentbox;
@end


@interface InboxOrSentbox : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *my_table;
    
}
@property (nonatomic, retain) id <InboxOrSentboxProtocol> delegate;

@end
