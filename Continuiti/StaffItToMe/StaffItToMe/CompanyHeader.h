//
//  CompanyHeader.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CompanyHeader : UIView 
{
    UIImageView *header_shadow;
    UIImageView *my_available_switch_background;
    UILabel *distance_from_user;
    UIImageView *my_profile_picture;
    UIImageView *my_profile_shiner;
    UILabel *my_profile_name;
    
}
-(id)initWithName:(NSString*)the_name;

@end
