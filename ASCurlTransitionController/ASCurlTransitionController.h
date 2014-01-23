//
//  ASCurlTransitionController.h
//
//  Created by Philippe Converset on 23/01/14.
//  Copyright (c) 2012 AutreSphere. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ASCurlTransitionOptions) {
    ASCurlTransitionOptionHorizontal   = 2 <<  0,
    ASCurlTransitionOptionVertical     = 1 <<  0,
    
    ASCurlTransitionOptionTopLeft      = 2 <<  4,
    ASCurlTransitionOptionTopRight     = 3 <<  4,
    ASCurlTransitionOptionBottomLeft   = 4 <<  4,
    ASCurlTransitionOptionBottomRight  = 5 <<  4,
};

@interface ASCurlTransitionController : UIViewController

@property (nonatomic, strong) UIViewController *contentController;

- (void)animateTransitionDownWithController:(UIViewController *)controller
                                   duration:(NSTimeInterval)duration
                                    options:(ASCurlTransitionOptions)options
                                 completion:(void(^)())completion;
- (void)animateTransitionUpWithController:(UIViewController *)controller
                                 duration:(NSTimeInterval)duration
                                  options:(ASCurlTransitionOptions)options
                               completion:(void(^)())completion;

@end
