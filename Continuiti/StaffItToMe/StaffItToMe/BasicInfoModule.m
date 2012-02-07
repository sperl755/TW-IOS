//
//  BasicInfoModule.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicInfoModule.h"
#import "StaffItToMeAppDelegate.h"

@implementation BasicInfoModule


-(id)initWithPos:(int)the_pos
{
    self = [super init];
    if (self) {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        // Initialization code //Create Header
        UIImage *header_image           = [UIImage imageNamed:@"module_header.png"];
        module_header_background        = [[UIImageView alloc] initWithImage:header_image];
        module_header_background.frame  = CGRectMake(0, 0, 310, 33);
        [self addSubview:module_header_background];
        //[header_image release];
        
        spam_your_friends_label                 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
        spam_your_friends_label.textColor       = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        spam_your_friends_label.backgroundColor = [UIColor clearColor];
        spam_your_friends_label.text            = @"Basic Info";
        [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        [self addSubview:spam_your_friends_label];
        
        //Create Row 1
        UIImage *row_background         = [UIImage imageNamed:@"module_row.png"];
        module_row_one_background       = [[UIImageView alloc] initWithImage:row_background];
        module_row_one_background.frame = CGRectMake(0, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, 42);
        [self addSubview:module_row_one_background];
        
        //Create Row 2
        module_row_two_background       = [[UIImageView alloc] initWithImage:row_background];
        module_row_two_background.frame = CGRectMake(0, module_row_one_background.frame.origin.y + module_row_one_background.frame.size.height,  310, 42);
        [self addSubview:module_row_two_background];
        
        basic_info_icons        = [[UIImageView alloc] initWithFrame:CGRectMake(module_row_one_background.frame.origin.x + 10, module_row_one_background.frame.origin.y + 5,178.5, 65.5)];
        basic_info_icons.image  = [UIImage imageNamed:@"BasicInfoIcons"];
        [self addSubview:basic_info_icons];
        
        //Location Information
        location_label                  = [[UILabel alloc] initWithFrame:CGRectMake(basic_info_icons.frame.origin.x + 30, basic_info_icons.frame.origin.y, 100, 12)];
        location_label.text             = @"Location";
        location_label.backgroundColor  = [UIColor clearColor];
        [location_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
        [self addSubview:location_label];
        
        location_details = [[UILabel alloc] initWithFrame:CGRectMake(location_label.frame.origin.x, location_label.frame.origin.y + location_label.frame.size.height, 100, 30)];
        
        
        NSMutableString *location_text_detail = [[NSMutableString alloc] initWithString:[[app_delegate.user_state_information.job_array objectAtIndex:the_pos] job_city]];
        [location_text_detail appendString:@", "];
        [location_text_detail appendFormat:[[app_delegate.user_state_information.job_array objectAtIndex:the_pos] job_state]];
        if (location_text_detail.length < 4) {
            location_details.text = @"NA";
        }
        else {
            location_details.text = location_text_detail;   
        }
        location_details.backgroundColor = [UIColor clearColor];
        [location_details setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
        [self addSubview:location_details];
        
        //Job Type Information
        job_type                    = [[UILabel alloc] initWithFrame:CGRectMake(basic_info_icons.frame.origin.x + basic_info_icons.frame.size.width + 5, location_label.frame.origin.y, 100, 12)];
        job_type.text               = @"Job Type";
        job_type.backgroundColor    = [UIColor clearColor];
        [job_type setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
        [self addSubview:job_type];
        
        job_type_detail                 = [[UILabel alloc] initWithFrame:CGRectMake(job_type.frame.origin.x, job_type.frame.origin.y + job_type.frame.size.height, 100, 30)];
        job_type_detail.text            = @"Location";
        job_type_detail.backgroundColor = [UIColor clearColor];
        [job_type_detail setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
        [self addSubview:job_type_detail];
        
        //Compensation Information
        compensation                    = [[UILabel alloc] initWithFrame:CGRectMake(location_label.frame.origin.x, location_label.frame.origin.y + 40, 100, 12)];
        compensation.text               = @"Compensation";
        compensation.backgroundColor    = [UIColor clearColor];
        [compensation setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
        [self addSubview:compensation];
        
        compensation_detail                 = [[UILabel alloc] initWithFrame:CGRectMake(compensation.frame.origin.x, compensation.frame.origin.y + compensation.frame.size.height, 100, 30)];
        compensation_detail.text            = @"Location";
        compensation_detail.backgroundColor = [UIColor clearColor];
        [compensation_detail setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
        [self addSubview:compensation_detail];
        
        //Job Time Information
        job_time = [[UILabel alloc] initWithFrame:CGRectMake(job_type.frame.origin.x, job_type.frame.origin.y + 40, 100, 12)];
        job_time.backgroundColor = [UIColor clearColor];
        [job_time setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
        job_time.text = @"Time";
        [self addSubview:job_time];
        job_time_details = [[UILabel alloc] initWithFrame:CGRectMake(job_time.frame.origin.x, job_time.frame.origin.y + job_time.frame.size.height, 100, 30)];
        job_time_details.text = @"Location";
        job_time_details.backgroundColor = [UIColor clearColor];
        [job_time_details setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
        [self addSubview:job_time_details];
        
        [self setFrame:CGRectMake(5, 0, 310, (module_row_two_background.frame.origin.y + module_row_two_background.frame.size.height) - module_header_background.frame.origin.y)];
    }
    return self;
}
-(id)initWithMutableDictionary:(NSMutableDictionary*)the_json_info
{
    if ((self = [super init]))
    {
        [self setupGUI];
        if (([[[the_json_info objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"city"] == [NSNull null] || [[[the_json_info objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"city"] == nil) || ([[[the_json_info objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"state"] == [NSNull null] || [[[the_json_info objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"state"] == nil))
        {
            location_details.text = @"No Location";
        }
        else
        {
            NSMutableString *location_text_detail = [[NSMutableString alloc] initWithString:[[[the_json_info objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"city"]];
            [location_text_detail appendString:@", "];
            [location_text_detail appendString:[[[the_json_info objectForKey:@"location"] objectForKey:@"location"] objectForKey:@"state"]];
            location_details.text = location_text_detail;
        }
        if ([the_json_info objectForKey:@"jobtype"] == [NSNull null] || [the_json_info objectForKey:@"jobtype"] == nil)
        {
            job_type_detail.text = @"Unknown";
        }
        else
        {
            job_type_detail.text = [the_json_info objectForKey:@"jobtype"];
        }

        
        if ([the_json_info objectForKey:@"compensation_details"] == [NSNull null] || [the_json_info objectForKey:@"compensation_details"] == nil)
        {
            compensation_detail.text = @"NA";
        }
        else
        {
            compensation_detail.text = [the_json_info objectForKey:@"compensation_details"];
        }
        if ([the_json_info objectForKey:@"time_details"] == [NSNull null] || [the_json_info objectForKey:@"time_details"] == nil)
        {
            job_time_details.text = @"NA";
        }
        else
        {
            job_time_details.text = [the_json_info objectForKey:@"time_details"];
        }
    }
    return self;
}
-(id)init
{
    if ((self = [super init]))
    { 
        [self setupGUI];
        NSMutableString *location_text_detail = [[NSMutableString alloc] initWithString:@"City"];
        [location_text_detail appendString:@", "];
        [location_text_detail appendString:@"State"];
        location_details.text = location_text_detail;
        job_type_detail.text = @"Something";
        compensation_detail.text = @"Money";
        job_time_details.text = @"Forever";
    }
    return self;
}
-(void)setupGUI
{
    // Initialization code //Create Header
    UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
    module_header_background = [[UIImageView alloc] initWithImage:header_image];
    module_header_background.frame = CGRectMake(0, 0, 310, 33);
    [self addSubview:module_header_background];
    //[header_image release];
    spam_your_friends_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
    spam_your_friends_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
    spam_your_friends_label.backgroundColor = [UIColor clearColor];
    [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    spam_your_friends_label.text = @"Basic Info";
    [self addSubview:spam_your_friends_label];
    
    //Create Row 1
    UIImage *row_background = [UIImage imageNamed:@"module_split"];
    module_row_one_background = [[UIImageView alloc] initWithImage:row_background];
    module_row_one_background.frame = CGRectMake(0, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, 42);
    [self addSubview:module_row_one_background];
    //Create Row 2
    UIImage *row_background_last = [UIImage imageNamed:@"module_split_last"];
    module_row_two_background = [[UIImageView alloc] initWithImage:row_background_last];
    module_row_two_background.frame = CGRectMake(0, module_row_one_background.frame.origin.y + module_row_one_background.frame.size.height,  310, 42);
    [self addSubview:module_row_two_background];
    
    basic_info_icons = [[UIImageView alloc] initWithFrame:CGRectMake(module_row_one_background.frame.origin.x + 10, module_row_one_background.frame.origin.y + 9,178.5, 65.5)];
    basic_info_icons.image = [UIImage imageNamed:@"BasicInfoIcons"];
    [self addSubview:basic_info_icons];
    
    //Location Information
    location_label = [[UILabel alloc] initWithFrame:CGRectMake(basic_info_icons.frame.origin.x + 30, basic_info_icons.frame.origin.y - 4, 100, 20)];
    location_label.text = @"Location";
    location_label.backgroundColor = [UIColor clearColor];
    [location_label setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:11]];
    [self addSubview:location_label];
    location_details = [[UILabel alloc] initWithFrame:CGRectMake(location_label.frame.origin.x, location_label.frame.origin.y + 10, 100, 30)];
    
    
    location_details.backgroundColor = [UIColor clearColor];
    [location_details setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
    [self addSubview:location_details];
    
    //Job Type Information
    job_type = [[UILabel alloc] initWithFrame:CGRectMake(basic_info_icons.frame.origin.x + basic_info_icons.frame.size.width + 5, location_label.frame.origin.y, 100, 20)];
    [job_type setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:11]];
    job_type.text = @"Job Type";
    job_type.backgroundColor = [UIColor clearColor];
    [self addSubview:job_type];
    job_type_detail = [[UILabel alloc] initWithFrame:CGRectMake(job_type.frame.origin.x, job_type.frame.origin.y + 10, 100, 30)];
    job_type_detail.backgroundColor = [UIColor clearColor];
    [job_type_detail setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
    [self addSubview:job_type_detail];
    
    //Compensation Information
    compensation = [[UILabel alloc] initWithFrame:CGRectMake(location_label.frame.origin.x, location_label.frame.origin.y + module_row_one_background.frame.size.height, 100, 20)];
    compensation.text = @"Compensation";
    compensation.backgroundColor = [UIColor clearColor];
    [compensation setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:11]];
    [self addSubview:compensation];
    compensation_detail = [[UILabel alloc] initWithFrame:CGRectMake(compensation.frame.origin.x, compensation.frame.origin.y + 10, 100, 30)];
    compensation_detail.backgroundColor = [UIColor clearColor];
    [compensation_detail setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
    [self addSubview:compensation_detail];
    
    //Job Time Information
    job_time = [[UILabel alloc] initWithFrame:CGRectMake(job_type.frame.origin.x, job_type.frame.origin.y + module_row_one_background.frame.size.height, 100, 20)];
    job_time.backgroundColor = [UIColor clearColor];
    [job_time setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:11]];
    job_time.text = @"Time";
    [self addSubview:job_time];
    job_time_details = [[UILabel alloc] initWithFrame:CGRectMake(job_time.frame.origin.x, job_time.frame.origin.y + 10, 100, 30)];
    job_time_details.backgroundColor = [UIColor clearColor];
    [job_time_details setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
    [self addSubview:job_time_details];
    
    [self setFrame:CGRectMake(5, 0, 310, (module_row_two_background.frame.origin.y + module_row_two_background.frame.size.height) - module_header_background.frame.origin.y)];  
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
