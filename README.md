# Bonsai

[![Version](https://img.shields.io/cocoapods/v/BonsaiController.svg?style=flat)](https://cocoapods.org/pods/BonsaiController)
[![License](https://img.shields.io/cocoapods/l/BonsaiController.svg?style=flat)](https://cocoapods.org/pods/BonsaiController)
[![Platform](https://img.shields.io/cocoapods/p/BonsaiController.svg?style=flat)](https://cocoapods.org/pods/BonsaiController)

**🌲 Bonsai** makes any view controller to present in a user defined frame with custom transition animation.

![Bonsai](https://user-images.githubusercontent.com/2233857/46226655-cbf61d80-c37e-11e8-9d2b-3d69177988a1.png)

**Bonsai** does not change the source code of the view controller. So it can be used on view controllers on which source code is not open. For eample, UIImagePickerController, AVPlayerViewController, MFMailComposeViewController, MFMessageComposeViewController etc.

## Features

* [x] Makes view controller appear as
    - [x] Popup alert
    - [x] Notification alert 
    - [x] Side menu
* [x] Transition animation 
    - [x] Slide In from left, right, top and bottom
    - [x] Bubble pop from an initial frame or a view
* [x] Supports both Storyboard and Code 
* [x] Blur effect on background view
* [x] Supports both landscape and portrait 


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
        return BonsaiController(fromDirection: .bottom, presentedViewController: presented, delegate: self)
        
        // or Bubble animation initiated from a view
        //return BonsaiController(fromView: yourOriginView, presentedViewController: presented, delegate: self)
        
        // or Bubble animation initiated from a frame
        //return BonsaiController(fromOrigin: yourOriginFrame, presentedViewController: presented, delegate: self)
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

## Installation with CocoaPods

BonsaiController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BonsaiController'
```

## Install Manually

Drag the `BonsaiController/Classes` folder anywhere in your project.


## Customize

###  Auto dismiss after delay

```Swift
let bonsaiController = BonsaiController(...
bonsaiController.perform(#selector(bonsaiController.dismiss), with: nil, afterDelay: 2)
```

### Customizable properties

```Swift
bonsaiController.springWithDamping = 0.8
bonsaiController.duration = 0.4
bonsaiController.isDisabledTapOutside = false
bonsaiController.isDisabledDismissAnimation = false
public var dismissDirection: Direction? // Availabel only for slide in transition animation
```

### Custom transition animation

Implement these two method for custom transition animation 

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


## Example

An example project is included with this repo. To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Minimum Requirements

* Xcode 9
* iOS 9.3


## Backlog

* Objective-C compatibility check
* Utility folder Notification utility
* Blur effect customization


##   Your input is welcome!

If you have any suggestions, please get in touch with us.  
If you need help or found a bug, please open an issue.
If you have a new transition animation or want to contribute, please submit a pull request.


## Let us know!

If you like BonsaiController, give it a ★ at the top right of this page.
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

Developer: Warif Akhand Rishi, rishi420@gmail.com
Designer: Takmila Tasmim Mim, mim.tasmim93@gmail.com 


## License

BonsaiController is available under the MIT license. See the LICENSE file for more info.
