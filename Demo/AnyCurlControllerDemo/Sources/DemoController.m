//
//  ViewController.m
//  CurlTransitionControllerDemo
//
//  Created by Philippe Converset on 23/01/2014.
//  Copyright (c) 2014 AutreSphere. All rights reserved.
//

#import "DemoController.h"
#import "ASAnyCurlController.h"

static NSInteger pageNumber = 1;

@interface DemoController ()

@end

@implementation DemoController

- (IBAction)transitionAction:(UIButton *)sender
{
    ASAnyCurlController *transitionController;
    DemoController *controller;
    ASAnyCurlOptions options = 0;
    
    transitionController = (ASAnyCurlController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Demo"];
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if(sender.tag == 0)
    {
        options = ASAnyCurlOptionTopRight | ASAnyCurlOptionHorizontal;
    }
    else if(sender.tag == 1)
    {
        options = ASAnyCurlOptionTopRight | ASAnyCurlOptionVertical;
    }
    else if(sender.tag == 2)
    {
        options = ASAnyCurlOptionBottomRight | ASAnyCurlOptionVertical;
    }
    else if(sender.tag == 3)
    {
        options = ASAnyCurlOptionBottomRight | ASAnyCurlOptionHorizontal;
    }
    else if(sender.tag == 4)
    {
        options = ASAnyCurlOptionBottomLeft | ASAnyCurlOptionHorizontal;
    }
    else if(sender.tag == 5)
    {
        options = ASAnyCurlOptionBottomLeft | ASAnyCurlOptionVertical;
    }
    else if(sender.tag == 6)
    {
        options = ASAnyCurlOptionTopLeft | ASAnyCurlOptionHorizontal;
    }
    else if(sender.tag == 7)
    {
        options = ASAnyCurlOptionTopLeft | ASAnyCurlOptionVertical;
    }
    
    if(self.directionControl.selectedSegmentIndex == 0)
    {
        [transitionController animateTransitionUpWithController:controller duration:1 options:options completion:nil];
    }
    else
    {
        [transitionController animateTransitionDownWithController:controller duration:1 options:options completion:nil];
    }
    controller.directionControl.selectedSegmentIndex = self.directionControl.selectedSegmentIndex;
    pageNumber++;
    controller.pageLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber];
}
@end
