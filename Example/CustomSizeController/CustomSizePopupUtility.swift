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
    
    func show() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SmallVC") as! SmallViewController
        vc.view.backgroundColor = .brown
        
        let customSizeC = CustomSizeController(presentedViewController: vc, fromDirection: .up)
        customSizeC.dismissDirection = .down
        customSizeC.springWithDamping = 0.7
        customSizeC.duration = 0.3
        customSizeC.sizeDelegate = self
        
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
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
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        let popupSize = CGSize(width: 300, height: 160)
        
        return CGRect(origin: CGPoint(x: (containerViewFrame.width - popupSize.width) / 2, y: (containerViewFrame.height - popupSize.height) / 2), size: popupSize)
    }
}
