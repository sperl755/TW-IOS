//
//  JobSkillsModule.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JobSkillsModule : UIView
{
    UIImageView *module_header_background;
    UILabel *spam_your_friends_label;
    
}

-(id)initWithArray:(NSArray*)the_skill_data;
@end
