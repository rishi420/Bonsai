//
//  CustomSizeController.swift
//  CustomSizeController
//
//  Created by Warif Akhand Rishi on 22/5/18.
//  Copyright © 2018 Warif Akhand Rishi. All rights reserved.
//

import UIKit

public protocol CustomSizeControllerDelegate: UIViewControllerTransitioningDelegate {
    
    /// Returns a frame for presented viewController on containerView
    ///
    /// - Parameter: containerViewFrame
    
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
}

public protocol CustomTransitionProperties {
    var duration: TimeInterval {get set}
    var springWithDamping: CGFloat {get set}
    var isDisabledDismissAnimation: Bool {get set}
}

public class CustomSizeController: UIPresentationController, CustomTransitionProperties {
    
    public var duration: TimeInterval = 0.4
    public var springWithDamping: CGFloat = 0.8
    public var isDisabledDismissAnimation: Bool = false
    public var blurEffectView: UIVisualEffectView!
    public var dismissDirection: Direction? // Availabel only for slide in transition
    public var isDisabledTapOutside: Bool = false
    
    // TODO: CUSTOM VIEW CONTROLLER ANIMATION README
    weak public var sizeDelegate: CustomSizeControllerDelegate?
    
    var originView: UIView?   // For Bubble transition
    var originFrame: CGRect?   // For Bubble transition
    var fromDirection: Direction! // For slide Transition
    
    convenience public init(fromDirection: Direction, presentedViewController: UIViewController, delegate: CustomSizeControllerDelegate?) {
        self.init(presentedViewController: presentedViewController, presenting: nil)
        
        self.fromDirection = fromDirection
        self.sizeDelegate = delegate
        setup(presentedViewController: presentedViewController)
    }
    
    convenience public init(fromOrigin: CGRect, presentedViewController: UIViewController, delegate: CustomSizeControllerDelegate?) {
        self.init(presentedViewController: presentedViewController, presenting: nil)
        
        self.originFrame = fromOrigin
        self.sizeDelegate = delegate
        setup(presentedViewController: presentedViewController)
    }
    
    convenience public init(fromView: UIView, presentedViewController: UIViewController, delegate: CustomSizeControllerDelegate?) {
        self.init(presentedViewController: presentedViewController, presenting: nil)
        
        self.originView = fromView
        self.sizeDelegate = delegate
        setup(presentedViewController: presentedViewController)
    }
    
    override private init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    public func dismiss() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    private func setup(presentedViewController: UIViewController) {
        
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        blurEffectView.addGestureRecognizer(tapGestureRecognizer)
        
        presentedView!.layer.masksToBounds = true
        presentedView!.layer.cornerRadius = 10
        
        presentedViewController.modalPresentationStyle = .custom
        presentedViewController.transitioningDelegate = self
    }
    
    @objc private func handleTap() {
        
        if !isDisabledTapOutside {
            dismiss()
        }
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
        presentedView?.frame = frameOfPresentedViewInContainerView
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] (UIViewControllerTransitionCoordinatorContext) in
            self?.blurEffectView.alpha = 1
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            
        })
    }

    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { [weak self] (contx) in
            guard let `self` = self else { return }
            self.presentedView?.frame = self.frameOfPresentedViewInContainerView
            self.presentedView?.layoutIfNeeded()
        })
    }
}

extension CustomSizeController: CustomSizeControllerDelegate {
    
    public func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height/2), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height/2))
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
}

extension CustomSizeController: UIViewControllerTransitioningDelegate {
    
    private func setupTransitioningProperties(transitioning: CustomTransitionProperties?) -> UIViewControllerAnimatedTransitioning? {
        var transitioning = transitioning
        transitioning?.duration = duration
        transitioning?.springWithDamping = springWithDamping
        transitioning?.isDisabledDismissAnimation = isDisabledDismissAnimation
        return transitioning as? UIViewControllerAnimatedTransitioning
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let sizeDelegate = sizeDelegate,  sizeDelegate.responds(to:#selector(animationController(forPresented:presenting:source:))) {
            return sizeDelegate.animationController!(forPresented: presented, presenting: presenting, source: source)
        }
        
        var transitioning: CustomTransitionProperties?
        
        if let originFrame = originFrame {
            transitioning = BubbleTransition(originFrame: originFrame)
        } else if let originView = originView {
            transitioning = BubbleTransition(originView: originView)
        } else {
            transitioning = SlideInTransition(fromDirection: fromDirection)
        }
        
        return setupTransitioningProperties(transitioning: transitioning)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let sizeDelegate = sizeDelegate,  sizeDelegate.responds(to:#selector(animationController(forDismissed:))) {
            return sizeDelegate.animationController!(forDismissed:dismissed)
        }
        
        var transitioning: CustomTransitionProperties?
        
        if let originFrame = originFrame {
            transitioning = BubbleTransition(originFrame: originFrame, reverse: true)
        } else if let originFrame = originView {
            transitioning = BubbleTransition(originView: originFrame, reverse: true)
        } else {
            transitioning = SlideInTransition(fromDirection: dismissDirection ?? fromDirection, reverse: true)
        }
        
        return setupTransitioningProperties(transitioning: transitioning)
    }
}
