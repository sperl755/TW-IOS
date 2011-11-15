//
//  JobHistoryController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JobHistoryControllerProtocol <NSObject>
-(void)removeJobHistoryDetail;
@end


@interface JobHistoryController : UIViewController {
    int job_position;
}
-(IBAction)doneDisplaying;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPos:(int)the_pos;
@property (retain) id <JobHistoryControllerProtocol> delegate;

@end
