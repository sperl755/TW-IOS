//
//  FeedWebService.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedService.h"
#import "PullRefreshHeader.h"
#import "SharePostViewController.h"

@interface FeedWebService : UIViewController<UIWebViewDelegate, UIScrollViewDelegate>
{
    IBOutlet UIWebView *my_web_view;
    BOOL am_loading;
    BOOL did_pull_load;
    PullRefreshHeader *refresh_header;
    UIButton *myShareButton;
    SharePostViewController *share_post_controller;
    FeedService *my_feed_service;
    BOOL view_has_displayed;
    
    BOOL share_displayed;
    
}
-(void)setupNavGUI;

-(void)displayShareButtonPost;
-(void)hideShareButtonPost;
@property (nonatomic, retain) NSString *my_facebook_token;
@property (nonatomic, retain) NSString *my_user_name;

@end
