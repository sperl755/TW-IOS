//
//  JobHistoryMain.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyJobsAndApplications.h"
#import "FacebookBroadcast.h"
#import "FriendFacebookBroadcast.h"
#import "ManualTimeJobEntry.h"
#import "CheckOutEntry.h"

@interface JobHistoryMain : UIViewController <JobAndApplicationProtocol, FriendFacebookBroadcastProtocol, FacebookBroadcastProtocol, UINavigationControllerDelegate>
{
    UINavigationController *nav_controller;
    MyJobsAndApplications *job_history_controller;
    FacebookBroadcast *broadcast_facebook;
    FriendFacebookBroadcast *friend_facebook_broadcast;
    ManualTimeJobEntry *manual_time_entry;
    CheckOutEntry *checkin_time_entry;
}

@end
