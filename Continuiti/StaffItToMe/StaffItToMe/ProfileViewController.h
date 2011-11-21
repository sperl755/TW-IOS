//
//  ProfileViewController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "UserInformationHeader.h"
#import "UserSummaryProfileModule.h"
#import "UserCapabilitiesProfileModule.h"
#import "UserExperienceProfileModule.h"
#import "UserEducationsModule.h"
#import "PullRefreshHeader.h"
@protocol ProfileViewProtocol <NSObject>
-(void)goToFacebookBroadcast;
@end;
@interface ProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UserInfoHeaderProtocol, UIScrollViewDelegate>
{
    UserInformationHeader *my_header;
    UIButton *logout_button;
    UIImageView *background;
    UITableView *my_table_view;
    NSArray *module_array;
    PullRefreshHeader *refresh_header;
}
@property (nonatomic, retain) id <ProfileViewProtocol> delegate;

@end
