//
//  CustomSizeController.swift
//  CustomSizeController
//
//  Created by Warif Akhand Rishi on 22/5/18.
//  Copyright © 2018 Warif Akhand Rishi. All rights reserved.
//

import UIKit

public enum Direction {
    case left, right, up, down
}

public protocol CustomSizeControllerDelegate: UIViewControllerTransitioningDelegate {
    
    /// Returns a frame for presented viewController on containerView
    ///
    /// - Parameter: containerViewFrame
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
}

extension CustomSizeController: CustomSizeControllerDelegate {
    
    public func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height/2), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height/2))
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
}

public class CustomSizeController: UIPresentationController {
    
    public var blurEffectView: UIVisualEffectView!
    private var fromDirection: Direction!
    public var dismissDirection: Direction?
    public var duration: TimeInterval = 0.3
    public var springWithDamping: CGFloat = 0.8
    weak public var sizeDelegate: CustomSizeControllerDelegate?
    
    @objc public func dismiss() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    convenience public init(presentedViewController: UIViewController, fromDirection: Direction, isDisabledTapOutside: Bool = false) {
        self.init(presentedViewController: presentedViewController, presenting: nil)
        
        self.fromDirection = fromDirection
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = true
        
        if !isDisabledTapOutside {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
            blurEffectView.addGestureRecognizer(tapGestureRecognizer)
        }
    
        presentedView!.layer.masksToBounds = true
        presentedView!.layer.cornerRadius = 10
        
        presentedViewController.modalPresentationStyle = .custom
        presentedViewController.transitioningDelegate = self
    }
    
    override private init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
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
        blurEffectView.frame = containerView!.bounds
        containerView?.addSubview(blurEffectView)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (UIViewControllerTransitionCoordinatorContext) in
            self?.blurEffectView.alpha = 1
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            
        })
    }
    
    override public func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
}

extension CustomSizeController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let sizeDelegate = sizeDelegate,  sizeDelegate.responds(to:#selector(animationController(forPresented:presenting:source:))) {
            return sizeDelegate.animationController!(forPresented: presented, presenting: presenting, source: source)
        }
        
        let transitioning = SlideInTransition(fromDirection: fromDirection)
        transitioning.duration = duration
        transitioning.springWithDamping = springWithDamping
        return transitioning
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let sizeDelegate = sizeDelegate,  sizeDelegate.responds(to:#selector(animationController(forDismissed:))) {
            return sizeDelegate.animationController!(forDismissed:dismissed)
        }
        
        let transitioning = SlideInTransition(fromDirection: dismissDirection ?? fromDirection, reverse: true)
        transitioning.duration = duration
        transitioning.springWithDamping = springWithDamping
        return transitioning
    }
}
