//
//  BubbleMessageView.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BubbleMessageView.h"


@implementation BubbleMessageView

- (id)initWithFrame:(CGRect)frame andMessage:(NSString*)the_message andSenderInteger:(int)send_or_recieve andDate:(NSString*)the_date
{
    self = [super initWithFrame:frame];
    if (self) {
        sender_or_reciever = send_or_recieve;
        int labelHeight = [self labelHeight:the_message];
        labelHeight -= bubble_frag_height;
        if (labelHeight<0) labelHeight = 0;
         
        if (sender_or_reciever == 1) //If Sender
        {
            //Place the bubble on the far right
            bubble_x = 150;
            bubble_frag_width = [UIImage imageNamed:@"SBottomRight.png"].size.width;
            bubble_frag_height = [UIImage imageNamed:@"SBottomRight.png"].size.height;
            top_left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"STopLeft.png"]];
            top_middle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"STopMiddle.png"]];
            top_right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"STopRight.png"]];
            middle_left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SMiddleLeft.png"]];
            middle_middle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SMiddleMiddle.png"]];
            middle_right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SMiddleRight.png"]];
            bottom_left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SBottomLeft.png"]];
            bottom_middle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SBottomMiddle.png"]];
            bottom_right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SBottomRight.png"]];
        }
        else if (sender_or_reciever == 2) //If Reciever
        {
            //Place Bubble on the left side
            bubble_x = 5;
            bubble_frag_width = [UIImage imageNamed:@"RBottomRight.png"].size.width;
            bubble_frag_height = [UIImage imageNamed:@"RBottomRight.png"].size.height;
            top_left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RTopLeft.png"]];
            top_middle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RTopMiddle.png"]];
            top_right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RTopRight.png"]];
            middle_left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RMiddleLeft.png"]];
            middle_middle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RMiddleMiddle.png"]];
            middle_right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RMiddleRight.png"]];
            bottom_left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RBottomLeft.png"]];
            bottom_middle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RBottomMiddle.png"]];
            bottom_right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RBottomRight.png"]];
        }  
        bubble_y = 20;
        message_label = [[UILabel alloc] init];
        message_label.text = the_message;
        date_label = [[UILabel alloc] init];
        date_label.text = the_date;
        date_label.font = [UIFont boldSystemFontOfSize:FONTSIZE];
        date_label.textAlignment = UITextAlignmentCenter;
        date_label.textColor = [UIColor darkGrayColor];
        date_label.backgroundColor = [UIColor clearColor];  
        [self addSubview:top_left];
        [self addSubview:top_middle];
        [self addSubview:top_right];
        [self addSubview:middle_left];
        [self addSubview:middle_middle];
        [self addSubview:middle_right];
        [self addSubview:bottom_left];
        [self addSubview:bottom_middle];
        [self addSubview:bottom_right];
        [self addSubview:message_label];
        [self addSubview:date_label];
        date_label.frame = CGRectMake(55, 0, 200, 15);
        
        //---top left---
        top_left.frame = CGRectMake(bubble_x, bubble_y, bubble_frag_width, bubble_frag_height);		
        //---top middle---
        top_middle.frame = CGRectMake(bubble_x + bubble_frag_width, bubble_y, bubble_frag_width, bubble_frag_height);        
        //---top right---
        top_right.frame = CGRectMake(bubble_x + (bubble_frag_width * 2), bubble_y, bubble_frag_width, bubble_frag_height);		
        //---middle left---
        middle_left.frame = CGRectMake(bubble_x, bubble_y + bubble_frag_height, bubble_frag_width, labelHeight);		
        //---middle middle---
        middle_middle.frame = CGRectMake(bubble_x + bubble_frag_width, bubble_y + bubble_frag_height, bubble_frag_width, labelHeight);		
        //---middle right---
        middle_right.frame = CGRectMake(bubble_x + (bubble_frag_width * 2), bubble_y + bubble_frag_height, bubble_frag_width, labelHeight);		
        //---bottom left---
        bottom_left.frame = CGRectMake(bubble_x, bubble_y + bubble_frag_height + labelHeight, bubble_frag_width, bubble_frag_height ); 		
        //---bottom middle---
        bottom_middle.frame = CGRectMake(bubble_x + bubble_frag_width, bubble_y + bubble_frag_height + labelHeight, bubble_frag_width, bubble_frag_height);		
        //---bottom right---
        bottom_right.frame = CGRectMake(bubble_x + (bubble_frag_width * 2), bubble_y + bubble_frag_height + labelHeight, bubble_frag_width, bubble_frag_height );
        
        //---you can customize the look and feel for each message here---	
        message_label.frame = CGRectMake(bubble_x + 10, bubble_y + 5, (bubble_frag_width * 3) - 25, (bubble_frag_height * 2) + labelHeight - 10);
        message_label.font = [UIFont systemFontOfSize:FONTSIZE];
        message_label.textAlignment = UITextAlignmentCenter;
        message_label.textColor = [UIColor darkTextColor];
        message_label.numberOfLines = 0;
        message_label.backgroundColor = [UIColor clearColor];
        message_label.lineBreakMode = UILineBreakModeWordWrap;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, (bubble_y + bubble_frag_height * 2 + labelHeight) + 5); 
    }
    return self;
}
//Calculate the_message's height
-(CGFloat) labelHeight:(NSString *) text 
{
    CGSize maximumLabelSize = CGSizeMake((bubble_frag_width * 3) - 25,9999);
    CGSize expectedLabelSize = [text sizeWithFont:[UIFont systemFontOfSize: FONTSIZE] 
                                constrainedToSize:maximumLabelSize 
                                    lineBreakMode:UILineBreakModeWordWrap]; 
    return expectedLabelSize.height;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
