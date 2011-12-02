//
//  PullRefreshHeader.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PullRefreshHeader.h"
#import <QuartzCore/QuartzCore.h>
#define FLIP_ANIMATION_DURATION 3000

@implementation PullRefreshHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        header_shadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        header_shadow.image = [UIImage imageNamed:@"header_shadow"];
        [self addSubview:header_shadow];
        arrow = [[UIImageView alloc] initWithFrame:CGRectMake(95, 15, 25, 40)];
        arrow.image = [UIImage imageNamed:@"LoadingArrow"];
        [self addSubview:arrow];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(arrow.frame.origin.x + arrow.frame.size.width + 15, arrow.frame.origin.y + 3, 140, 40)];
        label.text = @"Pull to Refresh";
        label.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        label.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12];
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        loaded = NO;
        
    }
    return self;
}
-(void)setStartPoint:(CGPoint)the_point
{
    start_point = the_point;
}
/**
 Okay so this will rotate the arrow until it is time for a refresh
 after refresh it sets loaded to YES
 */
-(void)rotate:(CGPoint)the_point
{
    if (start_point.y != 0)
    {
        return;
    }
    if (loaded)
    {
        printf("I am loaded");
        return;
    }
    if (the_point.y > -50)
    {
        arrow.layer.transform = CATransform3DMakeRotation((M_PI / 180.0) * 0, 0.0f, 0.0f, 1.0f);
        old_content_offset = the_point;
        return;
    }
    float y_offset = the_point.y - old_content_offset.y;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.2];
    y_offset *= 2.4;
    [CATransaction begin];
    [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
    arrow.layer.transform = CATransform3DMakeRotation((M_PI / 180.0) * (y_offset + angle), 0.0f, 0.0f, 1.0f);
    angle += y_offset;
    [CATransaction commit];
    [UIView commitAnimations];
    old_content_offset = the_point;
    printf("Angle: %f", angle);
    if (angle <= -180)
    {
        loaded = YES;
        [arrow removeFromSuperview];
        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.frame = CGRectMake(95, 24, 25, 25);
        [activity startAnimating];
        [self addSubview:activity];
    }
}
-(BOOL)isLoaded
{
    return loaded;
}
/**
 This will reset the header back to normal.
 */
-(void)reset
{
    loaded = NO;
    [activity stopAnimating];
    [activity removeFromSuperview];
    angle = 0;
    start_point = CGPointMake(0, 0);
    old_content_offset = CGPointMake(0, 0);
    [arrow removeFromSuperview];
    [arrow release];
    arrow = nil;
    
    arrow = [[UIImageView alloc] initWithFrame:CGRectMake(95, 15, 25, 40)];
    arrow.image = [UIImage imageNamed:@"LoadingArrow"];
    [self addSubview:arrow];
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
