## Purpose
ASCurlTransitionController gives you the ability to use Curl animation from any corner and in any direction.
iOS SDK allows only 2 types of curl animations, UIViewAnimationOptionTransitionCurlUp (a transition that curls a view up from the bottom) and UIViewAnimationOptionTransitionCurlDown (a transition that curls a view down from the top). With ASCurlTransitionController you can choose wheter your curl transition comes from the **top**, **bottom**, **left** and **right** and whether it is **horizontal** or **vertical**.

## Supported iOS
iOS 5 and above.

## ARC Compatibility
ASCurlTransitionController requires ARC. If you wish to use ASCurlTransitionController in a non-ARC project, just add the -fobjc-arc compiler flag to the "ASCurlTransitionController.m" file.

## Use it
Add `pod 'ASCurlTransitionController'` to your Podfile or copy 'ASCurlTransitionController.h' and 'ASCurlTransitionController.m' in your project.

ASCurlTransitionController is a UIViewController that will animate the transition between to view controllers, its current content controller and a new one.

You first set its initial content controller using its property `contentController`. Then you call `[ASCurlTransitionController animateTransitionDownWithController:duration:options:completion]` or `[ASCurlTransitionController animateTransitionUpWithController:duration:options:completion]` whether you want the new view to be revealed as if it were coming from above or below the current view.


## Technical explanation
coming soon