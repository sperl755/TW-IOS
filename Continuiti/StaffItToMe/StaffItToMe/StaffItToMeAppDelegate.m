//
//  StaffItToMeAppDelegate.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StaffItToMeAppDelegate.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "StaffItToMeViewController.h"
#import "SA_OAuthTwitterController.h"
#import "ASIFormDataRequest.h"

@implementation StaffItToMeAppDelegate

@synthesize window=_window;
@synthesize user_state_information;
@synthesize viewController=_viewController;
@synthesize facebook;
@synthesize tab_bar_controller;
@synthesize my_available_switch_array;

static NSString *staff_it_to_me_address = @"www.google.com";
#define CONSUMER_KEY @"g0LqV8EsFdhCPmFhdksh3A"
#define SECRET_KEY @"cUKExTEAqwcqsjvmQi2078rwwUnmQknvCWzHCL8snO0"
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{ 
    [[ApplicationDatabase sharedInstance] createUserInformationTable];
    [[ApplicationDatabase sharedInstance] createUsersFacebookFriendsTable];
    [[ApplicationDatabase sharedInstance] createUserLocationInformationTable];
    
    //test to see whether this IOS device is even connected.
    [self connectionFunction];
    [UIApplication sharedApplication].statusBarHidden = YES;
    my_available_switch_array = [[NSMutableArray alloc] initWithCapacity:11];
    
    //Checks to see if user is currently there.
    if ([[ApplicationDatabase sharedInstance] hasUserInformationTableBeenPopulated])
    {
        user_state_information  = [[USERINFORMATIONANDAPPSTATE alloc] init];
        logged_out              = NO;
        got_facebook_info       = YES;
        
        [user_state_information loadUserInfoFromDatabase];
        [user_state_information loadUsersFacebookFriendsFromDatabase];
        [user_state_information loadUserLocationFromDatabase];
        
        //setup the login and dashboard viewcontroller.
        self.window.rootViewController = self.viewController;
        [self.window makeKeyAndVisible];
        [self goToMainApp];
    }
    else
    {
        user_state_information = [[USERINFORMATIONANDAPPSTATE alloc] init];
        user_state_information.currentTabBar = @"Home";
        logged_out = YES;
        got_facebook_info = NO;
        //Add Notification to go to the main app after login is confirmed.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToMainApp) name:@"GoToMainApp" object:nil];
        //setup the login and dashboard viewcontroller.
        self.window.rootViewController = self.viewController;
        [self.window makeKeyAndVisible];
    }
    
    /*@try
    {
        if ([NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/appstate.archive"]] != nil
            && [[NSUserDefaults standardUserDefaults] objectForKey:@"FBExpirationDateKey"] != nil 
            && [[NSUserDefaults standardUserDefaults] objectForKey:@"FBAccessTokenKey"] != nil)
        {
            user_state_information      = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/appstate.archive"]];
            [user_state_information loadUserInfoFromDatabase];
            [user_state_information loadUsersFacebookFriendsFromDatabase];
            my_available_switch_array   = [[NSMutableArray alloc] initWithCapacity:11];
            logged_out = NO;
            got_facebook_info = YES;
            [self goToMainApp];
            return YES;
        }
        else
        {
            //allocate and create the user data model
            user_state_information                  = [[USERINFORMATIONANDAPPSTATE alloc] init];
            user_state_information.currentTabBar    = @"Home";
            logged_out = YES;
            //Add Notification to go to the main app after login is confirmed.
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToMainApp) name:@"GoToMainApp" object:nil];
            
            got_facebook_info  = NO;
            //setup the login and dashboard viewcontroller.
            self.window.rootViewController = self.viewController;
            [self.window makeKeyAndVisible];
        }
    }
    @catch (NSException *e) {
        //setup the login and dashboard viewcontroller.
        self.window.rootViewController = self.viewController;
        [self.window makeKeyAndVisible];
    }*/
    return YES;
}
-(void)updateAvailableSwitches
{
    for (int i = 0; i < my_available_switch_array.count; i++)
    {
        [[my_available_switch_array objectAtIndex:i] setOnWithoutDelegateCall:user_state_information.im_available];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    [self removeLoadingViewFromWindow];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    if (!logged_out)
    {
        NSString *write_path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/appstate.archive"] retain];
        [NSKeyedArchiver archiveRootObject:user_state_information toFile:write_path];   
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    [[ApplicationDatabase sharedInstance] closeDatabase];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url 
{ 
    //[self fbDidLogin];
    return [facebook handleOpenURL:url];
}
-(void)connectionFunction
{
    if([self cellularConnected]) {
        
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You are currently connected via cellular connection. For best results it is recommended to switch to a wifi connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[message show];
		[message release];
    }
    else if (![self networkConnected]) {
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You are currently not connected to the internet this application will not be able to access account information." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[message show];
		[message release];
        
    }
}
-(BOOL)cellularConnected
{
    SCNetworkReachabilityFlags flags = 0;
    SCNetworkReachabilityRef netReach = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [staff_it_to_me_address UTF8String]);
    if(netReach) {
        SCNetworkReachabilityGetFlags(netReach, &flags);
        CFRelease(netReach);
    }
    if(flags & kSCNetworkReachabilityFlagsIsWWAN) {
        return YES;
    }
    return NO;
}
-(void)displayLoadingView
{
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [_window addSubview:load_view];
}
-(void)displayLoadViewWithString:(NSString*)the_string
{
    AlertLoadView *alert_view = [[AlertLoadView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) andText:@"You have succesfully endorsed your friend great job!"];
    [_window insertSubview:alert_view atIndex:10000];
}
-(void)facebookFunction
{
    //show a alertview that we are accessing the credentials and talking to the server.
    [self displayLoadingView];
    facebook_request_is_loading = YES;
    /*load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];*/
    
    facebook = [[Facebook alloc] initWithAppId:@"187212574660004"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"])
    {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    if (![facebook isSessionValid]) {
        NSArray *permission = [[NSArray arrayWithObjects:@"email", @"read_friendlists", nil] retain];
        [facebook authorize:permission delegate:self];
    }
    if( [facebook isSessionValid]) {
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"friends, first_name, last_name, id, locale, gender, birthday, email, link, name", @"fields", nil];
                                           [facebook requestWithGraphPath:@"me" andParams:parameters andDelegate:self];
    }
    
    
}
-(void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"friends, first_name, last_name, id, locale, gender, birthday, email, link, name", @"fields", nil];
    [facebook requestWithGraphPath:@"me" andParams:parameters andDelegate:self];
}
-(FacebookBroadcast*)getFriendFacebookScreen
{
    return my_facebook_broadcaster;
}
/**
	This method calls all of the viewDIdLoads for the different controllers so the information is ready and waiting for the user instead of the user waiting for the controllers.
 */
-(void)loadControllerViews
{
    [home               viewDidLoad];
    [search             viewDidLoad];
    [jobs               viewDidLoad];
    [main_profile       viewDidLoad];
    [broadcast          viewDidLoad];
    [my_messages_inbox  viewDidLoad];
}
-(void)allocateNonNecessaryViewControllers
{
    my_facebook_broadcaster = [[FacebookBroadcast alloc] initWithNibName:@"FacebookBroadcast" bundle:nil];   
}
/**
 This method will cause the whole app to open. This is called after login.
 return void. 
 No parameters.
 */
-(void)goToMainApp
{
    home = [[DashboardController alloc] init];
    home.view.backgroundColor = [UIColor whiteColor];
    search = [[JobSearchController alloc] init];
    search.view.backgroundColor = [UIColor whiteColor];
    jobs = [[JobHistoryMain alloc] init];
    jobs.view.backgroundColor = [UIColor whiteColor];
    main_profile = [[ProfileMain alloc] init];
    main_profile.view.backgroundColor = [UIColor whiteColor];
    broadcast = [[StaffOutMain alloc] init];
    my_messages_inbox = [[MessageSystemMain alloc] init];
    [self performSelectorInBackground:@selector(allocateNonNecessaryViewControllers) withObject:nil];
    
    [_window.rootViewController.view removeFromSuperview];
    _window.rootViewController = nil;
    
    tab_bar_controller = [[UITabBarController alloc] init];
    tab_bar_controller.tabBar.frame = CGRectMake(0, 420, 320, 60);
    tab_bar_controller.delegate = self;
    UIImageView *tab_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BottomBar2"]];
    tab_background.frame = CGRectMake(0, 0, 320, 60);
    
    //This is extrememly important keep atIndex:1 because IOS 5 compatibility.
    [tab_bar_controller.tabBar insertSubview:tab_background atIndex:1];
    
    tab_bar_controller.viewControllers = [NSArray arrayWithObjects:home, search, jobs, main_profile, broadcast, nil];
    
    if ([user_state_information.currentTabBar isEqualToString:@"FindWork"]) {
        tab_bar_controller.selectedViewController = search;
    }
    else if ([user_state_information.currentTabBar isEqualToString:@"MyJobs"]) {
        tab_bar_controller.selectedViewController = jobs;
    }
    else if ([user_state_information.currentTabBar isEqualToString:@"Profile"]) {
        tab_bar_controller.selectedViewController = broadcast;
    }
    else if ([user_state_information.currentTabBar isEqualToString:@"Home"]) {
        tab_bar_controller.selectedViewController = home;
    }
    else if ([user_state_information.currentTabBar isEqualToString:@"Inbox"]) {
        tab_bar_controller.selectedViewController = main_profile;
    }
    _window.rootViewController = tab_bar_controller;
    [_window addSubview:tab_bar_controller.view];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    tab_bar_controller.viewControllers = [NSArray arrayWithObjects:home, search, jobs, main_profile, broadcast, nil];
    if (viewController == search)
    {
        user_state_information.currentTabBar = @"FindWork";
        [search properlyToRootViewController];
    }
    else if (viewController == jobs)
    {
        user_state_information.currentTabBar = @"MyJobs";
    }
    else if (viewController == broadcast)
    {
        user_state_information.currentTabBar = @"Profile";
    }
    else if (viewController == home)
    {
        user_state_information.currentTabBar = @"Home";
    }
    else if (viewController == main_profile)
    {
        user_state_information.currentTabBar = @"Inbox";
    }
    else if (viewController == my_messages_inbox)
    {
        user_state_information.currentTabBar = @"Messages";
    }
}
-(void)setCurrentTabBar:(NSString*)the_tab
{
    user_state_information.currentTabBar = [the_tab retain];
    if ([user_state_information.currentTabBar isEqualToString:@"FindWork"]) {
        tab_bar_controller.selectedViewController = search;
    }
    else if ([user_state_information.currentTabBar isEqualToString:@"MyJobs"]) {
        tab_bar_controller.selectedViewController = jobs;
    }
    else if ([user_state_information.currentTabBar isEqualToString:@"Profile"]) {
        tab_bar_controller.selectedViewController = broadcast;
    }
    else if ([user_state_information.currentTabBar isEqualToString:@"Home"]) {
        tab_bar_controller.selectedViewController = home;
    }
    else if ([user_state_information.currentTabBar isEqualToString:@"Inbox"]) {
        tab_bar_controller.selectedViewController = main_profile;
    }
    else if ([user_state_information.currentTabBar isEqualToString:@"Messages"])
    {
        tab_bar_controller.viewControllers = [NSArray arrayWithObjects:my_messages_inbox, search, jobs, main_profile, broadcast, nil];
        [tab_bar_controller setSelectedViewController:my_messages_inbox];
    }
    [_window addSubview:tab_bar_controller.view];   
}
-(BOOL)networkConnected
{
    SCNetworkReachabilityFlags flags = 0;
    SCNetworkReachabilityRef netReach = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [staff_it_to_me_address UTF8String]);
    BOOL retrievedFlags = NO;
    if (netReach) {
        retrievedFlags = SCNetworkReachabilityGetFlags(netReach, &flags);
        CFRelease(netReach);
    }
    if (!retrievedFlags || !flags) {
        return NO;
    }
    return  YES;
}
-(void)removeLoadingViewFromWindow
{
    [load_view removeFromSuperview];
    load_view = nil;
}
-(void)request:(FBRequest *)request didLoad:(id)result
{
    [self displayLoadingView];
    
    NSString *text = [[NSString alloc] initWithData:[request responseText] encoding:NSUTF8StringEncoding];
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:[[URLLibrary sharedInstance] getFacebookLoginURL]];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:[result objectForKey:@"first_name"] forKey:@"first_name"];
    [request_ror setPostValue:[result objectForKey:@"id"] forKey:@"facebook_uid"];
    user_state_information.facebook_id = [[result objectForKey:@"id"] retain];
    user_state_information.my_user_info.full_name = [[result objectForKey:@"name"] retain];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [request_ror setPostValue:[defaults objectForKey:@"FBAccessTokenKey"] forKey:@"facebook_session_key"];
    [request_ror setPostValue:[result objectForKey:@"locale"]       forKey:@"locale"];
    [request_ror setPostValue:[result objectForKey:@"gender"]       forKey:@"sex"];
    [request_ror setPostValue:[result objectForKey:@"last_name"]    forKey:@"last_name"];
    [request_ror setPostValue:[result objectForKey:@"birthday"]     forKey:@"birthday"];
    [request_ror setPostValue:[result objectForKey:@"email"]        forKey:@"email"];
    [request_ror setPostValue:[result objectForKey:@"name"]         forKey:@"name"];
    
    //Get the facebook friends
    [[ApplicationDatabase sharedInstance] dropfacebookFriendsTable];
    [[ApplicationDatabase sharedInstance] createUsersFacebookFriendsTable];
    
    NSMutableArray *dciont = [[result objectForKey:@"friends"] objectForKey:@"data"];
    for (int i = 0; i < dciont.count; i++)
    {
        NSMutableDictionary *friend_info = [[NSMutableDictionary alloc] initWithCapacity:2];
        [friend_info setObject:[[dciont objectAtIndex:i] objectForKey:@"name"] forKey:@"friend_name"];
        [friend_info setObject:[[dciont objectAtIndex:i] objectForKey:@"id"] forKey:@"friend_id"];
        [[ApplicationDatabase sharedInstance] insertFacebookFriend:friend_info];
    }
    [user_state_information loadUsersFacebookFriendsFromDatabase];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    /*ProfileMain *tester = [[ProfileMain alloc] init];
    [_viewController presentModalViewController:tester animated:YES];*/
    [request_ror startAsynchronous];
    loadDoneYet = 1;
    //[load_message dismissWithClickedButtonIndex:0 animated:YES];
    //[_viewController tearLoginScreen];
    
    
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    facebook_request_is_loading = NO;
    @try {
        if (loadDoneYet == 1) {
            if ([[request responseString] length] >= 40) {
                StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
                //Populate Data before entering app.
                [app_delegate.user_state_information getUserInformation:[request responseString]];
                got_facebook_info   = YES;
                logged_out          = NO;
                [_viewController tearLoginScreen];
            }
            else
            {
                UIAlertView *unable_to_login = [[UIAlertView alloc] initWithTitle:@"Unable_to_login" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [unable_to_login show];
                [unable_to_login release];
            }
            
        }
    }
    @catch (NSException *exception) {
        UIAlertView *unable_to_login = [[UIAlertView alloc] initWithTitle:@"Talentwire is down for maintenance and will be back up shortly.  Thank you for being part of our beta!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [unable_to_login show];
        [unable_to_login release];
    }
    @finally {
        [load_view removeFromSuperview];
    }
}
-(void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    [self removeLoadingViewFromWindow];
}
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {  
     NSUserDefaults          *defaults = [NSUserDefaults standardUserDefaults];  
   
     [defaults setObject: data forKey: @"authData"];  
     [defaults synchronize];  
 }  
   
 - (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {  
     return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];  
}  

-(void)twitterLogin
{
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"authData"];
    if(!twitter_engine){  
        twitter_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];  
        twitter_engine.consumerKey    = CONSUMER_KEY;  
        twitter_engine.consumerSecret = SECRET_KEY;  
    }  
    if (![twitter_engine isAuthorized]) 
    {
        UIViewController *view_controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:twitter_engine delegate:self];  
    
        if (view_controller){  
            [_viewController  presentModalViewController:view_controller animated: YES];  
        }  
    }
    else if ([twitter_engine isAuthorized])
    {
        [_viewController tearLoginScreen];
    }
    NSString *cachedData=[[NSUserDefaults standardUserDefaults] objectForKey:@"authData"];
    NSString *username=[twitter_engine extractUsernameFromHTTPBody:cachedData];

}

-(BOOL)wifiConnected
{
    if ([self cellularConnected]) {
        return NO;
    }
    return [self networkConnected];
}
- (void)dealloc
{
    [_window release];
    [_viewController release];
    [twitter_engine release];
    [user_state_information release];
    [super dealloc];
}
-(void)logoutFunction
{
    [[ApplicationDatabase sharedInstance] dropAllTables];
    [[ApplicationDatabase sharedInstance] createUserInformationTable];
    [[ApplicationDatabase sharedInstance] createUsersFacebookFriendsTable];
    logged_out = YES;
    //Kill facebook login credentials
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"FBAccessTokenKey"];
    [defaults setObject:nil forKey:@"FBExpirationDateKey"];
    //Do some memory cleanup
    [twitter_engine release];
    [tab_bar_controller.view removeFromSuperview];
    tab_bar_controller.viewControllers = [NSArray arrayWithObjects:nil];
    [my_messages_inbox release];
    [facebook release];
    ////////////////////////
    ///test to see whether this IOS device is even connected.
    [self connectionFunction];
    
    //allocate and create the user data model
    USERINFORMATIONANDAPPSTATE *old = user_state_information;
    user_state_information = [[USERINFORMATIONANDAPPSTATE alloc] init];
    [old release];
    NSString *write_path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/appstate.archive"] retain];
    [NSKeyedArchiver archiveRootObject:nil toFile:write_path];
    
    //Add Notification to go to the main app after login is confirmed.
    self.viewController = [[StaffItToMeViewController alloc] init];
    [_window addSubview:self.viewController.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToMainApp) name:@"GoToMainApp" object:nil];
	got_facebook_info  = NO;
    my_available_switch_array = [[NSMutableArray alloc] initWithCapacity:11];
    [UIApplication sharedApplication].statusBarHidden = YES;
    /////////////////////////// 
}

@end
