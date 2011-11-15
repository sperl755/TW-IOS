//
//  MyJobsAndApplications.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyJobsAndApplications.h"
#import "StaffItToMeAppDelegate.h"

@implementation MyJobsAndApplications
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)getApplications
{
    JobApplicationsModule *job_application_module = [[JobApplicationsModule alloc] init];
    job_application_module.delegate = self;
    module_array = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:my_header, my_jobs_module, job_application_module, nil]];
    //[my_jobs_module release];
    my_table_view = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 369)];
    my_table_view.allowsSelection = NO;
    my_table_view.delegate = self;
    my_table_view.dataSource = self;
    my_table_view.separatorColor = [UIColor clearColor];
    my_table_view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:my_table_view];
    
}
-(void)reloadTableData
{
    [my_table_view reloadData];
}
-(void)manualButtonPressedOnJobInArrayPosition:(int)the_array_position
{
    [delegate goToManualCheckinWithJobArrayPosition:the_array_position];
}
-(void)checkinButtonPressedOnJobInArrayPosition:(int)the_array_position
{
    [delegate goToCheckinWithJobArrayPosition:the_array_position];
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
    [cell.contentView addSubview:[module_array objectAtIndex:indexPath.row]];
    return cell;
}
//--------------End TABLE VIEW METHOD END TABLE VIEW METHODS END TABLE VIEW METHODS-----------
- (void)dealloc
{
    [module_array release];
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
    [delegate goToFacebookBroadcast];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
    background.frame = CGRectMake(0, 0, 320, 480);
    [self.view insertSubview:background atIndex:0];
    my_header = [[UserInformationHeader alloc] init];
    my_header.delegate = self;
    my_jobs_module = [[MyJobsModule alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    my_jobs_module.delegate = self;
}
-(void)goToInbox
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate setCurrentTabBar:@"Messages"];
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