//
//  StaffItToMeAppDelegate.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"
#import "FbGraph.h"
#import "SmallJobs.h"
#import "JobSearchController.h"
#import "USERINFORMATIONANDAPPSTATE.h"
#import "JobHistoryMain.h"
#import "FacebookFriend.h"
#import "JSON.h"
#import "HomeScreen.h"
#import "DashboardController.h"
#import "MessageSystemMain.h"
#import "ProfileMain.h"
#import "StaffOutMain.h"
@class StaffItToMeViewController;

@interface StaffItToMeAppDelegate : NSObject <UIApplicationDelegate,FBRequestDelegate, FBSessionDelegate, SA_OAuthTwitterEngineDelegate, SA_OAuthTwitterControllerDelegate, UITabBarControllerDelegate> {
    Facebook *facebook;
    SA_OAuthTwitterEngine    *twitter_engine; 
    UITabBarController *tab_bar_controller;
    DashboardController *home;
    JobSearchController *search;
    JobHistoryMain *jobs;
    ProfileMain *main_profile;
    MessageSystemMain *my_messages_inbox;
    StaffOutMain *broadcast;
	BOOL got_facebook_info;
    //This is used to count when we can go to the main app
    //because we need to make multiple requests at the beginning of login.
    int loadDoneYet;
    LoadingView *load_view;
}
-(void)displayLoadViewWithString:(NSString*)the_string;
-(void)logoutFunction;
-(void)updateAvailableSwitches;
-(void)facebookFunction;
-(BOOL)cellularConnected;
-(void)connectionFunction;
-(void)goToMainApp;
-(void)setCurrentTabBar:(NSString*)the_tab;
-(void)twitterLogin;
-(BOOL)wifiConnected;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
-(BOOL)networkConnected;
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet StaffItToMeViewController *viewController;
@property (nonatomic, assign) USERINFORMATIONANDAPPSTATE *user_state_information;
@property (nonatomic, retain) UITabBarController *tab_bar_controller;
@property (nonatomic, retain) NSMutableArray *my_available_switch_array;

@end
