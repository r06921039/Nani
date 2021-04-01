//
//  DismissAnimator.swift
//  Nani
//
//  Created by Jeff on 2021/4/1.
//

import UIKit

class DismissAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        for view in transitionContext.containerView.subviews {
            if (view.tag == 999) {
                view.backgroundColor = .clear
            }
        }
        
        
//        transitionContext.containerView.insertSubview(toVC.view,belowSubview:fromVC.view)
      

        let screenBounds = UIScreen.main.bounds
        let topRightCorner = CGPoint(x: screenBounds.width, y: 0)
        let finalFrame = CGRect(origin: topRightCorner, size: screenBounds.size)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromVC.view.frame = finalFrame
        },
            completion: { _ in
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
                
        }
        )
    }
    
}

