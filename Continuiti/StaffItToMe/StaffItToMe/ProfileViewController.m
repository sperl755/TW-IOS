//
//  ProfileViewController.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"
#import "StaffItToMeAppDelegate.h"
#import "JSON.h"


@implementation ProfileViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    [super viewDidLoad];
    background          = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
    background.frame    = CGRectMake(0, 0, 320, 480);
    [self.view insertSubview:background atIndex:0];
   

    
    //Perform the accessing of fthe server.
    int my_user_id  = app_delegate.user_state_information.my_user_info.user_id;
    NSURL *url      = [NSURL URLWithString:[[URLLibrary sharedInstance] getProfileInfoLinkWithId:my_user_id]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
    
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, -44, 320, 480)];
    [self.view addSubview:load_view];
    
    
}
//--------------TABLE VIEW METHOD TABLE VIEW METHODS TABLE VIEW METHODS-----------
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return module_array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Offset the logout button more
    if (indexPath.row == 4)
    {
        return [[module_array objectAtIndex:indexPath.row] frame].size.height + 15;
    }
    return  [[module_array objectAtIndex:indexPath.row] frame].size.height + 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell   = [[UITableViewCell alloc] init];
    cell.selectionStyle     = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:[module_array objectAtIndex:indexPath.row]];
    return cell;
}
//--------------End TABLE VIEW METHOD END TABLE VIEW METHODS END TABLE VIEW METHODS-----------
-(void)goToInbox
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate setCurrentTabBar:@"Messages"];
}
-(void)respondToConnectionsButton
{
    [delegate goToFacebookBroadcast];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [refresh_header setStartPoint:my_table_view.contentOffset];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([refresh_header isLoaded])
    {
        my_table_view.contentOffset = CGPointMake(0, -refresh_header.frame.size.height);
        my_table_view.userInteractionEnabled = NO;
        return;
    }
    if (![refresh_header isLoaded])
    {
        [refresh_header rotate:my_table_view.contentOffset];
        return;
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([refresh_header isLoaded])
    {
        my_table_view.contentOffset = CGPointMake(0, -refresh_header.frame.size.height);
        my_table_view.userInteractionEnabled = NO;
        //Data handling.
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        //Perform the accessing of fthe server.
        NSURL *url = [NSURL URLWithString:[[URLLibrary sharedInstance] getProfileInfoLinkWithId:app_delegate.user_state_information.my_user_info.user_id]];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"GET"];
        
        ///Finish request
        [request setValidatesSecureCertificate:NO];
        [request setTimeOutSeconds:30];
        [request setDelegate:self];
        [request startAsynchronous];
        [self performSelector:@selector(finishedLoadingSuggestedJob) withObject:nil afterDelay:30];
    }
}
-(void)finishedLoadingSuggestedJob
{
    [refresh_header reset];
    my_table_view.contentOffset = CGPointMake(0, 0);
    my_table_view.userInteractionEnabled = YES; 
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    // Do any additional setup after loading the view from its nib.
    if (my_header != nil)
    {
        [my_header removeFromSuperview];
        my_header.delegate = nil;
        my_header = nil;
    }
    my_header = [[UserInformationHeader alloc] init];
    my_header.delegate = self;
    
    my_table_view.allowsSelection = NO;
    my_table_view.backgroundColor = [UIColor clearColor];
    
    if (my_table_view != nil)
    {
        [my_table_view removeFromSuperview];
        my_table_view = nil;
    }
    my_table_view                   = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 370)];
    my_table_view.delegate          = self;
    my_table_view.dataSource        = self;
    my_table_view.backgroundColor   = [UIColor clearColor];
    my_table_view.separatorColor    = [UIColor clearColor];
    my_table_view.hidden            = YES;
    [self.view addSubview:my_table_view];
    
    if (refresh_header != nil)
    {
        [refresh_header removeFromSuperview];
        refresh_header = nil;
    }
    refresh_header = [[PullRefreshHeader alloc] initWithFrame:CGRectMake(0, -70, 320, 70)];
    [my_table_view addSubview:refresh_header];
    
    [load_view removeFromSuperview];
    
    
    NSDictionary *response_data = [[request responseString] JSONValue];
    NSArray *capability_array   = [response_data objectForKey:@"capabilities"];
    NSArray *experiences_array  = [response_data objectForKey:@"experiences"];
    NSArray *education_array    = [response_data objectForKey:@"educations"];
    
    //Fill Modules with recieved data
    UserSummaryProfileModule *user_summary              = [[UserSummaryProfileModule alloc] initWithString:[response_data objectForKey:@"summary"]];
    UserCapabilitiesProfileModule *user_capabilities    = [[UserCapabilitiesProfileModule alloc] initWithArray:capability_array];
    UserExperienceProfileModule *user_experience        = [[UserExperienceProfileModule alloc] initWithArray:experiences_array];
    UserEducationsModule *user_education                = [[UserEducationsModule alloc] initWithArray:education_array];
    
    
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    UIView *logout_button_view  = [[UIView alloc] initWithFrame:CGRectMake(73, 0, 93, 25.5)];
    logout_button_view.center   = CGPointMake(320/2, logout_button_view.center.y);
    logout_button                   = [UIButton buttonWithType:UIButtonTypeCustom];
    logout_button.frame             = CGRectMake(0, 0, 93, 25.5);
    [logout_button addTarget:app_delegate action:@selector(logoutFunction)      forControlEvents:UIControlEventTouchUpInside];
    [logout_button setBackgroundImage:[UIImage imageNamed:@"connections_box"]   forState:UIControlStateNormal];
    [logout_button_view addSubview:logout_button]; 
    
    //setupButtonLabel
    UILabel *connections_label          = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 22)];
    connections_label.text              = @"Logout";
    connections_label.center            = CGPointMake(97/2, connections_label.center.y + 4);
    connections_label.backgroundColor   = [UIColor clearColor];
    connections_label.font              = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
    connections_label.textColor         = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
    [logout_button_view addSubview:connections_label];
    
    module_array = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:my_header, user_summary, user_capabilities, user_experience, user_education, logout_button_view, nil]];
    
    my_table_view.hidden = NO;
    [refresh_header reset];
    [my_table_view reloadData];
    my_table_view.contentOffset = CGPointMake(0, 0);
    my_table_view.userInteractionEnabled = YES; 
    
}
-(void)logUserOut
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate logoutFunction];
}
-(void)viewDidUnload
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
