//
//  FacebookBroadcast.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookBroadcast.h"
#import "StaffItToMeAppDelegate.h"

@implementation FacebookBroadcast
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        [self.view addSubview:load_view];

        begin = 0;
        end = 24;
        table_size = 25;
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
        background.frame = CGRectMake(0, 0, 320, 480);
        [self.view insertSubview:background atIndex:0];
        // Custom initialization
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        filtered_people = [[NSMutableArray alloc] initWithCapacity:app_delegate.user_state_information.my_facebook_friends.count];
        original_people = [[NSMutableArray alloc] initWithCapacity:app_delegate.user_state_information.my_facebook_friends.count];
        filtered_facebook_ids = [[NSMutableArray alloc] initWithCapacity:app_delegate.user_state_information.my_facebook_friends.count];
        original_facebook_ids = [[NSMutableArray alloc] initWithCapacity:app_delegate.user_state_information.my_facebook_friends.count];
        for (int i = 0; i < app_delegate.user_state_information.my_facebook_friends.count; i++)
        {
            [original_people addObject:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:i] name]];
            [original_facebook_ids addObject:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:i] friend_id]];
            [filtered_people addObject:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:i] name]];
            [filtered_facebook_ids addObject:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:i] friend_id]];
        }
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 375) style:UITableViewStylePlain];
        table.dataSource = self;
        table.delegate = self;
        table.backgroundColor = [UIColor clearColor];
        table.separatorColor = [UIColor clearColor];
        table.allowsSelection = NO;
        pre_made_cells = [[NSMutableArray alloc] initWithCapacity:original_people.count];
        for (int i = 0; i < original_people.count; i++)
        {
            FacebookFriendEICell *friend_information = [[FacebookFriendEICell alloc] initWithFriendName:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:i] name] friend_id:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:i] friend_id]];   
            [pre_made_cells addObject:friend_information];
            [friend_information release];
        }
        search_bar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        search_bar.delegate = self;
        search_bar.tintColor = [UIColor blackColor];
        search_bar.keyboardType = UIKeyboardTypeAlphabet;
        table.tableHeaderView = search_bar;
        search_dc = [[UISearchDisplayController alloc] initWithSearchBar:search_bar contentsController:self];
        search_dc.searchResultsDataSource = self;
        search_dc.searchResultsDelegate = self;
        [self.view addSubview:table];
        [load_view removeFromSuperview];
        
    }
    return self;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", search_bar.text];
    filtered_people = [[NSMutableArray alloc] initWithArray:[original_people filteredArrayUsingPredicate:predicate]];
    filtered_facebook_ids = [[NSMutableArray alloc] initWithCapacity:filtered_people.count];
    for (int i = 0; i < filtered_people.count; i++)
    {
        for (int j = 0; j < app_delegate.user_state_information.my_facebook_friends.count; j++)
        {
            if ([[filtered_people objectAtIndex:i] isEqualToString:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:j] name]])
            {
                [filtered_facebook_ids addObject:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:j] friend_id]];
            }
        }
    }

}
- (void)dealloc
{
    [super dealloc];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;//height of an FFEICell plus five
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    if (tableView == table)
    {
        if (table_size > app_delegate.user_state_information.my_facebook_friends.count)
        {
            end = app_delegate.user_state_information.my_facebook_friends.count -1;  
        }
        return app_delegate.user_state_information.my_facebook_friends.count; 
    }
    else
    {
        return filtered_people.count; 
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*tableView.backgroundView = background;
    tableView.separatorColor = [UIColor clearColor];
    tableView.allowsSelection = NO;*/
    UITableViewCell *cell;
    if (tableView == table)
    {
        UITableViewCellStyle style = UITableViewCellStyleDefault;
        NSString *cell_label = [NSString stringWithFormat:@"Cell%d", indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:cell_label];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:cell_label] autorelease];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:[pre_made_cells objectAtIndex:indexPath.row]];
        }   
    }
    else
    {
        UITableViewCellStyle style = UITableViewCellStyleDefault;
        cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"Cell"] autorelease];
        NSArray *people = (tableView == table) ? original_people : filtered_people;
        NSString *name = [people objectAtIndex:indexPath.row];
        FacebookFriendEICell *friend_information = [[FacebookFriendEICell alloc] initWithFriendName:name friend_id:[filtered_facebook_ids objectAtIndex:indexPath.row]];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.textLabel.text = name;
        [cell.contentView addSubview:friend_information];
        [friend_information release];
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    for (int i = 0; i < app_delegate.user_state_information.my_facebook_friends.count; i++)
    {
        if ([[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:i] name] isEqualToString:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]])
        {
            index_in_real_array = i;
            printf("%d", index_in_real_array);
            [delegate goToFriendFacebookBroadcast:index_in_real_array];
        }
    }
}
-(IBAction)chooseFriend
{
    
    friend_menu = [[UIActionSheet alloc] initWithTitle:@"Choose Friend\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    [self.view addSubview:table];
   // [friend_menu showInView:self.view];
    //[friend_menu addSubview:friend];
    //[friend_menu addSubview:table];
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
    friend_choice.delegate = self;
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
