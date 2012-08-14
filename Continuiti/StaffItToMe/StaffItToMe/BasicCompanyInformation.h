//
//  BasicCompanyInformation.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BasicCompanyInformation : UIView 
{
    UIImageView *module_header_background;
    UILabel *spam_your_friends_label;
    UIImageView *module_row_one_background;
    UIImageView *module_row_two_background;
    UIImageView *basic_info_icons;
    UILabel *location_label;
    UILabel *location_details;
    UILabel *job_type;
    UILabel *job_type_detail;
    UILabel *compensation;
    UILabel *compensation_detail;
    UILabel *job_time;
    UILabel *job_time_details;
    
}

-(id)initWithMutableDictionary:(NSMutableDictionary*)the_json_info;
@end
