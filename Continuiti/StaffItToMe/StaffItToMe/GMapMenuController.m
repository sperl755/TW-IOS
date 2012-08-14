//
//  GMapMenuController.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GMapMenuController.h"
#import "StaffItToMeAppDelegate.h"


@implementation GMapMenuController
-(id)init
{
    if ((self = [super init]))
    {
        my_map = [[Menu alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        [self.view addSubview:my_map];
    }
    return self;
}
-(void)viewDidLoad
{
}
-(void)updateMenu
{
    [my_map.filter_screen updateTableView];
}

@end
