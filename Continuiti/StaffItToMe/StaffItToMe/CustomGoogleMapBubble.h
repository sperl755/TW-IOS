//
//  CustomGoogleMapBubble.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomGoogleMapBubble : UIView 
{
    UIImageView *background;
    int position_in_job_array;
}

- (id)initWithFrame:(CGRect)frame andPos:(int)the_position;
@property (assign) SEL react_to_tap;
@property (nonatomic, retain) id delegate;
@end
