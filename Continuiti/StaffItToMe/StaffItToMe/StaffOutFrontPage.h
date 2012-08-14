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
#import "StaffOutHeader.h"
#import "PullRefreshHeader.h"
#import "ASIFormDataRequest.h"

@protocol StaffOutFrontPageProtocol <NSObject>
-(void)goToProposal;
@end

@interface StaffOutFrontPage : UIViewController <PendingRequestModuleProtocol, StaffOutHeaderProtocol>
{
    IBOutlet UILabel *what_waiting;
    IBOutlet UITableView *table_view;
    NSArray *module_array;
    PullRefreshHeader *refresh_header;
    BOOL reloading;
    
    LoadingView *load_view;
    
}
-(IBAction)goToProposalPage;
@property (nonatomic, retain) id <StaffOutFrontPageProtocol> delegate;
@end
