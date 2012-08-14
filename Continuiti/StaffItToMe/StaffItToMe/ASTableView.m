//
//  ASTableView.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ASTableView.h"


@implementation ASTableView
@synthesize handleViewCallback;
@synthesize tag_for_listening;
@synthesize email_tag_for_listening;
@synthesize subject_tag_for_listening;
@synthesize message_tag_for_listening;
@synthesize button_tag_for_listening;
@synthesize rate_input_tag_for_listening;
-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *v = [self viewWithTag:tag_for_listening]; //999 is the tag of your subview, that you want to capture events
    CGPoint convertedPoint = [self convertPoint:point toView:v];
    
    UIView *v2 = [self viewWithTag:email_tag_for_listening];
    CGPoint convertedSecondPoint = [self convertPoint:point toView:v2];
    
    UIView *v3 = [self viewWithTag:subject_tag_for_listening];
    CGPoint convertedThirdPoint = [self convertPoint:point toView:v3];
    
    UIView *v4 = [self viewWithTag:message_tag_for_listening];
    CGPoint convertedFourthPoint = [self convertPoint:point toView:v4];
    
    UIView *v5 = [self viewWithTag:button_tag_for_listening];
    CGPoint convertedFifthPoint = [self convertPoint:point toView:v5];
    
    UIView *v6 = [self viewWithTag:rate_input_tag_for_listening];
    CGPoint convertedSixthPoint = [self convertPoint:point toView:v6];
    
    // If the touch is inside the view, let the view handle it
    if ([v pointInside:convertedPoint withEvent:event]) {
        return v;
    } 
    else if ([v2 pointInside:convertedSecondPoint withEvent:event])
    {
        return v2;
    }
    else if ([v3 pointInside:convertedThirdPoint withEvent:event])
    {
        return v3;
    }
    else if ([v4 pointInside:convertedFourthPoint withEvent:event])
    {
        return v4;
    }
    else if ([v5 pointInside:convertedFifthPoint withEvent:event])
    {
        return v5;
    }
    else if ([v6 pointInside:convertedSixthPoint withEvent:event])
    {
        return v6;
    }
    else
    {
        return [super hitTest:point withEvent:event];
    }
}
@end
