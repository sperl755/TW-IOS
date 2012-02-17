//
//  CompanyInformationScreen.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CompanyInformationScreen.h"
#import "StaffItToMeAppDelegate.h"


@implementation CompanyInformationScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithJSONInformation:(NSString*)json_information
{
    if ((self = [super init]))
    {
        StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        background          = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
        background.frame    = CGRectMake(0, 0, 320, 480);
        [self.view insertSubview:background atIndex:0];
        printf("Company info: %s", [json_information UTF8String]);
        
        NSDictionary *json_job_info = [json_information JSONValue];
        NSMutableDictionary *json_job_info_mutable = [NSMutableDictionary dictionaryWithDictionary:json_job_info];
        
        
        company_header = [[CompanyHeader alloc] initWithName:[[json_job_info_mutable objectForKey:@"company"] objectForKey:@"name"] andHeaderPicture:[[json_job_info_mutable objectForKey:@"company"] objectForKey:@"company_url"]];
        
        
        summary = [[CompanySummary alloc] initWithJSONDictionary:json_job_info_mutable];
        
       // summary = [[CompanySummary alloc] initWithSummary:string andDescription:[[json_job_info_mutable objectForKey:@"company"] objectForKey:@"description"]];   
        
        basic_info      = [[BasicCompanyInformation alloc] initWithMutableDictionary:json_job_info_mutable]; 
        module_array    = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:company_header, summary, basic_info, nil]];
        
        search_table                    = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 370)];
        search_table.delegate           = self;
        search_table.dataSource         = self;
        search_table.allowsSelection    = NO;
        search_table.separatorColor     = [UIColor clearColor];
        search_table.backgroundColor    = [UIColor clearColor];
        [self.view addSubview:search_table];
    }
    return self;
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
