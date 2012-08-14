//
//  StaffOutMain.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StaffOutMain.h"
#import "StaffItToMeAppDelegate.h"
#define BACK_BUTTON_ID 45

@implementation StaffOutMain

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
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
        front_page = [[StaffOutFrontPage alloc] initWithNibName:@"StaffOutFrontPage" bundle:nil];
        front_page.delegate = self;
        nav_control = [[UINavigationController alloc] initWithRootViewController:front_page];
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
        [self.view addSubview:nav_control.view];
        proposal_page = [[StaffOutProposalPage alloc] init];
        
    }
    return self;
}
-(void)goToProposal
{
    [nav_control pushViewController:proposal_page animated:YES];
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
