//
//  ASTableView.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HandleView)();

@interface ASTableView : UITableView 
{
    HandleView handleViewCallback;
}
@property (copy) HandleView handleViewCallback;
@property (nonatomic) int tag_for_listening;
@property (nonatomic) int email_tag_for_listening;
@property (nonatomic) int subject_tag_for_listening;
@property (nonatomic) int message_tag_for_listening;
@property (nonatomic) int button_tag_for_listening;

@end
