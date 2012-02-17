//
//  CompanySummary.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CompanySummary : UIView 
{
    UIImageView *module_header_background;
    UILabel *spam_your_friends_label;
    UIImageView *module_row_one_background;
    UITextView *my_summary_text;
}
-(id)initWithJSONDictionary:(NSDictionary*)the_json_info;

-(void)setupGUI:(NSString*)the_summary;
@end
