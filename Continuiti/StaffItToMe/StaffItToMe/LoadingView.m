//
//  LoadingView.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoadingView.h"
#define BackgroundWidth .312
#define BackgroundHeight .2083
#define SpinnerWidth .125
#define SpinnerHeight .0833

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        load_background = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width/2)-(frame.size.width * BackgroundWidth)/2, (frame.size.height/2)-(frame.size.height*BackgroundHeight)/2, 0, 0)];
        load_background.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self addSubview:load_background];
        UIImage *spinner_background = [UIImage imageNamed:@"loading_spinner_bg"];
        UIImage *stretched_spinner_background = [spinner_background stretchableImageWithLeftCapWidth:(spinner_background.size.width/2)-1 topCapHeight:(spinner_background.size.height/2)-1];
        [load_background setImage:stretched_spinner_background];
        
        
        spinner = [[UIImageView alloc] initWithFrame:CGRectMake(load_background.center.x - (frame.size.width*SpinnerWidth)/2, load_background.center.y-(frame.size.height*SpinnerHeight)/2, 0, 0)];
        spinner.center = CGPointMake(load_background.center.x, load_background.center.y);
        UIImage *spinner_image = [UIImage imageNamed:@"ajax-loader"];
        //UIImage *stretchable_spinner_image = [spinner_image stretchableImageWithLeftCapWidth:(spinner_image.size.width/2)-1 topCapHeight:(spinner_image.size.height/2)-1];
        [spinner setImage:spinner_image];
        [self addSubview:spinner];
        [self performSelector:@selector(rotate) withObject:nil afterDelay:0.1];
        loading = YES;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
        [UIView setAnimationRepeatCount:0];
        load_background.frame = CGRectMake((frame.size.width/2)-(frame.size.width * BackgroundWidth)/2, (frame.size.height/2)-(frame.size.height*BackgroundHeight)/2, frame.size.width * BackgroundWidth, frame.size.height*BackgroundHeight);
        load_background.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        spinner.frame = CGRectMake(load_background.center.x - (frame.size.width*SpinnerWidth)/2, load_background.center.y-(frame.size.height*SpinnerHeight)/2, frame.size.width * SpinnerWidth, frame.size.height * SpinnerHeight);
        [UIView commitAnimations];
        
        //make myself the frame of the thing.
        //[self setFrame:CGRectMake(0, 0, 320, 480)];
    }
    return self;
}
-(void)setMiniatureMapLoading
{
    [self setFrame:CGRectMake(280, 0, 30, 30)];
    [load_background setFrame:CGRectMake(0, 0, 30, 30)];
    [spinner setFrame:CGRectMake(0, 0, 10, 10)];
    spinner.center = load_background.center;
}
-(void)removeFromSuperview
{
    [super removeFromSuperview];
    loading = NO;
}
-(void)rotate
{
    if (loading)
    {
        spinner.transform = CGAffineTransformMakeRotation(angle + 1.57/3);
        [self performSelector:@selector(rotate) withObject:nil afterDelay:0.1];
        angle += .57;
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
