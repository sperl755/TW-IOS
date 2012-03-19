//
//  FeedController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedWebService.h"

@interface FeedController : UIViewController
{
    UINavigationController *my_nav_controller;
    FeedWebService *web_service;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andToken:(NSString*)the_token;
@end
