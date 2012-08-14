//
//  StaffYourself.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookBroadcast.h"
@protocol StaffYourselfProtocol <NSObject>
@required
-(void)staff1;
-(void)goToFaceBookBroadcast;
@end


@interface StaffYourself : UIViewController {
    IBOutlet UIImageView *user_profile_picture;
    
}
-(IBAction)goToStaffOutSegment1;
-(IBAction)broadcastOnFacebook;
@property (retain) id <StaffYourselfProtocol> delegate;
@end
