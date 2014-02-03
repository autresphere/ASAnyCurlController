## Purpose
ASAnyCurlController gives you the ability to use Curl animation from any corner and in any direction.

iOS SDK allows only 2 types of curl animations, UIViewAnimationOptionTransitionCurlUp and UIViewAnimationOptionTransitionCurlDown. It gives no choice, a curl up transition curls a view up from the bottom, while a curl down transition curls a view down from the top.

With ASAnyCurlController you are free to choose whether your up or down curl transition comes from the **top**, **bottom**, **left** and **right** and whether it is **horizontal** or **vertical**.


![](https://github.com/autresphere/ASAnyCurlController/raw/master/Screenshots/iPhoneVideo.gif)

This transition is used on some App Store apps like [Peter & the wolf](https://itunes.apple.com/fr/app/pierre-et-le-loup/id780386365?mt=8) ![](https://github.com/autresphere/ASAnyCurlController/raw/master/Screenshots/peterCurl.jpg)


## Supported iOS
iOS 5 and above.

## ARC Compatibility
ASAnyCurlController requires ARC. If you wish to use ASAnyCurlController in a non-ARC project, just add the -fobjc-arc compiler flag to the "ASAnyCurlController.m" file.

## Use it
Add `pod 'ASAnyCurlController'` to your Podfile or copy 'ASAnyCurlController.h' and 'ASAnyCurlController.m' in your project.

**ASAnyCurlController can be used as a UIViewController**. It animates the transition between to view controllers, its current content controller and a new one.

You first set its initial content controller using its property `contentController`. Then you call `[ASAnyCurlController animateTransitionDownWithController:duration:options:completion]` or `[ASAnyCurlController animateTransitionUpWithController:duration:options:completion]` whether you want the new view to be revealed as if it were coming from above or below the current view.

`options` parameter lets you specify the corner (`ASAnyCurlOptionTopLeft`, `ASAnyCurlOptionTopRight`, `ASAnyCurlOptionBottomLeft`, `ASCurlTransitionBottomRight`) and direction (`ASAnyCurlOptionHorizontal` or `ASAnyCurlOptionVertical`).

In a Curl Down transition, the specified corner is where the animation starts, while in a Curl Up transition it is where the animation ends. 

**ASAnyCurlController can also be used directly on your view** through its two class methods `[ASAnyCurlController animateTransitionDownFromView: toView: duration: options: completion:]` and `[ASAnyCurlController animateTransitionUpFromView: toView: duration: options: completion:]`.

## Technical explanation
The system uses a standard curl animation (launched by [UIView transitionWithView]) on which a specific transform is applied. This transform is composed of some PI/2 rotation and some horizontal and/or vertical mirroring (-1 scaling in fact) depending on the wanted corner and direction. This transform is set on a specific view which is created only for this purpose, which we call the 'transformedView'. But this is not enough, as the final animated view would otherwise be also transformed. The trick is to cancel this transform by applying its opposite transform. And as we don't want to alter the initial view (because it may have its own transform), we use a specific view, called 'contentView'.

So, in order to achieve the effect, ASAnyCurlController uses this stack of views: the standard controller's view, the 'transformedView', the 'contentView', and finally the view that is going to be visually animated (your view).
The 'transformView' bears a transform that configures the corner and direction of the curl, while the 'contentView' bears a transform that cancel the above transform. Finally the transition is launched on the 'contentView', et voilà!

In other words, here is the view hierarchy :

	ASAnyCurlController's View
		--> transformedView   <-- specific transform
			--> contentView   <-- opposite transform
				--> final view

