//
//  JobSummaryModule.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JobSummaryModule : UIView 
{
    UIImageView *module_header_background;
    UILabel *spam_your_friends_label;
    UIImageView *module_row_one_background;
    UITextView *my_summary_text;
    
}

-(id)initWithSummary:(NSString*)the_summary;
-(void)setupGUI:(NSString*)the_summary;
@end
