//
//  LoginScreen.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginScreen.h"
#import "StaffItToMeAppDelegate.h"

@implementation LoginScreen

static NSString *login_check_address = @"http://hydrogen.xen.exoware.net:3000/api_login";
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //Create logo and message container
        logo_message = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoAndMessage.png"]];
        [logo_message setFrame:CGRectMake(0, -30, logo_message.frame.size.width, logo_message.frame.size.height)];
        [self addSubview:logo_message];
        //create register btn
        register_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [register_btn setTitle:@"Register" forState:UIControlStateNormal];
        register_btn.frame = CGRectMake(56, 312, 208, 50);
        [register_btn addTarget:self action:@selector(displayRegisterScreen) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:register_btn];
        
        
        
        NSError *error;
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/username.txt"];
        NSString *inString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        
        
        //Setup username text box
        username_txt = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, 280, 31)];
        username_txt.borderStyle = UITextBorderStyleRoundedRect;
        username_txt.placeholder = @"Email: George@Bush.com";
        username_txt.backgroundColor = [UIColor whiteColor];
        username_txt.delegate = self;
        [self addSubview:username_txt];
        if (inString != nil)
        {
            [username_txt setText:inString];
        }
        
        path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/password.txt"];
        NSString *inPassString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        //Setup password text box
        password_txt = [[UITextField alloc] initWithFrame:CGRectMake(20, 160, 280, 31)];
        password_txt.borderStyle = UITextBorderStyleRoundedRect;
        password_txt.placeholder = @"Password: password";
        password_txt.backgroundColor = [UIColor whiteColor];
        password_txt.delegate = self;
        [password_txt setSecureTextEntry:YES];
        [self addSubview:password_txt];
        if (inPassString != nil)
        {
            [password_txt setText:inString];
        }
        
        
        //create login btn
        login_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [login_btn setTitle:@"Login" forState:UIControlStateNormal];
        login_btn.frame = CGRectMake(56, 200, 208, 50);
        [login_btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:login_btn];
        //create facebook btn
        facebook_btn = [[FacebookBtn alloc] initWithFrame:CGRectMake(56, 389, 208, 44)];
        facebook_btn.userInteractionEnabled = YES;
        [self addSubview:facebook_btn];
        //create twitter btn
        twitter_btn = [[TwitterBtn alloc] initWithFrame:CGRectMake(56, 440, 208, 44)];
        twitter_btn.userInteractionEnabled = YES;
        [self addSubview:twitter_btn];
        
    }
    return self;
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
    [self resignFirstResponder];
    [username_txt resignFirstResponder];
    [password_txt resignFirstResponder];
    if (username_txt.text.length == 0 || password_txt.text.length == 0) {
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to Login" message:@"Either an invalid username or password was used. Please retry login." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[message show];
		[message release];
        return;
    }
    
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
    NSURL *url = [NSURL URLWithString:login_check_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    NSString *login_stream = [NSString stringWithFormat:@"%s-%s", [username_txt.text UTF8String],[password_txt.text UTF8String]];
    printf("%s", [login_stream UTF8String]);
    [request appendPostData:[login_stream dataUsingEncoding:NSUTF8StringEncoding]];
    [request startAsynchronous];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *reData = [request responseData];
    if (reData) {
        printf("There is Data");
    }
    NSString *response = [request responseString];
    printf("%s", [response UTF8String]);
    
    //If username and password were correct
    if (response != nil && ![response isEqualToString:@"no"]) {
        //get rid of loading message
        [load_message dismissWithClickedButtonIndex:0 animated:YES];
        //set the global username ot the username
        StaffItToMeAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        delegate.user_state_information.userName = [username_txt.text copy];
        
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
        path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/password.txt"];
        [password_txt.text writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
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
    [facebook_btn release];
    [register_scrn release];
    [super dealloc];
}

@end
