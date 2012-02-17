//
//  LoginScreen.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
/*
 PROTOCOL FOR FACEBOOK LOGIN
 so website="Http://something.facebook.com", name = "Anthony Sierra",  first_name="Anthony", last_name="Sierra", birthday_date="12/2/92", locale="47,-122", sex="Male"   Kinda like that?
 */
#import "LoginScreen.h"
#import "StaffItToMeAppDelegate.h"

@implementation LoginScreen

static NSString *login_check_address = @"http://hydrogen.xen.exoware.net:3000/api_login";
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        //Create Login Screen Background
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginBackground.png"]];
        [background setFrame:CGRectMake(0, 0, 320, 480)];
        [self addSubview:background];
        //Create Facebook Button.
        facebook_register_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [facebook_register_btn setFrame:CGRectMake(47.5, 242, 225, 66)];
        [facebook_register_btn setBackgroundImage:[UIImage imageNamed:@"login_button"] forState:UIControlStateNormal];
        [facebook_register_btn setBackgroundImage:[UIImage imageNamed:@"login_button_pressed"] forState:UIControlStateSelected];
        [facebook_register_btn addTarget:app_delegate action:@selector(facebookFunction) forControlEvents:UIControlEventTouchUpInside];
        [self insertSubview:facebook_register_btn atIndex:20];
        
        
        //create twitter btn
       /* twitter_btn = [[TwitterBtn alloc] initWithFrame:CGRectMake(56, 440, 208, 44)];
        twitter_btn.userInteractionEnabled = YES;
        [self addSubview:twitter_btn];*/
        
    }
    return self;
}
-(void)reactToASSliderValueChange:(double)the_slider_value
{
    printf("\n%f", the_slider_value);
}
-(void)displayRegisterScreen
{
    //Clear text fields for return
    username_txt.text = @"";
    password_txt.text = @"";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leaveRegisterScreen) name:@"leaveRegisterScreen" object:nil];
    register_scrn = [[RegisterScreen alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    register_scrn.backgroundColor = [UIColor whiteColor];
    [self addSubview:register_scrn];
}
-(int)getRegisterScreenCount
{
    return [register_scrn retainCount];
}
-(void)leaveRegisterScreen
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [register_scrn removeFromSuperview];
}
-(void)login
{
    //resign the keyboard if it is on screen
    [self resignFirstResponder];
    [username_txt resignFirstResponder];
    [password_txt resignFirstResponder];
    //make sure there was something typed in the fields
    if (username_txt.text.length == 0 || password_txt.text.length == 0) {
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to Login" message:@"Either an invalid username or password was used. Please retry login." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[message show];
		[message release];
        return;
    }
    //show a alertview that we are accessing the credentials and talking to the server.
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
    
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:login_check_address];
    NSString *login_stream = [NSString stringWithFormat:@"%s-%s", [username_txt.text UTF8String],[password_txt.text UTF8String]];
    printf("%s", [login_stream UTF8String]);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:username_txt.text forKey:@"login"];
    [request setPostValue:password_txt.text forKey:@"password"];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    //printf("%s", [[request valueForKey:@"email"]  UTF8String]);
    //printf("\n%s\n", [[[request postBody] description] UTF8String]);
    [request startAsynchronous];
    
}
/*
 Called once the ASIHTTPRequest has finished acessing the server.
 */
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *reData = [request responseData];
    if (reData) {
        printf("There is Data");
    }
    NSString *response = [request responseString];
    printf("\n%s\n", [response UTF8String]);
    printf("\n%d\n", [request responseStatusCode]);
	
    //If username and password were correct
    if (response != nil && ![response isEqualToString:@"no"] && response.length == 40) {
        //get rid of loading message
        [load_message dismissWithClickedButtonIndex:0 animated:YES];
        //set the global username ot the username
        StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        delegate.user_state_information.userName = [username_txt.text copy];
		delegate.user_state_information.sessionKey = [[request responseString] retain];
		printf("\nThis is their sessionKey: %s\n", [delegate.user_state_information.sessionKey UTF8String]);
        
        NSError *error;
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/AskedAboutSaving.txt"];
        NSString *inString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if ([inString intValue] <= 0)
        {
            //Ask user if we can save their username and password
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Want us to save your password?" message:@"Hi there, we can save your password and username so you don't have to re-type it everytime if you would like." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sure!", nil];
            message.tag = 5;
            [message show];
            [message release];
            NSString *fini = @"18";
            [fini writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeLoginScreen" object:nil];
        
    }
    else if([response isEqualToString:@"no"])
    {
        //get rid of loading message
        [load_message dismissWithClickedButtonIndex:0 animated:YES];
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to Login" message:@"Either an invalid username or password was used. Please retry login." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[message show];
		[message release];
    }
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && alertView.tag == 5) {
        printf("User said sure");
        NSError *error;
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/username.txt"];
        [username_txt.text writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
        NSString *pass_path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/password.txt"];
        [password_txt.text writeToFile:pass_path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    else if (buttonIndex == 0 && alertView.tag == 5)
    {
        printf("user said heck no fool!");
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    //get rid of loading message
    [load_message dismissWithClickedButtonIndex:0 animated:YES];
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"There was an error." message:@"An error occurred please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [message show];
    [message release];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touch_locale = [touch locationInView:self];
    if (touch_locale.x > 188 && touch_locale.y > 308 && touch_locale.x < 250 && touch_locale.y < 330)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://helium.staffittome.com/about/termsofservice"]];
    }
}




/*------------------------------------------TextFieldFunctions-----------------------------------------------*/
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"] && textField == username_txt) {
        [username_txt resignFirstResponder];
        [password_txt becomeFirstResponder];
        [password_txt setSelected:YES];
        
    }
    else if([string isEqualToString:@"\n"] && textField == password_txt) {
        [password_txt resignFirstResponder];
        
    }
    return YES;
}

/*------------------------------------------EndTextFieldFunctions-----------------------------------------------*/

- (void)dealloc
{
    [logo_message release];
    [load_message release];
    [register_btn release];
    [username_txt release];
    [password_txt release];
    [login_btn release];
    [facebook_register_btn release];
    [register_scrn release];
    [super dealloc];
}

@end
