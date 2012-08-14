//
//  AlertLoadView.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AlertLoadView : UIView 
{
    UIImageView *load_background;
    UITextView *text_view;
    UIButton *remove_me;
}
- (id)initWithFrame:(CGRect)frame andText:(NSString*)the_string;

@end
