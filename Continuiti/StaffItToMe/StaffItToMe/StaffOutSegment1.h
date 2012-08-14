//
//  StaffOutSegment1.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StaffOutSegement1Protocol <NSObject>
-(void)goToSegment2;
@property (nonatomic, retain) NSString *proposal_title;
@property (nonatomic, retain) NSString *customer_name;
@property (nonatomic, retain) NSString *customer_company;
@property (nonatomic, retain) NSString *customer_email;
@property (nonatomic, retain) NSString *capabilities;
@end


@interface StaffOutSegment1 : UIViewController <UITextFieldDelegate, UITextViewDelegate> {
    IBOutlet UIButton *next;
    IBOutlet UITextField *proposal_title;
    IBOutlet UITextField *customer_name;
    IBOutlet UITextField *customer_company;
    IBOutlet UITextField *customer_email;
    IBOutlet UITextView *capabilities;
    
}
-(IBAction)goToNext;
@property (retain) id <StaffOutSegement1Protocol> delegate;
@end
