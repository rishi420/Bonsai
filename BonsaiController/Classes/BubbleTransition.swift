//
//  BubbleTransition.swift
//  BonsaiController
//
//  Created by Warif Akhand Rishi on 14/6/18.
//  Copyright © 2018 Warif Akhand Rishi. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class BubbleTransition: NSObject, BonsaiTransitionProperties {
    
    var duration: TimeInterval = 0.3
    var springWithDamping: CGFloat = 0.8
    var isDisabledDismissAnimation: Bool = false 
    
    private let reverse: Bool
    private var originView: UIView!
    
    var dismissCompletion: (()->Void)?
    
    init(originView: UIView, reverse: Bool = false) {
        self.reverse = reverse
        self.originView = originView
    }
}

extension BubbleTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let viewControllerKey: UITransitionContextViewControllerKey = reverse ? .from : .to
        let viewControllerToAnimate = transitionContext.viewController(forKey: viewControllerKey)!

        let viewToAnimate = viewControllerToAnimate.view!
        viewToAnimate.frame = transitionContext.finalFrame(for: viewControllerToAnimate)
        
        var initialFrame = CGRect.zero
        
        if let originImageView = originView as? UIImageView, originImageView.contentMode == .scaleAspectFit  {
            let imageSize = originImageView.image!.size
            let imageViewRect = originImageView.frame
            let frame = AVMakeRect(aspectRatio:imageSize , insideRect: imageViewRect)
            initialFrame = ((originView.superview) ?? originView).convert(frame, to: nil)
        } else {
            initialFrame = ((originView.superview) ?? originView).convert(originView.frame, to: nil)
        }
        
        let finalFrame = viewToAnimate.frame

        let xScaleFactor = initialFrame.width / finalFrame.width
        let yScaleFactor = initialFrame.height / finalFrame.height
    
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if !reverse {
            viewToAnimate.transform = scaleTransform
            viewToAnimate.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            viewToAnimate.clipsToBounds = true
            transitionContext.containerView.addSubview(viewToAnimate)
        }
        
        UIView.animate(withDuration: duration, delay:0.0, usingSpringWithDamping: reverse ? 1 : springWithDamping, initialSpringVelocity: 0.0, animations: { [weak self] in
            
            guard let self = self else { return }
            
            if self.reverse && self.isDisabledDismissAnimation {
                viewToAnimate.alpha = 0
                return
            }
            
            viewToAnimate.transform = self.reverse ? scaleTransform : .identity
            
            let frame = self.reverse ? initialFrame : finalFrame
            viewToAnimate.center = CGPoint(x: frame.midX, y: frame.midY)
            
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
        UIView.animate(withDuration: duration/2, delay: duration/2, options: .curveEaseOut, animations: {
            viewToAnimate.alpha = self.reverse ? 0.0 : 1
        })
    }
}
