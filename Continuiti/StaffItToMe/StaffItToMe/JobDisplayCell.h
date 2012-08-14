//
//  JobDisplayCell.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JobDisplayCell : UIView
{
    UIImageView *module_row_one_background;
    UIImageView *job_one_picture;
    UILabel *job_one_name;
    UILabel *job_one_description;
    UIImageView *arrow;
    UILabel *detail;
    
}
- (id)initWithFrame:(CGRect)frame pictureURL:(NSString*)picture_url name:(NSString*)the_name description:(NSString*)the_description detail:(NSString*)the_detail;
-(void)removeArrow;
-(void)setBackgroundImageToModuleRowLast;

@end
