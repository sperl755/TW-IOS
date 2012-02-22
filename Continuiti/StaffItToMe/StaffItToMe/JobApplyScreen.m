//
//  JobApplyScreen.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JobApplyScreen.h"
#import "StaffItToMeAppDelegate.h"
#import "ASIFormDataRequest.h"

@implementation JobApplyScreen
static NSString *job_apply_address = @"http://hydrogen.xen.exoware.net:3000/apis/submit_application";
@synthesize delegate;
//Initializer for this class.
-(id)init
{
    if ((self = [super init]))
    {
		StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
		//Create distance from you and price label
		distance_and_price = [[UILabel alloc] initWithFrame:CGRectMake(5, 50, 300, 50)];
		NSMutableString *distance_contents = [[NSMutableString alloc] initWithString:@"Distance From you "];
		[distance_contents appendString:@"2"];//Here should actually be accessing the jSON file
		[distance_contents appendString:@" miles from you. "];
		[distance_contents appendString:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] job_duration]];
		distance_and_price.text = distance_contents;
		[self.view addSubview:distance_and_price];
		
		rate_lbl = [[UILabel alloc] initWithFrame:CGRectMake(5, distance_and_price.frame.origin.y + distance_and_price.frame.size.height, 100, 50)];
		rate_lbl.text = @"Rate: ";
		[self.view addSubview:rate_lbl];
		
		rate_txt = [[UITextField alloc] initWithFrame:CGRectMake(120, distance_and_price.frame.origin.y + distance_and_price.frame.size.height, 50, 50)];
		rate_txt.text = [[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] cost_estimate_per_hour];
        rate_txt.delegate = self;
		[self.view addSubview:rate_txt];
		
		rate_hr_lbl = [[UILabel alloc] initWithFrame:CGRectMake(175, distance_and_price.frame.origin.y + distance_and_price.frame.size.height, 100, 50)];
		rate_hr_lbl.text = @"\\hr";
		[self.view addSubview:rate_hr_lbl];
		
		start_at_lbl = [[UILabel alloc] initWithFrame:CGRectMake(5, rate_lbl.frame.origin.y + rate_lbl.frame.size.height, 100, 50)];
		start_at_lbl.text = @"Starting At: ";
		[self.view addSubview:start_at_lbl];
		
		start_at_txt = [[UITextView alloc] initWithFrame:CGRectMake(105, rate_lbl.frame.origin.y + rate_lbl.frame.size.height, 100, 50)];
		start_at_txt.text = [[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] task_start_date];
		start_at_txt.delegate = self;
		start_at_txt.userInteractionEnabled = NO;
		[self.view addSubview:start_at_txt];
		
		start_at_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		start_at_btn.frame = CGRectMake(210, rate_lbl.frame.origin.y + rate_lbl.frame.size.height, 50, 50);
		[start_at_btn addTarget:self action:@selector(displayDatePicker) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:start_at_btn];
		
        //Create button to click
        apply_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        apply_btn.frame = CGRectMake(5, start_at_lbl.frame.origin.y + start_at_lbl.frame.size.height, 200, 55);
        [apply_btn setTitle:@"Send Application" forState:UIControlStateNormal];
        [apply_btn addTarget:self action:@selector(sendApplication) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:apply_btn];
		
        //Display Job description
        NSMutableString *job_details = [[NSMutableString alloc] initWithString:@"Start Time: "];
        [job_details appendString:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] task_start_time]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Start Date: "];
        [job_details appendString:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] task_start_date]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Description: "];
        [job_details appendString:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] job_description]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Created at: "];
        [job_details appendString:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] created_at]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Duration: "];
        [job_details appendString:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] job_duration]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Hour Per Week: "];
        [job_details appendString:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] hours_per_week]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Start Time: "];
        [job_details appendString:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] task_start_time]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Company: "];
        [job_details appendString:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] company]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Company Description: "];
        [job_details appendString:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] company_description]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Compensation: "];
        [job_details appendString:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] compensation]];
        [job_details appendString:@"\n"];
        [job_details appendString:@"Skills Needed: "];
        [job_details appendString:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] skills]];
        [job_details appendString:@"\n"];
        description_txt = [[UITextView alloc] initWithFrame:CGRectMake(5, apply_btn.frame.origin.y + apply_btn.frame.size.height, 310, 100)];
        description_txt.text = job_details;
        [description_txt setEditable:NO];
        description_txt.font = [UIFont fontWithName:@"Times New Roman" size:18];
        [self.view addSubview:description_txt];
    }
    return self;
}
-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	UIDatePicker *picker = (UIDatePicker*)[actionSheet viewWithTag:131];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"MM/dd/YY";
	NSString *suggested_date = [formatter stringFromDate:picker.date];
	start_at_txt.text = suggested_date;
	[formatter release];
	[picker release];
	[actionSheet release];
}
-(void)displayDatePicker
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\nSuggest a date" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Set", nil];
	[actionSheet showInView:self.view];
	
	date_picker = [[UIDatePicker alloc] init];
	date_picker.tag = 131;
	date_picker.datePickerMode = UIDatePickerModeDate;
	[actionSheet addSubview:date_picker];
}
-(void)removeKeyboard
{/*
    [delegate hideApplyKeyboardDoneButton];
    //Checking if cover letter was the one clicked because if so then nothing happened.
    if (cover_letter_txt.frame.origin.y == 5)
    {
        [cover_letter_txt resignFirstResponder];
    }
    else
    {
        cover_letter_txt.center = CGPointMake(cover_letter_txt.center.x, cover_letter_txt.center.y + 100);
        resume_txt.center = CGPointMake(resume_txt.center.x, resume_txt.center.y + 100);
        [resume_txt resignFirstResponder];
		[self.view resignFirstResponder];
		if (date_picker != nil) {
			[date_picker removeFromSuperview];
			date_picker = nil;
		}
    }*/
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [load_view removeFromSuperview];
    if ([[request responseString] isEqualToString:@"Application has been successfully submitted."])
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"Your application was succesfully submitted!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message show];
        [message release];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationSent" object:nil];
    }
    else
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable To Send" message:[request responseString] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message show];
        [message release];
    }
}
-(void)sendApplication
{
	StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
	//Acesss the server with application params
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_apply_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    NSString *the_id = [NSString stringWithFormat:@"%d", [[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] job_id]];
    [request setPostValue:the_id forKey:@"job_id"];
    //[request setPostValue:@"14" forKey:@"job_id"];
    [request setPostValue:rate_txt.text forKey:@"rate"];
    [request setPostValue:start_at_txt.text forKey:@"start_date"];
    [request setPostValue:@"12:00:00" forKey:@"start_time"];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
    
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, -50, 320, 480)];
    [self.view addSubview:load_view];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL valid_input = YES;
    
    if([string isEqualToString:@"\n"] && textField == rate_txt) {
        [rate_txt resignFirstResponder];
        [self resignFirstResponder];
    }//if not 1-9 then say no
    else if ([string characterAtIndex:0] <48 || [string characterAtIndex:0] > 57)
    {
        valid_input = NO;
    }
    return valid_input;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    /*if (textView == resume_txt) {
        cover_letter_txt.center = CGPointMake(cover_letter_txt.center.x, cover_letter_txt.center.y - 100);
        resume_txt.center = CGPointMake(resume_txt.center.x, resume_txt.center.y - 100);
    }
	else*/ if (textView == start_at_txt)
	{
		[start_at_txt resignFirstResponder];
	}
    [delegate displayApplyKeyboardDoneButton];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
	if (textView == start_at_txt)
	{
		start_at_txt.text =[NSString stringWithFormat:@"%s",date_picker.date];
	}
}
-(void)dealloc
{
    [apply_btn release];
    [super dealloc];
}
@end
