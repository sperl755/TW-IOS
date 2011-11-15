//
//  ASSLider.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ASSLider.h"


@implementation ASSLider
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame andMaxValue:(double)the_max_value minValue:(double)the_min_value
{
    self = [super initWithFrame:frame];
    if (self) {
        // Figure out how to esitimate value
        my_max_value = the_max_value;
        my_min_value = the_min_value;
        my_increase_distance = self.frame.size.width / (my_max_value - my_min_value);
        
        //Create background slider bar
        UIImage *slider_back = [UIImage imageNamed:@"SliderBackground"];
        UIImage *stretchable_slider_back = [slider_back stretchableImageWithLeftCapWidth:(slider_back.size.width/2)-1 topCapHeight:(slider_back.size.height/2)-1];
        my_bar_image = [[UIImageView alloc] initWithImage:stretchable_slider_back];
        my_bar_image.frame = CGRectMake(0, 25, self.frame.size.width, 3.5);
        [self addSubview:my_bar_image];
        
        //Create thumb
        my_thumb_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SliderThumb"]];
        my_thumb_image.frame = CGRectMake(0, 0, 36.5, 25.5);
        my_thumb_image.center = CGPointMake(my_bar_image.frame.origin.x, my_bar_image.center.y);
        [self addSubview:my_thumb_image];
        
        //Create Value Display
        my_value_display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SliderValueIndicator"]];
        my_value_display.frame = CGRectMake(0, 0, 39.5, 29.5);
        my_value_display.center = CGPointMake(my_bar_image.frame.origin.x + my_bar_image.frame.size.width, my_thumb_image.center.y - 20);
        [self addSubview:my_value_display];
        
        my_value_display_text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 25)];
        my_value_display_text.center = CGPointMake(my_value_display.center.x, my_value_display.center.y);
        my_value_display_text.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        my_value_display_text.textAlignment = UITextAlignmentCenter;
        my_value_display_text.backgroundColor = [UIColor clearColor];
        [my_value_display_text setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
        NSMutableString *value_text = [[NSMutableString alloc] initWithString:@"$"];
        int min_value = (int) the_min_value;
        [value_text appendString:[NSString stringWithFormat:@"%d", min_value]];
        my_value_display_text.text = value_text;
        [self addSubview:my_value_display_text];
    }
    return self;
}
-(void)hideValueDisplay
{
    [my_value_display removeFromSuperview];
    [my_value_display_text removeFromSuperview];
}
-(double)getMinValue
{
    return my_min_value;
}
-(CGRect)getThumbFrame
{
    return my_thumb_image.frame;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touch_point = [touch locationInView:self];
    my_previous_x = touch_point.x;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touch_point = [touch locationInView:self];
    double distance = touch_point.x - my_previous_x;
    if ((my_thumb_image.center.x + distance) > self.frame.size.width || my_thumb_image.center.x + distance < 0)
    {
        return;
    }
    
    my_previous_x = touch_point.x;
    my_thumb_image.center = CGPointMake(my_thumb_image.center.x + distance, my_thumb_image.center.y);
    my_value_display.center = CGPointMake(my_thumb_image.center.x, my_thumb_image.center.y - 20);
    NSMutableString *value_text = [[NSMutableString alloc] initWithString:@"$"];
    int current_value = (int) my_current_value;
    [value_text appendString:[NSString stringWithFormat:@"%d", current_value]];
    my_value_display_text.text = value_text;
    my_value_display_text.center = CGPointMake(my_value_display.center.x, my_value_display.center.y);
    my_current_value = (my_thumb_image.center.x / my_increase_distance) + my_min_value;
    [delegate reactToASSliderValueChange:my_current_value];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    my_value_display.center = CGPointMake(my_thumb_image.center.x, my_thumb_image.center.y - 20);
    NSMutableString *value_text = [[NSMutableString alloc] initWithString:@"$"];
    int current_value = (int) my_current_value;
    [value_text appendString:[NSString stringWithFormat:@"%d", current_value]];
    my_value_display_text.text = value_text;
    my_value_display_text.center = CGPointMake(my_value_display.center.x, my_value_display.center.y);
}
-(double)getCurrentValue
{
    return my_current_value;
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
