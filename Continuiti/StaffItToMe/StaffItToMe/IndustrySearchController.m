//
//  IndustrySearchController.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IndustrySearchController.h"
#import "StaffItToMeAppDelegate.h"

@implementation IndustrySearchController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        // Custom initialization
        
        NSMutableString *industry_list_address = [NSMutableString stringWithString:@"https://helium.staffittome.com/moreapis/industries"];
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        //Acesss the server with solr parameters
        //Perform the accessing of the server.
        NSURL *url = [NSURL URLWithString:industry_list_address];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        [request setValidatesSecureCertificate:NO];
        [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
        [request setTimeOutSeconds:30];
        [request setDelegate:self];
        [request startAsynchronous];
        UIImageView *table_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
        table_background.frame = CGRectMake(0, 0, 320, 380);
        [self.view addSubview:table_background];
        
        load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, -50, 320, 480)];
        [self.view addSubview:load_view];
        
    }
    return self;
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [load_view removeFromSuperview];
    search_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, 320, 370) style:UITableViewStylePlain];
    search_table.dataSource = self;
    search_table.delegate = self;
    search_table.separatorColor = [UIColor clearColor];
    search_table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:search_table];
    //Get the industries
    NSArray *industries_from_json = [[request responseString] JSONValue];
    NSMutableArray *industry_names = [[NSMutableArray alloc] initWithCapacity:industries_from_json.count];
    [industry_names addObject:@"All"];
    for (int i = 0; i < industries_from_json.count; i++)
    {
        [industry_names addObject:[[industries_from_json objectAtIndex:i] objectAtIndex:0]];
    }
    list_of_industries = [[NSArray alloc] initWithArray:industry_names];
}

-(void)goToInbox
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate setCurrentTabBar:@"Messages"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (list_of_industries.count + 1);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([[list_of_industries objectAtIndex:indexPath.row-1] isEqualToString:@"All"])
    {
        app_delegate.user_state_information.industry_search_type = @"";
    }
    else
    {
        app_delegate.user_state_information.industry_search_type = [list_of_industries objectAtIndex:indexPath.row-1];
    }
    [search_table reloadData];
    
    //Pop to root view controller.
    [delegate leaveIndustrySearch];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 25.5;
    }
    return 42;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //create cell
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row != 0)
    {
        CustomCategoryCell *my_category;
        my_category = [[CustomCategoryCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andCategory:[list_of_industries objectAtIndex:indexPath.row-1] andDetail:@""];
        [my_category hideArrow];
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        if ([[list_of_industries objectAtIndex:indexPath.row-1] isEqualToString:app_delegate.user_state_information.industry_search_type] || ([[list_of_industries objectAtIndex:indexPath.row-1] isEqualToString:@"All"] && [app_delegate.user_state_information.industry_search_type isEqualToString:@""]))
        {
            [my_category addCheckmark];
        }
        if (indexPath.row >= list_of_industries.count-1)
        {
            [my_category setLast];
        }
        [cell.contentView addSubview:my_category];   
    }
    else if (indexPath.row == 0)
    {
        UIImageView *industry_header = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 310, 33.5)];
        industry_header.image = [UIImage imageNamed:@"industry_header"];
        [cell.contentView addSubview:industry_header];
    }
    return cell;
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
