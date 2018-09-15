//
//  BonsaiPopupUtility.swift
//  BonsaiController_Example
//
//  Created by Warif Akhand Rishi on 1/6/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import BonsaiController

class BonsaiPopupUtility: NSObject {
    
    static let shared = BonsaiPopupUtility()
    
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

extension BonsaiPopupUtility: BonsaiControllerDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let frame = frameOfPresentedView(in: source.view.frame)
        let originFrame = frame.insetBy(dx: -20, dy: -20)
        let bonsaiController = BonsaiController(fromOrigin: originFrame, presentedViewController: presented, delegate: self)
        bonsaiController.springWithDamping = 0.5
        bonsaiController.duration = 0.5
        bonsaiController.isDisabledTapOutside = true
        bonsaiController.isDisabledDismissAnimation = true
        
        return bonsaiController
    }

    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        let popupSize = CGSize(width: 280, height: 150)
        
        return CGRect(origin: CGPoint(x: (containerViewFrame.width - popupSize.width) / 2, y: (containerViewFrame.height - popupSize.height) / 2), size: popupSize)
    }
}
