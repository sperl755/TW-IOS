//
//  IndustrySearchController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCategoryCell.h"
@protocol IndustrySearchProtocol <NSObject>
-(void)leaveIndustrySearch;
@end


@interface IndustrySearchController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *background_image;
    NSArray *list_of_industries;
    UITableView *search_table;
}
@property (nonatomic, retain) id <IndustrySearchProtocol> delegate;
@end
