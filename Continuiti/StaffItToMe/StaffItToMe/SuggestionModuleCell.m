//
//  SuggestionModuleCell.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SuggestionModuleCell.h"
#import "StaffItToMeAppDelegate.h"

@implementation SuggestionModuleCell
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame andJobSuggestionIndex:(int)the_index
{
    self = [super initWithFrame:frame];
    if (self) {
        my_index = the_index;
        module_row_one_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"module_row"]];
        module_row_one_background.frame = CGRectMake(0, 0, 310, 42);
        [self addSubview:module_row_one_background];
        
        //Setup the first job suggestions information.
        job_one_picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_company"]];
        [job_one_picture setFrame:CGRectMake(module_row_one_background.frame.origin.x + 10, module_row_one_background.frame.origin.y + 8, 25, 25)];
        [self addSubview:job_one_picture];
        
        job_one_overlay         = [[UIImageView alloc] initWithFrame:job_one_picture.frame];
        job_one_overlay.image   = [UIImage imageNamed:@"50x50_overlay"];
        [self addSubview:job_one_overlay];
        
        job_one_name                    = [[UILabel alloc] initWithFrame:CGRectMake(job_one_picture.frame.origin.x + job_one_picture.frame.size.width + 10, job_one_picture.frame.origin.y-2, 200, 20)];
        job_one_name.backgroundColor    = [UIColor clearColor];
        job_one_name.font               = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:10];
        [self addSubview:job_one_name];
        
        job_one_description                 = [[UILabel alloc] initWithFrame:CGRectMake(job_one_name.frame.origin.x, job_one_name.frame.origin.y + job_one_name.frame.size.height - 10, 200, 30)];
        job_one_description.textColor       = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        job_one_description.backgroundColor = [UIColor clearColor];
        job_one_description.font            = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        [self addSubview:job_one_description];
        
        
        arrow_one       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_following"]];
        arrow_one.frame = CGRectMake(module_row_one_background.frame.origin.x + module_row_one_background.frame.size.width - 23.5, module_row_one_background.frame.origin.y + 15, 12,12);
        [self addSubview:arrow_one];
        
        [self changeIndex:the_index];
        
        [self setFrame:CGRectMake(0, 0, 320, 42)];
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegate respondToTouchWithIndex:my_index andJobTitle:job_one_name.text];
}
-(BOOL)changeIndex:(int)index
{
    my_index = index;
    BOOL result = YES;
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    
    if ([[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:index] title] != nil) {
        
        job_one_name.text = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:index] title];   
    } else {result = NO;}
    
    if ([[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:index] company] != nil) {
        
        job_one_description.text    = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:index] company];
    } else {result = NO;};
    return result;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
