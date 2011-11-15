//
//  UserCapabilitiesProfileModule.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserCapabilitiesProfileModule.h"
#import "StaffItToMeAppDelegate.h"

@implementation UserCapabilitiesProfileModule
static NSString *capabilities = @"http://helium.staffittome.com/apis/capability_list";
-(id)init
{
    if ((self = [super init]))
    {
        //Create Header
        UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
        module_header_background = [[UIImageView alloc] initWithImage:header_image];
        module_header_background.frame = CGRectMake(5, 0, 310, 33);
        [self addSubview:module_header_background];
        //[header_image release];
        spam_your_friends_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
        spam_your_friends_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        spam_your_friends_label.backgroundColor = [UIColor clearColor];
        [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        NSMutableString *header_label = [[NSMutableString alloc] initWithString:app_delegate.user_state_information.my_user_info.full_name];
        [header_label appendString:@"'s Capabilities"];
        spam_your_friends_label.text = header_label;
        [self addSubview:spam_your_friends_label];
        
        //set The frame of this module.
        [self setFrame:CGRectMake(5, 0, 310, module_header_background.frame.size.height)]; 
    }
    return self;
}
-(id)initWithArray:(NSArray*)the_capabilities
{
    if ((self = [super init]))
    {
        //Create Header
        UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
        module_header_background = [[UIImageView alloc] initWithImage:header_image];
        module_header_background.frame = CGRectMake(5, 0, 310, 33);
        [self addSubview:module_header_background];
        //[header_image release];
        spam_your_friends_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
        spam_your_friends_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        spam_your_friends_label.backgroundColor = [UIColor clearColor];
        [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        NSMutableString *header_label = [[NSMutableString alloc] initWithString:app_delegate.user_state_information.my_user_info.full_name];
        [header_label appendString:@"'s Capabilities"];
        spam_your_friends_label.text = header_label;
        [self addSubview:spam_your_friends_label];
        
        if (the_capabilities.count < 1)
        {
            JobDisplayCell *no_info = [[JobDisplayCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) pictureURL:@"" name:@"Add a Capability" description:@"" detail:@""];
            [no_info removeArrow];
            [self addSubview:no_info];
    
            no_info.frame = CGRectMake(5, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, 33);
            [self setFrame:CGRectMake(0, 0, 310, 75 )];
        }
        else
        {
            int height = 0;
            for (int i = 0; i < the_capabilities.count; i++)
            {
                int from_year = [[[the_capabilities objectAtIndex:i] objectForKey:@"from_year"] intValue];
                NSMutableString *detail_text = [[NSMutableString alloc] initWithString:@"From Year: "];
                [detail_text appendString:[NSString stringWithFormat:@"%d", from_year]];
                JobDisplayCell *no_info = [[JobDisplayCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) pictureURL:@"" name:[[the_capabilities objectAtIndex:i] objectForKey:@"title"] description:[[[the_capabilities objectAtIndex:i] objectForKey:@"description"] capitalizedString] detail:@""];
                //Detail = [[the_capabilities objectAtIndex:i] objectForKey:@"inclusive"]
                [no_info removeArrow];
                
                if (i == the_capabilities.count-1)
                {
                    [no_info setBackgroundImageToModuleRowLast];
                }
                
                [self addSubview:no_info];
                no_info.frame = CGRectMake(5, (module_header_background.frame.origin.y + module_header_background.frame.size.height) + i*42, 310, 33);
                height+= 42;
            }
            //set The frame of this module.
            [self setFrame:CGRectMake(0, 0, 310, module_header_background.frame.size.height + height)]; 
        }
        int user_id = app_delegate.user_state_information.my_user_info.user_id;
        NSMutableString *url_string = [[NSMutableString alloc] initWithString:@"http://helium.staffittome.com/apis/"];
        [url_string appendString:[NSString stringWithFormat:@"%d", user_id]];
        [url_string appendString:@"/capability_list"];
        //Perform the accessing of fthe server. for the user capabilities
        NSURL *url = [NSURL URLWithString:url_string];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
        printf("%s", [[NSString stringWithFormat:@"%d", user_id] UTF8String]);
        [request setPostValue:[NSString stringWithFormat:@"%d", user_id]forKey:@"user_id"];
        ///Finish request
        [request setValidatesSecureCertificate:NO];
        [request setTimeOutSeconds:30];
        [request setDelegate:self];
        [request startAsynchronous];
        
    }
    return self;
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    printf("\n\n\nThis is theuser capabilities: %s\n\n", [[request responseString] UTF8String]);
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
