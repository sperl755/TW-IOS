//
//  FriendFacebookBroadcast.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"
@protocol FriendFacebookBroadcastProtocol <NSObject>
-(void)leaveFriendFacebookBroadcast;
@end


@interface FriendFacebookBroadcast : UIViewController<FBRequestDelegate, UITextViewDelegate> {
    int my_pos;
    Facebook *facebook;
    UIImageView *background_of_message;
    IBOutlet UITextView *message;
    IBOutlet UILabel *friend_message_label;
}
-(void)setPositionInArray:(int)the_pos;
-(IBAction)sendThePost;
@property (retain) id <FriendFacebookBroadcastProtocol> delegate;
@end
