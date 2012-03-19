//
//  ProfileWebService.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshHeader.h"

@interface ProfileWebService : UIViewController<UIWebViewDelegate, UIScrollViewDelegate>
{
    IBOutlet UIWebView *my_web_view;
    BOOL am_loading;
    BOOL did_pull_load;
    PullRefreshHeader *refresh_header;
}
-(void)setupNavGUI;

@property (nonatomic, retain) NSString *my_facebook_token;
@property (nonatomic, retain) NSString *my_user_name;

@end
