//
//  SlideInTransition.swift
//  CustomSizeController
//
//  Created by Warif Akhand Rishi on 9/6/18.
//

import UIKit

class SlideInTransition: NSObject {
    
    var duration: TimeInterval = 0.3
    var springWithDamping: CGFloat = 0.8
    let reverse: Bool
    let fromDirection: Direction
    
    init(fromDirection: Direction, reverse: Bool = false) {
        self.reverse = reverse
        self.fromDirection = fromDirection
    }
}

extension SlideInTransition: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let viewControllerKey = reverse ? UITransitionContextViewControllerKey.from : UITransitionContextViewControllerKey.to
        let viewControllerToAnimate = transitionContext.viewController(forKey: viewControllerKey)!
        
        let viewToAnimate = viewControllerToAnimate.view!
        viewToAnimate.frame = transitionContext.finalFrame(for: viewControllerToAnimate)
        
        let offsetFrame = fromDirection.offsetFrameForView(view: viewToAnimate, containerView: transitionContext.containerView)
        
        if !reverse {
            transitionContext.containerView.addSubview(viewToAnimate)
            viewToAnimate.frame = offsetFrame
        }
        
        let options: UIViewAnimationOptions = [.curveEaseOut]
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: springWithDamping, initialSpringVelocity: 0.0, options: options, animations: { [weak self] in
            
            if self?.reverse == true {
                viewToAnimate.frame = offsetFrame
            } else {
                viewToAnimate.frame = transitionContext.finalFrame(for: viewControllerToAnimate)
            }
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}

private extension Direction {
    
    func offsetFrameForView(view: UIView, containerView: UIView) -> CGRect {
        
        var frame = view.frame
        
        switch self {
        case .left:
            frame.origin.x = -frame.width
        case .right:
            frame.origin.x = containerView.bounds.width
        case .up:
            frame.origin.y = -frame.height
        case .down:
            frame.origin.y = containerView.bounds.height
        }
        
        return frame
    }
}
