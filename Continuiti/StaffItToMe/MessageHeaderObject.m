//
//  MessageHeaderObject.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MessageHeaderObject.h"
#import "ASIFormDataRequest.h"
#import "StaffItToMeAppDelegate.h"
#import "JSON.h"
#import "ConversationMessage.h"
#define MY_DATE_KEY @"MYDATEKEY"
#define BODY_KEY    @"MYBODYKEY"
#define SUBJECT_KEY @"SUBJECTKEY"
#define MY_RECIPIENT_ID_KEY @"MYRECIPEIENTID"
#define MY_SENDER_ID_KEY    @"MYSENDERID"
#define MY_NAME_SENDER_KEY  @"MYSENDERNAMEKEY"
#define RECIPIENT_NAME_KEY  @"RECIPIENT_NAME_KEY"
#define MESSAGE_IDS @"MYMESSAGEIDS"
@implementation MessageHeaderObject
@synthesize my_date;
@synthesize my_body;
@synthesize my_subject;
@synthesize my_recipient_id;
@synthesize my_sender_id;
@synthesize my_sender_name;
@synthesize my_recipient_name;
@synthesize my_message_id;
@synthesize my_conversations;

-(id)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super init]))
    {
        my_date = [[aDecoder decodeObjectForKey:MY_DATE_KEY] retain];
        my_body = [[aDecoder decodeObjectForKey:BODY_KEY] retain];
        my_subject = [[aDecoder decodeObjectForKey:SUBJECT_KEY] retain];
        my_recipient_id = [[aDecoder decodeObjectForKey:MY_RECIPIENT_ID_KEY] retain];
        my_sender_id = [[aDecoder decodeObjectForKey:MY_SENDER_ID_KEY] retain];
        my_sender_name = [[aDecoder decodeObjectForKey:MY_NAME_SENDER_KEY] retain];
        my_recipient_name = [[aDecoder decodeObjectForKey:RECIPIENT_NAME_KEY] retain];
        my_message_id = [[aDecoder decodeObjectForKey:MESSAGE_IDS] retain];
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeObject:my_date forKey:MY_DATE_KEY];
    [aCoder encodeObject:my_body forKey:BODY_KEY];
    [aCoder encodeObject:my_subject forKey:SUBJECT_KEY];
    [aCoder encodeObject:my_recipient_id forKey:MY_RECIPIENT_ID_KEY];
    [aCoder encodeObject:my_sender_id forKey:MY_SENDER_ID_KEY];
    [aCoder encodeObject:my_sender_name forKey:MY_NAME_SENDER_KEY];
    [aCoder encodeObject:my_recipient_name forKey:RECIPIENT_NAME_KEY];
    [aCoder encodeObject:my_message_id forKey:MESSAGE_IDS];
}
-(void)retrieveConversations
{
    NSMutableString *the_url_String = [NSMutableString stringWithString:@"https://helium.staffittome.com/apis/"];
    [the_url_String appendString:my_message_id];
    [the_url_String appendString:@"/view_message"];
    NSURL *url = [NSURL URLWithString:the_url_String];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request_ror startAsynchronous];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    printf("\n\n\nTHe message details: %s\n\n\n", [[request responseString] UTF8String]);
    NSString *string = [request responseString];
    NSDictionary *array_of_conversations = [string JSONValue];
    int sender = [[[array_of_conversations objectForKey:@"message"] objectForKey:@"sender_id"] intValue];
    my_sender_id = [[NSString alloc] initWithFormat:@"%d", sender];
    printf("%s", [my_sender_id UTF8String]);
    /*for (int i = 0; i < array_of_conversations.count; i++)
    {
        ConversationMessage *message = [[ConversationMessage alloc] init];
        message.my_body = [[array_of_conversations objectAtIndex:i] objectForKey:@"body"];
        message.my_subject = [[array_of_conversations objectAtIndex:i] objectForKey:@"subject"];
        message.my_sender_name = [[array_of_conversations objectAtIndex:i] objectForKey:@"sender_name"];
        message.my_date = [[array_of_conversations objectAtIndex:i] objectForKey:@"created_at"];
        message.my_id = (int) [[array_of_conversations objectAtIndex:i] objectForKey:@"id"];
        [my_conversations addObject:message];
        [message release];
    }*/
}
-(id)initWithDate:(NSString*)the_date body:(NSString*)the_body subject:(NSString*)the_subject recipient_id:(NSString*)the_recipient_id sender_id:(NSString*)the_sender_id sender_name:(NSString*)the_sender_name recipient_name:(NSString*)the_recipient_name message_id:(NSString*)the_message_id;
{
    if ((self = [super init]))
    {
        my_date = [the_date retain];
        my_body = [the_body retain];
        my_subject = [the_subject retain];
        my_recipient_id = [the_recipient_id retain];
        my_sender_id = [the_sender_id retain];
        my_sender_name = [the_sender_name retain];
        my_recipient_name = [the_sender_name retain];
        my_message_id = [the_message_id retain];
        my_conversations = [[NSMutableArray alloc] initWithCapacity:11];
        //[self retrieveConversations];
    }
    return self;
}
@end
