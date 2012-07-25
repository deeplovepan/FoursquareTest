//
//  MyActivityIndicatorViewLib.h
//  DeeploveProgram
//
//  Created by deeplove on 2011/5/11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyActivityIndicatorViewLib : NSObject

@property (retain, nonatomic) UIView *lockView;
-(void)showUIActivityIndicatorWithframe:(CGRect)frame text:(NSString*)text 
                           isLockScreen:(BOOL)isLockScreen onView:(UIView*)view;
-(void)removeUIActivityIndicator;
+(UIView*)showUIActivityIndicatorWithframe:(CGRect)frame text:(NSString*)text 
                              isLockScreen:(BOOL)isLockScreen onView:(UIView*)view;
@end
