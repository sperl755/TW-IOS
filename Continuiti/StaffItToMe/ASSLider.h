//
//  ASSLider.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ASSliderProtocol <NSObject>
-(void)reactToASSliderValueChange:(double)the_slider_value;
@end


@interface ASSLider : UIView 
{
    double my_current_value;
    double my_max_value;
    double my_min_value;
    double my_increase_distance;
    UIImageView *my_bar_image;
    UIImageView *my_thumb_image;
    UIImageView *my_value_display;
    
    UILabel *my_value_display_text;
    
    //Movement realization
    double my_previous_x;
    
}
- (id)initWithFrame:(CGRect)frame andMaxValue:(double)the_max_value minValue:(double)the_min_value;
-(double)getCurrentValue;
-(CGRect)getThumbFrame;
-(double)getMinValue;
-(void)hideValueDisplay;
@property (nonatomic, retain) id <ASSliderProtocol> delegate;
@end
