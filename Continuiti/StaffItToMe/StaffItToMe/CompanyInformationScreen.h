//
//  CompanyInformationScreen.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyHeader.h"
#import "CompanySummary.h"
#import "BasicCompanyInformation.h"


@interface CompanyInformationScreen : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *background;
    CompanyHeader *company_header;
    UITableView *search_table;
    NSArray *module_array;
}
-(id)initWithJSONInformation:(NSString*)json_information;

@end
