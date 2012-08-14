//
//  MessageHeaderObject.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MessageHeaderObject : NSObject 
{
    
}
@property (nonatomic, retain) NSString* my_date;
@property (nonatomic, retain) NSString* my_body;
@property (nonatomic, retain) NSString* my_subject;
@property (nonatomic, retain) NSString* my_recipient_id;
@property (nonatomic, retain) NSString* my_sender_id;
@property (nonatomic, retain) NSString* my_sender_name;
@property (nonatomic, retain) NSString* my_recipient_name;
@property (nonatomic, retain) NSString* my_message_id;
@property (nonatomic, retain)  NSMutableArray *my_conversations;
-(id)initWithDate:(NSString*)the_date body:(NSString*)the_body subject:(NSString*)the_subject recipient_id:(NSString*)the_recipient_id sender_id:(NSString*)the_sender_id sender_name:(NSString*)the_sender_name recipient_name:(NSString*)the_recipient_name message_id:(NSString*)the_message_id;
-(void)retrieveConversations;

-(id)initWithCoder:(NSCoder*)aDecoder;
-(void)encodeWithCoder:(NSCoder*)aCoder;
@end
