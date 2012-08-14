//
//  StaffYourself.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StaffYourself.h"
#import "StaffItToMeAppDelegate.h"

@implementation StaffYourself
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
-(IBAction)broadcastOnFacebook
{
    [delegate goToFaceBookBroadcast];
}
-(IBAction)goToStaffOutSegment1
{
    [delegate staff1];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *user_id = app_delegate.user_state_information.facebook_id;
    NSMutableString *user_url_string = [NSMutableString stringWithString:@"http://graph.facebook.com/"];
    [user_url_string appendString:user_id];
    [user_url_string appendString:@"/picture?type=large"];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user_url_string]]];
    if (image != nil)
    {
        [user_profile_picture setImage:image];
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

@end
