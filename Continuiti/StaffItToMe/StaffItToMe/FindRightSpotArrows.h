//
//  FindRightSpotArrows.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FindRightSpotArrowProtocol <NSObject>
-(void)reactToButtonFindRightSpotButtonBeingPressed:(NSString*)the_button_name;
@end

@interface FindRightSpotArrows : UIView
{
    UIButton *left_arrow;
    UIButton *up_arrow;
    UIButton *right_arrow;
    UIButton *down_arrow;
    
}
-(void)buttonTouched:(id)sender;
@property (nonatomic, retain) id <FindRightSpotArrowProtocol> delegate;
@end
