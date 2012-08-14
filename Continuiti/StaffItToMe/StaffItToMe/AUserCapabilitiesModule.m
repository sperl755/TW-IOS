//
//  AUserCapabilitiesModule.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AUserCapabilitiesModule.h"


@implementation AUserCapabilitiesModule

-(id)initWithArray:(NSArray*)the_capabilities andName:(NSString*)the_user_name
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
        NSMutableString *header_label = [[NSMutableString alloc] initWithString:the_user_name];
        [header_label appendString:@"'s Capabilities"];
        spam_your_friends_label.text = header_label;
        [self addSubview:spam_your_friends_label];
        
        if (the_capabilities.count < 1)
        {
            JobDisplayCell *no_info = [[JobDisplayCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) pictureURL:@"" name:@"Marketing" description:@"Full Time / Industry" detail:@"Involves sales"];
            [no_info removeArrow];
            [self addSubview:no_info];
            
            no_info.frame = CGRectMake(5, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, 33);
            [self setFrame:CGRectMake(0, 0, 310, (no_info.frame.origin.y + no_info.frame.size.height) - module_header_background.frame.origin.y)];
        }
        else
        {
            //set The frame of this module.
            [self setFrame:CGRectMake(5, 0, 310, module_header_background.frame.size.height)]; 
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
