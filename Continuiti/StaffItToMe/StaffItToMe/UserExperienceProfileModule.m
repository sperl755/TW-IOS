//
//  UserExperienceProfileModule.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserExperienceProfileModule.h"
#import "StaffItToMeAppDelegate.h"

@implementation UserExperienceProfileModule

-(id)init
{
    if ((self = [super init]))
    {
        //Create Header
        UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
        module_header_background = [[UIImageView alloc] initWithImage:header_image];
        module_header_background.frame = CGRectMake(5, 0, 310, 33);
        [self addSubview:module_header_background];
        //[header_image release];
        spam_your_friends_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
        spam_your_friends_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        spam_your_friends_label.backgroundColor = [UIColor clearColor];
        [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        NSMutableString *header_label = [[NSMutableString alloc] initWithString:app_delegate.user_state_information.my_user_info.full_name];
        [header_label appendString:@"'s Experience"];
        spam_your_friends_label.text = header_label;
        [self addSubview:spam_your_friends_label];
        
        //set The frame of this module.
        [self setFrame:CGRectMake(5, 0, 310, module_header_background.frame.size.height)];   
    }
    return self;
}
-(id)initWithArray:(NSArray*)the_experiences
{
    if ((self = [super init]))
    {
        //Create Header
        UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
        module_header_background = [[UIImageView alloc] initWithImage:header_image];
        module_header_background.frame = CGRectMake(5, 0, 310, 33);
        [self addSubview:module_header_background];
        //[header_image release];
        spam_your_friends_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
        spam_your_friends_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        spam_your_friends_label.backgroundColor = [UIColor clearColor];
        [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        NSMutableString *header_label = [[NSMutableString alloc] initWithString:app_delegate.user_state_information.my_user_info.full_name];
        [header_label appendString:@"'s Experience"];
        spam_your_friends_label.text = header_label;
        [self addSubview:spam_your_friends_label];
        
        if (the_experiences.count < 1)
        {
            int height = 0;
            NSMutableString *detail_text = [[NSMutableString alloc] initWithString:@"From Year: NA"];
            
            JobDisplayCell *no_info = [[JobDisplayCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) pictureURL:@"" name:@"Not Available" description:@"" detail:detail_text];
            [no_info removeArrow];
            
            [no_info setBackgroundImageToModuleRowLast];
            
            [self addSubview:no_info];
            no_info.frame = CGRectMake(5, (module_header_background.frame.origin.y + module_header_background.frame.size.height), 310, 33);
            height+= 42;
            //set The frame of this module.
            [self setFrame:CGRectMake(0, 0, 310, module_header_background.frame.size.height + height)]; 
        }
        else
        {
            int height = 0;
            for (int i = 0; i < the_experiences.count; i++)
            {
                int from_year = [[[the_experiences objectAtIndex:i] objectForKey:@"from_year"] intValue];
                NSMutableString *detail_text = [[NSMutableString alloc] initWithString:@"From Year: "];
                [detail_text appendString:[NSString stringWithFormat:@"%d", from_year]];
                JobDisplayCell *no_info = [[JobDisplayCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) pictureURL:@"" name:[[the_experiences objectAtIndex:i] objectForKey:@"title"] description:[[the_experiences objectAtIndex:i] objectForKey:@"company_name"] detail:detail_text];
                [no_info removeArrow];
                
                if (i == the_experiences.count-1)
                {
                    [no_info setBackgroundImageToModuleRowLast];
                }
                [self addSubview:no_info];
                no_info.frame = CGRectMake(5, (module_header_background.frame.origin.y + module_header_background.frame.size.height) + i*42, 310, 33);
                height+= 42;
            }
            //set The frame of this module.
            [self setFrame:CGRectMake(0, 0, 310, module_header_background.frame.size.height + height)]; 
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

- (void)dealloc
{
    [super dealloc];
}

@end
