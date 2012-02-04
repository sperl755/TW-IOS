//
//  CompanyHeader.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CompanyHeader.h"

@implementation CompanyHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithName:(NSString*)the_name
{
    
    if ((self = [super init]))
    {
        header_shadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        header_shadow.image = [UIImage imageNamed:@"header_shadow"];
        [self addSubview:header_shadow];
        
        //Setup the available switch background.
        my_available_switch_background = [[UIImageView alloc] initWithFrame:CGRectMake(250, 10, 70, 60)];
        [my_available_switch_background setImage:[UIImage imageNamed:@"distance_box"]];
        [self addSubview:my_available_switch_background];
        
        //setup company name
        distance_from_user                  = [[UILabel alloc] initWithFrame:CGRectMake(my_available_switch_background.frame.origin.x, my_available_switch_background.frame.origin.y + 20, 70, 40)];
        distance_from_user.textAlignment    = UITextAlignmentCenter;
        distance_from_user.backgroundColor  = [UIColor clearColor];
        distance_from_user.font             = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12];
        distance_from_user.textColor        = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        
        NSMutableString *distance_text = [[NSMutableString alloc] initWithString:@"0"];
        [distance_text appendString:@" mi"];
        
        distance_from_user.text = distance_text;
        [self addSubview:distance_from_user];
        
        //Setup Containers.
        //setup prof pic
        my_profile_picture = [[UIImageView alloc] initWithFrame:CGRectMake(5, 14, 48, 50)];
        [self addSubview:my_profile_picture];
        
        //Set User Profile Picture
        [my_profile_picture setImage:[UIImage imageNamed:@"default_company"]];
        
        //setup cover that makes thing nicer
        my_profile_shiner       = [UIButton buttonWithType:UIButtonTypeCustom];
        my_profile_shiner.frame = CGRectMake(0, 9, 58, 60);
        
        [my_profile_shiner setBackgroundImage:[UIImage imageNamed:@"profile_pic_overlay"] forState:UIControlStateNormal];
        [my_profile_shiner addTarget:self action:@selector(goToCompanyPage) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:my_profile_shiner];
        
        //setup user name
        my_profile_name = [[UILabel alloc] initWithFrame:CGRectMake(63, 15, 100, 22)];
        my_profile_name.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12];
        [self addSubview:my_profile_name];
        
        //Display users display name
        my_profile_name.text = the_name;
        my_profile_name.backgroundColor = [UIColor clearColor];
        [self setFrame:CGRectMake(0, 0, 320, 80)];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
