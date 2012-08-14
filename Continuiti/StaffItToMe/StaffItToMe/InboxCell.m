//
//  InboxCell.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InboxCell.h"


@implementation InboxCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initwithDetail:(NSString*)the_detail andArrow:(BOOL)arrow_on senderName:(NSString*)the_sender_name
{
    if ((self = [super init]))
    {
        UIImage *row_background = [UIImage imageNamed:@"module_row.png"];
        module_row_one_background = [[UIImageView alloc] initWithImage:row_background];
        module_row_one_background.frame = CGRectMake(0,0, 310, 42);
        [self addSubview:module_row_one_background];
        
        //Setup the first job suggestions information.
        job_one_picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_profile_pic"]];
        [job_one_picture setFrame:CGRectMake(module_row_one_background.frame.origin.x + 10, module_row_one_background.frame.origin.y + 8, 25, 25)];
        [self addSubview:job_one_picture];
        
        job_one_name = [[UILabel alloc] initWithFrame:CGRectMake(job_one_picture.frame.origin.x + job_one_picture.frame.size.width + 10, job_one_picture.frame.origin.y + 12, 230, 20)];
        job_one_name.backgroundColor = [UIColor clearColor];
        job_one_name.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        job_one_name.text = the_detail;
        job_one_name.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1];
        [self addSubview:job_one_name];
        
        job_one_description = [[UILabel alloc] initWithFrame:CGRectMake(job_one_name.frame.origin.x, job_one_name.frame.origin.y - 14, 150, 20)];
        job_one_description.backgroundColor = [UIColor clearColor];
        job_one_description.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        job_one_description.text = the_sender_name;
        [self addSubview:job_one_description];
        
        if (arrow_on)
        {
            arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
            arrow.frame = CGRectMake(module_row_one_background.frame.size.width - 15, module_row_one_background.frame.origin.y + 15.5, 6.5, 12);
            [self addSubview:arrow];
        }
        [self setFrame:CGRectMake(5, 0, 310, 42)];
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
