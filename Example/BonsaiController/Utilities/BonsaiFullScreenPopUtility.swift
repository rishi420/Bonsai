//
//  BonsaiFullScreenPopUtility.swift
//  PencilTest
//
//  Created by Warif Akhand Rishi on 11/4/19.
//  Copyright © 2019 Warif Akhand Rishi. All rights reserved.
//

import Foundation
import BonsaiController

class BonsaiFullScreenPopUtility: NSObject {
    
    static let shared = BonsaiFullScreenPopUtility()
    var sourceView: UIView?
    
    func show(viewController: UIViewController, fromView: UIView) {
        
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        sourceView = fromView
        
        topViewController()?.present(viewController, animated: true, completion: nil)
    }
}

private extension BonsaiFullScreenPopUtility {
    
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

extension BonsaiFullScreenPopUtility: BonsaiControllerDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let bonsaiController = BonsaiController(fromView: sourceView!, blurEffectStyle: .light, presentedViewController: presented, delegate: self)
        bonsaiController.presentedView?.layer.cornerRadius = 0
        bonsaiController.presentedView?.layer.masksToBounds = false
        return bonsaiController
    }
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        return containerViewFrame
    }
    
    func didDismiss() {
        //NotificationCenter.default.post(name: .refreshScreen, object: nil)
    }
}
