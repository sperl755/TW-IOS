//
//  MessagesWebService.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshHeader.h"

@interface MessagesWebService : UIViewController<UIWebViewDelegate, UIScrollViewDelegate>
{
    IBOutlet UIWebView *my_web_view;
    BOOL am_loading;
    BOOL did_pull_load;
    PullRefreshHeader *refresh_header;
    BOOL view_has_displayed;
}

@end
