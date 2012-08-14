//
//  LoginScreen.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterScreen.h"
#import "ASIFormDataRequest.h"
#import "TwitterBtn.h"
#import "JSON.h"

@interface LoginScreen : UIView <UITextFieldDelegate>{
    UIImageView *logo_message;
    UIImageView *background;
    UIAlertView *load_message;
    UIButton *register_btn;
    UITextField *username_txt;
    UITextField *password_txt;
    UIButton *login_btn;
    UILabel *login_or_register;
    UIButton *facebook_register_btn;
    TwitterBtn *twitter_btn;
    RegisterScreen *register_scrn;
}
-(void)displayRegisterScreen;
-(int)getRegisterScreenCount;
-(void)login;
-(void)leaveRegisterScreen;
@end
