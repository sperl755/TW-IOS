//
//  Checkbox.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Checkbox.h"


@implementation Checkbox
-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        on = NO;
        [self setImage:[UIImage imageNamed:@"CheckOff.png"]];
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (on) {
        [self setImage:[UIImage imageNamed:@"CheckOff.png"]];
        on = NO;
    }
    else
    {
        [self setImage:[UIImage imageNamed:@"CheckOn.png"]];
        on = YES;
    }
}
@end
