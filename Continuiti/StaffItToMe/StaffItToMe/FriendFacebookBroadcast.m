//
//  FriendFacebookBroadcast.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendFacebookBroadcast.h"
#import "StaffItToMeAppDelegate.h"


@implementation FriendFacebookBroadcast
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        facebook = [[Facebook alloc] initWithAppId:@"187212574660004"];
        facebook.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"FBExpirationDateKey"];
    }
    return self;
}
-(void)setPositionInArray:(int)the_pos
{
    my_pos = the_pos;
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
-(IBAction)sendThePost
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *graphPath = [NSString stringWithFormat:@"%@/feed", [[app_delegate.user_state_information.my_facebook_friends objectAtIndex:my_pos ] friend_id]];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"187212574660004",@"api_key",message.text,@"message", @"join me",@"caption", @"Some Random Message",@"description", nil];
    [facebook requestWithGraphPath:graphPath andParams:params andHttpMethod:@"POST" andDelegate:self];   
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text 
{
    if (textView == message && [text isEqualToString:@"\n"])
    {
        [message resignFirstResponder];
    }
    return YES;
}
    
-(void)request:(FBRequest *)request didLoad:(id)result
{
    UIAlertView *small_message = [[UIAlertView alloc] initWithTitle:@"Posted" message:@"You have succesfully sent your message!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [small_message show];
    [small_message release];
    //[delegate leaveFriendFacebookBroadcast];
}
-(void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    UIAlertView *small_message = [[UIAlertView alloc] initWithTitle:@"Unable to post" message:@"Unable to send request, user could have posting turned off!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [small_message show];
    [small_message release];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    message.delegate = self;
    
    friend_message_label.text = @"What would you like to say?";
    friend_message_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
    friend_message_label.backgroundColor = [UIColor clearColor];
    [friend_message_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    
    message.text = @"Message";
    message.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
    message.backgroundColor = [UIColor clearColor];
    [message setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [message resignFirstResponder];
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
