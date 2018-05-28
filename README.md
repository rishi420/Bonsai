# CustomSizeController

[![CI Status](https://img.shields.io/travis/rishi420/CustomSizeController.svg?style=flat)](https://travis-ci.org/rishi420/CustomSizeController)
[![Version](https://img.shields.io/cocoapods/v/CustomSizeController.svg?style=flat)](https://cocoapods.org/pods/CustomSizeController)
[![License](https://img.shields.io/cocoapods/l/CustomSizeController.svg?style=flat)](https://cocoapods.org/pods/CustomSizeController)
[![Platform](https://img.shields.io/cocoapods/p/CustomSizeController.svg?style=flat)](https://cocoapods.org/pods/CustomSizeController)

## Overview

CustomSizeController is a subclass of UIPresentationController allowing custom size for any UIViewController.

## Usage

```Swift
import CustomSizeController
```

Add these two extensions to your view controller

```Swift
extension ViewController: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {

        let customSizePC = CustomSizeController(presentedViewController: presented, presenting: presenting)
        customSizePC.sizeDelegate = self
        //customSizePC.isDisabledTapOutside = true

        return customSizePC
    }
}

extension ViewController: CustomSizeControllerDelegate {

    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {

        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 4), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
}
```
return a frame for the small view controller from `frameOfPresentedView(in:)` function. 

## How to Present the view controller 

### From Code:

```Swift
let vc = storyboard?.instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
vc.modalPresentationStyle = .custom
vc.transitioningDelegate = self
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

### Disable dismiss on tap outside

customSizePC.isDisabledTapOutside = true

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
