//
//  StaffOutFrontPage.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCapabilitiesProfileModule.h"
#import "PendingRequestsModule.h"
#import "ASIFormDataRequest.h"
@protocol StaffOutFrontPageProtocol <NSObject>
-(void)goToProposal;
@end

@interface StaffOutFrontPage : UIViewController
{
    IBOutlet UILabel *what_waiting;
    IBOutlet UITableView *table_view;
    NSArray *module_array;
}
-(IBAction)goToProposalPage;
@property (nonatomic, retain) id <StaffOutFrontPageProtocol> delegate;
@end
