//
//  BonsaiNotificationUtility.swift
//  BonsaiController_Example
//
//  Created by Warif Akhand Rishi on 18/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import BonsaiController

class BonsaiNotificationUtility: NSObject {
    
    static let shared = BonsaiNotificationUtility()
    let notificationHeight: CGFloat = 120
    let notificationDelay: TimeInterval = 2
    
    func show(viewController: UIViewController) {
        
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        
        topViewController()?.present(viewController, animated: true, completion: nil)
    }
}

extension BonsaiNotificationUtility {
    
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
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

extension BonsaiNotificationUtility: BonsaiControllerDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let bonsaiController = BonsaiController(fromDirection: .right, blurEffectStyle: .light, presentedViewController: presented, delegate: self)
        bonsaiController.perform(#selector(bonsaiController.dismiss), with: nil, afterDelay: notificationDelay)
        return bonsaiController
    }
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: .zero, size: CGSize(width: containerViewFrame.width, height: notificationHeight))
    }
}
