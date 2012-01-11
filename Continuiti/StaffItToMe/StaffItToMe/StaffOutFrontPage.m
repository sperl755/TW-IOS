//
//  StaffOutFrontPage.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StaffOutFrontPage.h"
#import "StaffItToMeAppDelegate.h"


@implementation StaffOutFrontPage
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Make the modules
        //Data handling.
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSMutableString *user_information = [[NSMutableString alloc] initWithString:@"http://helium.staffittome.com/apis/"];
        [user_information appendString:[NSString stringWithFormat:@"%d", app_delegate.user_state_information.my_user_info.user_id]];
        printf("USERID: %d", app_delegate.user_state_information.my_user_info.user_id);
        [user_information appendString:@"/profile_details"];
        //Perform the accessing of fthe server.
        NSURL *url = [NSURL URLWithString:user_information];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"GET"];
        
        ///Finish request
        [request setTimeOutSeconds:30];
        [request setDelegate:self];
        [request startAsynchronous];
        reloading = NO;
    }
    return self;
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    printf("\nThis is theuser info: %s", [[request responseString] UTF8String]);
    if (reloading)
    {
        [refresh_header reset];
        [table_view reloadData];
        table_view.contentOffset = CGPointMake(0, 0);
        table_view.userInteractionEnabled = YES; 
        reloading = NO;   
    }
    NSDictionary *response_data = [[request responseString] JSONValue];
    NSArray *capability_array = [response_data objectForKey:@"capabilities"];
    NSArray *experiences_array = [response_data objectForKey:@"experiences"];
    //Fill Modules with recieved data
    StaffOutHeader *staff_out_header = [[StaffOutHeader alloc] initWithFrame:CGRectMake(0, 0, 320, 117)];
    staff_out_header.delegate = self;
    UserCapabilitiesProfileModule *my_capabilities = [[UserCapabilitiesProfileModule alloc] initWithArray:capability_array];
    PendingRequestsModule *pending_module = [[PendingRequestsModule alloc] initRequesting];
    pending_module.delegate = self;
    module_array = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:staff_out_header, my_capabilities, pending_module, nil]];
    [my_capabilities release];
    [pending_module release];
    
    [table_view reloadData];
}
-(void)respondToStaffYourselfButton
{
    [self goToProposalPage];
}
-(void)reloadMyTableView
{
    [table_view reloadData];
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
    printf("Size of nexss : %d", module_array.count);
    return module_array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  [[module_array objectAtIndex:indexPath.row] frame].size.height + 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell.contentView addSubview:[module_array objectAtIndex:indexPath.row]];
    return cell;
}
//--------------End TABLE VIEW METHOD END TABLE VIEW METHODS END TABLE VIEW METHODS-----------
- (void)dealloc
{
    [super dealloc];
}
-(IBAction)goToProposalPage
{
    [delegate goToProposal];
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
    what_waiting.backgroundColor = [UIColor clearColor];
    what_waiting.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
    [what_waiting setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
    table_view.allowsSelection = NO;
    table_view.backgroundColor = [UIColor clearColor];
    table_view.separatorColor = [UIColor clearColor];
    refresh_header = [[PullRefreshHeader alloc] initWithFrame:CGRectMake(0, -70, 320, 70)];
    [table_view addSubview:refresh_header];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [refresh_header setStartPoint:table_view.contentOffset];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([refresh_header isLoaded])
    {
        table_view.contentOffset = CGPointMake(0, -refresh_header.frame.size.height);
        table_view.userInteractionEnabled = NO;
        return;
    }
    if (![refresh_header isLoaded])
    {
        [refresh_header rotate:table_view.contentOffset];
        return;
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([refresh_header isLoaded])
    {
        table_view.contentOffset = CGPointMake(0, -refresh_header.frame.size.height);
        table_view.userInteractionEnabled = NO;
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSMutableString *user_information = [[NSMutableString alloc] initWithString:@"http://helium.staffittome.com/apis/"];
        [user_information appendString:[NSString stringWithFormat:@"%d", app_delegate.user_state_information.my_user_info.user_id]];
        printf("USERID: %d", app_delegate.user_state_information.my_user_info.user_id);
        [user_information appendString:@"/profile_details"];
        //Perform the accessing of fthe server.
        NSURL *url = [NSURL URLWithString:user_information];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"GET"];
        
        ///Finish request
        [request setTimeOutSeconds:30];
        [request setDelegate:self];
        [request startAsynchronous];
        reloading = YES;
        [self performSelector:@selector(finishedLoadingSuggestedJob) withObject:nil afterDelay:30];
    }
}
-(void)finishedLoadingSuggestedJob
{
    [refresh_header reset];
    table_view.contentOffset = CGPointMake(0, 0);
    table_view.userInteractionEnabled = YES; 
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
