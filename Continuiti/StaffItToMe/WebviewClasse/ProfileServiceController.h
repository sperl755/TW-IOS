//
//  ProfileServiceController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileWebService.h"

@interface ProfileServiceController : UIViewController
{
    UINavigationController *my_nav_controller;
    ProfileWebService *web_service;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andToken:(NSString*)the_token;
@end
