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
    
    ASCurlTransitionOptionTop      = 2 <<  4,
    ASCurlTransitionOptionBottom   = 1 <<  4,
    
    ASCurlTransitionOptionLeft     = 2 <<  8,
    ASCurlTransitionOptionRight    = 1 <<  8,
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
