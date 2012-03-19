//
//  MessagesWebController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessagesWebService.h"

@interface MessagesWebController : UIViewController
{
    UINavigationController *my_nav_controller;
    MessagesWebService *web_service;
}

@end
