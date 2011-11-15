//
//  BasicCompanyInformation.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicCompanyInformation.h"


@implementation BasicCompanyInformation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithMutableDictionary:(NSMutableDictionary*)the_json_info
{
    if ((self = [super init]))
    {
        [self setupGUI];
        if ([[the_json_info objectForKey:@"company"] objectForKey:@"size"] == [NSNull null] || [[the_json_info objectForKey:@"company"] objectForKey:@"size"] == nil)
        {
            location_details.text = @"No size";
        }
        else
        {
            NSMutableString *location_text_detail = [[NSMutableString alloc] initWithString:[[the_json_info objectForKey:@"company"] objectForKey:@"size"]];
            location_details.text = location_text_detail;
        }
        if ([[the_json_info objectForKey:@"company"] objectForKey:@"company_type"] == [NSNull null] || [[the_json_info objectForKey:@"company"] objectForKey:@"company_type"] == nil)
        {
            job_type_detail.text = @"Company_type";
        }
        else
        {
            job_type_detail.text = [[the_json_info objectForKey:@"company"] objectForKey:@"company_type"];
        }
        
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
    UIImage *row_background = [UIImage imageNamed:@"module_split_last"];
    module_row_one_background = [[UIImageView alloc] initWithImage:row_background];
    module_row_one_background.frame = CGRectMake(0, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, 42);
    [self addSubview:module_row_one_background];
    
    basic_info_icons = [[UIImageView alloc] initWithFrame:CGRectMake(module_row_one_background.frame.origin.x + 10, module_row_one_background.frame.origin.y + 9,178.5, 65.5)];
    basic_info_icons.image = [UIImage imageNamed:@"BasicInfoIcons"];
    [self addSubview:basic_info_icons];
    
    //Location Information
    location_label = [[UILabel alloc] initWithFrame:CGRectMake(basic_info_icons.frame.origin.x + 30, basic_info_icons.frame.origin.y - 4, 100, 20)];
    location_label.text = @"Size";
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
    [self setFrame:CGRectMake(5, 0, 310, 84)];
    [self setClipsToBounds:YES];
    
   
}
- (void)dealloc
{
    [super dealloc];
}

@end
