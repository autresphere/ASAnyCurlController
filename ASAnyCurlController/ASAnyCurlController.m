//
//  ASAnyCurlController.m
//
//  Created by Philippe Converset on 23/01/14.
//  Copyright (c) 2012 AutreSphere. All rights reserved.
//

#import "ASAnyCurlController.h"

static NSString const *kTransformViewKey = @"transformView";
static NSString const *kContentViewKey = @"contentView";
static NSString const *kMainViewKey = @"mainView";

#define hasOptions(options, x) ((options & (x)) == (x))

@implementation ASAnyCurlController

+ (NSDictionary *)configureCurlOnView:(UIView *)view options:(ASAnyCurlOptions)options
{
    UIView *mainView;
    
    mainView = [[UIView alloc] initWithFrame:view.frame];    
    [view.superview insertSubview:mainView aboveSubview:view];
    
    return [self configureCurlOnMainView:mainView options:options];
}

+ (NSDictionary *)configureCurlOnMainView:(UIView *)mainView options:(ASAnyCurlOptions)options
{
    CGAffineTransform transform;
    CGFloat angle = 0;
    CGFloat scaleY = 1;
    CGFloat scaleX = 1;
    UIView *contentView;
    UIView *transformView;
    
    transformView = [[UIView alloc] initWithFrame:mainView.bounds];
    [mainView addSubview:transformView];
    
    contentView = [[UIView alloc] initWithFrame:mainView.bounds];
    [transformView addSubview:contentView];
    
    if(hasOptions(options, ASAnyCurlOptionHorizontal | ASAnyCurlOptionTopRight))
    {
        angle = -M_PI_2;
        scaleY = 1;
    }
    else if(hasOptions(options, ASAnyCurlOptionVertical | ASAnyCurlOptionTopRight))
    {
        angle = 0;
        scaleY = -1;
    }
    else if(hasOptions(options, ASAnyCurlOptionVertical | ASAnyCurlOptionBottomRight))
    {
        angle = 0;
        scaleY = 1;
    }
    else if(hasOptions(options, ASAnyCurlOptionHorizontal | ASAnyCurlOptionBottomRight))
    {
        angle = M_PI_2;
        scaleY = -1;
    }
    else if(hasOptions(options, ASAnyCurlOptionHorizontal | ASAnyCurlOptionTopLeft))
    {
        angle = -M_PI_2;
        scaleY = -1;
    }
    else if(hasOptions(options, ASAnyCurlOptionHorizontal | ASAnyCurlOptionBottomLeft))
    {
        angle = M_PI_2;
        scaleY = 1;
    }
    else if(hasOptions(options, ASAnyCurlOptionVertical | ASAnyCurlOptionTopLeft))
    {
        angle = 0;
        scaleY = -1;
        scaleX = -1;
    }
    else if(hasOptions(options, ASAnyCurlOptionVertical | ASAnyCurlOptionBottomLeft))
    {
        angle = 0;
        scaleY = 1;
        scaleX = -1;
    }
    
    transform = CGAffineTransformIdentity;
    transform = CGAffineTransformRotate(transform, angle);
    transform = CGAffineTransformScale(transform, scaleX, scaleY);
    transformView.transform = transform;

    transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, scaleX, scaleY);
    transform = CGAffineTransformRotate(transform, -angle);
    contentView.transform = transform;
    
    return @{kMainViewKey: mainView, kTransformViewKey: transformView, kContentViewKey: contentView};
}

- (void)animateTransitionWithController:(UIViewController *)controller
                          configuration:(NSDictionary *)configuration
                                options:(UIViewAnimationOptions)options
                               duration:(NSTimeInterval)duration
                             completion:(void(^)())completion
{
    UIViewController *previousContentController;
    UIView *fromView;
    UIView *toView;
    
    previousContentController = self.contentController;
    fromView = previousContentController.view;
    toView = controller.view;
    
    [self addChildViewController:controller];
    _contentController = controller;

    [ASAnyCurlController doAnimateTransitionFromView:fromView
                                                     toView:toView
                                              configuration:configuration
                                                    options:options
                                                   duration:duration
                                                 completion:^() {
                                                     UIView *transformView;
                                                     UIView *mainView;

                                                     transformView = configuration[kTransformViewKey];
                                                     mainView = configuration[kMainViewKey];
                                                     
                                                     [previousContentController removeFromParentViewController];
                                                     [mainView addSubview:toView];
                                                     [transformView removeFromSuperview];
                                                     if(completion)
                                                     {
                                                         completion();
                                                     }
                                                 }];
}

+ (void)animateTransitionFromView:(UIView *)fromView
                           toView:(UIView *)toView
                    configuration:(NSDictionary *)configuration
                          options:(UIViewAnimationOptions)options
                         duration:(NSTimeInterval)duration
                       completion:(void(^)())completion
{
    CGRect finalFrame;
    
    finalFrame = fromView.frame;
    fromView.frame = fromView.bounds;
    
    [self doAnimateTransitionFromView:fromView
                               toView:toView
                        configuration:configuration
                              options:options
                             duration:duration
                           completion:^() {
                               UIView *mainView;

                               mainView = configuration[kMainViewKey];
                               [mainView.superview insertSubview:toView aboveSubview:mainView];
                               toView.frame = finalFrame;
                               [mainView removeFromSuperview];
                               if(completion)
                               {
                                   completion();
                               }
                           }];
}

+ (void)doAnimateTransitionFromView:(UIView *)fromView
                             toView:(UIView *)toView
                      configuration:(NSDictionary *)configuration
                            options:(UIViewAnimationOptions)options
                           duration:(NSTimeInterval)duration
                         completion:(void(^)())completion
{
    UIView *contentView;
    
    toView.frame = fromView.bounds;
    
    contentView = configuration[kContentViewKey];
    
    // Put the previous view inside the view hierarchy that creates the curl effect.
    [contentView addSubview:fromView];
    
    // A small delay is needed to get the actual animation.
    // With no delay, the previous view would simply be removed before any animation occurs.
    // This is due to the fact this view is moved just before being removed.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        [UIView transitionWithView:contentView
                          duration:duration
                           options:options
                        animations:^{
                            [contentView addSubview:toView];
                            [fromView removeFromSuperview];
                        }
                        completion:^(BOOL finished) {
                            if(completion)
                            {
                                completion();
                            }
                        }];
    });
}

#pragma mark - Public
- (void)setContentController:(UIViewController *)controller
{
    [self addChildViewController:controller];
    controller.view.frame = self.view.bounds;
    [self.view addSubview:controller.view];
    _contentController = controller;
}

+ (void)animateTransitionDownFromView:(UIView *)fromView
                               toView:(UIView *)toView
                             duration:(NSTimeInterval)duration
                              options:(ASAnyCurlOptions)options
                           completion:(void(^)())completion
{
    NSDictionary *configuration;
    
    configuration = [self configureCurlOnView:fromView options:options];
    [self animateTransitionFromView:fromView toView:toView configuration:configuration options:UIViewAnimationOptionTransitionCurlDown duration:duration completion:completion];
}

+ (void)animateTransitionUpFromView:(UIView *)fromView
                             toView:(UIView *)toView
                           duration:(NSTimeInterval)duration
                            options:(ASAnyCurlOptions)options
                         completion:(void(^)())completion
{
    NSDictionary *configuration;
    
    configuration = [self configureCurlOnView:fromView options:options];
    [self animateTransitionFromView:fromView toView:toView configuration:configuration options:UIViewAnimationOptionTransitionCurlUp duration:duration completion:completion];
}


- (void)animateTransitionDownWithController:(UIViewController *)controller
                                   duration:(NSTimeInterval)duration
                                    options:(ASAnyCurlOptions)options
                                 completion:(void(^)())completion
{
    NSDictionary *configuration;
    
    configuration = [ASAnyCurlController configureCurlOnMainView:self.view options:options];
    [self animateTransitionWithController:controller configuration:configuration options:UIViewAnimationOptionTransitionCurlDown duration:duration completion:completion];
}

- (void)animateTransitionUpWithController:(UIViewController *)controller
                                 duration:(NSTimeInterval)duration
                                  options:(ASAnyCurlOptions)options
                               completion:(void(^)())completion
{
    NSDictionary *configuration;
    
    configuration = [ASAnyCurlController configureCurlOnMainView:self.view options:options];
    [self animateTransitionWithController:controller configuration:configuration options:UIViewAnimationOptionTransitionCurlUp duration:duration completion:completion];
}

@end
