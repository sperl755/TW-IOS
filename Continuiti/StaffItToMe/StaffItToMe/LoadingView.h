//
//  LoadingView.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoadingView : UIView
{
    UIImageView *load_background;
    UIImageView *spinner;
    BOOL loading;
    float angle;
    
}
-(void)setMiniatureMapLoading;
@end
