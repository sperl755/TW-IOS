//
//  HomeScreen.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
#import "SpamYourFriends.h"
#import "JobSuggestionsModule.h"
#import "UISwitch-Extended.h"
#import "ASSwitch.h"
#import "UserInformationHeader.h"
#import "PullRefreshHeader.h"
#import "Facebook.h"
@protocol HomeScreenProtocol <NSObject>
-(void)goToFaceBookBroadcast;
-(void)respondToSuggestedJob;
@end

@interface HomeScreen : UIViewController <ASSwitchDelegateProtocol, UserInfoHeaderProtocol, JobSuggestionProtocol, UIScrollViewDelegate, FBRequestDelegate>
{
    IBOutlet UIButton *im_available_btn;
    BOOL im_available;
    
    UIImageView *background;
    IBOutlet UIImageView *my_profile_picture;
    IBOutlet UILabel *my_profile_name;
    IBOutlet UIButton *my_connection_button;
    IBOutlet UILabel *connections_label;
    IBOutlet ASSwitch *my_available_switch;
    IBOutlet UITableView *my_table_view;
    UserInformationHeader *my_header;
    NSArray *module_array;
    PullRefreshHeader *refresh_header;
    Facebook *facebook;
    BOOL requesting;
}
-(IBAction)goToFriendBroadcast;
-(IBAction)changeFacebookPeeps;
-(IBAction)sendWallPost:(id)sender;
-(IBAction)displayStaffYourself;
-(IBAction)setScreen:(id)sender;
-(IBAction)imAvailable;
@property (retain) id <HomeScreenProtocol> home_screen_delegate;
@end
