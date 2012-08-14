//
//  ConversationViewController.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConversationViewController.h"

#define KEYBOARDOFFSET 170
@implementation ConversationViewController
@synthesize table_of_convos;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andMessageArray:(NSArray*)the_messages_array andDateArray:(NSArray*)the_dates_array
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        list_of_messages = [[NSMutableArray alloc] initWithCapacity:11];
        date_of_messages = [[NSMutableArray alloc] initWithCapacity:11];
        bubble_item_array = [[NSMutableArray alloc] initWithCapacity:11];
        for (int i = 0; i < the_messages_array.count; i++)
        {
            [list_of_messages addObject:[the_messages_array objectAtIndex:i]];
            [date_of_messages addObject:[the_dates_array objectAtIndex:i]];
            BubbleMessageView *message = [[BubbleMessageView alloc] initWithFrame:CGRectMake(0, 20, 320, 200) andMessage:[list_of_messages objectAtIndex:i] andSenderInteger:1 andDate:[date_of_messages objectAtIndex:i]];
            [bubble_item_array addObject:message];
            [message release];
        }
    }
    return self;
}

- (void)dealloc
{
    [list_of_messages removeAllObjects];
    [list_of_messages release];
    [date_of_messages removeAllObjects];
    [date_of_messages release];
    [bubble_item_array removeAllObjects];
    [bubble_item_array release];
    table_of_convos = nil;
    [table_of_convos release];
    [super dealloc];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[bubble_item_array objectAtIndex:indexPath.row] frame].size.height;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [bubble_item_array count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *the_cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"A Cell"];
    [the_cell.contentView addSubview:[bubble_item_array objectAtIndex:indexPath.row]];
    return the_cell;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    table_of_convos.frame = CGRectMake(table_of_convos.frame.origin.x, table_of_convos.frame.origin.y - KEYBOARDOFFSET, table_of_convos.frame.size.width, table_of_convos.frame.size.height);
    the_text.frame = CGRectMake(the_text.frame.origin.x, the_text.frame.origin.y - KEYBOARDOFFSET, the_text.frame.size.width, the_text.frame.size.height);
    send_button.frame = CGRectMake(send_button.frame.origin.x, send_button.frame.origin.y - KEYBOARDOFFSET, send_button.frame.size.width, send_button.frame.size.height);
    UIBarButtonItem *rightDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(textFieldDidEndEditing)];
    self.navigationItem.rightBarButtonItem = rightDone;
    [rightDone release];
    
}
-(void)textFieldDidEndEditing
{
    table_of_convos.frame = CGRectMake(table_of_convos.frame.origin.x, table_of_convos.frame.origin.y + KEYBOARDOFFSET, table_of_convos.frame.size.width, table_of_convos.frame.size.height);
    the_text.frame = CGRectMake(the_text.frame.origin.x, the_text.frame.origin.y + KEYBOARDOFFSET, the_text.frame.size.width, the_text.frame.size.height);
    send_button.frame = CGRectMake(send_button.frame.origin.x, send_button.frame.origin.y + KEYBOARDOFFSET, send_button.frame.size.width, send_button.frame.size.height);
    [the_text resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    the_text.delegate = self;
    table_of_convos.allowsSelection = NO;
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
