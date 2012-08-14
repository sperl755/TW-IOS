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
#import "FbGraph.h"
#import "SmallJobs.h"
#import "USERINFORMATIONANDAPPSTATE.h"
@class StaffItToMeViewController;

@interface StaffItToMeAppDelegate : NSObject <UIApplicationDelegate,FBRequestDelegate, FBSessionDelegate, SA_OAuthTwitterEngineDelegate> {
    Facebook *facebook;
    FbGraph *fbGraph;
    SA_OAuthTwitterEngine    *twitter_engine; 
    UITabBarController *tab_bar_controller;
    UIViewController *home;
    UIViewController *search;
    UIViewController *jobs;
    UIViewController *inbox;
    UIViewController *about;
}
-(void)facebookFunction;
-(BOOL)cellularConnected;
-(void)connectionFunction;
-(void)goToMainApp;
-(void)twitterLogin;
-(BOOL)wifiConnected;
-(BOOL)networkConnected;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet StaffItToMeViewController *viewController;
@property (nonatomic, assign) USERINFORMATIONANDAPPSTATE *user_state_information;

@end
