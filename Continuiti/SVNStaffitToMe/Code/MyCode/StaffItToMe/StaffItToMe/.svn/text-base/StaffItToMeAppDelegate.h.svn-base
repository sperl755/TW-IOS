//
//  StaffItToMeAppDelegate.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
#import "FbGraph.h"
@class StaffItToMeViewController;

@interface StaffItToMeAppDelegate : NSObject <UIApplicationDelegate,FBRequestDelegate, FBSessionDelegate> {
    NSString *username;
    Facebook *facebook;
    FbGraph *fbGraph;
}
-(void)facebookFunction;
-(BOOL)cellularConnected;
-(BOOL)wifiConnected;
-(BOOL)networkConnected;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, assign) NSString *username;
@property (nonatomic, retain) IBOutlet StaffItToMeViewController *viewController;

@end
