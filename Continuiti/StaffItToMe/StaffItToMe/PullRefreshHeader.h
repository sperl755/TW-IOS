//
//  PullRefreshHeader.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PullRefreshHeader : UIView
{
    UIImageView *header_shadow;
    UIImageView *arrow;
    UILabel *label;
    
    CGPoint old_content_offset;
    float angle;
    BOOL loaded;
    UIActivityIndicatorView *activity;
}
-(BOOL)isLoaded;
-(void)rotate:(CGPoint)the_point;
-(void)reset;
@end
