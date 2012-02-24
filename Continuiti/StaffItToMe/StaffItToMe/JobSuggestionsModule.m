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
        
        
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        //Perform the accessing of the server.
        NSURL *url = [NSURL URLWithString:[[URLLibrary sharedInstance] getJobSuggestionsLink]];
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
        index_beginning = 0;
        
    }
    return self;
}
-(void)oneSelected
{
}
-(void)twoSelected
{
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
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
    [app_delegate.user_state_information populateSuggestedJobsArrayWithString:[request responseString]];
    
    if (app_delegate.user_state_information.my_suggested_jobs.count < 3)
    {
        [module_header_background removeFromSuperview];
        [job_suggestion_label removeFromSuperview];
        [shuffle_button removeFromSuperview];
        [self removeFromSuperview];
        [delegate finishedLoadingSuggestedJob];
        return;
    }
    
    cell_array = [[NSMutableArray alloc] initWithCapacity:app_delegate.user_state_information.my_suggested_jobs.count];
    
    if (app_delegate.user_state_information.my_suggested_jobs.count >= 4) {
        index_end = 4;
        array_size = 4;
    }
    else {
        index_end = app_delegate.user_state_information.my_suggested_jobs.count;
        array_size = index_end;
    }
    
    int height = module_header_background.frame.size.height + module_header_background.frame.origin.y;
    
    for (int i = index_beginning; i < index_end; i++)
    {
        SuggestionModuleCell *cell  = [[SuggestionModuleCell alloc] initWithFrame:CGRectZero andJobSuggestionIndex:index_beginning + i];
        cell.frame                  = CGRectMake(0,height, 310, 42);
        cell.delegate = self;
        [cell_array addObject:cell];
        [self addSubview:cell];
        
        height += 42;
    }
    
    [self setFrame:CGRectMake(5, 0, 310, height)];
    information_loaded = YES;
    [delegate finishedLoadingSuggestedJob];
}
-(void)respondToTouchWithIndex:(int)the_index andJobTitle:(NSString *)the_title
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    for (int i = 0; i < app_delegate.user_state_information.my_suggested_jobs.count; i++)
    {
        if ([the_title isEqualToString:[[app_delegate.user_state_information.my_suggested_jobs objectAtIndex:i] title]]) {
            app_delegate.user_state_information.current_suggested_job_in_array = i;
            break;
        }
    }
    [delegate respondToSuggestionSelection];
}
-(void)scrollThroughJobs
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (index_beginning + 1 >= app_delegate.user_state_information.my_suggested_jobs.count) {
        
        index_beginning = 0;
        if (app_delegate.user_state_information.my_suggested_jobs.count >= 4) {
            index_end = 4;
        }
        else {
            index_end = app_delegate.user_state_information.my_suggested_jobs.count;
        }
    }
    index_beginning += 1;
    index_end += 1;
    
    for (int i = 0; i < array_size; i++)
    {
        if (index_beginning + i >= app_delegate.user_state_information.my_suggested_jobs.count)
        {
            [[cell_array objectAtIndex:i] changeIndex:(index_beginning + i) - app_delegate.user_state_information.my_suggested_jobs.count];   
        }
        else
        {
            [[cell_array objectAtIndex:i] changeIndex:index_beginning + i];   
        }
    }
    
}
- (void)dealloc
{
    [super dealloc];
}

@end
