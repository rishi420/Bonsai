//
//  CustomSizeController.swift
//  CustomSizeController
//
//  Created by Warif Akhand Rishi on 22/5/18.
//  Copyright © 2018 Warif Akhand Rishi. All rights reserved.
//

import UIKit

public protocol CustomSizeControllerDelegate: NSObjectProtocol {
    
    /// Returns a frame for presented viewController on containerView
    ///
    /// - Parameter: containerViewFrame
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect
}

public extension CustomSizeControllerDelegate {
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height/2), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height/2))
    }
}

public class CustomSizeController: UIPresentationController, CustomSizeControllerDelegate {
    
    public var isDisabledTapOutside = false
    weak public var sizeDelegate: CustomSizeControllerDelegate?
    
    private let blurEffectView: UIVisualEffectView!
    
    @objc func dismiss() {
        
        guard !isDisabledTapOutside else {
            return
        }
        
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    override public init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = true
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override public var frameOfPresentedViewInContainerView: CGRect {
        
        return (sizeDelegate ?? self).frameOfPresentedView(in: containerView!.frame)
    }
    
    override public func dismissalTransitionWillBegin() {
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (UIViewControllerTransitionCoordinatorContext) in
            self?.blurEffectView.alpha = 0
        }, completion: { [weak self] (UIViewControllerTransitionCoordinatorContext) in
            self?.blurEffectView.removeFromSuperview()
        })
    }
    
    override public func presentationTransitionWillBegin() {
        
        blurEffectView.alpha = 0
        containerView?.addSubview(blurEffectView)
    
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (UIViewControllerTransitionCoordinatorContext) in
            self?.blurEffectView.alpha = 1
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            
        })
    }
    
    override public func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView!.layer.masksToBounds = true
        presentedView!.layer.cornerRadius = 10
    }
    
    override public func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
}
