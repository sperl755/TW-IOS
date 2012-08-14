//
//  ProfileMain.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "FacebookBroadcast.h"
#import "FriendFacebookBroadcast.h"


@interface ProfileMain : UIViewController <ProfileViewProtocol, FriendFacebookBroadcastProtocol, FacebookBroadcastProtocol>
{
    UINavigationController *nav_control;
    ProfileViewController *profile_view_controller;
    FacebookBroadcast *broadcast_facebook;
    FriendFacebookBroadcast *friend_facebook_broadcast;
}

@end
