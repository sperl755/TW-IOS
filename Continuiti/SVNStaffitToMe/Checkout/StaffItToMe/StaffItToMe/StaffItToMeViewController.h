//
//  StaffItToMeViewController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginScreen.h"
#import "Menu.h"
@interface StaffItToMeViewController : UIViewController {
    LoginScreen *login_screen;
    Menu *menu;
}

-(void)tearLoginScreen;
@end
