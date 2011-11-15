//
//  RegisterScreen.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"

@interface RegisterScreen : UIView <UITextFieldDelegate> {
    UIImageView *logo_message;
    UIAlertView *load_message;
    UITextField *first_last_name_txt;
    UITextField *password_txt;
    UITextField *email_txt;
    UIButton *register_btn;
    UIButton *back_btn;
}
-(void)registerFunction;

@end
