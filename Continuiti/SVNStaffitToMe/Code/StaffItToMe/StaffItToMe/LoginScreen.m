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

static NSString *login_check_address = @" http://hydrogen.xen.exoware.net:3000/job_search/any_keyword";
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
        //Setup username text box
        username_txt = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, 280, 31)];
        username_txt.borderStyle = UITextBorderStyleRoundedRect;
        username_txt.placeholder = @"Email: George@Bush.com";
        username_txt.backgroundColor = [UIColor whiteColor];
        username_txt.delegate = self;
        [self addSubview:username_txt];
        //Setup password text box
        password_txt = [[UITextField alloc] initWithFrame:CGRectMake(20, 160, 280, 31)];
        password_txt.borderStyle = UITextBorderStyleRoundedRect;
        password_txt.placeholder = @"Password: password";
        password_txt.backgroundColor = [UIColor whiteColor];
        password_txt.delegate = self;
        [password_txt setSecureTextEntry:YES];
        [self addSubview:password_txt];
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
    NSURL *url = [NSURL URLWithString:login_check_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
   // [request addPostValue:@"value1" forKey:nil];
    [request appendPostData:[username_txt.text dataUsingEncoding:NSUTF8StringEncoding]];
    [request setDownloadDestinationPath:@"file.txt"];
    [request startSynchronous];
    NSString *response = [request responseString];
    printf("%s", [response UTF8String]);
    
    if ([response isEqualToString:@"YES"]) {
        StaffItToMeAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        delegate.username = [username_txt.text copy];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeLoginScreen" object:nil];
    }
    else {
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to Login" message:@"Either an invalid username or password was used. Please retry login." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[message show];
		[message release];
    }
    
    
    
    
    
    
    
    
    
    /*
    //Okay so create a MutableURL Request and then set the http method to post
    //Reason for doing it this way is do to security.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:login_check_address]];
    [request setHTTPMethod:@"POST"];
    //Now create the body of the request which will be username,password with no
    //spaces. THen we set the string to the request body.
    NSMutableData *request_body = [NSMutableData data];
    [request_body appendData:[[NSString stringWithFormat:@"%@,%@",[username_txt.text UTF8String], [password_txt.text UTF8String]] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:request_body];
    //Here we actually access the server
    //we catch an error with error and the status code incase it is useful.
    NSHTTPURLResponse *response = nil;
    NSError *return_error = nil;
    NSData *return_data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&return_error];
    //int status = response.statusCode;
    
    //here we convert the response from the server to a string.
    NSString *server_response = [[[NSString alloc] initWithData:return_data encoding:NSUTF8StringEncoding] autorelease];
    //If the person has an account then the server returns YES
    //else we warn the user that the account username or password is invalid.
    if([server_response isEqualToString:@"YES"]) {
        //Run Login Code
    }
    else {
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to Login" message:@"Either an invalid username or password was used. Please retry login." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[message show];
		[message release];
    }*/
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
    [register_btn release];
    [username_txt release];
    [password_txt release];
    [login_btn release];
    [facebook_btn release];
    [register_scrn release];
    [super dealloc];
}

@end
