//
//  DashboardController.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DashboardController.h"
#import "StaffItToMeAppDelegate.h"
#define BACK_BUTTON_ID 45

@implementation DashboardController
@synthesize proposal_title;
@synthesize customer_name;
@synthesize customer_company;
@synthesize customer_email;
@synthesize capabilities;
@synthesize service_description;
@synthesize rate_type;
@synthesize rate;
@synthesize items_included;
@synthesize items_not_included;
@synthesize start_date;
@synthesize end_date;
static NSString *staff_out_address = @"http://hydrogen.xen.exoware.net:3000/apis/submit_proposal";
-(id)init
{
    if ((self = [super init]))
    {
        UIImageView *nav_back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopBar"]];
        nav_back.frame = CGRectMake(0, 0, 320, 43);
        nav_back.tag = 132;
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        logo.frame = CGRectMake(50, 0, 200, 40);
        logo.center = CGPointMake(320/2, logo.center.y);
        home_screen = [[HomeScreen alloc] initWithNibName:@"HomeScreen" bundle:nil];
        home_screen.home_screen_delegate = self;
        nav_control = [[UINavigationController alloc] initWithRootViewController:home_screen];
        nav_control.delegate = self;
        //This is extremely important. DO NOT CHANGE THESE LINES these are for
        //IOS 5 COMPATIBILITY ISSUES
        [nav_control.navigationBar insertSubview:nav_back atIndex:1];
        [nav_control.navigationBar insertSubview:logo atIndex:2];
        
        
        //Create Back Button
        UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(5,5,50,31)];
        UIButton *myBackButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [myBackButton setFrame:CGRectMake(0,0,50,31)];
        [myBackButton setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
        [myBackButton setEnabled:YES];
        [myBackButton addTarget:self action:@selector(properlyPopViewController) forControlEvents:UIControlEventTouchUpInside];
        [backButtonView addSubview:myBackButton];
        backButtonView.tag = BACK_BUTTON_ID;
        [nav_control.navigationBar insertSubview:backButtonView atIndex:3];
        [[nav_control.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:YES];
        
        //Create Top Right Inbox Button
        UIView *inboxButtonView = [[UIView alloc] initWithFrame:CGRectMake(270,5,50,31)];
        UIButton *myInboxButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [myInboxButton setFrame:CGRectMake(0,0,50,31)];
        [myInboxButton setImage:[UIImage imageNamed:@"notify"] forState:UIControlStateNormal];
        [myInboxButton setEnabled:YES];
        [myInboxButton addTarget:self action:@selector(goToInbox) forControlEvents:UIControlEventTouchUpInside];
        [inboxButtonView addSubview:myInboxButton];
        [nav_control.navigationBar insertSubview:inboxButtonView atIndex:4];
        
        
        //nav_control.delegate = self;
        [self.view addSubview:nav_control.view];
        staff_yourself = [[StaffYourself alloc] initWithNibName:@"StaffYourself" bundle:nil];
        staff_yourself.title = @"Staff Yourself";
        staff_yourself.delegate = self;
        staff_out_1 = [[StaffOutSegment1 alloc] initWithNibName:@"StaffOutSegment1" bundle:nil];
        staff_out_1.title = @"Staff Yourself";
        staff_out_1.delegate = self;
        staff_out_2 = [[StaffOutSegment2 alloc] initWithNibName:@"StaffOutSegment2" bundle:nil];
        staff_out_2.title = @"Staff Yourself";
        staff_out_2.delegate = self;
        
        friend_facebook_broadcast = [[FriendFacebookBroadcast alloc] initWithNibName:@"FriendFacebookBroadcast" bundle:nil];
        friend_facebook_broadcast.delegate = self;
    }
    return self;
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([navigationController.viewControllers count ] > 1) {
        viewController.navigationItem.hidesBackButton = YES;
        [[nav_control.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:NO];
    }
}
-(void)properlyPopViewController
{
    [[nav_control.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:YES];
    [nav_control popViewControllerAnimated:YES];
}
-(void)goToInbox
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate setCurrentTabBar:@"Messages"];
}

-(void)leaveFriendFacebookBroadcast
{
    [nav_control popToRootViewControllerAnimated:YES];
}
-(void)staffYourselfScreen
{
    [nav_control pushViewController:staff_yourself animated:YES];
}
-(void)staff1
{
    [nav_control pushViewController:staff_out_1 animated:YES];
}
-(void)goToSegment2
{
    [nav_control pushViewController:staff_out_2 animated:YES];
}
-(void)goToFriendFacebookBroadcast:(int)array_position
{
    [friend_facebook_broadcast setPositionInArray:array_position];
    [nav_control pushViewController:friend_facebook_broadcast animated:YES];
}
-(void)respondToSuggestedJob
{
    StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    //show a alertview that we are accessing the credentials and talking to the server.
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, -50, 320, 480)];
    [self.view addSubview:load_view];
    
    NSMutableString *job_info_url = [[NSMutableString alloc] initWithString:@"http://helium.staffittome.com/apis/"];
    [job_info_url appendString:[NSString stringWithFormat:@"%d", [[delegate.user_state_information.my_suggested_jobs objectAtIndex:delegate.user_state_information.current_suggested_job_in_array] job_id]]];
    [job_info_url appendString:@"/job"];
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_info_url];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"GET"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:delegate.user_state_information.sessionKey forKey:@"session_key"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    /*ConversationViewController *tester = [[ConversationViewController alloc] initWithNibName:@"ConversationViewController" bundle:nil andMessageArray:nil andDateArray:nil];
     [_viewController presentModalViewController:tester animated:YES];*/
    [request_ror startAsynchronous];
}
-(void)didSubmitProposal
{
    //show a alertview that we are accessing the credentials and talking to the server.
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, -50, 320, 480)];
    [self.view addSubview:load_view];
    
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:staff_out_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    //Add all the values into the request
    [request setPostValue:proposal_title forKey:@"title"];
    [request setPostValue:customer_name forKey:@"customer_name"];
    [request setPostValue:customer_company forKey:@"customer_company"];
    [request setPostValue:customer_email forKey:@"customer_email"];
    [request setPostValue:service_description forKey:@"description_of_service"];
    [request setPostValue:rate_type forKey:@"payment_method"];
    [request setPostValue:rate forKey:@"rate"];
    [request setPostValue:items_included forKey:@"items_included"];
    [request setPostValue:items_not_included forKey:@"items_not_included"];
    [request setPostValue:start_date forKey:@"start_date"];
    [request setPostValue:end_date forKey:@"end_date"];
    
    ///Finish request
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [load_view removeFromSuperview];
    job_detail_screen = [[JobDetailScreen alloc] initWithSuggestedJobsArrayWithJSONString:[request responseString]];
    [nav_control pushViewController:job_detail_screen animated:YES];
}
-(void)goToFaceBookBroadcast
{
    broadcast_facebook = [[FacebookBroadcast alloc] initWithNibName:@"FacebookBroadcast" bundle:nil];
    broadcast_facebook.delegate = self;
    [nav_control pushViewController:broadcast_facebook animated:YES];
}
@end
