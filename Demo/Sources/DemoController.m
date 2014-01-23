//
//  ViewController.m
//  CurlTransitionControllerDemo
//
//  Created by Philippe Converset on 23/01/2014.
//  Copyright (c) 2014 AutreSphere. All rights reserved.
//

#import "DemoController.h"
#import "ASCurlTransitionController.h"

static NSInteger pageNumber = 1;

@interface DemoController ()

@end

@implementation DemoController

- (IBAction)transitionAction:(UIButton *)sender
{
    ASCurlTransitionController *transitionController;
    DemoController *controller;
    ASCurlTransitionOptions options = 0;
    
    transitionController = (ASCurlTransitionController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Demo"];
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if(sender.tag == 0)
    {
        options = ASCurlTransitionOptionTopRight | ASCurlTransitionOptionHorizontal;
    }
    else if(sender.tag == 1)
    {
        options = ASCurlTransitionOptionTopRight | ASCurlTransitionOptionVertical;
    }
    else if(sender.tag == 2)
    {
        options = ASCurlTransitionOptionBottomRight | ASCurlTransitionOptionVertical;
    }
    else if(sender.tag == 3)
    {
        options = ASCurlTransitionOptionBottomRight | ASCurlTransitionOptionHorizontal;
    }
    else if(sender.tag == 4)
    {
        options = ASCurlTransitionOptionBottomLeft | ASCurlTransitionOptionHorizontal;
    }
    else if(sender.tag == 5)
    {
        options = ASCurlTransitionOptionBottomLeft | ASCurlTransitionOptionVertical;
    }
    else if(sender.tag == 6)
    {
        options = ASCurlTransitionOptionTopLeft | ASCurlTransitionOptionHorizontal;
    }
    else if(sender.tag == 7)
    {
        options = ASCurlTransitionOptionTopLeft | ASCurlTransitionOptionVertical;
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
