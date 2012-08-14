    //
//  MyJobsController.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyJobsController.h"
#import "StaffItToMeAppDelegate.h"

@implementation MyJobsController
@synthesize my_delegate;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    my_table_view = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 370) style:UITableViewStylePlain];
    my_table_view.delegate = self;
    my_table_view.allowsSelection = NO;
    my_table_view.dataSource = self;
    [self.view addSubview:my_table_view];
	my_array_of_jobs = [[NSMutableArray alloc] initWithCapacity:11];
	/*top_arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopArrow"]];
	top_arrow.frame = CGRectMake(0, 50, 320, 30);
	top_arrow.hidden = YES;
	[self.view addSubview:top_arrow];
	*/
	/*bottom_arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BottomArrow"]];
	bottom_arrow.frame = CGRectMake(0, 350, 320, 30);
	bottom_arrow.hidden = NO;
	[self.view addSubview:bottom_arrow];*/
    StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate.user_state_information populateMyJobArray];
	for (int i = 0; i < delegate.user_state_information.my_jobs.count; i++)
	{
		OneOfMyJobs *my_job_test_view2 = [[OneOfMyJobs alloc] initWithFrame:CGRectMake(0, 0, 200, 180) andPositionInArray:i];
        [my_job_test_view2 setJob_delegate:self];
		//[self.view addSubview:my_job_test_view2];
		[my_array_of_jobs addObject:my_job_test_view2];
		[my_job_test_view2 release];
	}
	current_job = 0;
	[super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayTheCurrentJobHistoryToLookAt) name:@"JobHistoryReadyToBeDisplayed" object:nil];
    //Setup the inbox button in the top right
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"MessageButtonNone@2x.png"];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    UIBarButtonItem *bar_item = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(goToInbox) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = bar_item;
    [bar_item release];
}
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
    return my_array_of_jobs.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  [[my_array_of_jobs objectAtIndex:indexPath.row] frame].size.height;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] init] autorelease];
    }
    [cell.contentView addSubview:[my_array_of_jobs objectAtIndex:indexPath.row]];
    return cell;
}
-(void)goToInbox
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate setCurrentTabBar:@"Inbox"];
}
-(void)displayJobHistory:(int)the_position
{
    [my_delegate goToJobHistory:the_position];
}
-(void)enterManualTime:(int)the_position
{
    [my_delegate goToManualTimeEntry:the_position];
}
-(void)goToCheckout:(int)the_position
{
    [my_delegate goToCheckoutScreen:the_position];
}
-(void)removeJobHistoryDetail
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)removeManualTimeJobEntryDetail
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)removeCheckOutEntryDetail
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *the_touch = [touches anyObject];
	CGPoint location = [the_touch locationInView:self.view];
	if (location.y > 350)
	{
		if (current_job >= (my_array_of_jobs.count-1)/2)
		{
			return;
		}
		top_arrow.hidden = NO;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:1];
		[UIView setAnimationRepeatCount:0];
		for (int i = 0; i < my_array_of_jobs.count; i++)
		{
			[[my_array_of_jobs objectAtIndex:i] setFrame:CGRectMake(0, [[my_array_of_jobs objectAtIndex:i] frame].origin.y - 480, 320, 480)];
		}
		[UIView commitAnimations];
		current_job++;
		if (current_job >= (my_array_of_jobs.count-1)/2)
		{
			bottom_arrow.hidden = YES;
		}
	}
	else if (location.y < 60)
	{
		if (current_job == 0)
		{
			return;
		}
		bottom_arrow.hidden = NO;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:1];
		[UIView setAnimationRepeatCount:0];
		for (int i = 0; i < my_array_of_jobs.count; i++)
		{
			[[my_array_of_jobs objectAtIndex:i] setFrame:CGRectMake(0, [[my_array_of_jobs objectAtIndex:i] frame].origin.y + 480, 320, 480)];
		}
		[UIView commitAnimations];
		current_job--;
		if (current_job == 0)
		{
			top_arrow.hidden = YES;
		}
	}
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[my_array_of_jobs release];
    [super dealloc];
}


@end
