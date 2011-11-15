//
//  UserExperienceProfileModule.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDisplayCell.h"


@interface UserExperienceProfileModule : UIView 
{
    UIImageView *module_header_background;
    UILabel *spam_your_friends_label;
    
}
-(id)initWithArray:(NSArray*)the_experiences;

@end
