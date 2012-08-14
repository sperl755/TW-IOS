//
//  AUserProfileController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUserSummaryModule.h"
#import "AUserCapabilitiesModule.h"
#import "AUserExperienceModule.h"

@interface AUserProfileController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *background;
    UITableView *my_table_view;
    NSArray *module_array;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil jsonInformation:(NSString*)json_string_info;
@end
