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

@implementation StaffItToMeAppDelegate

@synthesize window=_window;
@synthesize username;
@synthesize viewController=_viewController;
static NSString *staff_it_to_me_address = @"www.google.com";
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
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
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarHidden = YES;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
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
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url 
{ 
    [self fbDidLogin];
    return [facebook handleOpenURL:url];
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

-(void)facebookFunction
{
    facebook = [[Facebook alloc] initWithAppId:@"187212574660004"];
    fbGraph = [[FbGraph alloc] initWithFbClientID:@"187212574660004"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"])
    {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    if (![facebook isSessionValid]) {
        [facebook authorize:nil delegate:self];
        [fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbDidLogin) andExtendedPermissions:@"user_location,user_birthday"];
    }
    if( [facebook isSessionValid]) {
        printf("%s", [username UTF8String]);
    }
    [facebook requestWithGraphPath:@"me" andDelegate:self];
    NSMutableDictionary *parmaters = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"first_name", @"fields", @"last_name", @"fields", @"languages", @"fields", @"birthday", @"fields", @"location", @"fields", nil];
    [facebook requestWithGraphPath:@"me" andParams:parmaters andHttpMethod:@"GET" andDelegate:self];
    //[facebook requestWithMethodName:@"users.getInfo" andParams:parmaters andHttpMethod:@"GET" andDelegate:self];
    
}
-(void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
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
-(void)request:(FBRequest *)request didLoad:(id)result
{
    printf("%s\n",[[result objectForKey:@"first_name"] UTF8String]);
    printf("%s\n",[[result objectForKey:@"last_name"] UTF8String]);
    printf("%s\n",[[result objectForKey:@"birthday"] UTF8String]);
    printf("%s\n",[[[result objectForKey:@"location"] objectForKey:@"name"] UTF8String]);
    NSEnumerator *enumerator = [[result objectForKey:@"languages"] objectEnumerator];
    printf("%s",[[[enumerator nextObject] valueForKey:@"name"] UTF8String]);
    printf("%s",[[[enumerator nextObject] valueForKey:@"name"] UTF8String]);
    printf("%s\n", [[[result class] description] UTF8String]);
}
-(void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    printf("ERREOR");
    printf("%s", [[error description] UTF8String]);
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
    [super dealloc];
}

@end
