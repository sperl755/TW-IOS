//
//  ASSwitch.h
//  Switch
//
//  Created by Anthony Sierra on 8/18/11.
//  Copyright 2011.  All rights reserved.
//  Files may be altered however must not be distributed after alteration.
//

#import <UIKit/UIKit.h>
@protocol ASSwitchDelegateProtocol <NSObject>
-(void)respondToOffHappening;
-(void)respondToOnHappening;
@end

@interface ASSwitch : UIView 
{
    UIImageView *on_image;
    UIImageView *off_image;
    UIImageView *slider;
    BOOL on;
    //This variable tracks whether they clicked the switch or not.
    int click;
    CGPoint start_point;
}
- (id)initWithFrame:(CGRect)frame andOnImage:(UIImage*)the_on_image offImage:(UIImage*)the_off_image sliderImage:(UIImage*)the_slider_image;
-(BOOL)isOn;

-(void)setOn:(BOOL)the_value;
-(void)setOnWithoutDelegateCall:(BOOL)the_value;
@property (nonatomic, retain) id <ASSwitchDelegateProtocol> delegate;
@end
/*
 Information
 
 * This class starts as off.
 * The class when changed triggeres the function respondToOffHappening and
 * respondToOnHappening.
*/