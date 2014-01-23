//
//  ASCurlTransitionController.m
//
//  Created by Philippe Converset on 23/01/14.
//  Copyright (c) 2012 AutreSphere. All rights reserved.
//

#import "ASCurlTransitionController.h"

#define hasOptions(options, x) ((options & (x)) == (x))

@interface ASCurlTransitionController ()

@property (retain, nonatomic) UIView *contentView;
@property (retain, nonatomic) UIView *transformedView;

@end

@implementation ASCurlTransitionController

- (void)configureCurlEffect:(ASCurlTransitionOptions)options
{
    CGAffineTransform transform;
    CGFloat angle = 0;
    CGFloat scaleY = 1;
    CGFloat scaleX = 1;
    
    self.transformedView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.transformedView];
    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.transformedView addSubview:self.contentView];
    
    if(hasOptions(options, ASCurlTransitionOptionHorizontal | ASCurlTransitionOptionRight | ASCurlTransitionOptionTop))
    {
        angle = -M_PI_2;
        scaleY = 1;
    }
    else if(hasOptions(options, ASCurlTransitionOptionVertical | ASCurlTransitionOptionRight | ASCurlTransitionOptionTop))
    {
        angle = 0;
        scaleY = -1;
    }
    else if(hasOptions(options, ASCurlTransitionOptionVertical | ASCurlTransitionOptionBottom | ASCurlTransitionOptionRight))
    {
        angle = 0;
        scaleY = 1;
    }
    else if(hasOptions(options, ASCurlTransitionOptionHorizontal | ASCurlTransitionOptionBottom | ASCurlTransitionOptionRight))
    {
        angle = M_PI_2;
        scaleY = -1;
    }
    else if(hasOptions(options, ASCurlTransitionOptionHorizontal | ASCurlTransitionOptionTop | ASCurlTransitionOptionLeft))
    {
        angle = -M_PI_2;
        scaleY = -1;
    }
    else if(hasOptions(options, ASCurlTransitionOptionHorizontal | ASCurlTransitionOptionBottom | ASCurlTransitionOptionLeft))
    {
        angle = M_PI_2;
        scaleY = 1;
    }
    else if(hasOptions(options, ASCurlTransitionOptionVertical | ASCurlTransitionOptionTop | ASCurlTransitionOptionLeft))
    {
        angle = 0;
        scaleY = -1;
        scaleX = -1;
    }
    else if(hasOptions(options, ASCurlTransitionOptionVertical | ASCurlTransitionOptionBottom | ASCurlTransitionOptionLeft))
    {
        angle = 0;
        scaleY = 1;
        scaleX = -1;
    }
    
    transform = CGAffineTransformIdentity;
    transform = CGAffineTransformRotate(transform, angle);
    transform = CGAffineTransformScale(transform, scaleX, scaleY);
    self.transformedView.transform = transform;

    transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, scaleX, scaleY);
    transform = CGAffineTransformRotate(transform, -angle);
    self.contentView.transform = transform;
}

- (void)setContentController:(UIViewController *)controller
{
    [self addChildViewController:controller];
    controller.view.frame = self.view.bounds;
    [self.view addSubview:controller.view];
    _contentController = controller;
}

- (void)animateTransitionWithController:(UIViewController *)controller
                                options:(UIViewAnimationOptions)options
                               duration:(NSTimeInterval)duration
                             completion:(void(^)())completion
{
    UIViewController *previousContentController;
    
    previousContentController = self.contentController;
    
    // Put the previous content view inside the inner view hierarchy that brings the actual effect.
    [self.contentView addSubview:previousContentController.view];
    
    [self addChildViewController:controller];
    controller.view.frame = self.view.bounds;
    _contentController = controller;
    
    // A small delay is needed to get the actual animation.
    // With no delay, the previous content view would be simply removed before any animation occurs. This is due to the fact this view is moved just before being removed.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        [UIView transitionWithView:self.contentView
                          duration:duration
                           options:options
                        animations:^{
                            [self.contentView addSubview:self.contentController.view];
                            [previousContentController.view removeFromSuperview];
                        }
                        completion:^(BOOL finished) {
                            [previousContentController removeFromParentViewController];
                            [self.view addSubview:self.contentController.view];
                            [self.transformedView removeFromSuperview];
                            [self.contentView removeFromSuperview];
                            self.transformedView = nil;
                            self.contentView = nil;
                            if(completion)
                            {
                                completion();
                            }
                        }];
    });
}


- (void)animateTransitionDownWithController:(UIViewController *)controller
                                   duration:(NSTimeInterval)duration
                                    options:(ASCurlTransitionOptions)options
                                 completion:(void(^)())completion
{
    [self configureCurlEffect:options];
    [self animateTransitionWithController:controller options:UIViewAnimationOptionTransitionCurlDown duration:duration completion:completion];
}

- (void)animateTransitionUpWithController:(UIViewController *)controller
                                 duration:(NSTimeInterval)duration
                                  options:(ASCurlTransitionOptions)options
                               completion:(void(^)())completion
{
    [self configureCurlEffect:options];
    [self animateTransitionWithController:controller options:UIViewAnimationOptionTransitionCurlUp duration:duration completion:completion];
}

@end
