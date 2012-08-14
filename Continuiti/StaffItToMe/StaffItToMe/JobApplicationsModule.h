//
//  JobApplicationsModule.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDisplayCell.h"
@protocol JobApplicationModuleProtocol <NSObject>
-(void)reloadTableData;
@end

@interface JobApplicationsModule : UIView {
    UIImageView *header_background;
    UILabel *my_applications_label;
    UILabel *my_application_count_label;
    
    
}
@property (nonatomic, retain) id <JobApplicationModuleProtocol> delegate;

@end
