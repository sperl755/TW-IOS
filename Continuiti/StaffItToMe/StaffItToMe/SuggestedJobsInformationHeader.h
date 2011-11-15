//
//  SuggestedJobsInformationHeader.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SuggestedJobInformationHeader <NSObject>
-(void)respondToApplyButton;
@end



@interface SuggestedJobsInformationHeader : UIView
{
    UIImageView *header_shadow;
    UIImageView *my_profile_picture;
    UIImageView *my_profile_shiner;
    UILabel *my_profile_name;
    UILabel *company_name;
    UILabel *distance_from_user;
    UIButton *my_connection_button;
    UILabel *connections_label;
    UIImageView *my_available_switch_background;
    
    UIAlertView *load_message;
}

-(id)initWithPos:(int)the_position;
-(void)sendApplication;
@property (nonatomic, retain) id <SuggestedJobInformationHeader> delegate;

@end
