//
//  FacebookFriendEICell.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 10/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookFriendEICell.h"
#import "StaffItToMeAppDelegate.h"
#define module_row_one_background_key @"module_row_one_background"
#define friend_one_picture_key @"friend_one_picture"
#define friend_one_label_key @"friend_one_label"
#define friend_one_invite_key @"friend_one_invite"
#define friend_one_endorse_key @"friend_one_endorse"
#define friend_id_key @"friend_id_key"
@implementation FacebookFriendEICell
static NSString *endorse_link = @"https://helium.staffittome.com/apis/endorse";
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        facebook = [[Facebook alloc] initWithAppId:@"187212574660004"];
        facebook.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"FBExpirationDateKey"];
        
        //Create back
        module_row_one_background = [[aDecoder decodeObjectForKey:module_row_one_background_key] retain];
        module_row_one_background.frame = CGRectMake(0, 0, 310, 42);
        [self addSubview:module_row_one_background];
        
        friend_one_picture = [[aDecoder decodeObjectForKey:friend_one_picture_key] retain];
        [friend_one_picture setFrame:CGRectMake(module_row_one_background.frame.origin.x + 10, module_row_one_background.frame.origin.y + 8, 25, 25)];
        [self addSubview:friend_one_picture];
        
        //add nice overlay to compliment photo
        friend_one_overlay = [[UIImageView alloc] initWithFrame:friend_one_picture.frame];
        friend_one_overlay.image = [UIImage imageNamed:@"50x50_overlay"];
        [self addSubview:friend_one_overlay];
        
        //module_row_one_background = [[aDecoder decodeObjectForKey:module_row_one_background_key] retain];
        //friend_one_picture = [[aDecoder decodeObjectForKey:friend_one_picture_key] retain];
        friend_one_name = [[aDecoder decodeObjectForKey:friend_one_label_key] retain];
        friend_one_name.backgroundColor = [UIColor clearColor];
        [self addSubview:friend_one_name];
        
        friend_one_invite_btn = [[aDecoder decodeObjectForKey:friend_one_invite_key] retain];
        [self addSubview:friend_one_invite_btn.imageView];
        
        friend_one_endorse_btn = [[aDecoder decodeObjectForKey:friend_one_endorse_key] retain];
        [self addSubview:friend_one_endorse_btn];
        
        friend_facebook_id = [[aDecoder decodeObjectForKey:friend_id_key] retain];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:module_row_one_background forKey:module_row_one_background_key];
    [aCoder encodeObject:friend_one_picture forKey:friend_one_picture_key];
    [aCoder encodeObject:friend_one_name forKey:friend_one_label_key];
    [aCoder encodeObject:friend_one_invite_btn forKey:friend_one_invite_key];
    [aCoder encodeObject:friend_one_endorse_btn forKey:friend_one_endorse_key];
    [aCoder encodeObject:friend_facebook_id forKey:friend_id_key];
}
/**EncoderTestingMethod*/
-(NSString*)getFriendName
{
    return friend_one_name.text;
}
-(float)getWidth
{
    return module_row_one_background.frame.size.height;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFriendName:(NSString*)friend_name friend_id:(NSString*)friend_id
{
    if ((self = [super init]))
    {
        facebook = [[Facebook alloc] initWithAppId:@"187212574660004"];
        facebook.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"FBExpirationDateKey"];
        //Create back
        UIImage *row_background = [UIImage imageNamed:@"module_row_single.png"];
        UIImage *stretch_back = [row_background stretchableImageWithLeftCapWidth:(row_background.size.width/2)-1 topCapHeight:(row_background.size.height/2)-1];
        module_row_one_background = [[UIImageView alloc] initWithImage:stretch_back];
        module_row_one_background.frame = CGRectMake(0, 0, 310, 42);
        [self addSubview:module_row_one_background];
        //creat invite
        friend_one_invite_btn = [[UIButton alloc] initWithFrame:CGRectMake(250, module_row_one_background.frame.origin.y + 10, 50, 22)];
        [friend_one_invite_btn addTarget:self action:@selector(sendWallPost:) forControlEvents:UIControlEventTouchUpInside];
        [friend_one_invite_btn setImage:[UIImage imageNamed:@"invite_button_text"] forState:UIControlStateNormal];
        friend_one_invite_btn.tag = 0;
        [self addSubview:friend_one_invite_btn];
        //create endorse
        friend_one_endorse_btn = [[UIButton alloc] initWithFrame:CGRectMake(190, module_row_one_background.frame.origin.y + 10, 50, 22)];
        [friend_one_endorse_btn addTarget:self action:@selector(sendEndorsement) forControlEvents:UIControlEventTouchUpInside];
        [friend_one_endorse_btn setImage:[UIImage imageNamed:@"endorse_button"] forState:UIControlStateNormal];
        friend_one_endorse_btn.tag = 0;
        [self addSubview:friend_one_endorse_btn];
        
        //Create and get picture of friend
        friend_facebook_id = [[NSString alloc] initWithString:friend_id];
        
        
        
        [self performSelectorInBackground:@selector(getImageForFriend) withObject:nil];
        
        //set the friend name
        friend_one_name = [[UILabel alloc] initWithFrame:CGRectMake(module_row_one_background.frame.origin.x + 45, module_row_one_background.frame.origin.y + 8, 200, 30)];
        friend_one_name.backgroundColor = [UIColor clearColor];
        friend_one_name.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:10];
        friend_one_name.text = friend_name;
        [self addSubview:friend_one_name];
        //set my frame
        [self setFrame:CGRectMake(5, 5, 310, 42)];
    }
    return self;
}
-(void)getImageForFriend
{
    NSAutoreleasePool *temp_pool = [[NSAutoreleasePool alloc] init];
    //Create picture of the friend
    NSMutableString *friend_one_url_string = [NSMutableString stringWithString:@"http://graph.facebook.com/"];
    [friend_one_url_string appendString:friend_facebook_id];
    [friend_one_url_string appendString:@"/picture?type=large"];
    
    friend_one_picture = [[UIImageView alloc] initWithImage:
                          [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:friend_one_url_string]]]];
    [friend_one_picture setFrame:CGRectMake(module_row_one_background.frame.origin.x + 10, module_row_one_background.frame.origin.y + 8, 25, 25)];
    [self addSubview:friend_one_picture];
    
    //add nice overlay to compliment photo
    friend_one_overlay = [[UIImageView alloc] initWithFrame:friend_one_picture.frame];
    friend_one_overlay.image = [UIImage imageNamed:@"50x50_overlay"];
    [self addSubview:friend_one_overlay];
    [temp_pool drain];
}
-(void)sendWallPost:(id)sender
{
    NSString *graphPath;
    graphPath = [NSString stringWithFormat:@"%@/feed",friend_facebook_id];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"187212574660004",@"api_key",@"You should come to staff with me!",@"message", @"join me",@"caption", @"Some Random Message",@"description", nil];
    [facebook requestWithGraphPath:graphPath andParams:params andHttpMethod:@"POST" andDelegate:self];
    
}
-(void)sendEndorsement
{
    //Show that they are loading the endorsement
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, -150, 320, 480)];
    [self.superview addSubview:load_view];
    
    
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:endorse_link];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    printf("\nFacebook UID: %s\n", [friend_facebook_id UTF8String]);
    [request_ror setPostValue:friend_facebook_id forKey:@"facebook_uid"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror startAsynchronous];   
}
-(void)request:(FBRequest *)request didLoad:(id)result
{
    AlertLoadView *alert = [[AlertLoadView alloc] initWithFrame:CGRectMake(0, -150, 320, 480) andText:@"You have succesfully invited your friend!"];
    [self.superview addSubview:alert];
}
-(void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Unable to post" message:@"Unable to send request, user could have posting turned off!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [message show];
    [message release];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [load_view removeFromSuperview];
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
    [module_row_one_background release];
    [friend_one_name release];
    [friend_one_picture release];
    [friend_one_overlay release];
    [friend_one_invite_btn release];
    [friend_one_endorse_btn release];
    [friend_facebook_id release];
    [facebook release];
    [super dealloc];
}

@end
