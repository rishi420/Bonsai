# Bonsai

[![Version](https://img.shields.io/cocoapods/v/BonsaiController.svg?style=flat)](https://cocoapods.org/pods/BonsaiController)
[![License](https://img.shields.io/cocoapods/l/BonsaiController.svg?style=flat)](https://cocoapods.org/pods/BonsaiController)
[![Platform](https://img.shields.io/cocoapods/p/BonsaiController.svg?style=flat)](https://cocoapods.org/pods/BonsaiController)

**🌲 Bonsai** makes custom frame size with cool transition animation to any view controller.

## Usage

```Swift
import BonsaiController
```

Add `BonsaiControllerDelegate` extension to your view controller

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

## How to Present the view controller 


### From Code:

```Swift
let smallVC = yourViewController()

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

## Customization


### Disable dismiss on tap outside

```Swift
bonsaiController.springWithDamping = 0.5
bonsaiController.duration = 0.5
bonsaiController.isDisabledTapOutside = true
bonsaiController.isDisabledDismissAnimation = true
public var dismissDirection: Direction? // Availabel only for slide in transition animation
public var isDisabledTapOutside: Bool = false
```

###  Auto dismiss after delay

```Swift
let bonsaiController = BonsaiController(...
bonsaiController.perform(#selector(bonsaiController.dismiss), with: nil, afterDelay: 2)
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

## Installation with CocoaPods

BonsaiController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BonsaiController'
```

Manually

Drag the Sources folder anywhere in your project.


## Author

Warif Akhand Rishi, rishi420@gmail.com

## License

BonsaiController is available under the MIT license. See the LICENSE file for more info.

## Credits

Jelly 
https://github.com/SebastianBoldt/Jelly

PresentHalfModal 
https://github.com/khuong291/PresentHalfModal

SideMenu
https://github.com/jonkykong/SideMenu

TransitionTreasury
https://github.com/DianQK/TransitionTreasury

Transition
https://github.com/Touchwonders/Transition

StarWars.iOS
https://github.com/Yalantis/StarWars.iOS

Hero
https://github.com/HeroTransitions/Hero

Your input is welcome!

If you have any suggestions, please get in touch with us. Feel free to fork and submit pull requests. Also, we're Dutch, so if any naming is odd, might be improved or is just plain inappropriate, let us know!

Backlog

Add functioning UIPresentationController support (it's there, but it doesn't animate properly...)
Write more tests


Communication

If you need help or found a bug, open an issue.
If you have a new transition animation or want to contribute, submit a pull request. :]

Thank You
A special thank you to everyone that has contributed to this library to make it better. Your support is appreciated!


If you like SideMenu, give it a ★ at the top right of this page.

Using SideMenu in your app? Send me a link to your app in the app store!

Let us know!

We’d be really happy if you sent us links to your projects where you use our component. Just send an email to github@yalantis.com And do let us know if you have any questions or suggestion regarding the animation.

P.S. We’re going to publish more awesomeness wrapped in code and a tutorial on how to make UI for iOS (Android) better than better. Stay tuned!


