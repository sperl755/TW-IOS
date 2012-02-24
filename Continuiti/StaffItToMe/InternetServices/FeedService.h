//
//  FeedService.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedService : NSObject
{
}

@property (nonatomic) SEL request_success_function;
@property (nonatomic) SEL request_failed_function;

-(void)postNewFeedWithDictionary:(NSDictionary*)the_values;

@end
