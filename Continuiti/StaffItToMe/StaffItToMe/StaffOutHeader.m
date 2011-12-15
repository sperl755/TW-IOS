//
//  StaffOutHeader.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StaffOutHeader.h"

@implementation StaffOutHeader
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        what_waiting = [[UILabel alloc] initWithFrame:CGRectMake(62, 31, 108, 21)];
        what_waiting.text = @"What are you waiting for?";
        what_waiting.backgroundColor = [UIColor clearColor];
        what_waiting.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        [what_waiting setCenter:CGPointMake(320/2, what_waiting.center.y)];
        [what_waiting setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
        [self addSubview:what_waiting];
        staff_out_button = [UIButton buttonWithType:UIButtonTypeCustom];
        staff_out_button.frame = CGRectMake(76, 57, 169, 40);
        [staff_out_button addTarget:self action:@selector(delegateRespondPlease) forControlEvents:UIControlEventTouchUpInside];
        [staff_out_button setBackgroundImage:[UIImage imageNamed:@"StaffYourselfButton.png"] forState:UIControlStateNormal];
        [self addSubview:staff_out_button];
        [self setFrame:CGRectMake(0, 0, 320, 117)];
    }
    return self;
}
-(void)delegateRespondPlease
{
    [delegate respondToStaffYourselfButton];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
