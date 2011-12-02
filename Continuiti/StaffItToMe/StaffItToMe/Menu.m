//
//  Menu.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"
#import "StaffItToMeAppDelegate.h"

@implementation Menu
@synthesize filter_screen;
#define JOB_Z_ORDER 2
#define BUTTON_Z_ORDER 9
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        google_map = [[GoogleMapsMenu alloc] initWithFrame:CGRectMake(0, 35, 320, 331) withLocation:app_delegate.user_state_information.my_user_location];
        [google_map changeCenter:app_delegate.user_state_information.my_user_location];
        [self addSubview:google_map];
		list_or_map = 0;
        map_button = [UIButton buttonWithType:UIButtonTypeCustom];
        map_button.frame = CGRectMake(0, 0, 100, 35);
        [map_button setBackgroundImage:[UIImage imageNamed:@"MapButtonPressed"] forState:UIControlStateNormal];
        [map_button addTarget:self action:@selector(mapAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:map_button];
        list_button = [UIButton buttonWithType:UIButtonTypeCustom];
        list_button.frame = CGRectMake(map_button.frame.origin.x + map_button.frame.size.width, 0, 100, 35);
        [list_button setBackgroundImage:[UIImage imageNamed:@"ListButton"] forState:UIControlStateNormal];
        [list_button addTarget:self action:@selector(listAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:list_button];
        option_button = [UIButton buttonWithType:UIButtonTypeCustom];
        option_button.frame = CGRectMake(list_button.frame.origin.x + list_button.frame.size.width, 0, 120, 35);
        [option_button setBackgroundImage:[UIImage imageNamed:@"OptionsButton"] forState:UIControlStateNormal];
        [option_button addTarget:self action:@selector(optionAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:option_button];
        seperator_view = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 101, 35)];
        seperator_view.image = [UIImage imageNamed:@"Seperators"];
        [self addSubview:seperator_view];
        [option_button setBackgroundImage:[UIImage imageNamed:@"OptionsButton"] forState:UIControlStateNormal];
        industry_search = [[IndustrySearchController alloc] initWithNibName:nil bundle:nil];
        list_or_map = 1;
        //[self updateCriteriaWithoutLoad];
		
    }
    return self;
}
-(void)optionAction
{
    if (filter_screen != nil)
    {
        if (google_map != nil)
        {
            [self sendSubviewToBack:google_map];   
        }
        if (list_screen != nil)
        {
            [self sendSubviewToBack:list_screen];
        }
        //Set the buttons to their appropriate Pictures
        [map_button setBackgroundImage:[UIImage imageNamed:@"MapButton"] forState:UIControlStateNormal];
        [list_button setBackgroundImage:[UIImage imageNamed:@"ListButton"] forState:UIControlStateNormal];
        [option_button setBackgroundImage:[UIImage imageNamed:@"OptionsButtonPressed"] forState:UIControlStateNormal];
        return;
    }
        /*[google_map setDie];
        [google_map removeFromSuperview];
        [google_map release];
        google_map = nil;*/
    filter_screen = [[SearchFilterScreen alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [filter_screen setFrame:CGRectMake(0, 35,320, 331)];
    [filter_screen setDelegate:self];
    [self addSubview:filter_screen];
    //Set the buttons to their appropriate Pictures
    [map_button setBackgroundImage:[UIImage imageNamed:@"MapButton"] forState:UIControlStateNormal];
    [list_button setBackgroundImage:[UIImage imageNamed:@"ListButton"] forState:UIControlStateNormal];
    [option_button setBackgroundImage:[UIImage imageNamed:@"OptionsButtonPressed"] forState:UIControlStateNormal];
}
-(void)goToIndustryPage
{
    
}
-(void)mapAction
{
    list_or_map = 1;
    if (google_map != nil)
    {
        if (list_screen != nil)
        {
            [self sendSubviewToBack:list_screen];
            [google_map setFilterText:[list_screen getFilterText]];
        }
        if (filter_screen != nil)
        {
            [self sendSubviewToBack:filter_screen];
        }
        //Set the buttons to their appropriate Pictures
        [map_button setBackgroundImage:[UIImage imageNamed:@"MapButtonPressed"] forState:UIControlStateNormal];
        [option_button setBackgroundImage:[UIImage imageNamed:@"OptionsButton"] forState:UIControlStateNormal];
        [list_button setBackgroundImage:[UIImage imageNamed:@"ListButton"] forState:UIControlStateNormal];
        return;
    }
    if (list_screen != nil)
    {
        [google_map setFilterText:[list_screen getFilterText]];
    }
    [self updateCriteria];
}
-(void)updateCriteriaWithoutLoad
{
    NSMutableString *job_list_address = [NSMutableString stringWithString:@"https://helium.staffittome.com/apis/search/"];
	StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
	//Acesss the server with solr parameters
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_list_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setValidatesSecureCertificate:NO];
    [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request setPostValue:[NSString stringWithFormat:@"%f", app_delegate.user_state_information.my_user_location.coordinate.latitude] forKey:@"latitude"];
    [request setPostValue:[NSString stringWithFormat:@"%f", app_delegate.user_state_information.my_user_location.coordinate.longitude] forKey:@"longitude"];
    [request setPostValue:app_delegate.user_state_information.distance_search_type forKey:@"distance"];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
}
-(void)listAction
{
    if (list_screen != nil)
    {
        if (google_map != nil)
        {
            [self sendSubviewToBack:google_map];
            [list_screen setFilterText:[google_map getFilterText]];
        }
        if (filter_screen != nil)
        {
            [self sendSubviewToBack:filter_screen];
        }
        //Change the buttons to the appropriate pictures.
        [map_button setBackgroundImage:[UIImage imageNamed:@"MapButton"] forState:UIControlStateNormal];
        [list_button setBackgroundImage:[UIImage imageNamed:@"ListButtonPressed"] forState:UIControlStateNormal];
        [option_button setBackgroundImage:[UIImage imageNamed:@"OptionsButton"] forState:UIControlStateNormal];
        [list_screen reloadMyJobTable];
        return;
    }
    list_screen = [[ListViewMenu alloc] initWithFrame:CGRectMake(0, 35, 320, 331)];
    [self addSubview:list_screen];
    //Change the buttons to the appropriate pictures.
    [map_button setBackgroundImage:[UIImage imageNamed:@"MapButton"] forState:UIControlStateNormal];
    [list_button setBackgroundImage:[UIImage imageNamed:@"ListButtonPressed"] forState:UIControlStateNormal];
    [option_button setBackgroundImage:[UIImage imageNamed:@"OptionsButton"] forState:UIControlStateNormal];
    if (google_map != nil)
    {
        [list_screen setFilterText:[google_map getFilterText]];
    }
}
-(void)setupListView
{
	if (list_or_map == 0) {
	}
	else if (list_or_map == 1)
	{
		[google_map removeFromSuperview];
	}
	else if (list_or_map == 2)
	{
		[list_screen removeFromSuperview];
	}
	list_or_map = 2;
	list_screen = [[ListViewMenu alloc] initWithFrame:CGRectMake(0, 40, 320, 400)];
	[self insertSubview:list_screen atIndex:0];
}
-(void)setupGoogleMap
{
	if (list_or_map == 0) {
	}
	else if (list_or_map == 1)
	{
		[google_map removeFromSuperview];
	}
	else if (list_or_map == 2)
	{
		[list_screen removeFromSuperview];
	}
	list_or_map = 1;
    google_map = [[GoogleMapsMenu alloc] initWithFrame:CGRectMake(0, 30, 320, 400) withLocation:nil];
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    [google_map changeCenter:app_delegate.user_state_information.my_user_location];
	[self insertSubview:google_map atIndex:0];
}
-(void)updateCriteria
{
    NSMutableString *job_list_address = [NSMutableString stringWithString:@"https://helium.staffittome.com/apis/search/"];
	StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
	//Acesss the server with solr parameters
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_list_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setValidatesSecureCertificate:NO];
    [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request setPostValue:[NSString stringWithFormat:@"%f", app_delegate.user_state_information.my_user_location.coordinate.latitude] forKey:@"latitude"];
    [request setPostValue:[NSString stringWithFormat:@"%f", app_delegate.user_state_information.my_user_location.coordinate.longitude] forKey:@"longitude"];
    [request setPostValue:app_delegate.user_state_information.distance_search_type forKey:@"distance"];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, -50, 320, 480)];
    [self addSubview:load_view];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [load_view removeFromSuperview];
    printf("This is the job json file: %s", [[request responseString] UTF8String]);
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate.user_state_information populateJobArrayWithJSONString:[request responseString]];
    
    if (list_or_map == 1)
    {
        if (google_map != nil)
        {
            if (list_screen != nil)
            {
                [self sendSubviewToBack:list_screen];
            }
            if (filter_screen != nil)
            {
                [self sendSubviewToBack:filter_screen];
            }
            //Set the buttons to their appropriate Pictures
            [map_button setBackgroundImage:[UIImage imageNamed:@"MapButtonPressed"] forState:UIControlStateNormal];
            [option_button setBackgroundImage:[UIImage imageNamed:@"OptionsButton"] forState:UIControlStateNormal];
            [list_button setBackgroundImage:[UIImage imageNamed:@"ListButton"] forState:UIControlStateNormal];
            return;
        }
        google_map = [[GoogleMapsMenu alloc] initWithFrame:CGRectMake(0, 35, 320, 331) withLocation:nil];
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        [google_map changeCenter:app_delegate.user_state_information.my_user_location];
        [self addSubview:google_map];
        //Set the buttons to their appropriate Pictures
        [map_button setBackgroundImage:[UIImage imageNamed:@"MapButtonPressed"] forState:UIControlStateNormal];
        [option_button setBackgroundImage:[UIImage imageNamed:@"OptionsButton"] forState:UIControlStateNormal];
        [list_button setBackgroundImage:[UIImage imageNamed:@"ListButton"] forState:UIControlStateNormal];
    }
    else if (list_or_map == 2)
    {
        if (list_screen != nil)
        {
            [list_screen removeFromSuperview];
        }
        list_screen = [[ListViewMenu alloc] initWithFrame:CGRectMake(0, 35, 320, 331)];
        [self addSubview:list_screen];
        //Change the buttons to the appropriate pictures.
        [map_button setBackgroundImage:[UIImage imageNamed:@"MapButton"] forState:UIControlStateNormal];
        [list_button setBackgroundImage:[UIImage imageNamed:@"ListButtonPressed"] forState:UIControlStateNormal];
        [option_button setBackgroundImage:[UIImage imageNamed:@"OptionsButton"] forState:UIControlStateNormal];
    }
}
-(void)switchView
{
	//If the List is displayed
	if (list_or_map)
	{
		[list_screen removeFromSuperView];
		list_or_map = NO;
		google_map = [[GoogleMapsMenu alloc] initWithFrame:[UIScreen mainScreen].applicationFrame withLocation:nil];
		[self addSubview:google_map];
	}
	else
	{
		[google_map removeFromSuperview];
		list_or_map = YES;
		list_screen = [[ListViewMenu alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
		[self addSubview:list_screen];
	}

}
-(void)viewAndApplyForJobs
{
    printf("I just got all the jobs in the world");
}
-(void)checkIntoMyJobs
{
    printf("I ran errands for ms potts!");
}


- (void)dealloc
{
    [google_map release];
    [filter_screen release];
    [super dealloc];
}

@end
