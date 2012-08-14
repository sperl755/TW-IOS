//
//  PendingRequestsModule.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PendingRequestsModule.h"
#import "ASIFormDataRequest.h"
#import "StaffItToMeAppDelegate.h"

@implementation PendingRequestsModule
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initRequesting
{
    if ((self = [super init]))
    {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
       
        int user_id = app_delegate.user_state_information.my_user_info.user_id;
        
        NSURL *url = [NSURL URLWithString:[[URLLibrary sharedInstance] getPendingRequestsLinkWithUserId:user_id]];
        ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
        [request_ror setRequestMethod:@"GET"];
        [request_ror setTimeOutSeconds:30];
        
        [request_ror setValidatesSecureCertificate:NO];
        [request_ror setDelegate:self];
        //[request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
        [request_ror startAsynchronous];
    }
    return self;
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSArray *first_level = [[request responseString] JSONValue];
    //Create Header First
    UIImage *header_image           = [UIImage imageNamed:@"module_header.png"];
    module_header_background        = [[UIImageView alloc] initWithImage:header_image];
    module_header_background.frame  = CGRectMake(5, 0, 310, 33);
    [self addSubview:module_header_background];
    
    spam_your_friends_label                 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
    spam_your_friends_label.textColor       = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
    spam_your_friends_label.backgroundColor = [UIColor clearColor];
    [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    
    StaffItToMeAppDelegate *app_delegate    = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    NSMutableString *header_label           = [[NSMutableString alloc] initWithString:app_delegate.user_state_information.my_user_info.full_name];
    
    [header_label appendString:@"'s Proposals"];
    spam_your_friends_label.text = header_label;
    
    [self addSubview:spam_your_friends_label];
    
    
    int height = 0;
    //Check to make sure there are proposals
    if (first_level.count < 1 )
    {
        JobDisplayCell *no_info = [[JobDisplayCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) pictureURL:@"" name:@"Not Available" description:@"" detail:@""];
        //Detail = [[the_capabilities objectAtIndex:i] objectForKey:@"inclusive"]
        [no_info removeArrow];
        
        [no_info setBackgroundImageToModuleRowLast];
        
        [self addSubview:no_info];
        no_info.frame = CGRectMake(5, (module_header_background.frame.origin.y + module_header_background.frame.size.height), 310, 33);
        height+= 42;
    }
    
    for (int i = 0; i < first_level.count; i++)
    {
        JobDisplayCell *no_info = [[JobDisplayCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) pictureURL:@"" name:[[[first_level objectAtIndex:i] objectForKey:@"proposal"] objectForKey:@"title"] description:[[[first_level objectAtIndex:i] objectForKey:@"proposal"] objectForKey:@"description_of_service"] detail:@""];
        //Detail = [[the_capabilities objectAtIndex:i] objectForKey:@"inclusive"]
        [no_info removeArrow];
        
        if (i == first_level.count-1)
        {
            [no_info setBackgroundImageToModuleRowLast];
        }
        
        [self addSubview:no_info];
        no_info.frame = CGRectMake(5, (module_header_background.frame.origin.y + module_header_background.frame.size.height) + i*42, 310, 33);
        height+= 42;
    }
    //set The frame of this module.
    [self setFrame:CGRectMake(0, 0, 310, module_header_background.frame.size.height + height)]; 
    
    
    [delegate reloadMyTableView];
}

-(id)initWithArray:(NSArray*)the_requests
{
    if ((self = [super init]))
    {
        //Create Header
        if (the_requests.count < 1) {
            return self;
        }
        UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
        module_header_background = [[UIImageView alloc] initWithImage:header_image];
        module_header_background.frame = CGRectMake(5, 0, 310, 33);
        [self addSubview:module_header_background];
        //[header_image release];
        spam_your_friends_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
        spam_your_friends_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        spam_your_friends_label.backgroundColor = [UIColor clearColor];
        [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        spam_your_friends_label.text = @"Pending Requests";
        [self addSubview:spam_your_friends_label];
        
        if (the_requests.count < 1)
        {
            JobDisplayCell *no_info = [[JobDisplayCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) pictureURL:@"" name:@"Mark Valley" description:@"Wanting to discuss our deal." detail:@""];
            [no_info removeArrow];
            [self addSubview:no_info];
            no_info.frame = CGRectMake(5, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, 33);
            [self setFrame:CGRectMake(0, 0, 310, (no_info.frame.origin.y + no_info.frame.size.height) - module_header_background.frame.origin.y)];
        }
        else
        {
            //set The frame of this module.
            [self setFrame:CGRectMake(5, 0, 310, module_header_background.frame.size.height)]; 
        }
        
    }
    return self;
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
