//
//  StaffOutHeader.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StaffOutHeaderProtocol <NSObject>
-(void)respondToStaffYourselfButton;
@end
@interface StaffOutHeader : UIView
{
    UILabel *what_waiting;
    UIButton *staff_out_button;
    UIImageView *header_shadow;
}
@property (nonatomic, retain) id <StaffOutHeaderProtocol> delegate;
@end
