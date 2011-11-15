//
//  FacebookFriendEICell.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 10/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"


@interface FacebookFriendEICell : UIView <FBRequestDelegate> {
    UIImageView *module_row_one_background;
    UIImageView *friend_one_picture;
    UIImageView *friend_one_overlay;
    UILabel *friend_one_name;
    UIButton *friend_one_invite_btn;
    UIButton *friend_one_endorse_btn;
    NSString *friend_facebook_id;
    UIAlertView *load_message;
    Facebook *facebook;
}

-(id)initWithFriendName:(NSString*)friend_name friend_id:(NSString*)friend_id;
@end
