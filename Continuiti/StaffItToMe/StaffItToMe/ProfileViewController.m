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
    [super viewDidLoad];
    background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
    background.frame = CGRectMake(0, 0, 320, 480);
    [self.view insertSubview:background atIndex:0];
    // Do any additional setup after loading the view from its nib.
    my_header = [[UserInformationHeader alloc] init];
    my_header.delegate = self;
    
    
    
    
    my_table_view.allowsSelection = NO;
    my_table_view.backgroundColor = [UIColor clearColor];
    
    my_table_view = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 370)];
    my_table_view.delegate = self;
    my_table_view.dataSource = self;
    my_table_view.backgroundColor = [UIColor clearColor];
    my_table_view.separatorColor = [UIColor clearColor];
    my_table_view.hidden = YES;
    [self.view addSubview:my_table_view];
    
    refresh_header = [[PullRefreshHeader alloc] initWithFrame:CGRectMake(0, -70, 320, 70)];
    [my_table_view addSubview:refresh_header];
    
    //Data handling.
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSMutableString *user_information = [[NSMutableString alloc] initWithString:@"https://helium.staffittome.com/apis/"];
    [user_information appendString:[NSString stringWithFormat:@"%d", app_delegate.user_state_information.my_user_info.user_id]];
    [user_information appendString:@"/profile_details"];
    //Perform the accessing of fthe server.
    NSURL *url = [NSURL URLWithString:user_information];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    
    ///Finish request
    [request setValidatesSecureCertificate:NO];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    
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
    return  [[module_array objectAtIndex:indexPath.row] frame].size.height + 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        
        NSMutableString *user_information = [[NSMutableString alloc] initWithString:@"https://helium.staffittome.com/apis/"];
        [user_information appendString:[NSString stringWithFormat:@"%d", app_delegate.user_state_information.my_user_info.user_id]];
        [user_information appendString:@"/profile_details"];
        //Perform the accessing of fthe server.
        NSURL *url = [NSURL URLWithString:user_information];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"GET"];
        
        ///Finish request
        [request setValidatesSecureCertificate:NO];
        [request setTimeOutSeconds:30];
        [request setDelegate:self];
        [request startAsynchronous];
    }
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    printf("\nThis is theuser info: %s", [[request responseString] UTF8String]);
    
    NSDictionary *response_data = [[request responseString] JSONValue];
    NSArray *capability_array = [response_data objectForKey:@"capabilities"];
    NSArray *experiences_array = [response_data objectForKey:@"experiences"];
    NSArray *education_array = [response_data objectForKey:@"educations"];
    //Fill Modules with recieved data
    UserSummaryProfileModule *user_summary = [[UserSummaryProfileModule alloc] initWithString:[response_data objectForKey:@"summary"]];
    UserCapabilitiesProfileModule *user_capabilities = [[UserCapabilitiesProfileModule alloc] initWithArray:capability_array];
    UserExperienceProfileModule *user_experience = [[UserExperienceProfileModule alloc] initWithArray:experiences_array];
    UserEducationsModule *user_education = [[UserEducationsModule alloc] initWithArray:education_array];
    
    
    logout_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logout_button.titleLabel.text = @"Logout";
    logout_button.frame = CGRectMake(5, 0, 300, 55);
    [logout_button addTarget:self action:@selector(logUserOut) forControlEvents:UIControlEventTouchUpInside];
    
    module_array = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:my_header, user_summary, user_capabilities, user_experience, user_education, logout_button, nil]];
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
