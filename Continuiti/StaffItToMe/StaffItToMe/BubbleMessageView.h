//
//  BubbleMessageView.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//These are all of the differnt tags
//for the objects of this view
//because when they are in the table view they must
//be reused.
static CGFloat const FONTSIZE = 14.0;
static int const DATE_LABEL_TAG = 1;
static int const MESSAGE_LABEL_TAG = 2;
static int const UPPER_LEFT_TAG = 3;
static int const UPPER_MIDDLE_TAG = 4;
static int const UPPER_RIGHT_TAG = 5;
static int const MIDDLE_LEFT_TAG = 6;
static int const MIDDLE_MIDDLE_TAG = 7;
static int const MIDDLE_RIGHT_TAG = 8;
static int const BOTTOM_LEFT_TAG = 9;
static int const BOTTOM_MIDDLE_TAG = 10;
static int const BOTTOM_RIGHT_TAG = 11;
int bubble_frag_width, bubble_frag_height;
int bubble_x, bubble_y;
@interface BubbleMessageView : UIView 
{
    //This variable tells me where and what image to use as the bubble.
    //Sender will be the green bubble.
    //Reciever will be the gray bubble.
    //1 will mean that it is a sender and 2 means a reciever.
    int sender_or_reciever;   
    //Label for the message
    UILabel *date_label;
    UILabel *message_label;
    //Objects for the bubble
    UIImageView *top_left;
    UIImageView *top_middle;
    UIImageView *top_right;
    
    UIImageView *middle_left;
    UIImageView *middle_right;
    UIImageView *middle_middle;
    
    UIImageView *bottom_left;
    UIImageView *bottom_middle;
    UIImageView *bottom_right;

}
- (id)initWithFrame:(CGRect)frame andMessage:(NSString*)the_message andSenderInteger:(int)send_or_recieve andDate:(NSString*)the_date;
-(CGFloat) labelHeight:(NSString *)text;

@end
