//
//  LoginScreen.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterScreen.h"
#import "FacebookBtn.h"
#import "ASIFormDataRequest.h"
#import "TwitterBtn.h"

@interface LoginScreen : UIView <UITextFieldDelegate>{
    UIImageView *logo_message;
    UIAlertView *load_message;
    UIButton *register_btn;
    UITextField *username_txt;
    UITextField *password_txt;
    UIButton *login_btn;
    FacebookBtn *facebook_btn;
    TwitterBtn *twitter_btn;
    RegisterScreen *register_scrn;
}
-(void)displayRegisterScreen;
-(void)facebookFunction;
-(int)getRegisterScreenCount;
-(void)login;
-(void)leaveRegisterScreen;
@end
