//
//  JobInformationHeader.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JobInformationHeaderProtocol <NSObject>
-(void)respondToApplyButton;
-(void)respondToCompanyTouch:(NSString*)the_information;
@end


@interface JobInformationHeader : UIView 
{
    UIImageView *header_shadow;
    UIImageView *my_profile_picture;
    UIButton *my_profile_shiner;
    UILabel *my_profile_name;
    UILabel *company_name;
    UILabel *distance_from_user;
    UIButton *my_connection_button;
    UILabel *connections_label;
    UIImageView *my_available_switch_background;
    LoadingView *load_view;
    BOOL company_information;
    
}
-(id)initWithPos:(int)the_position;
-(void)sendApplication;
@property (nonatomic, retain) id <JobInformationHeaderProtocol> delegate;

@end
