//
//  SearchFilterScreen.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchFilterScreen.h"


@implementation SearchFilterScreen
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        [background setImage:[UIImage imageNamed:@"SlideScreenBackground.png"]];
        [self addSubview:background];
        displayed = NO;
        
        //create filter text box
        //Setup Search by jobs, skills, etc text box
        search_by_txt = [[UITextField alloc] initWithFrame:CGRectMake(5, 35, 310, 31)];
        search_by_txt.borderStyle = UITextBorderStyleRoundedRect;
        search_by_txt.placeholder = @"Search by Job, Skills, Industry";
        search_by_txt.backgroundColor = [UIColor clearColor];
        search_by_txt.delegate = self;
        [self addSubview:search_by_txt];
        
        //create List btn
        list_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [list_btn setTitle:@"List" forState:UIControlStateNormal];
        list_btn.frame = CGRectMake(5, 410, 150, 44);
        [list_btn addTarget:self action:@selector(listFunction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:list_btn];
        //create Map btn
        map_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [map_btn setTitle:@"Map" forState:UIControlStateNormal];
        map_btn.frame = CGRectMake(165, 410, 150, 44);
        [map_btn addTarget:self action:@selector(mapFunction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:map_btn];
        //Setup distance from you label
        distance_from_you = [[UILabel alloc] initWithFrame:CGRectMake(85, 155, 160, 20)];
        distance_from_you.text = @"Distance From You";
        distance_from_you.center = CGPointMake(160, distance_from_you.center.y);
        [self addSubview:distance_from_you];
        //create the slider for distance from you
        distance_from_slider = [[UISlider alloc] initWithFrame:CGRectMake(5, 180, 310, 40)];
        distance_from_slider.value = 0.5f;
        [distance_from_slider addTarget:self action:@selector(setDistance) forControlEvents:UIControlEventTouchUpInside];
        [distance_from_slider setMinimumValueImage:[UIImage imageNamed:@"1Mile.png"]];
        [distance_from_slider setMaximumValueImage:[UIImage imageNamed:@"69Mile.png"]];
        [self addSubview:distance_from_slider];
        
        //Setup total value label
        total_value_lbl = [[UILabel alloc] initWithFrame:CGRectMake(85, 245, 90, 20)];
        total_value_lbl.text = @"Total Value";
        total_value_lbl.center = CGPointMake(160, total_value_lbl.center.y);
        [self addSubview:total_value_lbl];
        //create the slider for total value
        total_value_slider = [[UISlider alloc] initWithFrame:CGRectMake(5, 270, 310, 40)];
        total_value_slider.value = 0.5f;
        [total_value_slider addTarget:self action:@selector(setDistance) forControlEvents:UIControlEventTouchUpInside];
        [total_value_slider setMinimumValueImage:[UIImage imageNamed:@"1Mile.png"]];
        [total_value_slider setMaximumValueImage:[UIImage imageNamed:@"69Mile.png"]];
        [self addSubview:total_value_slider];
        //Setup Rate per hour label
        rate_per_hour_lbl = [[UILabel alloc] initWithFrame:CGRectMake(85, 335, 110, 20)];
        rate_per_hour_lbl.text = @"Rate Per Hour";
        rate_per_hour_lbl.center = CGPointMake(160, rate_per_hour_lbl.center.y);
        [self addSubview:rate_per_hour_lbl];
        //create the slider for rate per hour
        rate_slider = [[UISlider alloc] initWithFrame:CGRectMake(5, 360, 310, 40)];
        rate_slider.value = 0.5f;
        [rate_slider addTarget:self action:@selector(setDistance) forControlEvents:UIControlEventTouchUpInside];
        [rate_slider setMinimumValueImage:[UIImage imageNamed:@"1Mile.png"]];
        [rate_slider setMaximumValueImage:[UIImage imageNamed:@"69Mile.png"]];
        [self addSubview:rate_slider];
        //Setup from label
        from_lbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 95, 50, 20)];
        from_lbl.text = @"From";
        [self addSubview:from_lbl];
        //Setup From time&date box
        from_txt = [[UITextField alloc] initWithFrame:CGRectMake(60, 90, 100, 31)];
        from_txt.borderStyle = UITextBorderStyleRoundedRect;
        from_txt.placeholder = @"Time&Date";
        from_txt.backgroundColor = [UIColor clearColor];
        from_txt.delegate = self;
        [self addSubview:from_txt];
        //Setup to label
        to_lbl = [[UILabel alloc] initWithFrame:CGRectMake(165, 95, 30, 20)];
        to_lbl.text = @"To";
        [self addSubview:to_lbl];
        //Setup to time&date box
        to_txt = [[UITextField alloc] initWithFrame:CGRectMake(200, 90, 100, 31)];
        to_txt.borderStyle = UITextBorderStyleRoundedRect;
        to_txt.placeholder = @"Time&Date";
        to_txt.backgroundColor = [UIColor clearColor];
        to_txt.delegate = self;
        [self addSubview:to_txt];
    }
    return self;
}
-(void)listFunction
{
    
}
-(void)mapFunction
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
    [UIView setAnimationRepeatCount:0];
    [self setFrame:CGRectMake(0, -430, 320, 480)];
    [UIView commitAnimations];
    displayed = NO;
    [delegate setupGoogleMap];
}
-(void)setDistance
{
    printf("The distance is %f", distance_from_slider.value);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (displayed == NO)
    {
        startPoint = [[touches anyObject] locationInView:self];
        printf("%f\n%f", startPoint.y, self.frame.origin.y);
        [self setFrame:CGRectMake(0, startPoint.y - 905, 320, 480)];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (displayed == NO)
    {
        CGPoint cpoint = [[touches anyObject] locationInView:self];
        if (self.frame.origin.y < 0)
        {
            int DX = startPoint.y - cpoint.y;
            [self setFrame:CGRectMake(0, self.frame.origin.y - DX, 320, 480)];
        }
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint cpoint = [[touches anyObject] locationInView:self];
    if (self.frame.origin.y + 480 > 240 && displayed == NO)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
        [UIView setAnimationRepeatCount:0];
        [self setFrame:CGRectMake(0, 0, 320, 480)];
        [UIView commitAnimations];
        displayed = YES;
    }
    else if (self.frame.origin.y == 0 && displayed == YES && cpoint.y > 440)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
        [UIView setAnimationRepeatCount:0];
        [self setFrame:CGRectMake(0, -430, 320, 480)];
        [UIView commitAnimations];
        displayed = NO;
    }
    else if(self.frame.origin.y + 480 < 240 && self.frame.origin.y > -370 && displayed == NO)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
        [UIView setAnimationRepeatCount:0];
        [self setFrame:CGRectMake(0, -430, 320, 480)];
        [UIView commitAnimations];
        displayed = NO;
    }
    else if (self.frame.origin.y< -380 && displayed == NO && cpoint.y > 440)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
        [UIView setAnimationRepeatCount:0];
        [self setFrame:CGRectMake(0, 0, 320, 480)];
        [UIView commitAnimations];
        displayed = YES;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"] && textField == search_by_txt) {
        [search_by_txt resignFirstResponder];
    }
    else if([string isEqualToString:@"\n"] && textField == from_txt) {
        [from_txt resignFirstResponder];
    }
    else if([string isEqualToString:@"\n"] && textField == to_txt) {
        [to_txt resignFirstResponder];
    }
    return YES;
}
- (void)dealloc
{
    [background release];
    [search_by_txt release];
    [list_btn release];
    [map_btn release];
    [distance_from_you release];
    [distance_from_slider release];
    [total_value_lbl release];
    [total_value_slider release];
    [rate_per_hour_lbl release];
    [rate_slider release];
    [from_lbl release];
    [from_txt release];
    [to_lbl release];
    [to_txt release];
    [delegate release];
    [super dealloc];
}

@end
