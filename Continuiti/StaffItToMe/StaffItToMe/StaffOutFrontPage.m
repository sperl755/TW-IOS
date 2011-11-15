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
        [user_information appendString:@"/profile_details"];
        //Perform the accessing of fthe server.
        NSURL *url = [NSURL URLWithString:user_information];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"GET"];
        
        ///Finish request
        [request setTimeOutSeconds:30];
        [request setDelegate:self];
        [request startAsynchronous];
    }
    return self;
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    printf("\nThis is theuser info: %s", [[request responseString] UTF8String]);
    
    NSDictionary *response_data = [[request responseString] JSONValue];
    NSArray *capability_array = [response_data objectForKey:@"capabilities"];
    NSArray *experiences_array = [response_data objectForKey:@"experiences"];
    //Fill Modules with recieved data
    UserCapabilitiesProfileModule *my_capabilities = [[UserCapabilitiesProfileModule alloc] initWithArray:capability_array];
    PendingRequestsModule *pending_module = [[PendingRequestsModule alloc] initWithArray:[NSArray arrayWithObjects:nil]];
    module_array = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:my_capabilities, pending_module, nil]];
    [my_capabilities release];
    [pending_module release];
    
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