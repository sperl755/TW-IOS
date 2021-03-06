//
//  CompanySummary.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CompanySummary.h"


@implementation CompanySummary

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithJSONDictionary:(NSDictionary*)the_json_info
{
    if ((self = [super init]))
    {
        NSString *summary = [[the_json_info objectForKey:@"company"] objectForKey:@"mission_philosphy"];
        NSString *the_description = [[the_json_info objectForKey:@"company"] objectForKey:@"description"];
        if (summary.length <= 1 || the_description.length <= 1)
        {
            [self setupGUI:@"Not available"];
            my_summary_text.text = @"Not available";
        }
        else
        {
            NSMutableString *the_summary_and_desc = [[NSMutableString alloc] initWithCapacity:11];
            [the_summary_and_desc appendString:summary];
            [the_summary_and_desc appendString:@"\nDescription: "];
            [the_summary_and_desc appendString:the_description];
            my_summary_text.text = the_summary_and_desc;   
            [self setupGUI:the_summary_and_desc];
        } 
    }
    return self;
}
-(void)setupGUI:(NSString*)the_summary
{
    
    // Initialization code //Create Header
    UIImage *header_image           = [UIImage imageNamed:@"module_header.png"];
    module_header_background        = [[UIImageView alloc] initWithImage:header_image];
    module_header_background.frame  = CGRectMake(0, 0, 310, 33);
    [self addSubview:module_header_background];
    //[header_image release];
    
    spam_your_friends_label                 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 250, 22)];
    spam_your_friends_label.textColor       = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
    spam_your_friends_label.backgroundColor = [UIColor clearColor];
    spam_your_friends_label.text            = @"Company Summary and Description";
    [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    [self addSubview:spam_your_friends_label];
    
    //Create Row 1
    UIImage *row_background     = [UIImage imageNamed:@"module_row_last"];
    UIImage *row_back_stretch   = [row_background stretchableImageWithLeftCapWidth:(row_background.size.width/2)-1 topCapHeight:(row_background.size.height/2)-1];
    module_row_one_background   = [[UIImageView alloc] initWithImage:row_back_stretch];
    //module_row_one_background.frame = CGRectMake(0, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, 42);
    
    my_summary_text = [[UITextView alloc] initWithFrame:module_row_one_background.frame];
    [my_summary_text setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
    my_summary_text.userInteractionEnabled = NO;
    //[self setFrame:CGRectMake(5, 0, 310, (module_row_one_background.frame.size.height + module_row_one_background.frame.origin.y) - module_header_background.frame.origin.y)]; 
    
    //Figure out height of summary txt
    CGSize maximumLabelSize = CGSizeMake(300,9999);
    
    CGSize expectedLabelSize = [the_summary sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9] 
                                       constrainedToSize:maximumLabelSize 
                                           lineBreakMode:UILineBreakModeWordWrap]; 
    
    //adjust the label the the new height.
    //CGRect newFrame = user_summary_text.frame;
    //newFrame.size.height = expectedLabelSize.height;
    //user_summary_text.frame = newFrame;
    if (expectedLabelSize.height < 42)
    {
        module_row_one_background.frame = CGRectMake(0, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, 42);   
    }
    else
    {
        module_row_one_background.frame = CGRectMake(0, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, expectedLabelSize.height);  
    }
    [self addSubview:module_row_one_background]; 
    my_summary_text.backgroundColor = [UIColor clearColor];
    my_summary_text.frame = CGRectMake(0, module_header_background.frame.origin.y + module_header_background.frame.size.height, 300, expectedLabelSize.height + 10);
    [self addSubview:my_summary_text];
    [self setFrame:CGRectMake(5, 0, 310, (module_row_one_background.frame.origin.y + module_row_one_background.frame.size.height) - module_header_background.frame.origin.y)];
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
