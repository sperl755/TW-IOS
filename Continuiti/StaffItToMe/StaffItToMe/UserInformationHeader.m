//
//  UserInformationHeader.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserInformationHeader.h"
#import "StaffItToMeAppDelegate.h"


@implementation UserInformationHeader
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)init
{
    if ((self = [super init]))
    {
        StaffItToMeAppDelegate *app_delegate    = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        header_shadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        header_shadow.image = [UIImage imageNamed:@"header_shadow"];
        [self addSubview:header_shadow];
        //Setup the available switch background.
        my_available_switch_background = [[UIImageView alloc] initWithFrame:CGRectMake(230, 10, 89, 58)];
        [my_available_switch_background setImage:[UIImage imageNamed:@"available_widget"]];
        [self addSubview:my_available_switch_background];
        //Create custom switch
        my_available_switch = [[ASSwitch alloc] initWithFrame:CGRectMake(242, 36, 65, 22) andOnImage:[UIImage imageNamed:@"available_no"] offImage:[UIImage imageNamed:@"available_yes"] sliderImage:[UIImage imageNamed:@"available_slider"]];
        my_available_switch.delegate = self;
        [my_available_switch setOn:app_delegate.user_state_information.im_available];
        [self addSubview:my_available_switch];
        
        //Setup Containers.
        //setup prof pic
        my_profile_picture = [[UIImageView alloc] initWithFrame:CGRectMake(16, 14, 48, 50)];
        [self addSubview:my_profile_picture];
        //setup cover that makes thing nicer
        my_profile_shiner = [[UIImageView alloc] initWithFrame:CGRectMake(11, 9, 58, 60)];
        [my_profile_shiner setImage:[UIImage imageNamed:@"profile_pic_overlay"]];
        [self addSubview:my_profile_shiner];
        //add tap gesture so that when profile picture is tapped the profile page is displayed.
        UITapGestureRecognizer *tap_gesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToProfilePage)] autorelease];
        [tap_gesture setNumberOfTapsRequired:1];
        [tap_gesture setNumberOfTouchesRequired:1];
        [my_profile_shiner.inputView addGestureRecognizer:tap_gesture];
        
        
        //setup user name
        my_profile_name = [[UILabel alloc] initWithFrame:CGRectMake(74, 18, 100, 22)];
        [self addSubview:my_profile_name];
        
        //SetupButton
        my_connection_button = [UIButton buttonWithType:UIButtonTypeCustom];
        my_connection_button.frame = CGRectMake(73, 36, 93, 24.5);
        [my_connection_button setBackgroundImage:[UIImage imageNamed:@"connections_box"] forState:UIControlStateNormal];
        [my_connection_button addTarget:delegate action:@selector(respondToConnectionsButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:my_connection_button];
        //setupButtonLabel
        connections_label = [[UILabel alloc] initWithFrame:CGRectMake(89, 40, 73, 22)];
        [self addSubview:connections_label];
        //Setup Connection Icon
        connections_icon = [[UIImageView alloc] initWithFrame:CGRectMake(79.5, 45, 6, 8.5)];
        connections_icon.image = [UIImage imageNamed:@"connection_icon"];
        [self addSubview:connections_icon];
        
        
        //Set User Profile Picture
        [self updateProfilePicture];
        
        //Display users display name
        my_profile_name.text                    = app_delegate.user_state_information.my_user_info.full_name;
        my_profile_name.font                    = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12];
        my_profile_name.backgroundColor         = [UIColor clearColor];
        connections_label.backgroundColor       = [UIColor clearColor];
        connections_label.font                  = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        
        //Display connections box text
        NSMutableString *connections_text = [[NSMutableString alloc] init];
        NSString *friend_count = [NSString stringWithFormat:@"%d ", app_delegate.user_state_information.my_facebook_friends.count];
        connections_label.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        [connections_text appendString:friend_count];
        [connections_text appendString:@"Connections"];
        [connections_label setText:connections_text];
        [self setFrame:CGRectMake(0, 0, 320, 80)];
        [app_delegate.my_available_switch_array addObject:my_available_switch];
        
        
        //Setup the available switch background.
        my_available_switch_foreground = [[UIImageView alloc] initWithFrame:my_available_switch.frame];
        [my_available_switch_foreground setImage:[UIImage imageNamed:@"available_overlay"]];
        [self addSubview:my_available_switch_foreground];
        
        
    }
    return self;
}
-(void)updateProfilePicture
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    printf("%s", [app_delegate.user_state_information.picture_url UTF8String]);
    
    //check to make sure that the picture that we grabbed is not set to the missing_icon.gif;.
    NSArray *picture_web_components = [app_delegate.user_state_information.picture_url componentsSeparatedByString:@"/"];
    if ([[picture_web_components objectAtIndex:picture_web_components.count-1] isEqualToString:@"icon_missing_medium.gif"])
    {
        app_delegate.user_state_information.picture_url = nil;
    }
    
    if (app_delegate.user_state_information.picture_url.length <=15 ||
        app_delegate.user_state_information.picture_url == nil ||
        app_delegate.user_state_information.picture_url == [NSNull null])
    {
        NSMutableString *user_picture_string    = [NSMutableString stringWithString:@"http://graph.facebook.com/"];
        [user_picture_string appendString:app_delegate.user_state_information.facebook_id];
        [user_picture_string appendString:@"/picture?type=large"];
        
        NSURL *user_image_location              = [[NSURL alloc] initWithString:user_picture_string];
        if (user_image_location != nil)
        {
            [my_profile_picture setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:user_image_location]]];   
        }
    }
    else
    {
        [my_profile_picture setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:app_delegate.user_state_information.picture_url]]]];   
    }   
}
-(void)goToProfilePage
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    [app_delegate setCurrentTabBar:@"Inbox"];
}
//so a little retarded action here.
//Basically I need to switch the on to react as off and the off to react as on
//because of the art that was provided for the switch. THe yes shows in off mode
//and the no shows in on mode. Akward but whatever.
-(void)respondToOnHappening
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    [app_delegate.user_state_information stopUpdatingUserLocation];
    [app_delegate updateAvailableSwitches];
}
-(void)respondToOffHappening
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    [app_delegate.user_state_information startUpdatingUserLocation];
    [app_delegate updateAvailableSwitches];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear];
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [my_available_switch setOn:app_delegate.user_state_information.im_available];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
