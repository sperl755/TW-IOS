//
//  UserSummaryProfileModule.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserSummaryProfileModule.h"
#import "StaffItToMeAppDelegate.h"

@implementation UserSummaryProfileModule

-(id)initWithString:(NSString*)the_string
{
    if ((self = [super init]))
    {
        //Create Header
        UIImage *header_image           = [UIImage imageNamed:@"module_header.png"];
        module_header_background        = [[UIImageView alloc] initWithImage:header_image];
        module_header_background.frame  = CGRectMake(0, 0, 310, 33);
        [self addSubview:module_header_background];
        
        //[header_image release];
        spam_your_friends_label                 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
        spam_your_friends_label.textColor       = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        spam_your_friends_label.backgroundColor = [UIColor clearColor];
        [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        
        StaffItToMeAppDelegate *app_delegate    = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        NSMutableString *header_label           = [[NSMutableString alloc] initWithString:app_delegate.user_state_information.my_user_info.full_name];
        [header_label appendString:@"'s Summary"];
        spam_your_friends_label.text = header_label;
        [self addSubview:spam_your_friends_label];
        
        //Create Row 1
        UIImage *row_background     = [UIImage imageNamed:@"module_row_last.png"];
        UIImage *stretched          = [row_background stretchableImageWithLeftCapWidth:(row_background.size.width/2)-1 topCapHeight:(row_background.size.height/2)-1];
        module_row_one_background   = [[UIImageView alloc] initWithImage:stretched];
        
        //Create user Summary
        user_summary_text = [[UITextView alloc] init];
        if (the_string == nil || the_string == [NSNull null] || the_string.length < 15)
        {
            user_summary_text.text = @"";
            [module_header_background removeFromSuperview];
            [spam_your_friends_label removeFromSuperview];
            return self;
        }
        else
        {
            user_summary_text.text              = the_string;
            user_summary_text.textColor         = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
            user_summary_text.backgroundColor   = [UIColor clearColor];
            [user_summary_text setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
            user_summary_text.editable          = NO;
        
            //Figure out height of summary txt
            CGSize maximumLabelSize     = CGSizeMake(300,9999);
            CGSize expectedLabelSize    = [the_string sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9] 
                                          constrainedToSize:maximumLabelSize 
                                              lineBreakMode:UILineBreakModeWordWrap]; 
        
            //adjust the label the the new height.
            //CGRect newFrame = user_summary_text.frame;
            //newFrame.size.height = expectedLabelSize.height;
            //user_summary_text.frame = newFrame;
            module_row_one_background.frame = CGRectMake(0, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, expectedLabelSize.height);
            [self addSubview:module_row_one_background];
        
            user_summary_text.frame = CGRectMake(0, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, expectedLabelSize.height);
            [self addSubview:user_summary_text];
        
            //set The frame of this module.
            [self setFrame:CGRectMake(5, 0, 310, (module_row_one_background.frame.origin.y + module_row_one_background.frame.size.height) - module_header_background.frame.origin.y)];
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
