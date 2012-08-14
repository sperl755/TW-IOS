//
//  UserEducationsModule.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserEducationsModule : UIView
{
    UIImageView *module_header_background;
    UILabel *spam_your_friends_label;   
}
-(id)initWithArray:(NSArray*)the_experiences;

@end
