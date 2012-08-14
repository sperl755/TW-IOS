//
//  SalarySearchController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCategoryCell.h"

@protocol SalarySearchProtocol <NSObject>
-(void)leaveSalarySearch;
@end

@interface SalarySearchController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *background_image;
    NSArray *list_salaries;
    UITableView *search_table;
    
}
@property (nonatomic, retain) id <SalarySearchProtocol> delegate;
@end
