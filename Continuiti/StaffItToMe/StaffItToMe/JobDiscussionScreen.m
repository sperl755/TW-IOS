//
//  JobDiscussionScreen.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JobDiscussionScreen.h"
#import "StaffItToMeAppDelegate.h"
#import "ASIFormDataRequest.h"


@implementation JobDiscussionScreen
static NSString *create_message_address = @"http://hydrogen.xen.exoware.net:3000/apis/create_message";
-(id)init
{
    if ((self = [super init]))
    {
        
        StaffItToMeAppDelegate *application_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSMutableString *job_details = [[NSMutableString alloc] initWithString:@"Start Time: "];
        [job_details appendString:[[application_delegate.user_state_information.job_array objectAtIndex:application_delegate.user_state_information.current_job_in_array] task_start_time]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Start Date: "];
        [job_details appendString:[[application_delegate.user_state_information.job_array objectAtIndex:application_delegate.user_state_information.current_job_in_array] task_start_date]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Description: "];
        [job_details appendString:[[application_delegate.user_state_information.job_array objectAtIndex:application_delegate.user_state_information.current_job_in_array] job_description]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Created at: "];
        [job_details appendString:[[application_delegate.user_state_information.job_array objectAtIndex:application_delegate.user_state_information.current_job_in_array] created_at]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Duration: "];
        [job_details appendString:[[application_delegate.user_state_information.job_array objectAtIndex:application_delegate.user_state_information.current_job_in_array] job_duration]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Hour Per Week: "];
        [job_details appendString:[[application_delegate.user_state_information.job_array objectAtIndex:application_delegate.user_state_information.current_job_in_array] hours_per_week]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Start Time: "];
        [job_details appendString:[[application_delegate.user_state_information.job_array objectAtIndex:application_delegate.user_state_information.current_job_in_array] task_start_time]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Company: "];
        [job_details appendString:[[application_delegate.user_state_information.job_array objectAtIndex:application_delegate.user_state_information.current_job_in_array] company]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Company Description: "];
        [job_details appendString:[[application_delegate.user_state_information.job_array objectAtIndex:application_delegate.user_state_information.current_job_in_array] company_description]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Compensation: "];
        [job_details appendString:[[application_delegate.user_state_information.job_array objectAtIndex:application_delegate.user_state_information.current_job_in_array] compensation]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Skills Needed: "];
        [job_details appendString:[[application_delegate.user_state_information.job_array objectAtIndex:application_delegate.user_state_information.current_job_in_array] skills]];
        [job_details appendString:@"\n"];
        
        //Display description of job
        description_txt = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, 310, 150)];
        description_txt.text = job_details;
        [description_txt setEditable:NO];
        description_txt.font = [UIFont fontWithName:@"Times New Roman" size:18];
        [self.view addSubview:description_txt];
        
        //Display text box for user to type in message
        your_message_txt = [[UITextView alloc] initWithFrame:CGRectMake(5, 185, 310, 150)];
        your_message_txt.text = @"Enter your message";
        your_message_txt.font = [UIFont fontWithName:@"Times New Roman" size:18];
        your_message_txt.delegate = self;
        [self.view addSubview:your_message_txt];
        
        send_message_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        send_message_btn.frame = CGRectMake(130, 320, 120, 55);
        [send_message_btn setTitle:@"Send Message" forState:UIControlStateNormal];
        [send_message_btn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:send_message_btn];
    }
    return self;
}
-(void)removeKeyboard
{
    self.navigationItem.rightBarButtonItem = nil;
    description_txt.center = CGPointMake(description_txt.center.x, description_txt.center.y + 130);
    your_message_txt.center = CGPointMake(your_message_txt.center.x, your_message_txt.center.y + 130);
    [your_message_txt resignFirstResponder];
}
-(void)sendMessage
{
	StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
	//Acesss the server with solr parameters
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:create_message_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request setPostValue:your_message_txt.text forKey:@"body"];
    [request setPostValue:
	 [NSString stringWithFormat:@"%d",[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] job_id]] forKey:@"messageable_id"];
    [request setPostValue:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] user_id] forKey:@"recipient_id"];
    //[request setPostValue:@"1" forKey:@"recipient_id"];
	[request setPostValue:@"Job"  forKey:@"messageable_type"];
	[request setPostValue:@"Inquiry" forKey:@"subject"];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
    //show a alertview that we are accessing the credentials and talking to the server.
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
	[load_message dismissWithClickedButtonIndex:0 animated:YES];
    if ([[request responseString] isEqualToString:@"Message has been sent."]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MessageSent" object:nil];
    }
    else {
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error" message:[request responseString] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[message show];
		[message release];
        
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    UIBarButtonItem *rightDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(removeKeyboard)];
    self.navigationItem.rightBarButtonItem = rightDone;
    [rightDone release];
    description_txt.center = CGPointMake(description_txt.center.x, description_txt.center.y - 130);
    your_message_txt.center = CGPointMake(your_message_txt.center.x, your_message_txt.center.y - 130);
}
@end
