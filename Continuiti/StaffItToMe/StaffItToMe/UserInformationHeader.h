//
//  UserInformationHeader.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASSwitch.h"
@protocol UserInfoHeaderProtocol <NSObject>
-(void)respondToConnectionsButton;
@end


@interface UserInformationHeader : UIView <ASSwitchDelegateProtocol>
{
    UIImageView *header_shadow;
    UIImageView *my_profile_picture;
    UIImageView *my_profile_shiner;
    UILabel *my_profile_name;
    UIImageView *connections_icon;
    UIButton *my_connection_button;
    UILabel *connections_label;
    ASSwitch *my_available_switch;
    UIImageView *my_available_switch_background;
    UIImageView *my_available_switch_foreground;
    
}
-(void)updateProfilePicture;
@property (nonatomic, retain) id <UserInfoHeaderProtocol> delegate;
@end
