//
//  PopAnimator.swift
//  TDCustomTrans
//
//  Created by dahiyaboy on 05/03/18.
//  Copyright © 2018 dahiyaboy. All rights reserved.
//

import Foundation
import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    var dismissCompletion: (()->Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let viewControllerKey: UITransitionContextViewControllerKey = !presenting ? .from : .to
        let viewControllerToAnimate = transitionContext.viewController(forKey: viewControllerKey)!

        let viewToAnimate = viewControllerToAnimate.view!
        viewToAnimate.frame = transitionContext.finalFrame(for: viewControllerToAnimate)
        
        //let initialFrame = presenting ? originFrame : viewToAnimate.frame
        //let finalFrame = presenting ? viewToAnimate.frame : originFrame
        
        
        let initialFrame = originFrame
        let finalFrame = viewToAnimate.frame
        // calculate the scale factor we need to apply on each axis as we animate between each view.
        
//        let xScaleFactor = presenting ?
//
//            initialFrame.width / finalFrame.width :
//            finalFrame.width / initialFrame.width
//
//        let yScaleFactor = presenting ?
//
//            initialFrame.height / finalFrame.height :
//            finalFrame.height / initialFrame.height

        let xScaleFactor =
            
            initialFrame.width / finalFrame.width
        
        
        let yScaleFactor =
            
            initialFrame.height / finalFrame.height
        

        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        

        // When presenting the new view, we set its scale and position so it exactly matches the size and location of the initial frame.
        if presenting {
            viewToAnimate.transform = scaleTransform
            viewToAnimate.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            viewToAnimate.clipsToBounds = true
        }
        
        if presenting {
        transitionContext.containerView.addSubview(viewToAnimate)
        transitionContext.containerView.bringSubview(toFront: viewToAnimate)
        }
        // Core logic of animation
        
        UIView.animate(withDuration: duration, delay:0.0,
                       usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0,
                       animations: {
                        
                        viewToAnimate.transform = self.presenting ?
                            CGAffineTransform.identity : scaleTransform
                        
                        let frame = self.presenting ? finalFrame : initialFrame
                        viewToAnimate.center = CGPoint(x: frame.midX, y: frame.midY)
        },
                       completion: { _ in
                        if !self.presenting {
                            self.dismissCompletion?()
                        }
                        // completeTransition() on the transition context in the animation completion block; this tells UIKit that your transition animations are done and that UIKit is free to wrap up the view controller transition.
                        transitionContext.completeTransition(true)
        })
    }
    
}
