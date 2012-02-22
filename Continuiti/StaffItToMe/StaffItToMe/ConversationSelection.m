//
//  ConversationSelection.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConversationSelection.h"
#import "StaffItToMeAppDelegate.h"


@implementation ConversationSelection
@synthesize my_table;
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    [wait_header removeFromSuperview];
    [wait_label removeFromSuperview];
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [load_message removeFromSuperview];
    
    [app_delegate.user_state_information populateMyInboxWithString:[request responseString]];
    my_table                    = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, 320, 367)];
    my_table.delegate           = self;
    my_table.dataSource         = self;
    my_table.backgroundColor    = [UIColor clearColor];
    my_table.separatorColor     = [UIColor clearColor];
    [self.view addSubview:my_table];
    
    [load_view removeFromSuperview];
    load_view = nil;
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    return ([app_delegate.user_state_information.my_inbox_messages count] + 1);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 33;
    }
    else
    {
        return 42;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    UITableViewCell *the_cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (the_cell == nil)
    {
        the_cell = [[UITableViewCell alloc] init];
    }
    if (indexPath.row == 0)
    {
        UIView *cell_view                       = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 310, 33)];
        UIImage *header_image                   = [UIImage imageNamed:@"module_header"];
        UIImageView *module_header_background   = [[UIImageView alloc] initWithImage:header_image];
        module_header_background.frame          = CGRectMake(0, 0, 310, 33);
        [cell_view addSubview:module_header_background];
        
        //[header_image release];
        
        UILabel *spam_your_friends_label        = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
        spam_your_friends_label.textColor       = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        spam_your_friends_label.backgroundColor = [UIColor clearColor];
        [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        spam_your_friends_label.text = @"Notifications and Inbox";
        [cell_view addSubview:spam_your_friends_label];
        [the_cell.contentView addSubview:cell_view];
    }
    else
    {
        InboxCell *cell_view = [[InboxCell alloc] initwithDetail:[[app_delegate.user_state_information.my_inbox_messages objectAtIndex:indexPath.row-1] my_body] andArrow:YES senderName:[[app_delegate.user_state_information.my_inbox_messages objectAtIndex:indexPath.row-1] my_sender_name]];
        [the_cell.contentView addSubview:cell_view];
    }
    [the_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return the_cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }
    [delegate goToConversation:indexPath.row-1];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *cell_view       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 33)];
    UIImage *header_image   = [UIImage imageNamed:@"module_header.png"];
    wait_header             = [[UIImageView alloc] initWithImage:header_image];
    wait_header.frame       = CGRectMake(5, 5, 310, 33);
    [cell_view addSubview:wait_header];
    
    //[header_image release];
    wait_label                  = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 22)];
    wait_label.textColor        = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
    wait_label.backgroundColor  = [UIColor clearColor];
    wait_label.text             = @"Loading Your Messages";
    [wait_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    [cell_view addSubview:wait_label];
    [self.view addSubview:cell_view];
    
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //Start the second request for the inbox messages
    NSURL *url = [NSURL URLWithString:[[URLLibrary sharedInstance] getInboxUrl]];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request_ror startAsynchronous];
    
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, -44, 320, 480)];
    [self.view addSubview:load_view];
}
-(void)refreshInbox
{
    [my_table removeFromSuperview];
    UIView *cell_view       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 33)];
    UIImage *header_image   = [UIImage imageNamed:@"module_header.png"];
    wait_header             = [[UIImageView alloc] initWithImage:header_image];
    wait_header.frame       = CGRectMake(5, 5, 310, 33);
    [cell_view addSubview:wait_header];
    //[header_image release];
    
    wait_label                  = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 22)];
    wait_label.textColor        = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
    wait_label.backgroundColor  = [UIColor clearColor];
    wait_label.text             = @"Loading Your Messages";
    [wait_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    [cell_view addSubview:wait_label];
    [self.view addSubview:cell_view];
    
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //Start the second request for the inbox messages
    NSURL *url = [NSURL URLWithString:[[URLLibrary sharedInstance] getInboxUrl]];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request_ror startAsynchronous];
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, -44, 320, 480)];
    [self.view addSubview:load_view];
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
