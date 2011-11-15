//
//  MyJobDisplayCell.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyJobDisplayCellProtocol <NSObject>
-(void)reactToManualButton:(int)array_position;
-(void)reactToCheckinButton:(int)array_position;
@end


@interface MyJobDisplayCell : UIView 
{
    UIImageView *module_row_one_background;
    UIImageView *job_one_picture;
    UILabel *job_one_name;
    UILabel *job_one_description;
    UILabel *check_in_out_label;
    UIButton *manual_button;
    UIButton *checkin_button;
    int array_position;
    
    BOOL checkin_in;
    
    //Loading message
    UIAlertView *load_message;
    
    //Timer for show
    UILabel *timer_display;
    int second_count;
    int minute_count;
    int hour_count;
    BOOL timer_done;
}
@property (nonatomic, retain) id <MyJobDisplayCellProtocol> delegate;
- (id)initWithFrame:(CGRect)frame urlString:(NSString*)the_url name:(NSString*)the_name description:(NSString*)the_description arrayPosition:(int)the_position;
-(void)setBackgroundImageToModuleLast;
-(void)setCheckedInWithTime:(NSString*)the_time;
@end
