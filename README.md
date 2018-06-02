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
customSizeC = CustomSizeController(presentedViewController: vc)
customSizeC?.sizeDelegate = self
        
vc.modalPresentationStyle = .custom
vc.transitioningDelegate = customSizeC

present(vc, animated: true, completion: nil)
```

### From Storyboard:

```Swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if let smallVC = segue.destination as? SmallViewController {

        customSizeC = CustomSizeController(presentedViewController: smallVC)
        customSizeC?.sizeDelegate = self
            
        smallVC.modalPresentationStyle = .custom
        smallVC.transitioningDelegate = self
    }
}
```

### Disable dismiss on tap outside

Initiate `CustomSizeController` with outside tap disabled

```Swift
customSizeC = CustomSizeController(presentedViewController: vc, isDisabledTapOutside: true)
```

###  Auto dismiss after delay

```Swift
customSizeC?.perform(#selector(customSizeC?.dismiss), with: nil, afterDelay: 5)
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
