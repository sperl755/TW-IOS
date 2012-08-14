//
//  WildcardMovementGestureRecognizer.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WildcardMovementGestureRecognizer.h"


@implementation WildcardMovementGestureRecognizer
@synthesize touchesEndedCallback;

-(id) init{
    if ((self = [super init]))
    {
        self.cancelsTouchesInView = NO;
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touchesEndedCallback)
    {
        touchesEndedCallback(touches, event);
    }
}

- (void)reset
{
}

- (void)ignoreTouch:(UITouch *)touch forEvent:(UIEvent *)event
{
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    return NO;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    return NO;
}


@end
