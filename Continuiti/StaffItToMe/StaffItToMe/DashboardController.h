//
//  DashboardController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeScreen.h"
#import "StaffYourself.h"
#import "StaffOutSegment1.h"
#import "StaffOutSegment2.h"
#import "FacebookBroadcast.h"
#import "ASIFormDataRequest.h"
#import "JobDetailScreen.h"

@interface DashboardController : UIViewController<HomeScreenProtocol, StaffYourselfProtocol, StaffOutSegement1Protocol, StaffOutSegment2, FriendFacebookBroadcastProtocol, FacebookBroadcastProtocol, UINavigationControllerDelegate> {
    UINavigationController *nav_control;
    HomeScreen *home_screen;
    StaffYourself *staff_yourself;
    StaffOutSegment1 *staff_out_1;
    StaffOutSegment2 *staff_out_2;
    FacebookBroadcast *broadcast_facebook;
    FriendFacebookBroadcast *friend_facebook_broadcast;
    JobDetailScreen *job_detail_screen;
    
    //ALertView for accessing the server
    UIAlertView *load_message;
}
-(void)properlyPopViewController;
@end
