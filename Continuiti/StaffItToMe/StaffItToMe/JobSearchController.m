//
//  JobSearchController.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JobSearchController.h"
#import "StaffItToMeAppDelegate.h"

#define BACK_BUTTON_ID 45
@implementation JobSearchController
@synthesize navigation_controller;
-(id)init
{
    if ((self = [super init]))
    {
        gmap_menu = [[GMapMenuController alloc] init];
        navigation_controller = [[UINavigationController alloc] initWithRootViewController:gmap_menu];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToJobDetail) name:@"jumpToJobDetail" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToIndustrySearch) name:@"jumpToIndustrySearch" object:nil];
        
        UIImageView *nav_back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopBar"]];
        nav_back.frame = CGRectMake(0, 0, 320, 43);
        nav_back.tag = 132;
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        logo.frame = CGRectMake(50, 0, 200, 40);
        logo.center = CGPointMake(320/2, logo.center.y);
        //This is extremely important. DO NOT CHANGE THESE LINES these are for
        //IOS 5 COMPATIBILITY ISSUES
        [navigation_controller.navigationBar insertSubview:nav_back atIndex:1];
        [navigation_controller.navigationBar insertSubview:logo atIndex:2];
        
        //Create Back Button
        UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(5,5,50,31)];
        UIButton *myBackButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [myBackButton setFrame:CGRectMake(0,0,50,31)];
        [myBackButton setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
        [myBackButton setEnabled:YES];
        [myBackButton addTarget:self action:@selector(properlyPopViewController) forControlEvents:UIControlEventTouchUpInside];
        [backButtonView addSubview:myBackButton];
        backButtonView.tag = BACK_BUTTON_ID;
        [navigation_controller.navigationBar insertSubview:backButtonView atIndex:3];
        [[navigation_controller.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:YES];
        
        //Create Top Right Inbox Button
        UIView *inboxButtonView = [[UIView alloc] initWithFrame:CGRectMake(270,5,50,31)];
        UIButton *myInboxButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [myInboxButton setFrame:CGRectMake(0,0,50,31)];
        [myInboxButton setImage:[UIImage imageNamed:@"notify"] forState:UIControlStateNormal];
        [myInboxButton setEnabled:YES];
        [myInboxButton addTarget:self action:@selector(goToInbox) forControlEvents:UIControlEventTouchUpInside];
        [inboxButtonView addSubview:myInboxButton];
        [navigation_controller.navigationBar insertSubview:inboxButtonView atIndex:4];
        
        navigation_controller.delegate = self;
        [self.view addSubview:navigation_controller.view];
        at_detail_screen = NO;
        
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
-(void)properlyPopViewController
{
    [[navigation_controller.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:YES];
    [navigation_controller popViewControllerAnimated:YES];
}
-(void)properlyToRootViewController
{
    [[navigation_controller.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:YES];
    [navigation_controller popToRootViewControllerAnimated:YES];
}
-(void)displayApplyKeyboardDoneButton
{
    //Add keyboard done button for typing their message.
    UIBarButtonItem *done_button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:job_apply_screen action:@selector(removeKeyboard)];
    navigation_controller.navigationBar.topItem.rightBarButtonItem = done_button;
    [done_button release];
}
-(void)hideApplyKeyboardDoneButton
{
    navigation_controller.navigationBar.topItem.rightBarButtonItem = nil;
}
-(void)detailSwipeLeft:(id)sender
{
    printf("Swiped left");
    if (!at_detail_screen) {return;}
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    int next_array_spot = app_delegate.user_state_information.current_job_in_array + 1;
    if (next_array_spot < 0){ next_array_spot = app_delegate.user_state_information.job_array.count-1;}
    else if (next_array_spot >= app_delegate.user_state_information.job_array.count)
    {
        next_array_spot = 0;
    }
    app_delegate.user_state_information.current_job_in_array = next_array_spot;
    //show a alertview that we are accessing the credentials and talking to the server.
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
    
    NSMutableString *job_info_url = [[NSMutableString alloc] initWithString:@"http://helium.staffittome.com/apis/"];
    [job_info_url appendString:[NSString stringWithFormat:@"%d", [[app_delegate.user_state_information.job_array objectAtIndex:next_array_spot] job_id]]];
    [job_info_url appendString:@"/job"];
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_info_url];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"GET"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (!at_detail_screen)
    {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        [app_delegate.user_state_information populateMyAppliedToJobsWithString:[request responseString]];
        printf("\nThe something:%s\n", [[request responseString] UTF8String]);
        return;
    }
    [load_message dismissWithClickedButtonIndex:0 animated:YES];
    at_detail_screen = YES;
    job_detail_screen = [[JobDetailScreen alloc] initWithJSONString:[request responseString]];
    job_detail_screen.delegate = self;
    UISwipeGestureRecognizer *swipe_left_recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(detailSwipeLeft:)];
    swipe_left_recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *swipe_right_recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(detailSwipeRight:)];
    swipe_right_recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [job_detail_screen.view addGestureRecognizer:swipe_left_recognizer];
    [job_detail_screen.view addGestureRecognizer:swipe_right_recognizer];
    [navigation_controller popViewControllerAnimated:NO];
    [navigation_controller pushViewController:job_detail_screen animated:NO];
    
}
-(void)detailSwipeRight:(id)sender
{
    printf("Swiped right");
    if (!at_detail_screen) {return;}
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    int next_array_spot = app_delegate.user_state_information.current_job_in_array - 1;
    if (next_array_spot < 0){ next_array_spot = app_delegate.user_state_information.job_array.count-1;}
    else if (next_array_spot >= app_delegate.user_state_information.job_array.count)
    {
        next_array_spot = 0;
    }
    app_delegate.user_state_information.current_job_in_array = next_array_spot;
    //show a alertview that we are accessing the credentials and talking to the server.
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
    
    NSMutableString *job_info_url = [[NSMutableString alloc] initWithString:@"http://helium.staffittome.com/apis/"];
    [job_info_url appendString:[NSString stringWithFormat:@"%d", [[app_delegate.user_state_information.job_array objectAtIndex:next_array_spot] job_id]]];
    [job_info_url appendString:@"/job"];
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_info_url];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"GET"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror startAsynchronous];
}
-(void)jumpToJobDetail:(NSNotification*)notification
{
    NSString *json_info = [[notification userInfo] objectForKey:@"responseString"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    at_detail_screen = YES;
    job_detail_screen = [[JobDetailScreen alloc] initWithJSONString:json_info];
    job_detail_screen.delegate = self;
    UISwipeGestureRecognizer *swipe_left_recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(detailSwipeLeft:)];
    swipe_left_recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *swipe_right_recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(detailSwipeRight:)];
    swipe_right_recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [job_detail_screen.view addGestureRecognizer:swipe_left_recognizer];
    [job_detail_screen.view addGestureRecognizer:swipe_right_recognizer];
    [navigation_controller pushViewController:job_detail_screen animated:YES];
}
-(void)respondToCompanyInformationRequest:(NSString *)information
{
    CompanyInformationScreen *company_screen = [[CompanyInformationScreen alloc] initWithJSONInformation:information];
    [navigation_controller pushViewController:company_screen animated:YES];
}
-(void)jumpToJobApply
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    job_apply_screen = [[JobApplyScreen alloc] init];
    job_apply_screen.delegate = self;
    [navigation_controller pushViewController:job_apply_screen animated:YES];
	StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    job_apply_screen.title = [[delegate.user_state_information.job_array objectAtIndex:delegate.user_state_information.current_job_in_array] title];
}
-(void)jumpToIndustrySearch
{
    IndustrySearchController *industry_search = [[IndustrySearchController alloc] initWithNibName:nil bundle:nil];
    industry_search.delegate = self;
    [navigation_controller pushViewController:industry_search animated:YES];
}
-(void)jumpToSalarySearch
{
    SalarySearchController *salary_search = [[SalarySearchController alloc] initWithNibName:nil bundle:nil];
    salary_search.delegate = self;
    [navigation_controller pushViewController:salary_search animated:YES];
}
-(void)jumpToDistanceSearch
{
    DistanceSearchController *salary_search = [[DistanceSearchController alloc] initWithNibName:nil bundle:nil];
    salary_search.delegate = self;
    [navigation_controller pushViewController:salary_search animated:YES];
}
//Basically when the view controller is displayed add notification so that way it knows what buttons to use.
//Basically make NSNotification for the screens when they are displayed at any time.
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    at_detail_screen = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (viewController == job_detail_screen) {
        at_detail_screen = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToJobDiscussion) name:@"jumpToJobDiscussion" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToJobApply) name:@"jumpToJobApply" object:nil];
    }
    else if (viewController == gmap_menu) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToJobDetail:) name:@"jumpToJobDetail" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToIndustrySearch) name:@"jumpToIndustrySearch" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToSalarySearch) name:@"jumpToSalarySearch" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToDistanceSearch) name:@"jumpToDistanceSearch" object:nil];
    }
    else if (viewController == job_discussion_screen) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popController) name:@"MessageSent" object:nil];
    }
    else if (viewController == job_apply_screen) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popController) name:@"ApplicationSent" object:nil];
    }
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([navigationController.viewControllers count ] > 1) {
        viewController.navigationItem.hidesBackButton = YES;
        [[navigation_controller.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:NO];
    }
}
-(void)goToInbox
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate setCurrentTabBar:@"Messages"];
}

-(void)popController
{
    [navigation_controller popToRootViewControllerAnimated:YES];
}
/*
 Go to the job discussion screen after user clicks discuss in job description
 */
-(void)jumpToJobDiscussion
{
    //remove old notification about this object
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //Create screen for discussion
    job_discussion_screen = [[JobDiscussionScreen alloc] init];
    
    
    //[navigation_controller.navigationItem setRightBarButtonItem:done_button];
    
    //Go To next Screen
    [navigation_controller pushViewController:job_discussion_screen animated:YES];
    job_discussion_screen.title = @"Discuss";
    
    
}
-(void)leaveIndustrySearch
{
    [gmap_menu updateMenu];
    [self properlyPopViewController];
}
-(void)leaveSalarySearch
{
    [gmap_menu updateMenu];
    [self properlyPopViewController];
}
-(void)leaveDistanceSearch
{
    [gmap_menu updateMenu];
    [self properlyPopViewController];
}
//Deallocate memory for this object
-(void)dealloc
{
    [navigation_controller release];
    [gmap_menu release];
    [super dealloc];
}
@end
