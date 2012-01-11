//
//  JobSuggestionsModule.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JobSuggestionsModule.h"
#import "StaffItToMeAppDelegate.h"

@implementation JobSuggestionsModule
@synthesize delegate;
static NSString *job_suggestion_rl = @"https://helium.staffittome.com/apis/job_suggestion";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
-(id)init
{
    if ((self = [super init])) {
        // Initialization code
        
        //Create Header
        UIImage *header_image           = [UIImage imageNamed:@"module_header.png"];
        module_header_background        = [[UIImageView alloc] initWithImage:header_image];
        module_header_background.frame  = CGRectMake(0, 0, 310, 32);
        [self addSubview:module_header_background];
        
        //create label for this module
        job_suggestion_label                    = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
        job_suggestion_label.textColor          = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        job_suggestion_label.backgroundColor    = [UIColor clearColor];
        job_suggestion_label.text               = @"Job Discovery";
        job_suggestion_label.font               = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
        [self addSubview:job_suggestion_label];
        
        //Create button on far right for shuffling.
        shuffle_button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *shuffle_image = [UIImage imageNamed:@"arrows.png"];
        [shuffle_button setImage:shuffle_image forState:UIControlStateNormal];
        shuffle_button.frame = CGRectMake(250, 5, 50, 22);
        [shuffle_button addTarget:self action:@selector(scrollThroughJobs) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shuffle_button];
        //[shuffle_image release];
        
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        //Perform the accessing of the server.
        NSURL *url = [NSURL URLWithString:job_suggestion_rl];
        ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
        [request_ror setRequestMethod:@"GET"];
        [request_ror setValidatesSecureCertificate:NO];
        [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
        [request_ror setTimeOutSeconds:30];
        [request_ror setDelegate:self];
        [request_ror startAsynchronous];
        information_loaded = NO;
        /*
         Set Frame of this module
         */
        [self setFrame:CGRectMake(5, 0, 310, 160)];
        current_suggested_job_position = 0;
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    UITouch *touch = [touches anyObject];
    CGPoint touch_locale = [touch locationInView:self];
    if (touch_locale.y > module_row_one_background.frame.origin.y && touch_locale.y < module_row_two_background.frame.origin.y)
    {
        for (int i = 0; i < app_delegate.user_state_information.my_suggested_jobs.count; i++)
        {
            if ([job_one_name.text isEqualToString:[[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:i] title]]) {
                app_delegate.user_state_information.current_suggested_job_in_array = i;
            }
        }
    }
    else if (touch_locale.y > module_row_two_background.frame.origin.y)
    {
        for (int i = 0; i < app_delegate.user_state_information.my_suggested_jobs.count; i++)
        {
            if ([job_two_name.text isEqualToString:[[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:i] title]]) {
                app_delegate.user_state_information.current_suggested_job_in_array = i;
            }
        }
    }
    [delegate respondToSuggestionSelection];
}
-(void)oneSelected
{
    printf("HELLO");
}
-(void)twoSelected
{
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate.user_state_information populateSuggestedJobsArrayWithString:[request responseString]];
    if (app_delegate.user_state_information.my_suggested_jobs.count < 3)
    {
        [self removeFromSuperview];
        return;
    }
    //Create Row 1
    //module_row_one_background = [UIButton buttonWithType:UIButtonTypeCustom];
    //[module_row_one_background setImage:[UIImage imageNamed:@"module_row"] forState:UIControlStateNormal];
    //[module_row_one_background addTarget:self action:@selector(oneSelected) forControlEvents:UIControlEventTouchUpInside];
    module_row_one_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"module_row"]];
    module_row_one_background.frame = CGRectMake(0, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, 42);
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
    
    if (app_delegate.user_state_information.my_suggested_jobs.count >= 1)
    {
        job_one_name.text           = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:current_suggested_job_position] title];
        job_one_description.text    = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:current_suggested_job_position] company];
    }
    else
    {
        job_one_name.text           = @"";
        job_one_description.text    = @"";
    }
    
    //Create Row 2
    module_row_two_background       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"module_row_last"]];
    module_row_two_background.frame = CGRectMake(0, module_row_one_background.frame.origin.y + module_row_one_background.frame.size.height,  310, 42);
    [self addSubview:module_row_two_background];
    
    [self setFrame:CGRectMake(5, 0, 310, (module_row_two_background.frame.size.height + module_row_two_background.frame.origin.y) - module_header_background.frame.origin.y)]; 
    
    arrow_two       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_following"]];
    arrow_two.frame = CGRectMake(module_row_one_background.frame.origin.x + module_row_one_background.frame.size.width - 23.5, module_row_one_background.frame.origin.y + 15 + module_row_one_background.frame.size.height,12, 12);
    [self addSubview:arrow_two];
    
    //Setup the second job suggestions information.
    job_two_picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_company"]];
    [job_two_picture setFrame:CGRectMake(module_row_two_background.frame.origin.x + 10, module_row_two_background.frame.origin.y + 8, 25, 25)];
    [self addSubview:job_two_picture];
    
    job_two_overlay         = [[UIImageView alloc] initWithFrame:job_two_picture.frame];
    job_two_overlay.image   = [UIImage imageNamed:@"50x50_overlay"];
    [self addSubview:job_two_overlay];
    
    job_two_name                    = [[UILabel alloc] initWithFrame:CGRectMake(job_two_picture.frame.origin.x + job_two_picture.frame.size.width + 10, job_two_picture.frame.origin.y-2, 200, 20)];
    job_two_name.backgroundColor    = [UIColor clearColor];
    job_two_name.font               = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:10];
    [self addSubview:job_two_name];
    
    job_two_description                 = [[UILabel alloc] initWithFrame:CGRectMake(job_two_name.frame.origin.x, job_two_name.frame.origin.y + job_two_name.frame.size.height - 10, 200, 30)];
    job_two_description.backgroundColor = [UIColor clearColor];
    job_two_description.font            = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
    job_two_description.textColor       = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
    [self addSubview:job_two_description];
    
    if (app_delegate.user_state_information.my_suggested_jobs.count >= 2)
    {
        job_two_name.text           = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:current_suggested_job_position + 1] title];
        job_two_description.text    = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:current_suggested_job_position + 1] company];   
    }
    else
    {
        job_two_name.text           = @"";
        job_two_description.text    = @"";
    }
    information_loaded = YES;
    [delegate finishedLoadingSuggestedJob];
    [self setFrame:CGRectMake(5, 0, 310, 160)];
}
-(void)scrollThroughJobs
{
    if (!information_loaded)
    {
        return;
    }
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    if (app_delegate.user_state_information.my_suggested_jobs.count < 2)
    {
        return;
    }
    //If there is more in the array display it.
    if (current_suggested_job_position + 1 < app_delegate.user_state_information.my_suggested_jobs.count)
    { 
        current_suggested_job_position++; 
        job_one_name.text = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:current_suggested_job_position] title];
        job_one_description.text = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:current_suggested_job_position] company];  
        job_two_name.text = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:current_suggested_job_position + 1] title];
        job_two_description.text = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:current_suggested_job_position + 1] company]; 
    }
    else
    {//Else just bring it back to the beginning of the array.
        current_suggested_job_position = 0;
        job_one_name.text = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:current_suggested_job_position] title];
        job_one_description.text = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:current_suggested_job_position] company];  
        job_two_name.text = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:current_suggested_job_position + 1] title];
        job_two_description.text = [[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:current_suggested_job_position + 1] company];  
    }
}
- (void)dealloc
{
    [super dealloc];
}

@end
