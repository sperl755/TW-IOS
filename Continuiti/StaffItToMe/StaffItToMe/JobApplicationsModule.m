//
//  JobApplicationsModule.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JobApplicationsModule.h"
#import "StaffItToMeAppDelegate.h"

@implementation JobApplicationsModule
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      /*  StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        // Initialization code
        //Create Header
        UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
        header_background = [[UIImageView alloc] initWithImage:header_image];
        header_background.frame = CGRectMake(0, 0, 310, 33);
        [self addSubview:header_background];
        
        //Create Header Label
        my_applications_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
        my_applications_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        my_applications_label.backgroundColor = [UIColor clearColor];
        [my_applications_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
        my_applications_label.text = @"Job Applications";
        [self addSubview:my_applications_label];
        
        //Create Job Count Label
        my_application_count_label = [[UILabel alloc] initWithFrame:CGRectMake(270, my_applications_label.frame.origin.y - 7, 60, 35)];
        my_application_count_label.textColor = [UIColor colorWithRed:140.0/255 green:162.0/255 blue:205.0/255 alpha:1.0];
        my_application_count_label.backgroundColor = [UIColor clearColor];
        [my_application_count_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]];
        NSMutableString *my_job_count_text = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%d", app_delegate.user_state_information.my_jobs.count]];
        [my_job_count_text appendString:@" jobs"];
        my_application_count_label.text = my_job_count_text;
        [self addSubview:my_application_count_label];
        [self setFrame:CGRectMake(5, 0, 310, 33)];*/
    }
    return self;
}
-(id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        //Request information about applications
        NSURL *url = [NSURL URLWithString:applied_job_url];
        ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
        [request_ror setRequestMethod:@"POST"];
        [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
        [request_ror setPostValue:[NSString stringWithFormat:@"%d", app_delegate.user_state_information.my_user_info.user_id] forKey:@"user_id"];
        [request_ror setTimeOutSeconds:30];
        [request_ror setDelegate:self];
        [request_ror startAsynchronous];
    }
    return self;
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    printf("\n\n\nThis is  your applied to jobs: %s\n\n\n\n", [[request responseString] UTF8String]);
    
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    // Initialization code
    //Create Header
    UIImage *header_image   = [UIImage imageNamed:@"module_header"];
    header_background       = [[UIImageView alloc] initWithImage:header_image];
    header_background.frame = CGRectMake(0, 0, 310, 33);
    [self addSubview:header_background];
    
    //Create Header Label
    my_applications_label                   = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
    my_applications_label.textColor         = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
    my_applications_label.backgroundColor   = [UIColor clearColor];
    my_applications_label.text              = @"Job Applications";
    [my_applications_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    [self addSubview:my_applications_label];
    
    //Create Job Count Label
    my_application_count_label = [[UILabel alloc] initWithFrame:CGRectMake(270, my_applications_label.frame.origin.y - 7, 60, 35)];
    my_application_count_label.textColor = [UIColor colorWithRed:140.0/255 green:162.0/255 blue:205.0/255 alpha:1.0];
    my_application_count_label.backgroundColor = [UIColor clearColor];
    [my_application_count_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10]];
    [self addSubview:my_application_count_label];
    [self setFrame:CGRectMake(5, 0, 310, 33)];
    
    NSArray *applied_to_job_array = [[NSArray alloc] initWithArray:[[request responseString] JSONValue]];
    
    if (applied_to_job_array.count < 1)
    {
        JobDisplayCell *no_info = [[JobDisplayCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) pictureURL:@"" name:@"Not available" description:@"" detail:@""];
        [no_info removeArrow];
        [self addSubview:no_info];
        no_info.frame = CGRectMake(0, header_background.frame.origin.y + header_background.frame.size.height, 310, 33);
        [self setFrame:CGRectMake(5, 0, 310, (no_info.frame.origin.y + no_info.frame.size.height) - header_background.frame.origin.y)];
        [header_background removeFromSuperview];
    }
    else
    {
        int height = 0;
        for (int i = 0; i < applied_to_job_array.count; i++)
        {
            NSMutableString *string = [[NSMutableString alloc] initWithString:@"Applied at: "];
            [string appendString:[[applied_to_job_array objectAtIndex:i] objectForKey:@"applied_at"]];
            JobDisplayCell *no_info = [[JobDisplayCell alloc] initWithFrame:CGRectMake(0, i * 42, 0, 0) pictureURL:@"" name:[[applied_to_job_array objectAtIndex:i] objectForKey:@"title"] description:string detail:@""];
            [no_info removeArrow];
            if (i == applied_to_job_array.count - 1)
            {
                [no_info setBackgroundImageToModuleRowLast];
            }
            no_info.frame = CGRectMake(0, (header_background.frame.origin.y + header_background.frame.size.height) + (i*42), 310, 42);
            [self addSubview:no_info];
            height += 42;
            
        }
        NSMutableString *my_job_count_text = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%d", applied_to_job_array.count]];
        [my_job_count_text appendString:@" jobs"];
        my_application_count_label.text = my_job_count_text;
        //set The frame of this module.
        [self setFrame:CGRectMake(5, 0, 310, header_background.frame.size.height + height)]; 
    }
    [delegate reloadTableData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
