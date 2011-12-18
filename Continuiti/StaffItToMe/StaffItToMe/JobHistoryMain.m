//
//  JobHistoryMain.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JobHistoryMain.h"
#import "StaffItToMeAppDelegate.h"

#define BACK_BUTTON_ID 45

@implementation JobHistoryMain

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        job_history_controller = [[MyJobsAndApplications alloc] init];
        job_history_controller.delegate = self;
        nav_controller = [[UINavigationController alloc] initWithRootViewController:job_history_controller];
        UIImageView *nav_back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopBar"]];
        nav_back.frame = CGRectMake(0, 0, 320, 43);
        nav_back.tag = 132;
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        logo.frame = CGRectMake(50, 0, 200, 40);
        logo.center = CGPointMake(320/2, logo.center.y);
        //This is extremely important. DO NOT CHANGE THESE LINES these are for
        //IOS 5 COMPATIBILITY ISSUES
        [nav_controller.navigationBar insertSubview:nav_back atIndex:1];
        [nav_controller.navigationBar insertSubview:logo atIndex:2];
        nav_controller.delegate = self;
        [self.view addSubview:nav_controller.view];
        
        
        //Create Back Button
        UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(5,5,50,31)];
        UIButton *myBackButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [myBackButton setFrame:CGRectMake(0,0,50,31)];
        [myBackButton setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
        [myBackButton setEnabled:YES];
        [myBackButton addTarget:self action:@selector(properlyPopViewController) forControlEvents:UIControlEventTouchUpInside];
        [backButtonView addSubview:myBackButton];
        backButtonView.tag = BACK_BUTTON_ID;
        [nav_controller.navigationBar insertSubview:backButtonView atIndex:3];
        [[nav_controller.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:YES];
        
        //Create Top Right Inbox Button
        UIView *inboxButtonView = [[UIView alloc] initWithFrame:CGRectMake(270,5,50,31)];
        UIButton *myInboxButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [myInboxButton setFrame:CGRectMake(0,0,50,31)];
        [myInboxButton setImage:[UIImage imageNamed:@"notify"] forState:UIControlStateNormal];
        [myInboxButton setEnabled:YES];
        [myInboxButton addTarget:self action:@selector(goToInbox) forControlEvents:UIControlEventTouchUpInside];
        [inboxButtonView addSubview:myInboxButton];
        [nav_controller.navigationBar insertSubview:inboxButtonView atIndex:4];
        
        
        
        friend_facebook_broadcast = [[FriendFacebookBroadcast alloc] initWithNibName:@"FriendFacebookBroadcast" bundle:nil];
        friend_facebook_broadcast.delegate = self;
    }
    return self;
}
-(void)viewDidLoad
{
    [self performSelectorInBackground:@selector(loadFriendContent) withObject:nil];
}
-(void)loadFriendContent
{
    broadcast_facebook = [[FacebookBroadcast alloc] initWithNibName:@"FacebookBroadcast" bundle:nil];
    broadcast_facebook.delegate = self;   
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([navigationController.viewControllers count ] > 1) {
        viewController.navigationItem.hidesBackButton = YES;
        [[nav_controller.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:NO];
    }
}
-(void)properlyPopViewController
{
    [[nav_controller.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:YES];
    [nav_controller popViewControllerAnimated:YES];
}
-(void)goToInbox
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate setCurrentTabBar:@"Messages"];
}
-(void)goToFacebookBroadcast
{
    [nav_controller pushViewController:broadcast_facebook animated:YES];
}
-(void)goToFriendFacebookBroadcast:(int)array_position
{
    [friend_facebook_broadcast setPositionInArray:array_position];
    [nav_controller pushViewController:friend_facebook_broadcast animated:YES];
}
-(void)leaveFriendFacebookBroadcast
{
    [nav_controller popToRootViewControllerAnimated:YES];
}
-(void)goToManualCheckinWithJobArrayPosition:(int)the_array_position
{
    manual_time_entry = [[ManualTimeJobEntry alloc] initWithNibName:@"ManualTimeJobEntry" bundle:nil andPos:the_array_position];
    [nav_controller pushViewController:manual_time_entry animated:YES];
}
-(void)goToCheckinWithJobArrayPosition:(int)the_array_position
{
    checkin_time_entry = [[CheckOutEntry alloc] initWithNibName:@"CheckOutEntry" bundle:nil andPos:the_array_position];
    [nav_controller pushViewController:checkin_time_entry animated:YES];
}
/*
-(void)goToJobHistory:(int)the_position
{
    JobHistoryController *chocolate = [[JobHistoryController alloc] initWithNibName:@"JobHistoryController" bundle:nil andPos:the_position];
    [nav_controller pushViewController:chocolate animated:YES];
}
-(void)goToManualTimeEntry:(int)the_position
{
    ManualTimeJobEntry *time_entry = [[ManualTimeJobEntry alloc] initWithNibName:@"ManualTimeJobEntry" bundle:nil andPos:the_position];
    time_entry.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [nav_controller pushViewController:time_entry animated:YES];
}
-(void)goToCheckoutScreen:(int)the_position
{
    CheckOutEntry *check_out = [[CheckOutEntry alloc] initWithNibName:@"CheckOutEntry" bundle:nil andPos:the_position];
    check_out.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [nav_controller pushViewController:check_out animated:YES];
}*/
- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
