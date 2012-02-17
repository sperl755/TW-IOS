//
//  Capability.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
	Holds information about a users capability in object format for manipulation and reading.
 */
@interface Capability : NSObject
{
    
}
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *capability_id;
@end
