//
//  CustomSizePopupUtility.swift
//  CustomSizeController_Example
//
//  Created by Warif Akhand Rishi on 1/6/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import CustomSizeController

class CustomSizePopupUtility: NSObject {
    
    static let shared = CustomSizePopupUtility()
    
    func show(viewController: UIViewController) {
        
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        
        UIApplication.topViewController()?.present(viewController, animated: true, completion: nil)
    }
}

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}

extension CustomSizePopupUtility: CustomSizeControllerDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let frame = frameOfPresentedView(in: source.view.frame)
        let originFrame = frame.insetBy(dx: -20, dy: -20)
        // TODO: USE inset by and frame IN INIT
        let customSizeC = CustomSizeController(fromOrigin: originFrame, presentedViewController: presented, delegate: self)
        customSizeC.springWithDamping = 0.5
        customSizeC.duration = 0.5
        customSizeC.isDisabledDismiss = true
        customSizeC.isDisabledDismissAnimation = true
        
        return customSizeC
    }

    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        let popupSize = CGSize(width: 280, height: 150)
        
        return CGRect(origin: CGPoint(x: (containerViewFrame.width - popupSize.width) / 2, y: (containerViewFrame.height - popupSize.height) / 2), size: popupSize)
    }
}
