//
//  HomeScreen.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeScreen.h"
#import "StaffItToMeAppDelegate.h"


@implementation HomeScreen
@synthesize home_screen_delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        im_available = YES;
        SpamYourFriends *spam_friends = [[SpamYourFriends alloc] init];
        //JobSuggestionsModule *job_suggests = [[JobSuggestionsModule alloc] init];
        //job_suggests.delegate = self;
        my_header = [[UserInformationHeader alloc] init];
        my_header.delegate = self;
        [self.view addSubview:my_header];
        
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        UIView *logout_button_view  = [[UIView alloc] initWithFrame:CGRectMake(73, 0, 93, 25.5)];
        logout_button_view.center   = CGPointMake(320/2, logout_button_view.center.y);
        UIButton *logout_button                   = [UIButton buttonWithType:UIButtonTypeCustom];
        logout_button.frame             = CGRectMake(0, 0, 93, 25.5);
        [logout_button addTarget:app_delegate action:@selector(logoutFunction)      forControlEvents:UIControlEventTouchUpInside];
        [logout_button setBackgroundImage:[UIImage imageNamed:@"connections_box"]   forState:UIControlStateNormal];
        [logout_button_view addSubview:logout_button];
        UILabel *aconnections_label          = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 22)];
        aconnections_label.text              = @"Logout";
        aconnections_label.center            = CGPointMake(97/2, aconnections_label.center.y + 4);
        aconnections_label.backgroundColor   = [UIColor clearColor];
        aconnections_label.font              = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        aconnections_label.textColor         = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        [logout_button_view addSubview:aconnections_label];
        
        module_array = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:my_header, spam_friends, logout_button_view, nil]];
        [spam_friends release];
        //[job_suggests release];
        
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
-(void)respondToConnectionsButton
{
    [home_screen_delegate goToFaceBookBroadcast];
}
#pragma mark - View lifecycle
- (void)viewDidLoad
{
    background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
    background.frame = CGRectMake(0, 0, 320, 480);
    [self.view insertSubview:background atIndex:0];
    
    [super viewDidLoad];
    //Create custom switch
    //my_available_switch = [[ASSwitch alloc] initWithFrame:CGRectMake(234, 36, 60, 22) andOnImage:[UIImage imageNamed:@"available_no"] offImage:[UIImage imageNamed:@"available_yes"] sliderImage:[UIImage imageNamed:@"available_slider"]];
    //my_available_switch.delegate = self;
    //[self.view addSubview:my_available_switch];
    
    
    
    my_table_view.allowsSelection = NO;
    my_table_view.backgroundColor = [UIColor clearColor];
    refresh_header = [[PullRefreshHeader alloc] initWithFrame:CGRectMake(0, -70, 320, 70)];
    [my_table_view addSubview:refresh_header];
    
    //load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, -44, 320, 480)];
    //[self.view addSubview:load_view];
    
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
-(void)request:(FBRequest *)request didLoad:(id)result
{
    //Get the facebook friends
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [app_delegate.user_state_information.my_facebook_friends removeAllObjects];
    
    NSMutableArray *dciont = [[result objectForKey:@"friends"] objectForKey:@"data"];
    for (int i = 0; i < dciont.count; i++)
    {
        FacebookFriend *friend  = [[FacebookFriend alloc] init];
        friend.friend_id        = [[dciont objectAtIndex:i] objectForKey:@"id"];
        friend.name             = [[dciont objectAtIndex:i] objectForKey:@"name"];
        [app_delegate.user_state_information.my_facebook_friends addObject:friend];
        [friend release];
    }
    
    //Reset the screen
    im_available                        = YES;
    SpamYourFriends *spam_friends       = [[SpamYourFriends alloc] init];
    JobSuggestionsModule *job_suggests  = [[JobSuggestionsModule alloc] init];
    job_suggests.delegate               = self;
    my_header                           = [[UserInformationHeader alloc] init];
    my_header.delegate                  = self;
    module_array                        = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:my_header, spam_friends, job_suggests, nil]];
    
    [spam_friends release];
    [job_suggests release];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([refresh_header isLoaded])
    {
        my_table_view.contentOffset = CGPointMake(0, -refresh_header.frame.size.height);
        my_table_view.userInteractionEnabled = NO;
        //facebook = [[Facebook alloc] initWithAppId:@"187212574660004"];
        //facebook.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"FBAccessTokenKey"];
        //facebook.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"FBExpirationDateKey"];
        //NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"friends, first_name, last_name, id, locale, gender, birthday, email, link, name", @"fields", nil];
        //[facebook requestWithGraphPath:@"me" andParams:parameters andDelegate:self];
        [self performSelector:@selector(finishedLoadingSuggestedJob) withObject:nil afterDelay:30];
    }
}
-(void)finishedLoadingSuggestedJob
{
    [refresh_header reset];
    
    [load_view removeFromSuperview];
    load_view = nil;
    
    [my_table_view reloadData];
    my_table_view.contentOffset             = CGPointMake(0, 0);
    my_table_view.userInteractionEnabled    = YES; 
    requesting                              = NO;
}
-(void)reloadTableData
{
    [my_table_view reloadData];
}
-(void)respondToSuggestionSelection
{
    [home_screen_delegate respondToSuggestedJob];
}
//so a little retarded action here.
//Basically I need to switch the on to react as off and the off to react as on
//because of the art that was provided for the switch. THe yes shows in off mode
//and the no shows in on mode. Akward but whatever.
-(void)respondToOnHappening
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    [app_delegate.user_state_information stopUpdatingUserLocation];
}
-(void)respondToOffHappening
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    [app_delegate.user_state_information startUpdatingUserLocation];
}
-(void)imAvailable
{
    //if when user clicked the button was on then turn it off.
    if (im_available)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location" message:@"You have shut off your location transmittal" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
        im_available = NO;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location" message:@"You have turned on your location transmittal" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
        im_available = YES;
    }
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
    return  [[module_array objectAtIndex:indexPath.row] frame].size.height;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[[UITableViewCell alloc] init] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:[module_array objectAtIndex:indexPath.row]];
    return cell;
}
//--------------End TABLE VIEW METHOD END TABLE VIEW METHODS END TABLE VIEW METHODS-----------
-(IBAction)goToFriendBroadcast
{
    [home_screen_delegate goToFaceBookBroadcast];
}
-(IBAction)displayStaffYourself
{
}
-(void)dismissMePlease
{
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)setScreen:(id)sender
{
    StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    UIButton *pressed = (UIButton*)sender;
    if (pressed.tag == 10)
    {
        [delegate setCurrentTabBar:@"FindWork"];
    }
    else if (pressed.tag == 11)
    {
        [delegate setCurrentTabBar:@"MyJobs"];
    }
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
