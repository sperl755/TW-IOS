//
//  AUserSummaryModule.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AUserSummaryModule : UIView
{
    UIImageView *module_header_background;
    UILabel *spam_your_friends_label;
    UIImageView *module_row_one_background;
    UITextView *user_summary_text;
}
-(id)initWithString:(NSString*)the_string andName:(NSString*)user_name;

@end
