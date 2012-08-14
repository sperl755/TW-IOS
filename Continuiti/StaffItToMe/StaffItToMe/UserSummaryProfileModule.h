//
//  UserSummaryProfileModule.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserSummaryProfileModule : UIView
{
    UIImageView *module_header_background;
    UILabel *spam_your_friends_label;
    UIImageView *module_row_one_background;
    UILabel *user_summary_text;
}
-(id)initWithString:(NSString*)the_string;

@end
