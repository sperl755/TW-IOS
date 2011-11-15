//
//  MessageSystemMain.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MessageSystemMain.h"
#import "StaffItToMeAppDelegate.h"

#define BACK_BUTTON_ID 45

@implementation MessageSystemMain
-(id)init
{
    if ((self = [super init]))
    {
        in_or_out = [[InboxOrSentbox alloc] initWithNibName:@"InboxOrSentbox" bundle:nil];
        in_or_out.delegate = self;
        inbox_controller = [[ConversationSelection alloc] initWithNibName:@"ConversationSelection" bundle:nil];
        inbox_controller.delegate = self;
        UIImageView *nav_back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopBar"]];
        nav_back.frame = CGRectMake(0, 0, 320, 43);
        nav_back.tag = 132;
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        logo.frame = CGRectMake(90, 10, 139, 21);
        
        
        navigation_controller = [[UINavigationController alloc] initWithRootViewController:inbox_controller];
        navigation_controller.delegate = self;
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
        [self.view addSubview:navigation_controller.view];
        sent_message_controller = [[SentMessageController alloc] initWithNibName:@"SentMessageController" bundle:nil];
        sent_message_controller.delegate = self;
        
        //Create Top Right Inbox Button
        UIView *inboxButtonView = [[UIView alloc] initWithFrame:CGRectMake(270,5,50,31)];
        UIButton *myInboxButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [myInboxButton setFrame:CGRectMake(0,0,50,31)];
        [myInboxButton setImage:[UIImage imageNamed:@"notify"] forState:UIControlStateNormal];
        [myInboxButton setEnabled:YES];
        [myInboxButton addTarget:self action:@selector(refreshInbox) forControlEvents:UIControlEventTouchUpInside];
        [inboxButtonView addSubview:myInboxButton];
        [navigation_controller.navigationBar insertSubview:inboxButtonView atIndex:4];
        
        navigation_controller.delegate = self;
        [self.view addSubview:navigation_controller.view];
        
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        in_or_out = [[InboxOrSentbox alloc] initWithNibName:@"InboxOrSentbox" bundle:nil];
        in_or_out.delegate = self;
        inbox_controller = [[ConversationSelection alloc] initWithNibName:@"ConversationSelection" bundle:nil];
        inbox_controller.delegate = self;
        UIImageView *nav_back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopBar"]];
        nav_back.frame = CGRectMake(0, 0, 320, 43);
        nav_back.tag = 132;
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        logo.frame = CGRectMake(90, 10, 139, 21);
        
        
        navigation_controller = [[UINavigationController alloc] initWithRootViewController:inbox_controller];
        navigation_controller.delegate = self;
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
        [self.view addSubview:navigation_controller.view];
        sent_message_controller = [[SentMessageController alloc] initWithNibName:@"SentMessageController" bundle:nil];
        sent_message_controller.delegate = self;
        
        //Create Top Right Inbox Button
        UIView *inboxButtonView = [[UIView alloc] initWithFrame:CGRectMake(270,5,50,31)];
        UIButton *myInboxButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [myInboxButton setFrame:CGRectMake(0,0,50,31)];
        [myInboxButton setImage:[UIImage imageNamed:@"notify"] forState:UIControlStateNormal];
        [myInboxButton setEnabled:YES];
        [myInboxButton addTarget:self action:@selector(refreshInbox) forControlEvents:UIControlEventTouchUpInside];
        [inboxButtonView addSubview:myInboxButton];
        [navigation_controller.navigationBar insertSubview:inboxButtonView atIndex:4];
        
        navigation_controller.delegate = self;
        [self.view addSubview:navigation_controller.view];
    }
    return self;
}
-(void)refreshInbox
{
    [[navigation_controller.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:YES];
    [navigation_controller popToRootViewControllerAnimated:YES];
    [inbox_controller refreshInbox];
}
-(void)goToInbox
{
    [navigation_controller pushViewController:inbox_controller animated:YES];
}
-(void)goToSentbox
{
    [navigation_controller pushViewController:sent_message_controller animated:YES];
}
-(void)goToSentMessage:(int)convo_position
{
    message_detail = [[MessageDetailsController alloc] initWithPositionInSentBoxArray:convo_position];
    [navigation_controller pushViewController:message_detail animated:YES];   
}
-(void)goToConversation:(int)convo_position
{
    message_detail = [[MessageDetailsController alloc] initWithPositionInInboxArray:convo_position];
    message_detail.delegate = self;
    [navigation_controller pushViewController:message_detail animated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([navigationController.viewControllers count ] > 1) {
        viewController.navigationItem.hidesBackButton = YES;
        [[navigation_controller.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:NO];
    }
}
-(void)properlyPopViewController
{
    [[navigation_controller.navigationBar viewWithTag:BACK_BUTTON_ID] setHidden:YES];
    [navigation_controller popViewControllerAnimated:YES];
}
-(void)goToThisNewController:(UIViewController *)the_new_controller
{
    [navigation_controller pushViewController:the_new_controller animated:YES];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
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
