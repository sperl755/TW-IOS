//
//  DistanceSearchController.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DistanceSearchProtocol <NSObject>
-(void)leaveDistanceSearch;
@end

@interface DistanceSearchController : UIViewController <UITableViewDelegate, UITableViewDataSource> 
{
    UIImageView *background_image;
    NSArray *list_of_industries;
    UITableView *search_table;
    
}

@property (nonatomic, retain) id <DistanceSearchProtocol> delegate;
@end
