//
//  AUserExperienceModule.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDisplayCell.h"


@interface AUserExperienceModule : UIView
{
    UIImageView *module_header_background;
    UILabel *spam_your_friends_label;
}
-(id)initWithArray:(NSArray*)the_experiences andName:(NSString*)the_user_name;

@end
