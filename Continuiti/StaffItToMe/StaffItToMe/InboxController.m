//
//  InboxController.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InboxController.h"
#import "StaffItToMeAppDelegate.h"


@implementation InboxController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        conversations = [[ConversationSelection alloc] initWithNibName:@"ConversationSelection" bundle:nil];
        conversations.delegate = self;
    }
    return self;
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
    nav_control                 = [[UINavigationController alloc] initWithRootViewController:conversations];
    UIImageView *nav_back       = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopBar"]];
    nav_back.frame              = CGRectMake(0, 0, 320, 43);
    nav_back.tag                = 132;
    UIImageView *logo           = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    logo.frame                  = CGRectMake(50, 0, 200, 40);
    logo.center                 = CGPointMake(320/2, logo.center.y);
    
    //This is extremely important. DO NOT CHANGE THESE LINES these are for
    //IOS 5 COMPATIBILITY ISSUES
    [nav_control.navigationBar insertSubview:nav_back atIndex:1];
    [nav_control.navigationBar insertSubview:logo atIndex:2];
    [self.view addSubview:nav_control.view];
    
    // Do any additional setup after loading the view from its nib.
    UIColor *background                     = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TopBar.png"]];
    nav_control.navigationBar.tintColor     = background;
    [background release];
}
-(void)goToConversation:(int)convo_position
{ 
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    
    //show a alertview that we are accessing the credentials and talking to the server.
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
    
    NSMutableString *message_info_url = [[NSMutableString alloc] initWithString:@"https://helium.staffittome.com/apis/"];
    [message_info_url appendString:[[app_delegate.user_state_information.my_inbox_messages objectAtIndex:convo_position] my_message_id]];
    [message_info_url appendString:@"/view_message"];
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:message_info_url];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setDelegate:self];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request_ror setPostValue:[[app_delegate.user_state_information.my_inbox_messages objectAtIndex:convo_position] my_message_id] forKey:@"id"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    /*ConversationViewController *tester = [[ConversationViewController alloc] initWithNibName:@"ConversationViewController" bundle:nil andMessageArray:nil andDateArray:nil];
     [_viewController presentModalViewController:tester animated:YES];*/
    [request_ror startAsynchronous];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    printf("\nConversation Info: %s\n", [[request responseString] UTF8String]);
    [load_message dismissWithClickedButtonIndex:0 animated:YES];
    printf("\n\n\nThis is message details: %s", [[request responseString] UTF8String]);
    if (convo_details == nil) {
        convo_details = [[ConversationViewController alloc] initWithNibName:@"ConversationViewController" bundle:nil andMessageArray:[NSArray arrayWithObjects:nil] andDateArray:[NSArray arrayWithObjects:nil]];
    }
    else
    {
        ConversationViewController *temp = convo_details;
        convo_details = [[ConversationViewController alloc] initWithNibName:@"ConversationViewController" bundle:nil andMessageArray:[NSArray arrayWithObjects:nil] andDateArray:[NSArray arrayWithObjects:nil]];
        [temp release];
    }
    [nav_control pushViewController:convo_details animated:YES];
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
