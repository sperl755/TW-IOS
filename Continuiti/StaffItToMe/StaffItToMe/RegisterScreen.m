//
//  RegisterScreen.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RegisterScreen.h"
#import "StaffItToMeAppDelegate.h"

@implementation RegisterScreen

static NSString *login_check_address = @"http://hydrogen.xen.exoware.net:3000/api_signup";
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Create logo and message container
        logo_message = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoAndMessage.png"]];
        [logo_message setFrame:CGRectMake(0, -30, logo_message.frame.size.width, logo_message.frame.size.height)];
        [self addSubview:logo_message];
        
        //Setup first_last_name text box
        first_last_name_txt = [[UITextField alloc] initWithFrame:CGRectMake(20, 140, 280, 31)];
        first_last_name_txt.borderStyle = UITextBorderStyleRoundedRect;
        first_last_name_txt.placeholder = @"First name Last name";
        first_last_name_txt.backgroundColor = [UIColor whiteColor];
        first_last_name_txt.delegate = self;
        [self addSubview:first_last_name_txt];
        
        //Setup email text box
        email_txt = [[UITextField alloc] initWithFrame:CGRectMake(20, 180, 280, 31)];
        email_txt.borderStyle = UITextBorderStyleRoundedRect;
        email_txt.placeholder = @"Email: Awsome@awsome.com";
        email_txt.backgroundColor = [UIColor whiteColor];
        email_txt.delegate = self;
        [self addSubview:email_txt];
        
        //Setup password text box
        password_txt = [[UITextField alloc] initWithFrame:CGRectMake(20, 220, 280, 31)];
        password_txt.borderStyle = UITextBorderStyleRoundedRect;
        password_txt.placeholder = @"Password: password";
        password_txt.backgroundColor = [UIColor whiteColor];
        password_txt.delegate = self;
        [password_txt setSecureTextEntry:YES];
        [self addSubview:password_txt];
        
        //create register btn
        register_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [register_btn setTitle:@"Register" forState:UIControlStateNormal];
        register_btn.frame = CGRectMake(55, 320, 208, 50);
        [register_btn addTarget:self action:@selector(registerFunction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:register_btn];
        //create back btn
        back_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [back_btn setTitle:@"Back" forState:UIControlStateNormal];
        back_btn.frame = CGRectMake(10, 420, 60, 30);
        [back_btn addTarget:self action:@selector(leaveFunction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:back_btn];
    }
    return self;
}

-(void)leaveFunction
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"leaveRegisterScreen" object:nil];
}
-(void)registerFunction
{
    if (email_txt.text.length == 0 || password_txt.text.length <= 6)
    {
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to Login" message:@"Either an invalid username or password was used. Passwords must be longer than 6 characters. Please retry login." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[message show];
		[message release];
        return;
    }
    //tell user that I am thinking.
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
    
    NSURL *url = [NSURL URLWithString:login_check_address];
    //Create a request to the server.
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:first_last_name_txt.text forKey:@"name"];
    [request setPostValue:email_txt.text forKey:@"email"];
    [request setPostValue:password_txt.text forKey:@"password"];
    [request setPostValue:password_txt.text forKey:@"password_confirmation"];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
    
    //First send up the username to make sure it hasnt been taken already
    //If taken send message saying not valid
    //second send all the information to be registered
    //Assign username for use
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData *reData = [request responseData];
    if (reData) {
        printf("There is Data");
    }
    NSString *response = [request responseString];
    printf("\n\nResponse String : %s\n\n", [response UTF8String]);
    [load_message dismissWithClickedButtonIndex:0 animated:YES];
    
    if (response != nil && ![response isEqualToString:@"no"])
    {
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Congratulations and welcome to StaffItToMe You have been succesfully registered!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[message show];
		[message release];
        StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        delegate.user_state_information.userName = [email_txt.text copy];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeLoginScreen" object:nil];
        printf("Saved the user name");
    }
    else if ([response isEqualToString:@"no"])
    {
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to Login" message:@"Either an invalid username or password was used. Please retry login." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[message show];
		[message release];
    }
}





/*------------------------------------------TextFieldFunctions-----------------------------------------------*/
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"] && textField == first_last_name_txt) {
        [first_last_name_txt resignFirstResponder];
        [email_txt becomeFirstResponder];
        [email_txt setSelected:YES];
        
    }
    else if([string isEqualToString:@"\n"] && textField == email_txt) {
        [email_txt resignFirstResponder];
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
    [first_last_name_txt release];
    [logo_message release];
    [load_message release];
    [password_txt release];
    [email_txt release];
    [register_btn release];
    [back_btn release];
    [super dealloc];
}

@end
