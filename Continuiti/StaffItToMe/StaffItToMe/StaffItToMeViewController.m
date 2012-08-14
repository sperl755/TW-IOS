//
//  StaffItToMeViewController.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StaffItToMeViewController.h"

@implementation StaffItToMeViewController

-(id)init
{
    if ((self = [super init]))
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tearLoginScreen) name:@"removeLoginScreen" object:nil];
        login_screen = [[LoginScreen alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        [self.view addSubview:login_screen];
        
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tearLoginScreen) name:@"removeLoginScreen" object:nil];
    login_screen = [[LoginScreen alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [self.view addSubview:login_screen];
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
-(void)tearLoginScreen
{
    if ([login_screen getRegisterScreenCount] > 1)
    {
        [login_screen leaveRegisterScreen];
    }
    [login_screen removeFromSuperview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tearDashboard) name:@"tearDashboard" object:nil];
    dashboard = [[Dashboard alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [self.view addSubview:dashboard];
    [self tearDashboard];
}
-(void)tearDashboard
{
    [dashboard removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToMainApp" object:nil];
}

- (void)dealloc
{
    [login_screen release];
    [dashboard release];
    [super dealloc];
}
@end
