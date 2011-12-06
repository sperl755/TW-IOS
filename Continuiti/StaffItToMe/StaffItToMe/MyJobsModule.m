//
//  MyJobsModule.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyJobsModule.h"
#import "StaffItToMeAppDelegate.h"

@implementation MyJobsModule
@synthesize delegate;
static NSString *my_job_contracts_url = @"https://helium.staffittome.com/apis/my_job_contracts";
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        //Perform the accessing of the server.
        NSURL *url = [NSURL URLWithString:my_job_contracts_url];
        ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
        [request_ror setRequestMethod:@"POST"];
        [request_ror setValidatesSecureCertificate:NO];
        [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
        
        [request_ror setTimeOutSeconds:30];
        [request_ror setDelegate:self];
        [request_ror startAsynchronous];
        
    }
    return self;
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    height = 0;
    printf("\n\n\n This is the job contracts: %s\n\n\n", [[request responseString] UTF8String]);
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate.user_state_information populateMyJobArrayWithJSONString:[request responseString]];
    // Initialization code
    //Create Header
    UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
    module_header_background = [[UIImageView alloc] initWithImage:header_image];
    module_header_background.frame = CGRectMake(0, 0, 310, 33);
    height += module_header_background.frame.size.height;
    [self addSubview:module_header_background];
    
    //Create Header Label
    my_jobs_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
    my_jobs_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
    my_jobs_label.backgroundColor = [UIColor clearColor];
    [my_jobs_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    my_jobs_label.text = @"My Jobs";
    [self addSubview:my_jobs_label];
    
    //Create Job Count Label
    my_job_count_label = [[UILabel alloc] initWithFrame:CGRectMake(270, my_jobs_label.frame.origin.y - 5, 60, 35)];
    my_job_count_label.textColor = [UIColor colorWithRed:140.0/255 green:162.0/255 blue:205.0/255 alpha:1.0];
    my_job_count_label.backgroundColor = [UIColor clearColor];
    [my_job_count_label setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:10]];
    NSMutableString *my_job_count_text = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%d", app_delegate.user_state_information.my_jobs.count]];
    [my_job_count_text appendString:@" jobs"];
    my_job_count_label.text = my_job_count_text;
    [self addSubview:my_job_count_label];
    
    //Generate jobs
    for (int i = 0; i < app_delegate.user_state_information.my_jobs.count; i++)
    {
        MyJobDisplayCell *my_job_cell = [[MyJobDisplayCell alloc] initWithFrame:CGRectMake(module_header_background.frame.origin.x, module_header_background.frame.origin.y + module_header_background.frame.size.height + i * 42, 310, 42) urlString:@"" name:[[app_delegate.user_state_information.my_jobs objectAtIndex:i] title] description:[[app_delegate.user_state_information.my_jobs objectAtIndex:i] job_details] arrayPosition:i];
        //if the job is checked in then set the timer of my job_cell.
        if ([[[app_delegate.user_state_information.my_jobs objectAtIndex:i] my_checkin_chekcout_status] isEqualToString:@"checkedin"])
        {
            [my_job_cell setCheckedInWithTime:[[app_delegate.user_state_information.my_jobs objectAtIndex:i] start_date_time] manual:NO];
        }
        my_job_cell.delegate = self;
        if (i == app_delegate.user_state_information.my_jobs.count - 1)
        {
            [my_job_cell setBackgroundImageToModuleLast];
        }
        height += my_job_cell.frame.size.height;
        [self addSubview:my_job_cell];
    }
    [self setFrame:CGRectMake(5, 0, 310, module_header_background.frame.size.height + height)]; 
    /********THIS IS COMPLETELY TESTING GENERATION********************************/
    
    /*
    for (int i = 0; i < 3; i++)
    {
        MyJobDisplayCell *my_job_cell = [[MyJobDisplayCell alloc] initWithFrame:CGRectMake(module_header_background.frame.origin.x, module_header_background.frame.origin.y + module_header_background.frame.size.height + i * 42, 310, 42) urlString:@"" name:@"Marketer" description:@"Analyzing the public" arrayPosition:i];
        my_job_cell.delegate = self;
        height += my_job_cell.frame.size.height;
        [self addSubview:my_job_cell];
    }*/
    
    
    
    
    
    /********THIS IS THE END OF THE COMPLTELY TESTING GENERATION******************/
    [self setFrame:CGRectMake(5, 0, 310, height + 10)];
    
    if (app_delegate.user_state_information.my_jobs.count < 1)
    {
        UIButton *apply_to_jobs = [UIButton buttonWithType:UIButtonTypeCustom];
        [apply_to_jobs setBackgroundImage:[UIImage imageNamed:@"module_row_last"] forState:UIControlStateNormal];
        [apply_to_jobs setTitle:@"Apply To Job" forState:UIControlStateNormal];
        [apply_to_jobs.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:10]];
        apply_to_jobs.titleLabel.textAlignment = UITextAlignmentLeft;
        [apply_to_jobs setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [apply_to_jobs addTarget:self action:@selector(goToJobSearch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:apply_to_jobs];
        [apply_to_jobs setFrame:CGRectMake(0, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, 33)];
        [self setFrame:CGRectMake(5, 0, 310, 75)];
    }
    [delegate getApplications];
}
-(void)goToJobSearch
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    [app_delegate setCurrentTabBar:@"FindWork"];
}
-(void)reactToManualButton:(int)array_position
{
    [delegate manualButtonPressedOnJobInArrayPosition:array_position];
}
-(void)reactToCheckinButton:(int)array_position
{
    [delegate checkinButtonPressedOnJobInArrayPosition:array_position];
}

- (void)dealloc
{
    [super dealloc];
}

@end
