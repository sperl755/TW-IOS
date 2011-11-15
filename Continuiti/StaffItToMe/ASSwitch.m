//
//  ASSwitch.m
//  Switch
//
//  Created by Anthony Sierra on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ASSwitch.h"


@implementation ASSwitch
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame andOnImage:(UIImage*)the_on_image offImage:(UIImage*)the_off_image sliderImage:(UIImage*)the_slider_image
{
    self = [super initWithFrame:frame];
    printf("%f", frame.size.width/2);
    if (self) {        on = NO;
        // This switch starts as off
        //create on image 
        on_image =  [[UIImageView alloc] initWithImage:the_on_image];
        on_image.frame = CGRectMake(-(frame.size.width / 2), 0, frame.size.width, self.frame.size.height);
        [self addSubview:on_image];
        
        //create off image 
        off_image = [[UIImageView alloc] initWithImage:the_off_image];
        off_image.frame = CGRectMake(0, 0, frame.size.width, self.frame.size.height);
        [self insertSubview:off_image atIndex:3];
        
        slider = [[UIImageView alloc] initWithImage:the_slider_image];
        slider.frame = CGRectMake(0, 0, (int)(frame.size.width / 2), self.frame.size.height);
        [self addSubview:slider];
        self.clipsToBounds = YES;

    }
    return self;
}
-(void)setSwitchToOn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
    [UIView setAnimationRepeatCount:0];
    on_image.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    off_image.frame = CGRectMake((self.frame.size.width/2), 0, self.frame.size.width, self.frame.size.height);
    slider.frame = CGRectMake(self.frame.size.width/2, 0, (int)(self.frame.size.width / 2), self.frame.size.height);
    on = YES;
    [UIView commitAnimations];
    [delegate respondToOnHappening];
}
-(void)setSwitchToOff
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
    [UIView setAnimationRepeatCount:0];
    on_image.frame = CGRectMake(-(self.frame.size.width / 2), 0, self.frame.size.width, self.frame.size.height);
    off_image.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    slider.frame = CGRectMake(0, 0, (int)(self.frame.size.width / 2), self.frame.size.height);
    on = NO;
    [UIView commitAnimations];
    [delegate respondToOffHappening];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    start_point = [[touches anyObject] locationInView:self];
    click = 10;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint cpoint = [[touches anyObject] locationInView:self];
    int DX = start_point.x - cpoint.x;
    if (slider.frame.origin.x - DX < 0 || slider.frame.origin.x + slider.frame.size.width - DX > self.frame.size.width)
    {
        return;
    }
    [on_image setFrame:CGRectMake(on_image.frame.origin.x - DX, 0, on_image.frame.size.width, on_image.frame.size.height)];
    [off_image setFrame:CGRectMake(off_image.frame.origin.x - DX, 0, off_image.frame.size.width, off_image.frame.size.height)];
    [slider setFrame:CGRectMake(slider.frame.origin.x - DX, 0, slider.frame.size.width, slider.frame.size.height)];
    start_point = [[touches anyObject] locationInView:self];
    click = 0;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //set switch to off
    if (slider.center.x < self.frame.size.width /2)
    {
        [self setSwitchToOff];
    } //Set Switch to on
    else if (slider.center.x >= self.frame.size.width/2)
    {
        [self setSwitchToOn];
    }
    if (click == 10 && on)
    {
        [self setSwitchToOff]; 
    }
    else if (click == 10 && !on)
    {
        [self setSwitchToOn];
    }
    click = 0;
}
-(BOOL)isOn
{
    return on;
}
-(void)setOn:(BOOL)the_value
{
    if (on && the_value) {
        
    }
    else if (!on && the_value) {
        [self setSwitchToOn];
    }
    else if (!on && !the_value) {
        
    }
    else if (on && !the_value){
        [self setSwitchToOff];
    }
}
-(void)setOnWithoutDelegateCall:(BOOL)the_value
{
    if (on && the_value) {
        
    }
    else if (!on && the_value) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
        [UIView setAnimationRepeatCount:0];
        on_image.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        off_image.frame = CGRectMake((self.frame.size.width/2), 0, self.frame.size.width, self.frame.size.height);
        slider.frame = CGRectMake(self.frame.size.width/2, 0, (int)(self.frame.size.width / 2), self.frame.size.height);
        on = YES;
        [UIView commitAnimations];
    }
    else if (!on && !the_value) {
        
    }
    else if (on && !the_value){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
        [UIView setAnimationRepeatCount:0];
        on_image.frame = CGRectMake(-(self.frame.size.width / 2), 0, self.frame.size.width, self.frame.size.height);
        off_image.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        slider.frame = CGRectMake(0, 0, (int)(self.frame.size.width / 2), self.frame.size.height);
        on = NO;
        [UIView commitAnimations];
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
