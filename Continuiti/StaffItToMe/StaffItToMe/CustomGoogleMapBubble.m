//
//  CustomGoogleMapBubble.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomGoogleMapBubble.h"
#import "StaffItToMeAppDelegate.h"


@implementation CustomGoogleMapBubble
@synthesize react_to_tap;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame andPos:(int)the_position
{
    self = [super initWithFrame:frame];
    if (self) {
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 70)];
        background.image = [UIImage imageNamed:@"BalloonBackground.png"];
        [self addSubview:background];
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        //Create Job Upper Label
        NSMutableString *top_label = [[NSMutableString alloc] initWithString:[[app_delegate.user_state_information.job_array objectAtIndex:the_position] title]];
        if (![[[app_delegate.user_state_information.job_array objectAtIndex:the_position] company] isEqualToString:@""])
        {
            [top_label appendString:@" at "];
            [top_label appendString:[[app_delegate.user_state_information.job_array objectAtIndex:the_position] company]];
        }
        UILabel *top_txt = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, 200, 20)];
        //top_txt.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        top_txt.backgroundColor = [UIColor clearColor];
        [top_txt setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:11]];
        top_txt.text = top_label;
        [self addSubview:top_txt];
        
        //Create Job Lower Label
        NSMutableString *bottom_label = [[NSMutableString alloc] initWithString:[[app_delegate.user_state_information.job_array objectAtIndex:the_position] job_type_title]];
        [bottom_label appendString:@" / "];
        [bottom_label appendString:[[app_delegate.user_state_information.job_array objectAtIndex:the_position] industry_name]];
        UILabel *bottom_txt = [[UILabel alloc] initWithFrame:CGRectMake(8, 22, 200, 20)];
        bottom_txt.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        bottom_txt.backgroundColor = [UIColor clearColor];
        [bottom_txt setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
        bottom_txt.text = bottom_label;
        [self addSubview:bottom_txt];
        
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegate performSelector:react_to_tap];
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
