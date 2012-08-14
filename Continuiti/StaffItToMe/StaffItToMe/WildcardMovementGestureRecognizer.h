//
//  WildcardMovementGestureRecognizer.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^TouchesEventBlock)(NSSet *touches, UIEvent *event);
@interface WildcardMovementGestureRecognizer : UIGestureRecognizer
{
    TouchesEventBlock touchesEndedCallback;
    
}
@property (copy) TouchesEventBlock touchesEndedCallback;

@end
