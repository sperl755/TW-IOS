//
//  PendingRequestsModule.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDisplayCell.h"
@protocol PendingRequestModuleProtocol <NSObject>
-(void)reloadMyTableView;
@end

@interface PendingRequestsModule : UIView 
{
    UIImageView *module_header_background;
    UILabel *spam_your_friends_label;
    
}
-(id)initRequesting;
-(id)initWithArray:(NSArray*)the_requests;
@property (nonatomic, retain) id <PendingRequestModuleProtocol> delegate;

@end
