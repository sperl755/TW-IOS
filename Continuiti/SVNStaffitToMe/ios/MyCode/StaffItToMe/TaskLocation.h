//
//  TaskLocation.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TaskLocation : NSObject {
    
}
@property (nonatomic, assign) NSString *address_name;
@property (nonatomic, assign) NSString *address_one;
@property (nonatomic, assign) NSString *address_two;
@property (nonatomic, assign) NSString *city;
@property (nonatomic, assign) NSString *state;
@property (nonatomic, assign) NSString *zipcode;
@property (nonatomic, assign) NSString *country;
@property (nonatomic, assign) NSString *phone;
@property (nonatomic, assign) NSString *contact_name;
@end
