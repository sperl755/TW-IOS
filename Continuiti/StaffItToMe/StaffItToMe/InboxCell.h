//
//  InboxCell.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InboxCell : UIView 
{
    
    UIImageView *module_row_one_background;
    UIImageView *job_one_picture;
    UILabel *job_one_name;
    UILabel *job_one_description;
    UIImageView *arrow;
    UILabel *detail;
}

-(id)initwithDetail:(NSString*)the_detail andArrow:(BOOL)arrow_on senderName:(NSString*)the_sender_name;
@end
