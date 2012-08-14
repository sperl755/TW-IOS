//
//  ProfileWebService.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileWebService.h"
#import "StaffItToMeAppDelegate.h"

@implementation ProfileWebService
@synthesize my_facebook_token;
@synthesize my_user_name;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)viewDidAppear:(BOOL)animated
{
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *nav_back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopBar"]];
    nav_back.frame  = CGRectMake(0, 0, 322, 43);
    nav_back.tag    = 132;
    
    UIImageView *logo   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    logo.frame          = CGRectMake(50, 0, 200, 40);
    logo.center         = CGPointMake(320/2, logo.center.y);
    //This is extremely important. DO NOT CHANGE THESE LINES these are for
    //IOS 5 COMPATIBILITY ISSUES
    [self.navigationController.navigationBar insertSubview:nav_back atIndex:1];
    [self.navigationController.navigationBar insertSubview:logo atIndex:2];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    UISwipeGestureRecognizer *swipe_left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(sendViewForward:)];
    UISwipeGestureRecognizer *swipte_right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(sendViewBack:)];
    
    swipe_left.direction    = UISwipeGestureRecognizerDirectionLeft;
    swipte_right.direction  = UISwipeGestureRecognizerDirectionRight;
    
    [my_web_view addGestureRecognizer:swipe_left];
    [my_web_view addGestureRecognizer:swipte_right];
    
    
    my_web_view.delegate            = self;
    my_web_view.scrollView.delegate = self;
    
    
    
    refresh_header = [[PullRefreshHeader alloc] initWithFrame:CGRectMake(0, -70, 320, 70)];
    [my_web_view.scrollView addSubview:refresh_header];
    
    [self setupNavGUI];
    @try {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        NSMutableString *string = [[NSMutableString alloc] initWithString:@"https://www.talentwire.me/users/"];
        NSString *formatted_username = [app_delegate.user_state_information.my_user_info.full_name stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        
        [string appendString:formatted_username];
        [string appendString:@"?header=no&mobile=true"];
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:string]];
        [my_web_view loadRequest:request];
    }
    @catch (NSException *exception) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://talentwire.me"]];
        [my_web_view loadRequest:request];
    }
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)setupNavGUI
{
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [refresh_header setStartPoint:my_web_view.scrollView.contentOffset];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([refresh_header isLoaded])
    {
        my_web_view.scrollView.contentOffset = CGPointMake(0, -refresh_header.frame.size.height);
        my_web_view.scrollView.userInteractionEnabled = NO;
        return;
    }
    if (![refresh_header isLoaded])
    {
        [refresh_header rotate:my_web_view.scrollView.contentOffset];
        return;
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([refresh_header isLoaded])
    {
        my_web_view.scrollView.contentOffset = CGPointMake(0, -refresh_header.frame.size.height);
        my_web_view.scrollView.userInteractionEnabled = NO;
        
        did_pull_load = YES;
        [my_web_view reload];
    }
}
-(void)sendViewBack:(id)sender
{
    if ([my_web_view canGoBack])
    {
        [my_web_view goBack];
    }
}
-(void)sendViewForward:(id)sender
{
    if ([my_web_view canGoForward])
    {
        [my_web_view goForward];
    }
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    printf("%s", [[[request URL] description] UTF8String]);
    NSMutableString *request_url = [[NSMutableString alloc] initWithString:[request.URL description]];
    if ([request_url rangeOfString:@"/www.talentwire.me/"].location != NSNotFound &&  [request_url rangeOfString:@"header=no"].location == NSNotFound)
    {
        NSArray *components = [request_url componentsSeparatedByString:@"/"];
        NSString *end = [components objectAtIndex:components.count-1];
        if ([end rangeOfString:@"?"].location == NSNotFound)
        {
            [request_url appendString:@"?header=no&mobile=true"];
        }
        else
        {
            [request_url appendString:@"&header=no&mobile=true"];
        }
        NSURLRequest *new_request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:request_url]];
        [my_web_view loadRequest:new_request];
    }
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    if(!am_loading)
    {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        if (!did_pull_load)
        {
            //[app_delegate displayLoadingView];   
            [[URLLibrary sharedInstance] addLoadingView:self.view];
        }
        am_loading = YES;   
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (am_loading)
    {
        [refresh_header reset];
        my_web_view.scrollView.contentOffset = CGPointMake(0, 0);
        my_web_view.scrollView.userInteractionEnabled = YES;
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        [[URLLibrary sharedInstance] removeLoadingView:self.view];
        am_loading = NO;
        did_pull_load = NO;
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
-(void)profilePage:(id)sender
{
    @try {
        
        NSMutableString *string = [[NSMutableString alloc] initWithString:@"https://www.talentwire.me/users/"];
        NSString *formatted_username = [my_user_name stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        
        [string appendString:formatted_username];
        [string appendString:@"?mobile=true&header=no"];
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:string]];
        [my_web_view loadRequest:request];
    }
    @catch (NSException *exception) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://talentwire.me"]];
        [my_web_view loadRequest:request];
    }
}

@end