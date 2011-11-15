//
//  JobInformationHeader.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JobInformationHeader.h"
#import "StaffItToMeAppDelegate.h"


@implementation JobInformationHeader
@synthesize delegate;
static NSString *job_apply_address = @"https://helium.staffittome.com/apis/submit_application";
static NSString *job_company_info_address = @"https://helium.staffittome.com/apis/view_company";

-(id)initWithPos:(int)the_position
{
    if ((self = [super init]))
    {
        header_shadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        header_shadow.image = [UIImage imageNamed:@"header_shadow"];
        [self addSubview:header_shadow];
        StaffItToMeAppDelegate *app_delegate = [[UIApplication sharedApplication] delegate];
        //Setup the available switch background.
        my_available_switch_background = [[UIImageView alloc] initWithFrame:CGRectMake(250, 10, 70, 60)];
        [my_available_switch_background setImage:[UIImage imageNamed:@"distance_box"]];
        [self addSubview:my_available_switch_background];
        //setup company name
        distance_from_user = [[UILabel alloc] initWithFrame:CGRectMake(my_available_switch_background.frame.origin.x, my_available_switch_background.frame.origin.y + 20, 70, 40)];
        distance_from_user.textAlignment = UITextAlignmentCenter;
        distance_from_user.backgroundColor = [UIColor clearColor];
        distance_from_user.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12];
        distance_from_user.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        int distance_text_user = (int)[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] job_distance];
        NSMutableString *distance_text = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%d", distance_text_user]];
        [distance_text appendString:@" mi"];
        
        distance_from_user.text = distance_text;
        [self addSubview:distance_from_user];
        
        //Setup Containers.
        //setup prof pic
        my_profile_picture = [[UIImageView alloc] initWithFrame:CGRectMake(5, 14, 48, 50)];
        [self addSubview:my_profile_picture];
        
        //setup cover that makes thing nicer
        my_profile_shiner = [UIButton buttonWithType:UIButtonTypeCustom];
        my_profile_shiner.frame = CGRectMake(0, 9, 58, 60);
        [my_profile_shiner setBackgroundImage:[UIImage imageNamed:@"profile_pic_overlay"] forState:UIControlStateNormal];
        [my_profile_shiner addTarget:self action:@selector(goToCompanyPage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:my_profile_shiner];
        
        
        
        //setup user name
        my_profile_name = [[UILabel alloc] initWithFrame:CGRectMake(63, 13, 100, 22)];
        my_profile_name.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12];
        [self addSubview:my_profile_name];
        //setup company name
        company_name = [[UILabel alloc] initWithFrame:CGRectMake(63, my_profile_name.frame.origin.y + 13, 100, 22)];
        company_name.backgroundColor = [UIColor clearColor];
        company_name.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        [self addSubview:company_name];
        //SetupButton
        my_connection_button = [UIButton buttonWithType:UIButtonTypeCustom];
        my_connection_button.frame = CGRectMake(63, 42, 60, 22);
        [my_connection_button setBackgroundImage:[UIImage imageNamed:@"connections_box"] forState:UIControlStateNormal];
        [my_connection_button addTarget:delegate action:@selector(sendApplication) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:my_connection_button];
        //setupButtonLabel
        connections_label = [[UILabel alloc] initWithFrame:CGRectMake(my_connection_button.frame.origin.x, my_connection_button.frame.origin.y + 1, 60, 22)];
        [self addSubview:connections_label];
        
        
        //Set User Profile Picture
        [my_profile_picture setImage:[UIImage imageNamed:@"default_company"]];
        
        //Display users display name
        my_profile_name.text = [[app_delegate.user_state_information.job_array objectAtIndex:the_position] title];
        company_name.text = [[app_delegate.user_state_information.job_array objectAtIndex:the_position] company];
        company_name.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        my_profile_name.backgroundColor = [UIColor clearColor];
        connections_label.backgroundColor = [UIColor clearColor];
        connections_label.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:10];
        NSMutableString *connections_text = [[NSMutableString alloc] init];
        connections_label.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        [connections_text appendString:@"Apply"];
        connections_label.textAlignment = UITextAlignmentCenter;
        [connections_label setText:connections_text];
        [self setFrame:CGRectMake(0, 0, 320, 80)];
        company_information = NO;
        
    }
    return self;
}
-(void)tapped:(id)sender {
	NSLog(@"See a tap gesture");
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    printf("\n\n\n\n\n\nThis is the application response: %s\n\n", [[request responseString] UTF8String]);
    [load_message dismissWithClickedButtonIndex:0 animated:YES];
    if (company_information)
    {
        [delegate respondToCompanyTouch:[request responseString]];
         company_information = NO;
         return;
    }
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
-(void)goToCompanyPage
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
	//Acesss the server with application params
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_company_info_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setValidatesSecureCertificate:NO];
    [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    NSString *the_id = [NSString stringWithFormat:@"%d", [[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] job_id]];
    [request setPostValue:the_id forKey:@"id"];
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
    company_information = YES;
}
-(void)sendApplication
{
	StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
	//Acesss the server with application params
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_apply_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setValidatesSecureCertificate:NO];
    [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    NSString *the_id = [NSString stringWithFormat:@"%d", [[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] job_id]];
    [request setPostValue:the_id forKey:@"job_id"];
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