//
//  FindRightSpotArrows.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FindRightSpotArrows.h"
#define BUTTONWIDTHHEIGHT 25


@implementation FindRightSpotArrows
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Create Left Button
        left_arrow = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        left_arrow.titleLabel.text = @"Left";
        left_arrow.tag = 0;
        left_arrow.frame = CGRectMake(0, BUTTONWIDTHHEIGHT, BUTTONWIDTHHEIGHT, BUTTONWIDTHHEIGHT);
        [left_arrow addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:left_arrow];
        
        //Create Right Button
        right_arrow = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        right_arrow.titleLabel.text = @"Right";
        right_arrow.tag = 1;
        right_arrow.frame = CGRectMake(BUTTONWIDTHHEIGHT, BUTTONWIDTHHEIGHT, BUTTONWIDTHHEIGHT, BUTTONWIDTHHEIGHT);
        [right_arrow addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:right_arrow];
        
        //Create Up Button
        up_arrow = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        up_arrow.titleLabel.text = @"Up";
        up_arrow.tag = 2;
        up_arrow.frame = CGRectMake(BUTTONWIDTHHEIGHT/2, 0, BUTTONWIDTHHEIGHT, BUTTONWIDTHHEIGHT);
        [up_arrow addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:up_arrow];
        
        //Create Down Button
        down_arrow = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        down_arrow.titleLabel.text = @"Down";
        down_arrow.tag = 3;
        down_arrow.frame = CGRectMake(BUTTONWIDTHHEIGHT/2, BUTTONWIDTHHEIGHT*2, BUTTONWIDTHHEIGHT, BUTTONWIDTHHEIGHT);
        [down_arrow addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:down_arrow];
        //Set Frame
        [self setFrame:CGRectMake(0, 0, BUTTONWIDTHHEIGHT*2, BUTTONWIDTHHEIGHT*3)];
        
    }
    return self;
}

-(void)buttonTouched:(id)sender
{
    UIButton *pressed = (UIButton*)sender;
    switch (pressed.tag) {
        case 0:
            [delegate reactToButtonFindRightSpotButtonBeingPressed:@"Left"];
            break;
        case 1:
            [delegate reactToButtonFindRightSpotButtonBeingPressed:@"Right"];
            break;
        case 2:
            [delegate reactToButtonFindRightSpotButtonBeingPressed:@"Up"];
            break;
        case 3:
            [delegate reactToButtonFindRightSpotButtonBeingPressed:@"Down"];
            break;
    }
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
