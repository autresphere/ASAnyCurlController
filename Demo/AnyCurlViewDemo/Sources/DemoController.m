//
//  ViewController.m
//  CurlTransitionControllerDemo
//
//  Created by Philippe Converset on 23/01/2014.
//  Copyright (c) 2014 AutreSphere. All rights reserved.
//

#import "DemoController.h"
#import "ASAnyCurlController.h"

@interface DemoController ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, assign) NSInteger pageNumber;

@end

@implementation DemoController

- (void)viewDidLoad
{
    UIView *view;

    [super viewDidLoad];
    
    view = [self viewToCurl];
    view.frame = self.contentView.bounds;
    [self.contentView addSubview:view];
}

- (UIView *)viewToCurl
{
    UIView *view;
    UILabel *label;
    
    self.pageNumber++;
    
    view = [[UIView alloc] initWithFrame:self.contentView.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.backgroundColor = (self.pageNumber%2?[UIColor redColor]:[UIColor greenColor]);
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, view.bounds.size.height/2 - 20, view.bounds.size.width, 40)];
    label.text = [NSString stringWithFormat:@"%d", self.pageNumber];
    label.textAlignment = UITextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:40];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [view addSubview:label];
    
    return view;
}

- (IBAction)transitionAction:(UIButton *)sender
{
    ASAnyCurlOptions options = 0;
    UIView *view;
    
    self.view.userInteractionEnabled = NO;
    
    view = [self viewToCurl];
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
        [ASAnyCurlController animateTransitionUpFromView:self.contentView toView:view duration:1 options:options completion:^{
            self.view.userInteractionEnabled = YES;
        }];
    }
    else
    {
        [ASAnyCurlController animateTransitionDownFromView:self.contentView toView:view duration:1 options:options completion:^{
            self.view.userInteractionEnabled = YES;
        }];
    }
    self.contentView = view;
}
@end
