//
//  AlertLoadView.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlertLoadView.h"
#define BackgroundWidth .312
#define BackgroundHeight .2083
#define SpinnerWidth .125
#define SpinnerHeight .0833


@implementation AlertLoadView

- (id)initWithFrame:(CGRect)frame andText:(NSString*)the_string
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
        
        text_view = [[UITextView alloc] initWithFrame:CGRectMake((frame.size.width/2) - 75/2, (frame.size.height/2) - 75/2, 0, 0)];
        text_view.center = load_background.center;
        text_view.text = the_string;
        text_view.editable = NO;
        text_view.backgroundColor = [UIColor clearColor];
        text_view.textColor = [UIColor whiteColor];
        [self addSubview:text_view];
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
        [UIView setAnimationRepeatCount:0];
        load_background.frame = CGRectMake((frame.size.width/2)-(frame.size.width * BackgroundWidth)/2, (frame.size.height/2)-(frame.size.height*BackgroundHeight)/2, frame.size.width * BackgroundWidth, frame.size.height*BackgroundHeight);
        load_background.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        text_view.frame = CGRectMake((frame.size.width/2) - 75/2, (frame.size.height/2) - 75/2, 75, 75);
        [UIView commitAnimations];
        
        remove_me = [UIButton buttonWithType:UIButtonTypeCustom];
        remove_me.frame = CGRectMake((frame.size.width/2)-(frame.size.width * BackgroundWidth)/2,  load_background.frame.size.height  - 25+ ((frame.size.height/2)-(frame.size.height*BackgroundHeight)/2), frame.size.width * BackgroundWidth, 100*BackgroundHeight);
        [remove_me setBackgroundImage:[UIImage imageNamed:@"loading_spinner_bg"] forState:UIControlStateNormal];
        [self addSubview:remove_me];
        [remove_me addTarget:self action:@selector(removeMyselfFromView) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)removeMyselfFromView
{
    [self removeFromSuperview];
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
    [load_background release];
    [text_view release];
    [remove_me release];
    [super dealloc];
}

@end
