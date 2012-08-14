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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Create logo and message container
        logo_message = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoAndMessage.png"]];
        [logo_message setFrame:CGRectMake(0, -30, logo_message.frame.size.width, logo_message.frame.size.height)];
        [self addSubview:logo_message];
        
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
    //First send up the username to make sure it hasnt been taken already
    //If taken send message saying not valid
    //second send all the information to be registered
    //Assign username for use
    StaffItToMeAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate setUsername:[email_txt text]];
    printf("Saved the user name");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeLoginScreen" object:nil];
}





/*------------------------------------------TextFieldFunctions-----------------------------------------------*/
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"] && textField == email_txt) {
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
    [logo_message release];
    [password_txt release];
    [email_txt release];
    [register_btn release];
    [super dealloc];
}

@end
