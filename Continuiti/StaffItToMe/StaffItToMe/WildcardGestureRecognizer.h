//
//  WildcardGestureRecognizer.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TouchesEventBlock)(NSSet *touches, UIEvent *event);

@interface WildcardGestureRecognizer : UIGestureRecognizer 
{
    TouchesEventBlock touchesEndedCallback;
    TouchesEventBlock touchesMovedCallback;
}
@property (copy) TouchesEventBlock touchesEndedCallback;
@property (copy) TouchesEventBlock touchesMovedCallback;
@end
