//
//  AUserProfileController.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AUserProfileController.h"
#import "StaffItToMeAppDelegate.h"
#import "JSON.h"

@implementation AUserProfileController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil jsonInformation:(NSString*)json_string_info
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        printf("The User JSON Info: %s", [json_string_info UTF8String]);
        NSDictionary *user_information = [json_string_info JSONValue];
        
        UIImageView *header_shadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        
        header_shadow.image = [UIImage imageNamed:@"header_shadow"];
        [self.view addSubview:header_shadow];
        
        //Setup the available switch background.
        UIImageView *my_available_switch_background = [[UIImageView alloc] initWithFrame:CGRectMake(230, 10, 89, 58)];
        [my_available_switch_background setImage:[UIImage imageNamed:@"available_widget"]];
        [self.view addSubview:my_available_switch_background];
        
        //Setup Containers.
        //setup prof pic
        UIImageView *my_profile_picture = [[UIImageView alloc] initWithFrame:CGRectMake(16, 14, 48, 50)];
        [self.view addSubview:my_profile_picture];
        
        
        //setup cover that makes thing nicer
        UIImageView *my_profile_shiner = [[UIImageView alloc] initWithFrame:CGRectMake(11, 9, 58, 60)];
        [my_profile_shiner setImage:[UIImage imageNamed:@"profile_pic_overlay"]];
        [self.view addSubview:my_profile_shiner];
        
        
        //setup user name
        UILabel *my_profile_name = [[UILabel alloc] initWithFrame:CGRectMake(74, 18, 100, 22)];
        [self.view addSubview:my_profile_name];
        
        //SetupButton
        UIButton *my_connection_button = [UIButton buttonWithType:UIButtonTypeCustom];
        my_connection_button.frame = CGRectMake(73, 36, 93, 24.5);
        [my_connection_button setBackgroundImage:[UIImage imageNamed:@"connections_box"] forState:UIControlStateNormal];
        [self.view addSubview:my_connection_button];
        
        //setupButtonLabel
        UILabel *connections_label = [[UILabel alloc] initWithFrame:CGRectMake(89, 40, 73, 22)];
        [self.view addSubview:connections_label];
        
        //Setup Connection Icon
        UIImageView *connections_icon = [[UIImageView alloc] initWithFrame:CGRectMake(79.5, 45, 6, 8.5)];
        connections_icon.image = [UIImage imageNamed:@"connection_icon"];
        [self.view addSubview:connections_icon];
        
        
        //Set User Profile Picture
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        NSMutableString *user_picture_string = [NSMutableString stringWithString:@"http://graph.facebook.com/"];
        [user_picture_string appendString:app_delegate.user_state_information.facebook_id];
        [user_picture_string appendString:@"/picture?type=large"];
        
        //[my_profile_picture setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user_picture_string]]]];
        [my_profile_picture setImage:[UIImage imageNamed:@"default_profile_pic"]];
        
        //Display users display name
        my_profile_name.text = [user_information objectForKey:@"name"];
        
        my_profile_name.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12];
        my_profile_name.backgroundColor = [UIColor clearColor];
        connections_label.backgroundColor = [UIColor clearColor];
        connections_label.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        
        //Display connections box text
        NSMutableString *connections_text = [[NSMutableString alloc] init];
        NSString *friend_count = [NSString stringWithFormat:@"%d ", app_delegate.user_state_information.my_facebook_friends.count];
        connections_label.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        [connections_text appendString:friend_count];
        [connections_text appendString:@"Connections"];
        [connections_label setText:connections_text];
        
        @try 
        {
            
            //Fill Modules with recieved data
            NSArray *capability_array = [user_information objectForKey:@"capabilities"];
            NSArray *experiences_array = [user_information objectForKey:@"experiences"];
            AUserSummaryModule *user_summary = [[AUserSummaryModule alloc] initWithString:[user_information objectForKey:@"summary"] andName:[user_information objectForKey:@"name"]];
            AUserCapabilitiesModule *user_capabilities = [[AUserCapabilitiesModule alloc] initWithArray:capability_array andName:[user_information objectForKey:@"name"]];
            AUserExperienceModule *user_experience = [[AUserExperienceModule alloc] initWithArray:experiences_array andName:[user_information objectForKey:@"name"]];
            module_array = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:user_summary, user_capabilities, user_experience, nil]];
        }
        @catch (NSException *exception) {
        }
        
        
        my_table_view = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 320, 307)];
        my_table_view.delegate = self;
        my_table_view.dataSource = self;
        my_table_view.backgroundColor = [UIColor clearColor];
        my_table_view.separatorColor = [UIColor clearColor];
        [self.view addSubview:my_table_view];
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
    return  [[module_array objectAtIndex:indexPath.row] frame].size.height + 10;
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
