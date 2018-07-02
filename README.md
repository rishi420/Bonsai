# CustomSizeController

[![CI Status](https://img.shields.io/travis/rishi420/CustomSizeController.svg?style=flat)](https://travis-ci.org/rishi420/CustomSizeController)
[![Version](https://img.shields.io/cocoapods/v/CustomSizeController.svg?style=flat)](https://cocoapods.org/pods/CustomSizeController)
[![License](https://img.shields.io/cocoapods/l/CustomSizeController.svg?style=flat)](https://cocoapods.org/pods/CustomSizeController)
[![Platform](https://img.shields.io/cocoapods/p/CustomSizeController.svg?style=flat)](https://cocoapods.org/pods/CustomSizeController)

CustomSizeController is a subclass of UIPresentationController allowing custom size for any UIViewController.

## Usage

```Swift
import CustomSizeController
```

Add `CustomSizeControllerDelegate` extension to your view controller

```Swift
extension YourViewController: CustomSizeControllerDelegate {
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    
        // Slide animation from .left, .right, .up, .down
        let customSizeC = CustomSizeController(fromDirection: .down, presentedViewController: presented)
        
        // or pop animation initiate from a CGRect
        //let customSizeC = CustomSizeController(fromOrigin: initialFrame, presentedViewController: presented)
        
        customSizeC.sizeDelegate = self
        return customSizeC
    }
}
```
return a frame for the small view controller from `frameOfPresentedView(in:)` function. 

## How to Present the view controller 

```Swift
var customSizeC: CustomSizeController?
```

### From Code:

```Swift
let vc = storyboard?.instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
        
vc.modalPresentationStyle = .custom
vc.transitioningDelegate = customSizeC

present(vc, animated: true, completion: nil)
```

### From Storyboard:

```Swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if let smallVC = segue.destination as? SmallViewController {
            
        smallVC.modalPresentationStyle = .custom
        smallVC.transitioningDelegate = self
    }
}
```

## Customization


### Disable dismiss on tap outside

Initiate `CustomSizeController` with outside tap disabled

```Swift
customSizeC = CustomSizeController(presentedViewController: vc, isDisabledTapOutside: true)
```

###  Auto dismiss after delay

```Swift
customSizeC?.perform(#selector(customSizeC?.dismiss), with: nil, afterDelay: 5)
```

### Custom animation

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

CustomSizeController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CustomSizeController'
```

## Author

Warif Akhand Rishi, rishi420@gmail.com

## License

CustomSizeController is available under the MIT license. See the LICENSE file for more info.

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

