//
//  SpamYourFriends.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
#import "FacebookFriendEICell.h"

//Spam your friends module for the dashboard.
//This class goes in the UITableView that contains al the modules
@interface SpamYourFriends : UIView  <FBRequestDelegate>
{
    UIImageView *module_header_background;
    UILabel *spam_your_friends_label;
    UIButton *shuffle_button;
    UIAlertView *load_message;
    NSMutableArray *friend_cells;
    int beginning;
    int end;
}
@end
