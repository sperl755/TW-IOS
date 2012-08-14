//
//  DataMaker.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataMaker.h"
#import "StaffItToMeAppDelegate.h"


@implementation DataMaker

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self makeAMessage];
        
        //Me 1269
        //shayan 1272
    }
    return self;
}
-(void)makeAMessage
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    // Custom initialization
    NSURL *url = [NSURL URLWithString:[[URLLibrary sharedInstance] getCreateMessageLink]];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setTimeOutSeconds:30];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setDelegate:self];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request_ror setPostValue:@"4" forKey:@"sender_id"];
    [request_ror setPostValue:@"205" forKey:@"recipient_id"];
    [request_ror setPostValue:@"THis Is the body" forKey:@"body"];
    [request_ror setPostValue:@"This is Subject" forKey:@"subject"];
    [request_ror setPostValue:@"Job"  forKey:@"messageable_type"];
    [request_ror setPostValue:@"2" forKey:@"messageable_id"];
    [request_ror startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
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
