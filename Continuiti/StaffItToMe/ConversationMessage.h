//
//  ConversationMessage.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ConversationMessage : NSObject {
    
}
@property (nonatomic, retain) NSString *my_body;
@property (nonatomic, retain) NSString *my_subject;
@property (nonatomic, retain) NSString *my_sender_name;
@property (nonatomic, retain) NSString *my_date;
@property int my_id;

@end
