# Bonsai

[![Version](https://img.shields.io/cocoapods/v/BonsaiController.svg?style=flat)](https://cocoapods.org/pods/BonsaiController)
[![License](https://img.shields.io/cocoapods/l/BonsaiController.svg?style=flat)](https://cocoapods.org/pods/BonsaiController)
[![Platform](https://img.shields.io/cocoapods/p/BonsaiController.svg?style=flat)](https://cocoapods.org/pods/BonsaiController)

**🌲 Bonsai** makes any view controller to present in a user defined frame with custom transition animation.

![Bonsai](https://user-images.githubusercontent.com/2233857/46226655-cbf61d80-c37e-11e8-9d2b-3d69177988a1.png)

**Bonsai** does not change the source code of the view controller. So it can be used on view controllers on which source code is not open. For eample, UIImagePickerController, AVPlayerViewController, MFMailComposeViewController, MFMessageComposeViewController etc.


## Features

* [x] Makes view controller appear as
    - [x] Popup alert (no dismiss on tap outside)
    - [x] Notification alert (auto dismiss after delay)
    - [x] Side menu (drawer) 
* [x] Transition animation 
    - [x] Slide In from left, right, top and bottom
    - [x] Bubble pop from an initial frame or a view
* [x] Blur effect on background 
    - [x] light, dark, regular, prominent 
* [x] Supports Storyboard and Code 
* [x] Supports landscape and portrait orientation 
* [x] Created with Swift compatible with Objective-C
* [x] Preserves Safe Area and Auto Layout constraints 


## Installation with CocoaPods

BonsaiController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
use_frameworks!
pod 'BonsaiController'
```

## Install Manually

Drag the `~/BonsaiController` directory anywhere in your project.


## How to use

```Swift
import BonsaiController
```

Add (copy paste) `BonsaiControllerDelegate` extension to your view controller

```Swift
extension YourViewController: BonsaiControllerDelegate {
    
    // return the frame of your Bonsai View Controller
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
    
    // return a Bonsai Controller with SlideIn or Bubble transition animator
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    
        // Slide animation from .left, .right, .top, .bottom
        return BonsaiController(fromDirection: .bottom, blurEffectStyle: .light, presentedViewController: presented, delegate: self)
        
        
        
        // or Bubble animation initiated from a view
        //return BonsaiController(fromView: yourOriginView, blurEffectStyle: .dark,  presentedViewController: presented, delegate: self)
    }
}
```

## How to present the view controller 

### From Code:

```Swift
let smallVC = YourViewController() // instantiateViewController(withIdentifier:)
smallVC.transitioningDelegate = self
smallVC.modalPresentationStyle = .custom
present(smallVC, animated: true, completion: nil)
```

### From Storyboard:

```Swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if segue.destination is YourViewController {
        segue.destination.transitioningDelegate = self
        segue.destination.modalPresentationStyle = .custom
    }
}
```


## Customize

###  Auto dismiss after delay

```Swift
let bonsaiController = BonsaiController(...
bonsaiController.perform(#selector(bonsaiController.dismiss), with: nil, afterDelay: 2)
```

### Customizable properties (Default values)

```Swift
bonsaiController.springWithDamping = 0.8
bonsaiController.duration = 0.4
bonsaiController.isDisabledTapOutside = false
bonsaiController.isDisabledDismissAnimation = false
bonsaiController.dismissDirection = nil // Reverse direction. Availabel only for slide in transition.
```

### Custom transition animation

If you want to create your own transition animation, implement this protocol in your viewController 

```Swift
extension YourViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // Your presentation animation hear
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // Your dismiss animation here
    }
}
```

## Usage In Objective-C

```objc
#import "YourModuleName-Swift.h"  // only if project created in swift

@import BonsaiController;
```

Add (copy paste) `BonsaiControllerDelegate` extension to your view controller

```objc
// MARK:- Bonsai Controller Delegate
- (CGRect)frameOfPresentedViewIn:(CGRect)containerViewFrame {

    return CGRectMake(0, containerViewFrame.size.height / 4, containerViewFrame.size.width, containerViewFrame.size.height / (4.0 / 3.0));
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {

    // Slide animation from .left, .right, .top, .bottom
    //return [[BonsaiController alloc] initFromDirection:DirectionBottom blurEffectStyle:UIBlurEffectStyleLight presentedViewController:presented delegate:self];

    // or Bubble animation initiated from a view
    return [[BonsaiController alloc] initFromView:self.exampleButton blurEffectStyle:UIBlurEffectStyleDark presentedViewController:presented delegate:self];
}
```

### How to present the view controller(obj-c) 

### From Code:

```objc
SmallViewController *smallVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SmallVC"];
smallVC.transitioningDelegate = self;
smallVC.modalPresentationStyle = UIModalPresentationCustom;
[self presentViewController:smallVC animated:true completion:nil];
```

### From Storyboard:

```objc
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController isKindOfClass:SmallViewController.class]) {
        segue.destinationViewController.transitioningDelegate = self;
        segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
}
```


## Example

An example project is included with this repo. To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Minimum Requirements

* Xcode 9
* iOS 9.3


## Backlog

* Utility folder Notification utility


##   Your input is welcome!

If you have any suggestions, please get in touch with us.<br>
If you need help or found a bug, please open an issue.<br>
If you have a new transition animation or want to contribute, please submit a pull request.


## Let us know!

If you like BonsaiController, give it a ★ at the top right of this page. <br>
Using BonsaiController in your app? Send us a link to your app in the app store!


## Credits

- Jelly - https://github.com/SebastianBoldt/Jelly
- PresentHalfModal - https://github.com/khuong291/PresentHalfModal
- SideMenu - https://github.com/jonkykong/SideMenu
- TransitionTreasury - https://github.com/DianQK/TransitionTreasury
- Transition - https://github.com/Touchwonders/Transition
- StarWars.iOS - https://github.com/Yalantis/StarWars.iOS
- Hero - https://github.com/HeroTransitions/Hero


## Thank You

A special thank you to everyone that has contributed to this library to make it better. Your support is appreciated!


## Author

Developer: Warif Akhand Rishi, rishi420@gmail.com <br>
Designer: Takmila Tasmim Mim, mim.tasmim93@gmail.com 


## License

BonsaiController is available under the MIT license. See the LICENSE file for more info.
