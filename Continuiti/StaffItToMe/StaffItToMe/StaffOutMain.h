//
//  StaffOutMain.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaffOutFrontPage.h"
#import "StaffOutProposalPage.h"

@interface StaffOutMain : UIViewController <UINavigationControllerDelegate, StaffOutFrontPageProtocol>
{
    UINavigationController *nav_control;
    StaffOutFrontPage *front_page;
    StaffOutProposalPage *proposal_page;
}

@end
