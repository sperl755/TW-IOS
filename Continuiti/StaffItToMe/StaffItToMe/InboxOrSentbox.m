//
//  InboxOrSentbox.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InboxOrSentbox.h"


@implementation InboxOrSentbox
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
    // Do any additional setup after loading the view from its nib.
    my_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 367)];
    my_table.delegate = self;
    my_table.dataSource = self;
    my_table.backgroundColor = [UIColor clearColor];
    my_table.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:my_table];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *the_cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    CustomCategoryCell *my_category;
    if (the_cell == nil)
    {
        the_cell = [[UITableViewCell alloc] init];
    }
    switch (indexPath.row) {
        case 0:
            my_category = [[CustomCategoryCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andCategory:@"Inbox" andDetail:@""];
            break;
        case 1:
            my_category = [[CustomCategoryCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andCategory:@"Outbox" andDetail:@""];
            break;
    }
    the_cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [the_cell.contentView addSubview:my_category];
    return the_cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            [delegate goToInbox];
            break;
        case 1:
            [delegate goToSentbox];
            break;
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
