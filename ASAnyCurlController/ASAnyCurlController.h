//
//  ASAnyCurlController.h
//
//  Created by Philippe Converset on 23/01/14.
//  Copyright (c) 2012 AutreSphere. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ASAnyCurlOptions) {
    ASAnyCurlOptionHorizontal   = 2 <<  0,
    ASAnyCurlOptionVertical     = 1 <<  0,
    
    ASAnyCurlOptionTopLeft      = 2 <<  4,
    ASAnyCurlOptionTopRight     = 3 <<  4,
    ASAnyCurlOptionBottomLeft   = 4 <<  4,
    ASAnyCurlOptionBottomRight  = 5 <<  4,
};

@interface ASAnyCurlController : UIViewController

@property (nonatomic, strong) UIViewController *contentController;

+ (void)animateTransitionDownFromView:(UIView *)fromView
                               toView:(UIView *)toView
                             duration:(NSTimeInterval)duration
                              options:(ASAnyCurlOptions)options
                           completion:(void(^)())completion;
+ (void)animateTransitionUpFromView:(UIView *)fromView
                             toView:(UIView *)toView
                           duration:(NSTimeInterval)duration
                            options:(ASAnyCurlOptions)options
                         completion:(void(^)())completion;

- (void)animateTransitionDownWithController:(UIViewController *)controller
                                   duration:(NSTimeInterval)duration
                                    options:(ASAnyCurlOptions)options
                                 completion:(void(^)())completion;
- (void)animateTransitionUpWithController:(UIViewController *)controller
                                 duration:(NSTimeInterval)duration
                                  options:(ASAnyCurlOptions)options
                               completion:(void(^)())completion;

@end
